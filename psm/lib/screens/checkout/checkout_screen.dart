import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psm/blocs/checkout/checkout_bloc.dart';
import 'package:psm/models/catagory_model.dart';
import 'package:psm/widgets/widgets.dart';

import '../../models/models.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_bottomappbar.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: CustomBottomAppBar(screen: routeName),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CheckoutLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'CUSTOMER INFO',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    _buildTextFormField((value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(email: value));
                    }, context, 'Email'),
                    _buildTextFormField((value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(fullName: value));
                    }, context, 'Full Name'),
                    Text(
                      'DELIVERY',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    _buildTextFormField((value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(address: value));
                    }, context, 'Address'),
                    _buildTextFormField((value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(city: value));
                    }, context, 'City'),
                    _buildTextFormField((value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(country: value));
                    }, context, 'Country'),
                    _buildTextFormField((value) {
                      context
                          .read<CheckoutBloc>()
                          .add(UpdateCheckout(zipCode: value));
                    }, context, 'Zipcode'),
                    SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(color: Colors.black),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: Text(
                              'CHOOSE A PAYMENT METHOD',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                    Text(
                      'ORDER SUMMARY',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    OrderSummary(),
                  ],
                );
              } else {
                return Text('Oops! Looks like something went wrong. :(');
              }
            },
          ),
        ),
      ),
    );
  }

  Padding _buildTextFormField(
      Function(String)? onChanged, BuildContext context, String labelText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
              width: 75,
              child: Text(
                labelText,
                style: Theme.of(context).textTheme.bodyText1,
              )),
          Expanded(
            child: TextFormField(
              onChanged: onChanged,
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.only(left: 10),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            ),
          )
        ],
      ),
    );
  }
}
