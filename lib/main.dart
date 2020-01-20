import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  String _resultText;
  int _dutchTreatType;
  int _count;
  int _price;
  int _coordinatorPrice;
  int _cuppedPrice;
  int _cuppedCount;


  @override
  void initState() {
    super.initState();
    _resultText = "結果がこちらに表示されます。";
    _dutchTreatType = 0;
    _count = 0;
    _price = 0;
    _coordinatorPrice = 0;
    _cuppedPrice = null;
    _cuppedCount = null;
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }

  Widget _build(BuildContext context) {
    return this.keyboardDismiss(
        context: context,
        child:
          new Form(
            key: _formKey,
            child: new Scaffold(
              appBar: new AppBar(
                title: new Text('小銭びと電卓'),
              ),
              body:
                new Column(
                    children: <Widget>[
                      new Text(
                        "小銭を払う<小銭びと>の支払額を算出します。",
                        style: new TextStyle(
                            fontSize:17.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w200,
                            fontFamily: "Roboto"
                        ),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 余白を均等に使用する
                        children: <Widget>[
                          new SizedBox(
                            width: 150.0,
                            height: 100.0,
                            child:
                            new TextFormField(
                              autofocus: true,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.people),
                                hintText: '例: 5',
                                labelText: '人数 *',
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return '必須項目です';
                                }
                                if (_cuppedCount != null && int.tryParse(value) <= _cuppedCount) {
                                  return '不正なカスタム設定';
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                this._count = int.tryParse(value);
                              },
                              keyboardType: TextInputType.number,
                            ),

                          ),
                          new SizedBox(
                            width: 150.0,
                            height: 100.0,
                            child:
                            new TextFormField(
                              decoration: const InputDecoration(
                                icon: Icon(Icons.attach_money),
                                hintText: '例: 1000',
                                labelText: '金額 *',
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return '必須項目です';
                                }
                                if (_cuppedPrice != null && int.tryParse(value) <= _cuppedPrice * _cuppedCount) {
                                  return '不正なカスタム設定';
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                this._price = int.tryParse(value);
                              },
                              keyboardType: TextInputType.number,
                            ),

                          ),
                        ],
                      ),

                      new Column(
                        children: <Widget>[
                          new Text(
                              "小銭びと以外の支払い桁 *",
                              style: new TextStyle(fontSize:12.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto"
                              ),
                          ),
                          new SizedBox(
                            width: 200.0,
                            height: 30.0,
                            child:
                            new RadioListTile(
                              activeColor: Colors.blue,
                              title: Text('1円単位'),
                              value: 1,
                              controlAffinity: ListTileControlAffinity.leading,
                              groupValue: _dutchTreatType,
                              onChanged: _handleDutchTreatRadio,
                            ),
                          ),
                          new SizedBox(
                            width: 200.0,
                            height: 30.0,
                            child:
                            new RadioListTile(
                              activeColor: Colors.blue,
                              title: Text('10円単位'),
                              value: 10,
                              controlAffinity: ListTileControlAffinity.leading,
                              groupValue: _dutchTreatType,
                              onChanged: _handleDutchTreatRadio,
                            ),

                          ),
                          new SizedBox(
                            width: 200.0,
                            height: 30.0,
                            child:
                            new RadioListTile(
                              activeColor: Colors.blue,
                              title: Text('100円単位'),
                              value: 100,
                              controlAffinity: ListTileControlAffinity.leading,
                              groupValue: _dutchTreatType,
                              onChanged: _handleDutchTreatRadio,
                            ),

                          ),
                          new SizedBox(
                            width: 200.0,
                            height: 60.0,
                            child:
                            new RadioListTile(
                              activeColor: Colors.blue,
                              title: Text('1000円単位'),
                              value: 1000,
                              controlAffinity: ListTileControlAffinity.leading,
                              groupValue: _dutchTreatType,
                              onChanged: _handleDutchTreatRadio,
                            ),

                          ),
                        ],
                      ),

                      RaisedButton(
                        onPressed: onCalcButtonPressed,
                        child: Text('計算'),
                      ),

                      new Text(
                        _resultText,
                        style: new TextStyle(
                            fontSize:17.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w200,
                            fontFamily: "Roboto"
                        ),
                      ),
                      _minPriceCup(),
                    ]
                ),
            ),
        ),
    );
  }

  Widget _minPriceCup() {
    return new Column(
      children: <Widget>[
        new Text(
          "\nカスタム設定",
          style: new TextStyle(
              fontSize:17.0,
              color: const Color(0xFF0000FF),
              fontWeight: FontWeight.w200,
              fontFamily: "Roboto"
          ),
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 余白を均等に使用する
          children: <Widget>[
            new SizedBox(
              width: 150.0,
              height: 100.0,
              child:
                new TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: '例: 1',
                    labelText: '下/上限の人数',
                  ),
                  validator: (String value) {
                      return (value.isEmpty && _cuppedPrice != null) ? '片側の未入力' : null;
                  },
                  onChanged: (String value) {
                    if (value != null) {
                      this._cuppedCount = int.tryParse(value);
                    } else {
                      this._cuppedCount = null;
                    }
                  },
                  onSaved: (String value) {
                    if (value != null) {
                      this._cuppedCount = int.tryParse(value);
                    } else {
                      this._cuppedCount = null;
                    }
                  },
                  keyboardType: TextInputType.number,
                ),
            ),
            new SizedBox(
              width: 150.0,
              height: 100.0,
              child:
              new TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.money_off),
                  hintText: '例: 10000',
                  labelText: '下/上限の金額',
                ),
                validator: (String value) {
                  return (value.isEmpty && _cuppedCount != null) ? '片側の未入力' : null;
                },
                onChanged: (String value) {
                  if (value != null) {
                    this._cuppedPrice = int.tryParse(value);
                  } else {
                    this._cuppedPrice = null;
                  }
                },
                onSaved: (String value) {
                  if (value != null) {
                    this._cuppedPrice = int.tryParse(value);
                  } else {
                    this._cuppedPrice = null;
                  }
                },
                keyboardType: TextInputType.number,
              ),
            ),
          ]
        ),
      ],
    );
  }

  List calculateBinarySimultaneousEquations(List f0, List f1) {
    int x = ((f0[2]*f1[1]-f0[1]*f1[2])/(f0[0]*f1[1]-f0[1]*f1[0])).round();
    int y = ((f1[2]*f0[0]-f0[2]*f1[0])/(f0[0]*f1[1]-f1[0]*f0[1])).round();
    return [x, y];
  }

  void onCalcButtonPressed() {
    FocusScope.of(context).requestFocus(new FocusNode());

    if (!this._formKey.currentState.validate()) {
      return;
    }
    this._formKey.currentState.save();

    double _average = (_price / _count * 100).round() / 100; // ex. 100.01234 → 100.01
    int _minPrice;
    int _maxPrice;
    int _minCount;
    int _maxCount;

    // キャップありの場合
    if (_cuppedPrice != null && _cuppedPrice >= 0 && _cuppedCount != null && _cuppedCount >= 0) {
      _minCount = _cuppedCount;
      _maxCount = _count - _cuppedCount;
      _minPrice = _cuppedPrice;
      _maxPrice = ((_price - _minPrice * _minCount) / _maxCount / _dutchTreatType).floor() * _dutchTreatType;

    // キャップなしの場合
    } else {
      _minPrice = (_average / _dutchTreatType).floor() * _dutchTreatType;
      _maxPrice = (_average / _dutchTreatType).ceil() * _dutchTreatType;

      if (_maxPrice != _minPrice && _maxPrice != 0 && _minPrice != 0) {
        List countList = new List();
        countList = calculateBinarySimultaneousEquations([_maxPrice, _minPrice, _price],[1,1,_count]);
        _maxCount = countList[0];
        _minCount = countList[1];
      } else {
        _maxCount = 0;
        _minCount = _count;
      }
    }

    if (_maxPrice < _minPrice) {
      int _tmpPrice = _maxPrice;
      _maxPrice = _minPrice;
      _minPrice = _tmpPrice;
      _minCount = _maxCount;
      _maxCount = _count - _minCount;
    }

    _coordinatorPrice = _price - (_maxCount * _maxPrice + _minCount * _minPrice);

    if (_coordinatorPrice != 0) {
      if (_maxCount == 0) {
        _coordinatorPrice += _minPrice;
        _minCount -= 1;
      } else {
        _coordinatorPrice += _maxPrice;
        _maxCount -= 1;
      }

      setState(() {
        _resultText = "端: " + _coordinatorPrice.toString() + "円　小銭びと\n"
            + "大: " + _maxPrice.toString() + "円　" + _maxCount.toString() + "人\n"
            + "小: " + _minPrice.toString() + "円　" + _minCount.toString() + "人\n"
            + "（平均: " + _average.toString() + "円）";
      });
    } else {
      setState(() {
        _resultText = "小銭びとは生まれない\n"
            + "大: " + _maxPrice.toString() + "円　" + _maxCount.toString() + "人\n"
            + "小: " + _minPrice.toString() + "円　" + _minCount.toString() + "人\n"
            + "（平均: " + _average.toString() + "円）";
      });
    }
  }

  void _handleDutchTreatRadio(int e) => setState(() {_dutchTreatType = e;});

  Widget keyboardDismiss({BuildContext context, Widget child}) {
    final gesture = GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: child,
    );

    return gesture;
  }
}