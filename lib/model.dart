class RecipeModel
{
  late String? applabel;
  late String? appimage;
   double? appcalories;
   String? appurl;

  RecipeModel({ this.appcalories , this.appimage, this.applabel,this.appurl});
  factory RecipeModel.fromMap(Map recipe)
  {
    return RecipeModel(
      applabel: recipe["label"],
      appcalories: recipe["calories"],
      appimage: recipe["image"],
      appurl: recipe["url"],
    );
  }
}
