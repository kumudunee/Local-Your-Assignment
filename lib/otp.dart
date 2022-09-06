import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model.dart';
class Otp extends StatefulWidget {
  // const Otp({Key key}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              const Text(
                "Enter your DAC number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 80,
              ),
              Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(first: true, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: true),
                      ],
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_){
                                //making the dialog box
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  content: Text("Is this a repairable job?"),
                                  actions: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("Yes")),
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("No")),
                                  ],
                                );
                              }
                          );
                        },
                        style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({required bool first, last}) {
    return Container(
      height: 85,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}

class HttpScreen extends StatelessWidget {
  const HttpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
Future<Model> getDAC() async {
  final url ="https://vendor.localyour.com/vendor/api/change-service-request-status";
  final response = await http.get(url);

  if(response.statusCode == 200){
    String jsonDAC = jsonDecode(response.body);
    return Model.fromJson(jsonDAC);

  }
}

