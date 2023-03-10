import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:samplejsonbloc/Product.dart';
import 'Categories.dart';
import 'DetailsScreen.dart';
import 'bloc_user_bloc.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'shopping cart',
      theme: ThemeData(textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserBloc _newsBloc = UserBloc();

  @override
  void initState() {
    _newsBloc.add(GetProductList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: _buildListProduct(),
    );
  }

  Widget _buildListProduct() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<UserBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<UserBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductInitial) {
                return _buildLoading();
              } else if (state is ProductLoading) {
                return _buildLoading();
              } else if (state is ProductLoaded) {
                return _buildCard(context, state.productModel);
              } else if (state is ProductError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
  Widget _buildCard(BuildContext context, Product model) {
    return Column(
      children: [Align(alignment: Alignment.topLeft,
        child: Text('Shopping', style: Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(fontWeight: FontWeight.bold),),
      ),
        const Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: model.data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
              itemBuilder: (context, index) {
                var s=model.data[index];
                return GestureDetector(
                  onTap: (){
                    print(s.name);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => DetailsScreen(name:s.name,price:s.price.toString(),image:s.image,description:s.description,
                        )
                    )
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[

                           Hero(
                               tag: s.image,
                               child: Image.network(s.image)),
                            Text(
                                "name: ${s.name}"),
                            Text(
                                "price: Rs${s.price}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/back.svg"),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            // By default our  icon color is white
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/cart.svg",
            // By default our  icon color is white
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPaddin = 20.0;
