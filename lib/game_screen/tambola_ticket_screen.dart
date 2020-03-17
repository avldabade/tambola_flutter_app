import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tambola/utils/utils.dart';
import 'package:tambola/constants/constants.dart';

class TambolaTicket extends StatefulWidget {
  @override
  _TambolaTicketState createState() => _TambolaTicketState();
}

class _TambolaTicketState extends State<TambolaTicket> {
  //var itemList;
  Map ticketList = new Map<int, List<int>>();

  //List<List<int>> ticketList =new List();
  //List<List<int>> ticketList = new List<List<int>>();
  List<int> noList = new List();
  List<int> noList0 = new List();
  List<int> noList1 = new List();
  List<int> noList2 = new List();
  List<int> noList3 = new List();

  Map cellSelectedMap = new Map<int, List<bool>>();
  List<bool> isCellSeleced = new List(27);

  List<Map<int, int>> selectedNosMap = new List();
  Map selectedNos = new Map<int, int>();

  List<int> generatedNos = new List();
  List<int> displayNos = new List();
  List<int> displayNosAtClaimTime = new List();

  bool wonTopLine = false,
      wonMidLine = false,
      wonBottomLine = false,
      wonFullHouse = false,
      wonCorners = false;

  //Map generatedNos = new Map<int, int>();

  Timer timer;
  static int timerCounter = 0;

  ScrollController _scrollController = new ScrollController();

  //math.Random random = math.Random();
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    noList = [
      8,
      15,
      0,
      0,
      43,
      50,
      65,
      0,
      0,
      0,
      0,
      20,
      36,
      0,
      0,
      69,
      76,
      86,
      0,
      19,
      28,
      0,
      49,
      52,
      0,
      77,
      0
    ];
    noList1 = [
      0,
      14,
      0,
      34,
      45,
      0,
      0,
      75,
      89,
      4,
      0,
      23,
      0,
      0,
      54,
      66,
      0,
      90,
      7,
      18,
      0,
      39,
      46,
      55,
      0,
      0,
      0
    ];
    noList2 = [
      2,
      0,
      27,
      0,
      43,
      0,
      61,
      0,
      85,
      0,
      11,
      0,
      32,
      0,
      52,
      0,
      70,
      87,
      0,
      0,
      29,
      33,
      0,
      59,
      69,
      76,0
    ];
    noList3 = [
      1,
      0,
      0,
      0,
      40,
      50,
      68,
      0,
      80,
      0,
      13,
      21,
      31,
      0,
      0,
      0,
      71,
      88,
      0,
      16,
      24,
      35,
      44,
      53,
      0,
      0,
      0
    ];
    noList0 = [
      6,
      0,
      0,
      0,
      41,
      56,
      65,
      77,
      0,
      0,
      10,
      25,
      37,
      0,
      0,
      0,
      79,
      86,
      0,
      12,
      0,
      38,
      48,
      58,
      67,
      0,
      0
    ];

    initTicket();
    for (int i = 0; i < 27; i++) {
      isCellSeleced[i] = false;
    }
    for (var k in ticketList.keys) {
      cellSelectedMap[k]=isCellSeleced;
      print('cellSelectedMap[$k]:: ${cellSelectedMap[k]}');
      //selectedNosMap
    }

    //(() async {
    generateRandomNo();
    //})();

