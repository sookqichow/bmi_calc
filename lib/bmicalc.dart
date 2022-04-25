import 'package:flutter/material.dart';
import "package:audioplayers/audioplayers.dart";


class BMIScreen extends StatelessWidget {
  const BMIScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('BMI Calc'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: 200,
                    child: Center(
                      child: Image.asset("assets/images/bmicalc.png"),
                    )),
                Container(height: 500, child: BmiForm()),
              ],
            ),
          )),
    );
  }
}

class BmiForm extends StatefulWidget {
  const BmiForm({Key? key}) : super(key: key);

  @override
  State<BmiForm> createState() => _BmiFormState();
}

class _BmiFormState extends State<BmiForm> {
  TextEditingController heightEditingController = TextEditingController();
  TextEditingController weightEditingController = TextEditingController();
  double height = 0.0, weight = 0.0, bmi = 0.0;
  AudioCache audioCache=new AudioCache();
  AudioPlayer audioPlayer=new AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            "BMI calculator",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: heightEditingController,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
                hintText: "Height in Meter",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: weightEditingController,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
                hintText: "Weight in Kg",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: _bmiCalc, child: const Text("Calculate BMI")),
          const SizedBox(height: 10),
          Text(
            "Your BMI " + bmi.toStringAsFixed(3),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          
          ),
        ],
      ),
    );
  }

  void _bmiCalc() {
    height = double.parse(heightEditingController.text);
    weight = double.parse(weightEditingController.text);
    setState(() {
      bmi = weight / (height * height);
      if(bmi>25){
        loadFail();
      }else if((bmi<=24.9)&&(bmi>=18.5)){
        loadOk();
      }else if(bmi<18.5){
        loadFail();
      }
      
    });
  }

  Future loadOk() async{
    audioPlayer= await AudioCache().play("audios/ok.wav");
  }
  Future loadFail() async{
    audioPlayer= await AudioCache().play("audios/fail.wav");
  }
}
