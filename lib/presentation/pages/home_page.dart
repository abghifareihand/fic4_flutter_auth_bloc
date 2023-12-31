import 'package:fic4_flutter_auth_bloc/bloc/product/create_product/create_product_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/product/get_all_product/get_all_product_bloc.dart';
import 'package:fic4_flutter_auth_bloc/bloc/profile/profile_bloc.dart';
import 'package:fic4_flutter_auth_bloc/data/localsources/auth_local_storage.dart';
import 'package:fic4_flutter_auth_bloc/data/models/request/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    context.read<ProfileBloc>().add(GetProfileEvent());
    context.read<GetAllProductBloc>().add(DoGetAllProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Profile'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 32.0,
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProfileLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name : ${state.profile.name ?? ''}'),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text('Email : ${state.profile.email ?? ''}'),
                  ],
                );
              }

              return const Text('No Data Profile');
            },
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
            onPressed: () async {
              await AuthLocalStorage().removeToken();
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Success Logout'),
                  backgroundColor: Colors.redAccent,
                ),
              );

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false);
            },
            child: const Text('Logout'),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: BlocBuilder<GetAllProductBloc, GetAllProductState>(
              builder: (context, state) {
                if (state is GetAllProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GetAllProductLoaded) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final product =
                          state.listProduct.reversed.toList()[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text('${product.price}'),
                          ),
                          title: Text(product.title ?? '-'),
                          subtitle: Text(product.description ?? '-'),
                        ),
                      );
                    },
                  );
                }
                return const Text('No Data Product');
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add product'),
                content: Column(
                  /// ikutin lebar content bukan layar
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: titleController,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Price'),
                      controller: priceController,
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      maxLines: 3,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      controller: descriptionController,
                    ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  BlocListener<CreateProductBloc, CreateProductState>(
                    listener: (context, state) {
                      if (state is CreateProductLoaded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Add product id: ${state.productResponeModel.id}'),
                            backgroundColor: Colors.blue,
                          ),
                        );
                        Navigator.pop(context);
                        context
                            .read<GetAllProductBloc>()
                            .add(DoGetAllProductEvent());
                      }
                    },
                    child: BlocBuilder<CreateProductBloc, CreateProductState>(
                      builder: (context, state) {
                        if (state is CreateProductLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ElevatedButton(
                          onPressed: () {
                            final productModel = ProductModel(
                              title: titleController.text,
                              price: int.parse(priceController.text),
                              description: descriptionController.text,
                            );
                            context.read<CreateProductBloc>().add(
                                DoCreateProductEvent(
                                    productModel: productModel));
                          },
                          child: const Text('Save'),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
