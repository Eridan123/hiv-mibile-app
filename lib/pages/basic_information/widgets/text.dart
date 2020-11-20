
import 'package:HIVApp/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(TextWidget());

class TextWidget extends StatefulWidget {
  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {

  bool _isLoading = true;
  int _textBodyNumber = 1;
  double _fontSize = 18;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
          children: [
            ListTile(
                title: Text(
                  'Что такое ВИЧ?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: () {
                  Route route =
                  MaterialPageRoute(builder: (context) => TextBody(fontSize: _fontSize, title: 'Что такое ВИЧ?', type: 1,));
                  Navigator.push(context,route);
                }),
            Divider(),
            ListTile(
                title: Text(
                  'Иммунная система',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                onTap: () {

                  Route route =
                  MaterialPageRoute(builder: (context) => TextBody(fontSize: _fontSize, title: 'Иммунная система', type: 2,));
                  Navigator.push(context,route);}
            ),
          ],
      ),
    );
  }
}


class TextBody extends StatefulWidget {
  double fontSize;
  String title;
  int type;

  TextBody({this.fontSize, this.title, this.type});

  @override
  _TextBodyState createState() => _TextBodyState();
}

class _TextBodyState extends State<TextBody> {
  Widget _myListView1(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: ListTile.divideTiles(
        color: Colors.transparent,
        context: context,
        tiles: [
          ListTile(
            title: RichText(
              text: TextSpan(
                  style: TextStyle( fontWeight: FontWeight.bold, fontSize:  widget.fontSize+3, color: Theme.of(context).cursorColor),
                  children: [
                    TextSpan(text: 'ЧТО ТАКОЕ ВИРУС?'),
                  ]
              ),
            ),
          ),
          ListTile(
            title: RichText(
              text: TextSpan(
                  style: TextStyle( fontSize:  widget.fontSize, color: Theme.of(context).cursorColor),
                  children: [
                    TextSpan(text: 'Вирусы', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' – это мельчайшие возбудители некоторых инфекционных заболеваний. Вирусы настолько малы, что их можно разглядеть только через '
                        'электронный микроскоп при очень большом увеличении. Попадая в человеческий организм, вирусы вызывают такие инфекционные болезни, как '
                        'ВИЧ-инфекция, грипп, полиомиелит, бешенство, гепатит и другие.Вирусы передаются человеку различными путями. Например, вирус ветряной '
                        'оспы передается через воздух, а вирус гепатита А передается через пищу или воду.\n'),
                  ]
              ),
            ),
          ),
          ListTile(
            title: RichText(
              text: TextSpan(
                  style: TextStyle( fontWeight: FontWeight.bold, fontSize:  widget.fontSize+3, color: Theme.of(context).cursorColor),
                  children: [
                    TextSpan(text: 'ЧТО ТАКОЕ ВИЧ?'),
                  ]
              ),
            ),
          ),
          ListTile(
            title: RichText(
              text: TextSpan(
                  style: TextStyle( fontSize:  widget.fontSize, color: Theme.of(context).cursorColor),
                  children: [
                    TextSpan(text: 'ВИЧ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '– это вирус иммунодефицита человека: \n'),
                  ]
              ),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.solidCircle, color: kColorPrimary,),
            title: RichText(
              text: TextSpan(
                  style: TextStyle( fontSize:  widget.fontSize, color: Theme.of(context).cursorColor),
                  children: [
                    TextSpan(text: 'Вирус', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' – это мельчайший возбудитель инфекционных заболеваний;'),
                  ]
              ),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.solidCircle, color: kColorPrimary,),
            title: RichText(
              text: TextSpan(
                  style: TextStyle( fontSize:  widget.fontSize, color: Theme.of(context).cursorColor),
                  children: [
                    TextSpan(text: 'Иммунодефицит ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '– означает, что вирус разрушает иммунную систему и создает условия «дефицита» (слабости, недостатка) в борьбе организма против инфекционных заболеваний;'),
                  ]
              ),
            ),
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.solidCircle, color: kColorPrimary,),
            title: RichText(
              text: TextSpan(
                  style: TextStyle( fontSize:  widget.fontSize, color: Theme.of(context).cursorColor),
                  children: [
                    TextSpan(text: 'Человека ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '– означает то, что данный вирус поражает только человека.ВИЧ относится к семейству '),
                    TextSpan(text: '«ретровирусов» ', style: TextStyle(fontStyle: FontStyle.italic)),
                    TextSpan(text: ', поэтому противовирусные лекарства, назначаемые для лечения ВИЧ-инфекции, называются '),
                    TextSpan(text: 'антиретровирусными препаратами, ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' а лечение называется '),
                    TextSpan(text: 'антиретровирусная терапия (АРТ). ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'ВИЧ вызывает у людей заболевание, которое называют '),
                    TextSpan(text: 'ВИЧ-инфекция.', style: TextStyle(fontWeight: FontWeight.bold)),
                  ]
              ),
            ),
          ),
        ],
      ).toList(),
    );
  }
  Widget _myListView2(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: ListTile.divideTiles(
        color: Colors.transparent,
        context: context,
        tiles: [
          ListTile(
            title: RichText(
              text: TextSpan(
                  style: TextStyle( fontWeight: FontWeight.bold, fontSize:  widget.fontSize+3, color: Theme.of(context).cursorColor),
                  children: [
                    TextSpan(text: 'ЧТО ТАКОЕ ИММУННАЯ СИСТЕМА?'),
                  ]
              ),
            ),
          ),
          ListTile(
            title: RichText(
              text: TextSpan(
                  style: TextStyle( fontSize:  widget.fontSize, color: Theme.of(context).cursorColor),
                  children: [
                    TextSpan(text: 'Иммунная система организма', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' отвечает за защиту организма от всего чужого – как от чужеродных агентов (микробов, вирусов), '
                        'так и от собственных измененных клеток организма. Это позволяет сохранить целостность организма. Поэтому ее еще называют '),
                    TextSpan(text: 'защитной системой.\n', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Основные клетки иммунной защиты находятся в крови и костном мозге, в других органах, например, в печени. '
                        'Различают несколько видов иммунных клеток, одними из них являются Т-лимфоциты помощники (хелперы), которые организуют '
                        'слаженную работу иммунной системы. Их называют СД4 клетками. \nЧеловека окружает множество микроорганизмов (вирусы, бактерии, '
                        'грибки), которые при попадании в организм могут стать причиной инфекционных заболеваний (грипп, менингит, туберкулез, дизентерия '
                        'и т. п.). Иммунная система в большинстве случаев уничтожает микроорганизмы, попадающие в человеческий организм, защищая его от болезней.'
                        ' Однако, ВИЧ – вирус иммунодефицита человека – разрушает основные клетки иммунитета (СД4 клетки). В результате организм становится беззащитным перед другими болезнями.'),
                  ]
              ),
            ),
          ),
          ListTile(
            title: Column(
              children: [
                Container(
                  child: Image.asset('assets/images/image2.png', fit: BoxFit.fitWidth,),
                ),
              ],
            ),
          ),
          ListTile(
            title: Column(
              children: [
                Container(
                    child: Image.asset('assets/images/image1.png', fit: BoxFit.fitWidth,)),
              ],
            ),
          ),
          ListTile(
            title: RichText(
              text: TextSpan(
                  style: TextStyle( fontWeight: FontWeight.bold, fontSize:  widget.fontSize+3, color: Theme.of(context).cursorColor),
                  children: [
                    TextSpan(text: 'ЧТО ПРОИСХОДИТ, КОГДА ВИЧ ПОПАДАЕТ В ОРГАНИЗМ ЧЕЛОВЕКА?'),
                  ]
              ),
            ),
          ),
          ListTile(
            title: RichText(
              text: TextSpan(
                  style: TextStyle( fontSize:  widget.fontSize, color: Theme.of(context).cursorColor),
                  children: [
                    TextSpan(text: 'Когда ВИЧ попадает в организм человека, он атакует клетки иммунной системы, а именно, '),
                    TextSpan(text: 'Т-лимфоциты помощники (CД4 клетки). ', style: TextStyle(fontStyle: FontStyle.italic)),
                    TextSpan(text: 'В результате пораженная клетка начинает сама производить вирусы. Таким образом, она теряет свои защитные функции и со временем погибает. '
                        'До 10 миллиардов новых вирусных частиц вырабатываются в день и миллионы CД4 клеток разрушаются ежедневно. Новые вирусы выходят из клетки и поражают новые '
                        'Т-лимфоциты. Уменьшение числа CД4 клеток приводит к снижению иммунитета, который уже не может защищать организм от возбудителей инфекционных и других заболеваний, '
                        'которые редко наблюдаются у лиц с сильной иммунной системой. Их называют СПИД-индикаторными заболеваниями или '),
                    TextSpan(text: 'оппортунистическими инфекциями.', style: TextStyle(fontWeight: FontWeight.bold)),
                  ]
              ),
            ),
          ),
          ListTile(
            tileColor: Colors.lightBlue,
            title: RichText(
              text: TextSpan(
                  style: TextStyle( fontSize:  widget.fontSize, color: Theme.of(context).cursorColor),
                  children: [
                    TextSpan(text: 'Состояние иммунной системы инфицированного ВИЧ человека определяется подсчетом CД4 клеток. Их количество '
                        'в крови составляет в норме от 500 до 1500 клеток в 1 микролитре. Когда у человека, живущего с ВИЧ, выявляется одна '
                        'или несколько оппортунистических инфекций и уровень СД4 клеток снижается ниже 200 в 1 микролитре крови, то говорят о наступлении стадии СПИДа.',
                        style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                  ]
              ),
            ),
          ),
        ],
      ).toList(),
    );
  }


  Widget _getCorrectTextBody(BuildContext context, int type){

    if(type == 1){
      return _myListView1(context);
    }
    else if(type ==2){
      return _myListView2(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Column(
            children: [
              Text(widget.title),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,5,0,10),
                child: Slider(
                  value: widget.fontSize,
                  min: 10,
                  max: 50,
                  divisions: 15,
                  label: widget.fontSize.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      widget.fontSize = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        body: _getCorrectTextBody(context, widget.type),
      ),
    );
  }
}