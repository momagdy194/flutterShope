import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mygeneralshope/api/helper_api.dart';
import 'package:mygeneralshope/product/product.dart';
import 'package:mygeneralshope/product/product_category.dart';
import 'package:mygeneralshope/screen/singleproduct.dart';
import 'package:mygeneralshope/screen/streams/category_stream.dart';
import 'package:mygeneralshope/screen/streams/dotsstream.dart';
import 'package:mygeneralshope/screen/utilities/colorutilities.dart';
import 'package:mygeneralshope/screen/utilities/helperWidgets.dart';
import 'package:mygeneralshope/screen/utilities/screenconfigration.dart';
import '../product/home_product.dart';
import 'cart_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ScreenConfig screenConfig;
  TabController tabController;
  int currentIndex = 0;
  List<ProductCategory> productCategory;

  PageController _pageController;

  HelperApi helperApi = HelperApi();
  ValueNotifier<int> dotsIndex = ValueNotifier(1);

  HomeProductBlock homeProductBlock = HomeProductBlock();
  CategoryStream categoryStream = CategoryStream();

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: 1,
      viewportFraction: .75,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    homeProductBlock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);
    return FutureBuilder(
        future: helperApi.fetchCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductCategory>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return errore('no Conection mode');
              break;
            case ConnectionState.waiting:
              return loading();
              break;

            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return errore(snapshot.error.toString());
              } else if (!snapshot.hasData) {
                return errore('no data');
              } else {
                this.productCategory = snapshot.data;
                homeProductBlock.fetchProduct
                    .add(this.productCategory[0].category_id);

                return _screens(snapshot.data, context);
              }

              break;
          }
          return Container();
        });
  }

  Widget _screens(List<ProductCategory> categories, BuildContext context) {
    tabController =
        TabController(length: categories.length, vsync: this, initialIndex: 0);

    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(child: Text('Heder'),decoration: BoxDecoration(
                color: Colors.grey.shade200
              ),),
              ListTile(
                title: Text('goooo'),
                leading: Icon(Icons.card_travel),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return CartScreen();
                  }));
                }

              )
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Home'),
          elevation: 0,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
          bottom: TabBar(
            indicatorWeight: 4,
            indicatorColor: ScreenUtilities.mainBlue,
            isScrollable: true,
            tabs: _tabs(categories),
            controller: tabController,
            onTap: (int index) {
              homeProductBlock.fetchProduct
                  .add(this.productCategory[index].category_id);
            },
          ),
        ),
        body: Container(
          child: StreamBuilder(
              stream: homeProductBlock.productStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Product>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return errore(' no conection found');
                    break;
                  case ConnectionState.waiting:
                    return loading();
                    break;
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return errore(snapshot.error.toString());
                    } else if (!snapshot.hasData) {
                      return errore('no data foind');
                    } else {
                      return _drawProduct(snapshot.data);
                    }
                    break;
                }
                return Container();
              }),
        ));
  }

  List<Product> _randomImageProduct(List<Product> products) {
    Random random = Random();
    List<int> indexs = [];
    List<Product> newProducts = [];
    int counter = 5;
    do {
      var rnd = random.nextInt(products.length);
      if (!indexs.contains(rnd)) {
        indexs.add(rnd);
        counter--;
      }
    } while (counter != 0);
    for (int index in indexs) {
      newProducts.add(products[index]);
    }
    return newProducts;
  }

  Widget _drawProduct(List<Product> products) {
    List<Product> topProduct = _randomImageProduct(products);

    return Container(
      padding: EdgeInsets.only(top: 24),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * .25,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: topProduct.length,
              itemBuilder: (context, position) {
                return InkWell(
                  onTap: () {
                    _gotoSingleProduct(products[position], context);
                  },
                  child: Card(
                    margin: EdgeInsets.only(right: 3, left: 3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    clipBehavior: Clip.hardEdge,
                    child: Image(
                      loadingBuilder:
                          (context, image, ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) {
                          return image;
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      fit: BoxFit.cover,
                      image: NetworkImage(topProduct[position].feachImage()),
                    ),
                  ),
                );
              },
              onPageChanged: (int index) {
                dotsIndex.value = index;
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ValueListenableBuilder(
              valueListenable: dotsIndex,
              builder: (context, value, _) {
                return Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _drawDots(topProduct.length, value)),
                );
              }),
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: Container(
                child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: .55,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, position) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          shape: BoxShape.rectangle),
                      child: InkWell(
                        onTap: () {
                          _gotoSingleProduct(products[position], context);
                          print(products[position].product_title);
                        },
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 150,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    shape: BoxShape.rectangle),
                                child: Image(
                                  loadingBuilder: (context, image,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) {
                                      return image;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  image: NetworkImage(
                                      products[position].feachImage()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                products[position].product_title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: ScreenUtilities.textColor),
                                maxLines: 3,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                products[position].product_price.toString() +
                                    ' \$',
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: ScreenUtilities.textColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }

  List<Widget> _drawDots(int qnt, int index) {
    List<Widget> widget = [];
    for (int i = 0; i < qnt; i++) {
      widget.add(Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: (i == index)
              ? ScreenUtilities.mainBlue
              : ScreenUtilities.lightGray,
        ),
        width: 10,
        height: 10,
        margin: (i == qnt - 1)
            ? EdgeInsets.only(right: 0)
            : EdgeInsets.only(right: 10, top: 8),
      ));
    }
    return widget;
  }

  List<Tab> _tabs(List<ProductCategory> categories) {
    List<Tab> tabs = [];

    for (ProductCategory category in categories) {
      tabs.add(Tab(
        text: category.category_name,
      ));
    }
    return tabs;
  }

  void _gotoSingleProduct(Product product, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SingleProduct(product);
    }));
  }
}