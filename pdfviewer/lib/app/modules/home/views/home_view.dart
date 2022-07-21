import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: controller.products.length,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            child: Text("${controller.products[index]['id']}"),
          ),
          title: Text("${controller.products[index]['name']}"),
          subtitle: Text("${controller.products[index]['desc']}"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.getPDF(),
        child: Icon(Icons.note),
      ),
    );
  }
}
