namespace RecipeBook.Api.Dtos
{
    public class ProfileDto
    {
        public int RecipesCount { get; set; }
        public int LikesCount { get; set; }
        public int FavoritesCount { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Login { get; set; }
    }
}
