import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Product extends Equatable {
  final int? id;
  final String name;
  final double price;
  final String image;

  const Product({this.id, required this.name, required this.price, required this.image});

  //const Product( this.id, this.name, this.price,this.image);


  @override
  // TODO: implement props
  List<Object?> get props =>  [id, name , price , image];
}