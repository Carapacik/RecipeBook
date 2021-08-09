﻿using RecipeBook.Application.Services.Entities;

namespace RecipeBook.Application.Services
{
    public interface IStaticService
    {
        GetFileResult GetFile(string path);
        SaveFileResult SaveFile(RecipeFile file, string path);
    }
}