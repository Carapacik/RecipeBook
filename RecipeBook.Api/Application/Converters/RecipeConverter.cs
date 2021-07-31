﻿using System.Linq;
using RecipeBook.Api.Application.Entities;
using RecipeBook.Api.Application.Services.Entities;

namespace RecipeBook.Api.Application.Converters
{
    public static class RecipeConverter
    {
        public static Recipe Convert(this AddRecipeCommand addRecipeCommandDto, SaveImageResult saveImageResult)
        {
            return new()
            {
                ImageUrl = saveImageResult.ImageUri,
                Title = addRecipeCommandDto.Title,
                Description = addRecipeCommandDto.Description,
                CookingTimeInMinutes = addRecipeCommandDto.CookingTimeInMinutes,
                PortionsCount = addRecipeCommandDto.PortionsCount,
                Tags = addRecipeCommandDto.Tags.Select(x => new Tag
                {
                    Name = x
                }).ToList(),
                Steps = addRecipeCommandDto.Steps.Select(x => new Step
                {
                    Description = x
                }).ToList(),
                Ingredients = addRecipeCommandDto.Ingredients.Select(x => new Ingredient
                {
                    Title = x.Title,
                    IngredientItems = x.IngredientNames.Select(y => new IngredientItem
                    {
                        Name = y
                    }).ToList()
                }).ToList()
            };
        }
    }
}