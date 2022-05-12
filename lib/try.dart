import 'package:flutter/material.dart';

class TryView extends StatefulWidget {
  const TryView({Key? key}) : super(key: key);

  @override
  State<TryView> createState() => _TryViewState();
}

class _TryViewState extends State<TryView> {
  final yyy = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "5",
    "6",
    "7",
    "9",
  ];
  final xx = [];
  int dragIndex = 0;

  void _acceptDraggedItem() {
    setState(() {
      xx.contains(yyy[dragIndex])
          ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 1),
              padding: EdgeInsets.all(40),
              backgroundColor: Colors.red,
              content: Text(
                'This Product Already Exist',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ))
          : xx.add(yyy[dragIndex]);
    });
  }
  
  void _removeOnlineProduct(index){
    setState(() {
      xx.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2)),
              child: Column(
                children: [
                  Text(
                    "Offline Products",
                    style: TextStyle(color: Colors.orange, fontSize: 20),
                  ),
                  Expanded(
                    child: GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      crossAxisCount: 2,
                      children: List.generate(yyy.length, (index) {
                        return Padding(
                            padding: const EdgeInsets.all(44.0),
                            child: Draggable<int>(
                              onDragStarted: () => dragIndex = index,
                              // onDragEnd:(_)=>dragIndex=index,
                              data: index,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    border: Border.all(
                                      color: Colors.blue,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Center(
                                    child: Text(
                                  yyy[index],
                                  style: TextStyle(fontSize: 20),
                                )),
                              ),

                              feedback: Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ));
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(30),
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2)),
              child: Column(
                children: [
                  Text(
                    "Online Products",
                    style: TextStyle(color: Colors.orange, fontSize: 20),
                  ),
                  Expanded(
                    child: DragTarget(
                      builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) =>
                          GridView.count(
                        shrinkWrap: true,
                        primary: false,
                        crossAxisCount: 2,
                        children: List.generate(xx.length, (index) {
                          return Padding(
                              padding: const EdgeInsets.all(44.0),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          contentPadding: EdgeInsets.all(40),
                                          content: Text("Do You Want To Remove Prouct From Online Store?",style: TextStyle(fontSize: 30),),
                                            shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                          actions: [
                                            TextButton(
                                              onPressed: ()
                                        {
                                          _removeOnlineProduct(index);
                                          Navigator.pop(context);
                                        },
                                              child: const Text('Yes',style: TextStyle(fontSize: 20),),
                                            ),
                                            TextButton(
                                              onPressed: () =>Navigator.pop(context),
                                              child: const Text('No',style: TextStyle(fontSize: 20)),
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                  child: Center(
                                      child: Text(
                                    xx[index],
                                    style: TextStyle(fontSize: 20),
                                  )),
                                ),
                              ));
                        }),
                      ),
                      onAccept: (int data) {
                        _acceptDraggedItem();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
