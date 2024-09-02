import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:rasoi/model.dart';
import 'package:http/http.dart';

class Search extends StatefulWidget {
  final String query;
  Search(this.query);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = true;
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = TextEditingController();

  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/api/recipes/v2?type=public&q=$query&app_id=59879e5f&app_key=b6344f3ff53c99ceade1a70b8a193027";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    data["hits"].forEach((element) {
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      setState(() {
        isLoading = false;
      });
      log(recipeList.toString());
    });
    recipeList.forEach((Recipe) {
      print(Recipe.applabel);
      print(Recipe.appcalories);
    });
  }

  // Define the _performSearch method
  void _performSearch() {
    String query = searchController.text.trim();

    if (query.isEmpty) {
      print('Please enter a search term.');
      // You can also show a message on the screen using a Snackbar, AlertDialog, etc.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a search term.'),
        ),
      );
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Search(searchController.text)));
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Search(searchController.text)));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print("${widget.query}");
    setState(() {
      getRecipe(widget.query);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FOOD APP',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        backgroundColor: Colors.green.shade800,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff213A50),
                  Color(0xff0719318),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            style: TextStyle(
                                color: Colors.blueAccent, fontSize: 25),
                            decoration: InputDecoration(
                              hintText: 'Search Foods',
                              hintStyle: TextStyle(
                                  color: Colors.blueAccent, fontSize: 25),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                            size: 35,
                          ),
                          onPressed: _performSearch,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.0),

                  Container(
                    child: isLoading?Center(child: CircularProgressIndicator()):ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: recipeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              margin: EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              elevation: 0.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(15.5),
                                    child: Image.network(
                                      recipeList[index].appimage!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 300,
                                    ),
                                  ),
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 19),
                                          decoration: BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius:
                                              BorderRadius.only(
                                                  bottomRight:
                                                  Radius.circular(
                                                      12),
                                                  bottomLeft:
                                                  Radius.circular(
                                                      12))),
                                          child: Text(
                                            recipeList[index].applabel!,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25),
                                          ))),
                                  Positioned(
                                      right: 0,
                                      width: 80,
                                      height: 35,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topRight:
                                                Radius.circular(10),
                                                bottomLeft:
                                                Radius.circular(10))),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.local_fire_department,
                                              size: 20,
                                              color: Colors.green,
                                            ),
                                            Text(
                                              recipeList[index]
                                                  .appcalories
                                                  .toString()
                                                  .substring(0, 6),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight:
                                                  FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                  // Add other widgets here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


