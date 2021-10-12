import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

import 'package:weather_flutter_app/business_logic/blocs/weather_bloc.dart';

class WeatherSearchBar extends StatefulWidget {
  const WeatherSearchBar({Key? key}) : super(key: key);

  @override
  State<WeatherSearchBar> createState() => _WeatherSearchBarState();
}

class _WeatherSearchBarState extends State<WeatherSearchBar> {
  late TextEditingController _controller;
  bool _validate = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 50,
            child: TextField(
                onSubmitted: (value) {
                  BlocProvider.of<WeatherBloc>(context, listen: false)
                      .add(FetchWeatherEvent(cityName: _controller.text));
                },
                onChanged: (value) =>
                    setState(() => _validate = value.isNotEmpty),
                controller: _controller,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: 'Enter city name...',
                    hintStyle: TextStyle(
                        color: _validate ? Colors.black : Colors.white),
                    filled: !_validate,
                    fillColor: Colors.redAccent,
                    border: OutlineInputBorder())),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              setState(() {
                _controller.text.isEmpty ? _validate = false : _validate = true;
              });
              BlocProvider.of<WeatherBloc>(context, listen: false)
                  .add(FetchWeatherEvent(cityName: _controller.text));
            },
            child: Text('Search'),
          ),
        ),
      ],
    );
  }
}