    //timerFunction();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 24.0,
              ),
              new ConstrainedBox(
                  constraints: new BoxConstraints(
                    minHeight: 35.0,
                    maxHeight: 80.0,
                  ),
                  child: new ListView.builder(
                      //padding: const EdgeInsets.fromLTRB(50.0,40.0,50.0,40.0),
                      //padding: const EdgeInsets.all(50.0),
                      scrollDirection: Axis.horizontal,
                      itemCount: displayNos.length,
                      padding: EdgeInsets.all(8.0),
                      shrinkWrap: true,
                      //reverse: true,
                      controller: _scrollController,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Row(
                          children: <Widget>[
                            Container(
                              decoration: new BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              width: 50.0,
                              //height: 160.0,
                              child: Center(
                                  child: Text(
                                '${displayNos[index]}',
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                            Container(
                              width: 5.0,
                            )
                          ],
                        );
                      })),
              getAllTickets(),
              //getSingleTicket(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSingleTicket(int i) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.brown.shade200,
          border: Border.all(color: Colors.brown, width: 3.0, style: BorderStyle.solid),
          borderRadius:new BorderRadius.all(const Radius.circular(10.0)),
        /*new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0),
          )*/
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            getTicketBuilder(i),
            Container(
              height: 10.0,
              //color: Colors.brown,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: wonTopLine ? Colors.red.shade200 : Colors.red,
                      onPressed: () {
                        if (!wonTopLine) {
                          claimLine(0, 8, "Top",i);
                        }
                      },
                      child: Text(
                        'Claim Top Line',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      width: 10.0,
                    ),
                    RaisedButton(
                      color: wonMidLine ? Colors.red.shade200 : Colors.red,
                      onPressed: () {
                        if (!wonMidLine) {
                          claimLine(9, 17, "Middle",i);
                        }
                      },
                      child: Text(
                        'Claim Middle Line',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      width: 10.0,
                    ),
                    RaisedButton(
                      color: wonBottomLine ? Colors.red.shade200 : Colors.red,
                      onPressed: () {
                        if (!wonBottomLine) {
                          claimLine(18, 26, "Bottom",i);
                        }
                      },
                      child: Text(
                        'Claim Bottom Line',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: wonCorners ? Colors.red.shade200 : Colors.red,
                      onPressed: () {
                        if (!wonCorners) {
                          claimForCorner(i);
                        }
                      },
                      child: Text(
                        'Claim Corners',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      width: 10.0,
                    ),
                    RaisedButton(
                      color: wonFullHouse ? Colors.red.shade200 : Colors.red,
                      onPressed: () {
                        if (!wonFullHouse) {
                          claimFullHouse(i);
                        }
                      },
                      child: Text(
                        'Claim Full House',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getTicketBuilder(int i) {
    List<int> noList=new List();
    noList.addAll(ticketList[i]);
    List<bool> isCellSeleced=new List();
    isCellSeleced.addAll(cellSelectedMap[i]);
    Map<int, int> selectedNos=new Map();
    //selectedNos.addAll(selectedNosMap[i]);

    //print('getTicketBuilder i:: $i noList:: $noList');
    //print('getTicketBuilder i:: $i isCellSeleced:: $isCellSeleced');

    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: MediaQuery.of(context).size.height / 2.4,
      child: GridView.count(
          padding: EdgeInsets.all(0.0),
          crossAxisCount: 9,
          physics: new NeverScrollableScrollPhysics(),
          children: new List<Widget>.generate(27, (index) {
            return Card(
              child: InkWell(
                child: Center(
                    child: noList[index] == 0
                        ? Text('')
                        : Text('${noList[index]}')),
                onTap: () {
                  print('ticket no:: ${i+1}');
                  if (noList
                  [index] != 0) {
                    setState(() {
                      isCellSeleced[index] = !isCellSeleced[index];
                    });
                    if (isCellSeleced[index]) {
                      selectedNos[index] = noList[index];
                    } else {
                      selectedNos.remove(index);
                    }
                    selectedNosMap[i]=selectedNos;
                    cellSelectedMap[i]=isCellSeleced;
                    print(
                        'selected Map length:: ${selectedNos.length}, taped no is::: ${noList[index]}');
                  }
                },
              ),
              color: isCellSeleced[index]
                  ? Colors.blue.shade200
                  : Colors.yellow.shade200,
            );
          })),
    );


  }

  void generateRandomNo() {
    int randomNumber = getRandomNo();
    if (generatedNos.length < 90) {
      if (!generatedNos.contains(randomNumber)) {
        generatedNos.add(randomNumber);
      }
      if (generatedNos.length < 89) {
        generateRandomNo();
      } else {
        print(
            'else generatedNos size::: ${generatedNos.length} generatedNos::: $generatedNos');
        timerFunction();
      }
    }
  }

  void timerFunction() {
    print('timerCounter:: $timerCounter');

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (timerCounter < 89) {
        setState(() {
          displayNos.add(generatedNos[timerCounter]);
        });
        setScrollerPosition();
        //print('displayNos size:: ${displayNos.length} displayNos:: $displayNos  timerCounter:: $timerCounter');
        timerCounter++;
      } else {
        timer?.cancel();
      }
    });
  }

  int getRandomNo() {
    Random random = new Random();
    int randomNumber = random.nextInt(89) + 1;
    //print('randomNumber::: $randomNumber');
    return randomNumber;
  }

  claimForCorner(int index) {
    print('claimForCorner Clicked!!!');
    List<int> noList=new List();
    noList.addAll(ticketList[index]);
    List<bool> isCellSeleced=new List();
    isCellSeleced.addAll(cellSelectedMap[index]);

    displayNosAtClaimTime.clear();
    displayNosAtClaimTime.addAll(displayNos);
    bool topLeft = false; //selectedNos.containsKey(0);
    bool topRight = false; //selectedNos.containsKey(8);
    bool bottomLeft = false; //selectedNos.containsKey(18);
    bool bottomRight = false; //selectedNos.containsKey(26);
    //print('c1:: $c1, c2:: $c2, c3:: $c3, c4:: $c4');
    for (int i = 0; i <= 4;) {
      if (noList[i] != 0) {
        if (displayNosAtClaimTime.contains(noList[i]) && isCellSeleced[i]) {
          topLeft = true;
        }
        i = 100;
      } else {
        i++;
      }
    }
    for (int i = 8; i >= 4;) {
      if (noList[i] != 0) {
        if (displayNosAtClaimTime.contains(noList[i]) && isCellSeleced[i]) {
          topRight = true;
        }
        i = 0;
      } else {
        i--;
      }
    }
    for (int i = 18; i <= 22;) {
      if (noList[i] != 0) {
        if (displayNosAtClaimTime.contains(noList[i]) && isCellSeleced[i]) {
          bottomLeft = true;
        }
        i = 100;
      } else {
        i++;
      }
    }
    for (int i = 26; i >= 22;) {
      if (noList[i] != 0) {
        if (displayNosAtClaimTime.contains(noList[i]) && isCellSeleced[i]) {
          bottomRight = true;
        }
        i = 0;
      } else {
        i--;
      }
    }
    if (topLeft && topRight && bottomLeft && bottomRight) {
      print('Corner has gone!!!');
      Utils.showOKAlertDialog(
          context, Constant.YOU_WON, Constant.WON_CORNERS_MESSAGE);
      setState(() {
        wonCorners = true;
      });
    } else {
      print('Sorry!! need more nos!!!');
      Utils.showOKAlertDialog(
          context, Constant.TRY_AGAIN, Constant.CLAIM_ERREO_MESSAGE);
    }
  }

  void claimFullHouse(int index) {
    print('Housefull Claimed');
    List<int> noList=new List();
    noList.addAll(ticketList[index]);
    List<bool> isCellSeleced=new List();
    isCellSeleced.addAll(cellSelectedMap[index]);
    displayNosAtClaimTime.clear();
    displayNosAtClaimTime.addAll(displayNos);
    int count = 0;
    for (int p = 0; p <= 26; p++) {
      if (noList[p] != 0 &&
          displayNosAtClaimTime.contains(noList[p]) &&
          isCellSeleced[p]) {
        count++;
      }
    }
    if (count == 15) {
      print('You won Housefull!!');
      Utils.showOKAlertDialog(
          context, Constant.YOU_WON, Constant.WON_FULL_HOUSE_MESSAGE);
      setState(() {
        wonFullHouse = true;
      });
    } else {
      print('Sorry!! need more nos!!!');
      Utils.showOKAlertDialog(
          context, Constant.TRY_AGAIN, Constant.CLAIM_ERREO_MESSAGE);
    }
  }

  void claimLine(int i, int j, String line, int index) {
    List<int> noList=new List();
    noList.addAll(ticketList[index]);
    List<bool> isCellSeleced=new List();
    isCellSeleced.addAll(cellSelectedMap[index]);

    displayNosAtClaimTime.clear();
    //displayNosAtClaimTime = displayNos;
    displayNosAtClaimTime.addAll(displayNos);
    int count = 0;
    for (int p = i; p <= j; p++) {
      if (noList[p] != 0 &&
          displayNosAtClaimTime.contains(noList[p]) &&
          isCellSeleced[p]) {
        count++;
      }
    }
    if (count == 5) {
      print('You won $line line!!!');
      Utils.showOKAlertDialog(
          context, Constant.YOU_WON, 'You won $line line!!!');
      switch (line) {
        case 'Top':
          setState(() {
            wonTopLine = true;
          });
          break;
        case 'Middle':
          setState(() {
            wonMidLine = true;
          });
          break;
        case 'Bottom':
          setState(() {
            wonBottomLine = true;
          });
          break;
      }
    } else {
      print('Sorry!! need more nos!!!');
      Utils.showOKAlertDialog(
          context, Constant.TRY_AGAIN, Constant.CLAIM_ERREO_MESSAGE);
    }
  }

  void setScrollerPosition() {
    /*_scrollController.animateTo(
            0.0,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 10));*/
    //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    /* _scrollController.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 10),
        );*/
  }

  Widget getAllTickets() {
    return Expanded(
      child: new ListView.builder(
          //padding: const EdgeInsets.fromLTRB(50.0,40.0,50.0,40.0),
          //padding: const EdgeInsets.all(50.0),
          scrollDirection: Axis.vertical,
          itemCount: ticketList.length,
          padding: EdgeInsets.all(8.0),
          shrinkWrap: true,
          //reverse: true,
          //controller: _scrollController,
          itemBuilder: (BuildContext ctxt, int index) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getSingleTicket(index),
                ),
                Container(
                  width: 25.0,
                )
              ],
            );
          }),
    );
  }

  void initTicket() {
    ticketList[0] = noList0;
    ticketList[1] = noList1;
    ticketList[2] = noList2;
    ticketList[3] = noList3;
  }
}
