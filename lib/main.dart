import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:path_provider/path_provider.dart';
import 'dart:collection';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Card'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool front = true;
  List<String> cards = [];
  List<String> daysOfWeekShort = ["Mon", "Tue", "Wed", "Thu","Fr","Sat","Sun"];
  List<Map<String, String>> students = [];
  List studentsDaysValues = [];
  var random = Random();

  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  final cardController = TextEditingController();

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        backgroundColor: const Color(0xFF2A282D),
      appBar: null,
      body:
        SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top:20.0),
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () {
                      setState(() {
                        if(front==true) {
                            front = false;
                          }
                        else{
                          front = true;
                        }
                      });
                    },
                      child:
                      Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
                      child:

                        Container(
                        height: MediaQuery.of(context).size.height/4,
                        width: MediaQuery.of(context).size.width - 10,
                        decoration: BoxDecoration(
                        color: Color(0xFF5E1A71),
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                        ),
                        child: Center(child:
                        front?
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              const Text("Press on card to add new card ->",
                              style: TextStyle(
                                fontSize: 10
                              ),),
                              const Text("Your cards: ",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 30),
                              ),
                              for(int i =0; i<cards.length;i++)
                                GestureDetector(
                                  onTap: (){
                                    Clipboard.setData(ClipboardData(text: cards.elementAt(i))).then((_){
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Card is copied to clipboard")));
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(cards.elementAt(i),
                                      style: const TextStyle(decoration:TextDecoration.underline,
                                          fontSize: 15,
                                      backgroundColor: Colors.white10),),
                                  ),
                                )
                            ],
                          ),
                        ):
                        Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
                        child: Column(
                          children:<Widget>[
                          TextFormField(
                            controller: cardController,
                          decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter your card here',
                          ),
                          ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff006400), // background
                                onPrimary: Colors.white, // foreground
                              ),
                              onPressed: () {
                                setState(() {
                                  cards.length<4?
                                  cards.add(cardController.text):
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You can not add more than 4 cards")));
                                  front=true;
                                });
                              },
                              child: Text('Add card'),
                            ),
                        ]
                        ),

                        ),
                        ) ,
                    ),
          ),
          ),


                    Row(
                       children:<Widget>[
                        for(int i =0; i<daysOfWeekShort.length;i++)
                          Padding(
                            padding: EdgeInsets.only(
                              top: deviceHeight(context) /100,
                              left: deviceWidth(context) *0.015,
                            ),
                            child: Container(
                              width: deviceWidth(context)/8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFA79FB4),
                              ),
                              child: Text(daysOfWeekShort.elementAt(i),
                              textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: deviceHeight(context)/50),
                            ),
                          )
                          )
                      ],
                      ),




                      Row(
                    children:[
                        for(var i in days)
                          if(students.isNotEmpty && !students.any((element) => element.containsKey(i)))
                             Padding(
                               padding: EdgeInsets.only(
                                 top: deviceHeight(context) /100,
                                 left:10,
                               ),
                               child: Container(
                                    width: 45,
                                    height: 20,
                            ),
                             )

                          else
                                Column(
                                  children: [
                                    for(int j  =0; j<students.length;j++)
                                    if(students.elementAt(j).keys.contains(i))
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: deviceHeight(context) /100,
                                        left:10,
                                      ),
                                      child: Container(
                                        width: 45,
                                        color: Color.fromARGB(
                                          255,
                                          random.nextInt(255),
                                          random.nextInt(130),
                                          random.nextInt(128) + 128,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Text(students.elementAt(j).values.elementAt(0),
                                            textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.black),),
                                        ),
                                      ),
                                    ),
                                  ],
                                )

                          ]

    ),


                    Padding(
                      padding: EdgeInsets.only(
                        top: deviceHeight(context)/60,
                      ),
                      child: ElevatedButton.icon(
                        // style: style,
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddEvent(students)),
                          );
                          setState(() {
                            print(students);
                          });


                        },
                        icon:const Icon(Icons.add),
                        label: const Text('Add lesson'),
                      ),
                    ),

        ],
                ),
              ),
            )

    );
  }
}
class AddEvent extends StatefulWidget {
  AddEvent(this.students, {super.key});

  final List<Map<String, String>> students;
  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
  final nameController = TextEditingController();


  List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  String _selectedValue = "Monday";
  int dayNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
          child: Padding(
          padding: EdgeInsets.only(
          left: widget.deviceWidth(context)/100,
      right: widget.deviceWidth(context)/100,
      top: widget.deviceHeight(context)/10,
    ),
    child: Column(
    children:[
    TextFormField(
    controller: widget.nameController,
    decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      labelText: 'Student name ',
    ),
    ),
      DropdownButton<String>(
        value: _selectedValue,
        onChanged: (String ?newValue) {
          setState(() {
            if(newValue!=null) {
                    _selectedValue = newValue;

                  }
                });
        },
        items: widget.days.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
      Row(
        children: [
          ElevatedButton(
            onPressed: () {
              widget.students.add({_selectedValue:widget.nameController.text});
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go back'),
          ),
        ],
      ),
    ]
    ),
          ),
      ),
    );
  }
}

