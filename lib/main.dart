import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samplejsonbloc/Data.dart';
import 'package:samplejsonbloc/Product.dart';

import 'bloc_user_bloc.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      appBar: AppBar(title: Text('Product')),
      body: _buildListCovid(),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: EdgeInsets.all(8.0),
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
    return ListView.builder(
      itemCount: model.data!.length,
      itemBuilder: (context, index) {
        var s=model.data[index] as Data;
        return Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text("Status: ${model.status}"),
                  Text(
                      "name: ${s.name}"),
                  Text("Brand: ${s.brand}"),
                  Image.network('${s.image}'),
                  Text(
                      "price: ${s.price}"),
                  Text("Brand: ${s.description}"),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}