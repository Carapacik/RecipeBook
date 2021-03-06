using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Http;
using RecipeBook.Application.Entities;
using RecipeBook.Domain.Entities;
using RecipeBook.Domain.Repositories;

namespace RecipeBook.Application.Services
{
    public class UserService : IUserService
    {
        private readonly IRatingRepository _ratingRepository;
        private readonly IRecipeRepository _recipeRepository;
        private readonly IUserRepository _userRepository;

        public UserService(
            IUserRepository userRepository,
            IRatingRepository ratingRepository,
            IRecipeRepository recipeRepository )
        {
            _userRepository = userRepository;
            _ratingRepository = ratingRepository;
            _recipeRepository = recipeRepository;
        }


        public async Task<AuthenticationResult> Login( AuthenticateUserCommand authenticateUserCommand )
        {
            User user = await _userRepository.GetByLogin( authenticateUserCommand.Login );
            if ( user == null )
            {
                return new AuthenticationResult( false, "user" );
            }

            if ( HashPassword( authenticateUserCommand.Password ) != user.Password )
            {
                return new AuthenticationResult( false, "password" );
            }

            await Authenticate( authenticateUserCommand.Login, authenticateUserCommand.HttpContext );
            return new AuthenticationResult( true, null );
        }

        public async Task<AuthenticationResult> Register( AuthenticateUserCommand authenticateUserCommand )
        {
            User user = await _userRepository.GetByLogin( authenticateUserCommand.Login );
            if ( user != null )
            {
                return new AuthenticationResult( false, "user" );
            }

            _userRepository.Add( new User
            {
                Login = authenticateUserCommand.Login,
                Name = authenticateUserCommand.Name,
                CreationDateTime = DateTime.Now,
                Password = HashPassword( authenticateUserCommand.Password )
            } );

            await Authenticate( authenticateUserCommand.Login, authenticateUserCommand.HttpContext );
            return new AuthenticationResult( true, null );
        }

        public async Task EditUserProfile( ProfileCommand profileCommand )
        {
            User existingUser = await _userRepository.GetByLogin( profileCommand.OldLogin );
            if ( existingUser == null )
            {
                throw new ValidationException( $"User with login:{profileCommand.Login} does not exist" );
            }

            User editedUser = ConvertToUser( profileCommand );
            _userRepository.Edit( existingUser, editedUser );
        }

        public async Task<UserProfile> GetUserProfile( string username )
        {
            User user = await _userRepository.GetByLogin( username );
            int favoritesCount = await _ratingRepository.GetUserFavoritesCountByUserId( user.UserId );
            int likesCount = await _ratingRepository.GetUserLikesCountByUserId( user.UserId );
            int recipesCount = await _recipeRepository.GetUserRecipesCountByUserId( user.UserId );
            return new UserProfile
            {
                RecipesCount = recipesCount,
                FavoritesCount = favoritesCount,
                LikesCount = likesCount,
                Name = user.Name,
                Description = user.Description,
                Login = user.Login,
                Password = user.Password
            };
        }

        private static async Task Authenticate( string userName, HttpContext httpContext )
        {
            List<Claim> claims = new() { new Claim( ClaimsIdentity.DefaultNameClaimType, userName ) };
            ClaimsIdentity id = new(claims, "RecipeBookCookie", ClaimsIdentity.DefaultNameClaimType, ClaimsIdentity.DefaultRoleClaimType);
            await httpContext.SignInAsync( CookieAuthenticationDefaults.AuthenticationScheme, new ClaimsPrincipal( id ) );
        }

        private static User ConvertToUser( ProfileCommand profileCommand )
        {
            return new User
            {
                Description = profileCommand.Description,
                Name = profileCommand.Name,
                Login = profileCommand.Login,
                Password = HashPassword( profileCommand.Password )
            };
        }

        private static string HashPassword( string password )
        {
            byte[] hash = MD5.Create().ComputeHash( Encoding.UTF8.GetBytes( password ) );

            return Convert.ToBase64String( hash );
        }
    }
}
