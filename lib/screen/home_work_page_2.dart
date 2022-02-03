import 'package:flutter/material.dart';
import 'package:home_work_2_4/utilits/mine_theme.dart';
import "package:sliding_switch/sliding_switch.dart";
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';


//Предача класса _SwitchesProectState (код изображения страницы) классу class SwitchesProect
//который перерерисовывает изображение страницы после выбора пользователем разных кнопочек
enum Skilllevel{hot, sweet_sour, cheese}

class SwitchesProect extends StatefulWidget {
  const SwitchesProect({Key? key}) : super(key: key);



  @override
  _SwitchesProectState createState() => _SwitchesProectState();
}

// Код изображения страницы проекта
class _SwitchesProectState extends State<SwitchesProect> {
  bool _checked = false;
  double _pizzaSize = 40;
  bool _slimDough = false;
  int _cost = 100;
  bool _addCheese = true;

  Skilllevel? _skilllevel = Skilllevel.hot;

  void _onCheckedChenge(bool? val) {
    setState(() {
      _checked = !_checked;
    });
  }


  void _onSkilllevel(Skilllevel? value) {
    setState(() {
      _skilllevel = value;
    });
  }

  // Функция вычисления стоимости пиццы
  int _costPizza() {
    _cost = (_pizzaSize.round() + 50) * 3;

    if (_slimDough == true) _cost -= 30;
    if (_addCheese == true) _cost += 50;

    switch (_skilllevel) {
      case Skilllevel.hot:
        _cost += 20;
        break;
      case Skilllevel.sweet_sour:
        _cost += 40;
        break;
      case Skilllevel.cheese:
        _cost += 30;
        break;
      case null:
        _skilllevel = Skilllevel.hot;
        break;
    }
    return _cost;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MineTheme(),
      home: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Center(
          child: Column(
              // картинка ПИЦЦЫ
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                        width: 300,
                        height: 200,
                        child: Image(
                            image:AssetImage("assets/pizza.png")
                        )
                    ),
                  ],
                ),
                // Заголовок 'Калькулятор пиццы'
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Калькулятор пиццы', style: Theme.of(context).textTheme.headline5),
                  ],
                ),
                //Заголовок 'Выберите параметры'
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Выберите параметры',
                        style: TextStyle(fontSize: 20,
                      color:Color.fromRGBO(118, 87, 45, 1.0), fontWeight: FontWeight.w500
                )
                    ),
                  ],
                ),
                // Выбор теста для пиццы:
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                 width: 300,
                 child: SlidingSwitch(
                   value: false,
                   width: 300,
                   onChanged: (bool value){
                     _slimDough = value;
                     setState(() {
                       _costPizza();
                     });
                   },
                   height: 30,
                   animationDuration: const Duration(milliseconds: 100),
                   onTap: (){},
                   onDoubleTap: (){},
                   onSwipe: (){},
                   textOff: 'Обычное тесто',
                   textOn: 'Тонкое тесто',
                   colorOff: const Color.fromRGBO(226, 219, 218, 1.0),
                   colorOn: const Color.fromRGBO(226, 219, 218, 1.0),
                   buttonColor: const Color(0xffc25454),
                   background: const Color.fromRGBO(226, 219, 218, 1.0),
                   inactiveColor:const Color.fromRGBO(146, 143, 143, 1.0) ,
                 ),
                ),
                // Выбор размера пиццы:
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Размер:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(120, 89, 52, 1.0)),
                      ),
                      SizedBox(
                        width:230,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 350,
                  child: SfSlider(
                    min: 20,
                    max: 60,
                    value: _pizzaSize,
                    interval: 20,
                    showTicks: true,
                    showLabels: true,
                    numberFormat: NumberFormat ('##cm'),
                    enableTooltip: false,
                    stepSize: 20,
                    onChanged: (dynamic value){
                      setState(() {
                        _pizzaSize = value;
                        _costPizza();
                      });
                    },
                  ),
                ),
                //Выбор соуса:
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 290, 0),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Соус:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(120, 89, 52, 1.0)),
                    ),
                  ],
              ),
                ),
                RadioListTile<Skilllevel>(activeColor: Color(0xffc25454),
                 title: const Text('острый',
                     style: TextStyle(
                         fontSize: 16,
                         color: Color.fromRGBO(101, 100, 100, 1.0),
                         fontWeight: FontWeight.w500
                     ),),
                 value: Skilllevel.hot,
                 groupValue: _skilllevel,
                 onChanged: _onSkilllevel
                ),
                RadioListTile<Skilllevel> (activeColor: Color(0xffc25454),
                  title: const Text('кисло-сладкий',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(101, 100, 100, 1.0),
                        fontWeight: FontWeight.w500
                    ),),
                    value: Skilllevel.sweet_sour,
                    groupValue: _skilllevel,
                    onChanged: _onSkilllevel,
                ),
                RadioListTile<Skilllevel> (activeColor: Color(0xffc25454),
                  title: const Text('острый',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(101, 100, 100, 1.0),
                        fontWeight: FontWeight.w500
                    ),),
                    value: Skilllevel.cheese,
                    groupValue: _skilllevel,
                    onChanged: _onSkilllevel,
                ),
                SizedBox(
                  width: 350,
                  child: Card(
                    elevation: 0,
                    color: const Color.fromRGBO(226, 219, 218, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: SizedBox(
                            width: 38,
                            height: 48,
                            child: Image.asset('assets/cheese_2.png')),
                        ),
                       const Text('Дополнительный сыр',
                       style: TextStyle(fontSize: 16),
                       ),
                        Switch(
                          value: _addCheese,
                          activeColor: Color(0xffc25454),
                          onChanged: (bool value) {setState(() {_addCheese = value;
                          _costPizza();});
                          }
                          ),
                      ],
                    )
                  ),
                ),
                // Изображение стоимости пиццы:
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Стоимость:',
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(120, 89, 52, 1.0)
                        ),
                      ),
                      SizedBox(
                        width: 197,
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 250,
                    height: 50,

                    child: Card(
                      elevation: 0,
                      color: const Color.fromRGBO(226, 219, 218, 1.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                    ),
                      child: Text('${_costPizza()} руб.',
                      style: const TextStyle(
                          fontSize: 30,
                          color: Color(0xffc25454),
                          fontWeight: FontWeight.w700,
                           ),
                        textAlign: TextAlign.center
                        ),
                  ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}
