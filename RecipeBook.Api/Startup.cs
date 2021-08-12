using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.OpenApi.Models;
using RecipeBook.Application.Services.Entities;
using RecipeBook.Infrastructure;

namespace RecipeBook.Api
{
    public class Startup
    {
        public Startup( IConfiguration configuration )
        {
            Configuration = configuration;
        }

        private IConfiguration Configuration { get; }

        public void ConfigureServices( IServiceCollection services )
        {
            services.AddControllers();
            services.AddDependencies();
            services.AddDbContext<RecipeBookDbContext>( conf =>
                conf.UseNpgsql( Configuration.GetConnectionString( "ConnectionString" ) ) );
            services.AddAuthentication( CookieAuthenticationDefaults.AuthenticationScheme ).AddCookie( options =>
            {
                options.LoginPath = new PathString( "/api/user/login" ); // это нужно указывать?
            } );
            services.AddSingleton( Configuration.GetSection( "FileStorageSettings" ).Get<FileStorageSettings>() );
            services.AddSwaggerGen( c => { c.SwaggerDoc( "v1", new OpenApiInfo { Title = "RecipeBook.Api", Version = "v1" } ); } );
        }

        public static void Configure( IApplicationBuilder app, IWebHostEnvironment env )
        {
            if ( env.IsDevelopment() )
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI( c => c.SwaggerEndpoint( "/swagger/v1/swagger.json", "RecipeBook.Api v1" ) );
            }

            app.UseRouting();
            app.UseAuthentication();
            app.UseAuthorization();

            app.UseEndpoints( endpoints => { endpoints.MapControllers(); } );
        }
    }
}
