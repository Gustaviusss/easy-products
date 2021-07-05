import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:products/screens/login_screen.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:truncate/truncate.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key key, String token}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

ProductModel _productsList;

Future<ProductModel> _getProducts() async {
  try {
    final response = await http.get(
        Uri.parse(
            'http://servicosflex.rpinfo.com.br:9000/v2.0/produtounidade/listaprodutos/0/unidade/83402711000110'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token
        });
    if (response.statusCode == 200) {
      ProductModel _productList =
          ProductModel.fromJson(jsonDecode(response.body));
      return _productList;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool hasItems = false;
  static const style = TextStyle(fontSize: 16);
  String message = 'Nenhum Produto';
  @override
  Widget build(BuildContext context) {
     if(_productsList?.response?.status != 'ok'){
       setState(() {
         message = _productsList?.response?.messages?.first?.message?? 'Nenhum Produto';
       });
     }
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        leading: Icon(Icons.card_giftcard_rounded),
        title: Text('Lista de Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              token = '';
              Navigator.pop(context);
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: hasItems
          ? ListView.builder(
              itemCount: _productsList?.response?.produtos?.length??0,
              itemBuilder: (context, index) {
                num price = _productsList?.response?.produtos[index]?.preco?? 0;
                num code = _productsList?.response?.produtos[index]?.codigo?? 0;
                String barCode =
                    _productsList?.response?.produtos[index]?.codigoBarras?? '';
                String description = truncate(
                    _productsList?.response?.produtos[index]?.descricao, 25,
                    omission: '...', position: TruncatePosition.end)??'';
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  description,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                              ),
                              Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.card_giftcard_rounded,
                                        color: Colors.black,
                                        size: 16,
                                      ),
                                      Text(
                                        code.toString(),
                                        style: style,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.view_week,
                                        color: Colors.black,
                                        size: 16,
                                      ),
                                      Text(
                                        barCode,
                                        style: style,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                'R\$$price',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            width: 60,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                          )
                        ],
                      )),
                  color: Colors.greenAccent,
                );
              },
            )
          : Center(child: Text(message, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[300],
        onPressed: () {
          _getProducts().then((value) {
            _productsList = value;
          });
          setState(() {
            hasItems = true;
          });
        },
        tooltip: 'Recarregar',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
