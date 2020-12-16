import 'package:HIVApp/components/custom_button.dart';
import 'package:HIVApp/data/pref_manager.dart';
import 'package:HIVApp/model/test_model.dart';
import 'package:HIVApp/routes/routes.dart';
import 'package:HIVApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../empty_page.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with AutomaticKeepAliveClientMixin<TestPage> {

  bool _isdark = Prefs.getBool(Prefs.DARKTHEME, def: false);
  List<TestModel> _testList = new List<TestModel>();


  var _kTabs = [
    Tab(
      text: 'Секс',
    ),
    Tab(
      text: 'Кровь',
    ),
    Tab(
      text: 'Симптомы',
    ),
  ];

  final _kTabTextStyle = TextStyle(
    color: kColorBlue,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  var _kTabPages = [
  ];



  fillTheTests(){
    setState(() {

      _kTabPages = [
        SexQuestions(),
        EmptyPage(),
        EmptyPage(),
      ];
    });
  }

  @override
  void initState() {
    fillTheTests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('screening_on_hiv'.tr()),
      ),
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: _kTabs.length,
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _isdark
                          ? Colors.white.withOpacity(0.12)
                          : Color(0xfffbfcff),
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: _isdark ? Colors.black87 : Colors.grey[200],
                        ),
                        bottom: BorderSide(
                          width: 1,
                          color: _isdark ? Colors.black87 : Colors.grey[200],
                        ),
                      ),
                    ),
                    child: TabBar(
                      indicatorColor: kColorBlue,
                      labelStyle: _kTabTextStyle,
                      unselectedLabelStyle:
                      _kTabTextStyle.copyWith(color: Colors.grey),
                      labelColor: kColorBlue,
                      unselectedLabelColor: Colors.grey,
                      tabs: _kTabs,
                    ),
                  ),
                  Expanded(
                    child: SexQuestions(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class QuestionBuilder extends StatefulWidget {
  int type;


  QuestionBuilder({this.type});

  @override
  _QuestionBuilderState createState() => _QuestionBuilderState();
}

class _QuestionBuilderState extends State<QuestionBuilder> {
  TestTreeModel model = new TestTreeModel();

  var question2 = new TestTreeModel(body: "В сексе я предпочитаю", value: 0, );
  var question3 = new TestTreeModel(body: "Количество партнеров в сексе за последний год", value: 0, );
  var question4 = new TestTreeModel(body: "Я занимаюсь с сексом за вознаграждение", value: 0, );
  var question5 = new TestTreeModel(body: "Я знаю, что у моего партнера по сексу ВИЧ", value: 0, );
  var question6 = new TestTreeModel(body: "Мой партнер регулярно принимает АРТ(терапию, сдерживающую ВИЧ)", value: 0, );
  var question7 = new TestTreeModel(body: "Мой половой партнер ВИЧ положительный)", value: 0, );
  var question8 = new TestTreeModel(body: "Я использую стимуляторы или другие вещества, чтобы сделать секс интересней и ярче", value: 0, );
  var question9 = new TestTreeModel(body: "Я практикую анальный секс", value: 0, );
  var question10 = new TestTreeModel(body: "У моего полового партнера (партнеров) бывают другие партнеры", value: 0, );
  var question11 = new TestTreeModel(body: "Я использую/требую от партнера использовать презерватив", value: 0, );
  var question12 = new TestTreeModel(body: "Мой партнер (партнеры) занимаются сексом за вознаграждение", value: 0, );
  var question13 = new TestTreeModel(body: "У меня случаются рискованные половые контакты, которые могут привести к инфицированию ВИЧ", value: 0, );
  var question14 = new TestTreeModel(body: "У меня был секс с мужчиной за последние 6 месяцев", value: 0, );
  var question15 = new TestTreeModel(body: "Мы использовали презерватив", value: 0, );
  var question16 = new TestTreeModel(body: "Мы практиковали анальный секс", value: 0, );
  var question17 = new TestTreeModel(body: "я использую презерватив, когда занимаюсь сексом", value: 0, );
  var question18 = new TestTreeModel(body: "я использую презерватив, когда занимаюсь анальным сексом", value: 0, );


  var question2Answer1 = new TestTreeModel(body: "Не важно", value: 0,);
  var question2Answer2 = new TestTreeModel(body: "Мужчин", value: 0,);
  var question2Answer3 = new TestTreeModel(body: "Женщин", value: 0,);

  var question3Answer1 = new TestTreeModel(body: "1", value: 0, );
  var question3Answer2 = new TestTreeModel(body: ">1", value: 0, );
  var question3Answer3 = new TestTreeModel(body: "Много", value: 0, );
  var question3Answer4 = new TestTreeModel(body: "Нет", value: 0, );


  var question4Answer1 = new TestTreeModel(body: "Да", value: 0, );
  var question4Answer2 = new TestTreeModel(body: "Нет", value: 0, );

  var question5Answer1 = new TestTreeModel(body: "Да", value: 0, );
  var question5Answer2 = new TestTreeModel(body: "Нет", value: 0, );
  var question5Answer3 = new TestTreeModel(body: "Затрудняюсь ответить", value: 0, );

  var question6Answer1 = new TestTreeModel(body: "Да", value: 0, );
  var question6Answer2 = new TestTreeModel(body: "Нет", value: 0, );
  var question6Answer3 = new TestTreeModel(body: "Не знаю", value: 0, );

  var question7Answer1 = new TestTreeModel(body: "Да", value: 0, );
  var question7Answer2 = new TestTreeModel(body: "Нет", value: 0, );
  var question7Answer3 = new TestTreeModel(body: "Не знаю", value: 0, );

  var question8Answer1 = new TestTreeModel(body: "Да", value: 0, );
  var question8Answer2 = new TestTreeModel(body: "Нет", value: 0, );

  var question9Answer1 = new TestTreeModel(body: "Да", value: 0, );
  var question9Answer2 = new TestTreeModel(body: "Нет", value: 0, );

  var question10Answer1 = new TestTreeModel(body: "Да", value: 0, );
  var question10Answer2 = new TestTreeModel(body: "Нет", value: 0, );
  var question10Answer3 = new TestTreeModel(body: "Не знаю", value: 0, );

  var question11Answer1 = new TestTreeModel(body: "Всегда", value: 0, );
  var question11Answer2 = new TestTreeModel(body: "Никогда", value: 0, );
  var question11Answer3 = new TestTreeModel(body: "Иногда", value: 0, );

  var question12Answer1 = new TestTreeModel(body: "Да", value: 0, );
  var question12Answer2 = new TestTreeModel(body: "Нет", value: 0, );
  var question12Answer3 = new TestTreeModel(body: "Не знаю", value: 0, );

  var question13Answer1 = new TestTreeModel(body: "Бывает", value: 0, );
  var question13Answer2 = new TestTreeModel(body: "Никогда", value: 0, );

  var question14Answer1 = new TestTreeModel(body: "Да", value: 0, );
  var question14Answer2 = new TestTreeModel(body: "Нет", value: 0, );

  var question15Answer1 = new TestTreeModel(body: "Да", value: 0, );
  var question15Answer2 = new TestTreeModel(body: "Нет", value: 0, );

  var question16Answer1 = new TestTreeModel(body: "Да", value: 0, );
  var question16Answer2 = new TestTreeModel(body: "Нет", value: 0, );

  var question17Answer1 = new TestTreeModel(body: "Всегда", value: 0, );
  var question17Answer2 = new TestTreeModel(body: "Никогда", value: 0, );
  var question17Answer3 = new TestTreeModel(body: "Не всегда", value: 0, );

  var question18Answer1 = new TestTreeModel(body: "Всегда", value: 0, );
  var question18Answer2 = new TestTreeModel(body: "Никогда", value: 0, );
  var question18Answer3 = new TestTreeModel(body: "Не всегда", value: 0, );

  @override
  void initState() {
    question2.answers = [question2Answer1, question2Answer2, question2Answer3];
    question3.answers = [question3Answer1, question3Answer2, question3Answer3, question3Answer4];
    question4.answers = [question4Answer1, question4Answer2];
    question5.answers = [question5Answer1, question5Answer2, question5Answer3];
    question6.answers = [question6Answer1, question6Answer2, question6Answer3];
    question7.answers = [question7Answer1, question7Answer2, question7Answer3];
    question8.answers = [question8Answer1, question8Answer2];
    question9.answers = [question9Answer1, question9Answer2];
    question10.answers = [question10Answer1, question10Answer2, question10Answer3];
    question11.answers = [question11Answer1, question11Answer2, question11Answer3];
    question12.answers = [question12Answer1, question12Answer2, question12Answer3];
    question13.answers = [question13Answer1, question13Answer2];
    question14.answers = [question14Answer1, question14Answer2];
    question15.answers = [question15Answer1, question15Answer2];
    question16.answers = [question16Answer1, question16Answer2];
    question17.answers = [question17Answer1, question17Answer2, question17Answer3];
    question18.answers = [question18Answer1, question18Answer2, question18Answer3];

    question2Answer1.to = question3;
    question2Answer2.to = question3;
    question2Answer3.to = question3;
    if(widget.type == 0)
      manQuestionBuilder();
    else if(widget.type == 1)
      womanQuestionBuilder();
    else if(widget.type == 2)
      transManQuestionBuilder();
    else if(widget.type == 3)
      transWomanQuestionBuilder();
    model = question2;
    super.initState();
  }

  manQuestionBuilder(){
    question3Answer1.to = question5;
    question3Answer2.to = question4;
    question3Answer3.to = question4;
    question3Answer4.to = question5;

    question4Answer1.to = question7;
    question4Answer2.to = question7;

    question5Answer1.to = question6;
    question5Answer2.to = question6;
    question5Answer2.to = question8;

    question6Answer1.to = question8;
    question6Answer2.to = question8;
    question6Answer3.to = question8;

    question7Answer1.to = question6;
    question7Answer2.to = question9;
    question7Answer3.to = question9;

    question8Answer1.to = question10;
    question8Answer2.to = question10;

    question9Answer1.to = question10;

    question10Answer1.to = question12;
    question10Answer2.to = question11;
    question10Answer3.to = question12;

    question11Answer1.to = question13;
    question11Answer2.to = question13;
    question11Answer3.to = question13;

    question12Answer1.to = question18;
    question12Answer2.to = question18;
    question12Answer3.to = question18;

    question18Answer1.to = question13;
    question18Answer2.to = question13;
    question18Answer3.to = question13;

  }
  womanQuestionBuilder(){

    question2Answer1.to = question3;
    question2Answer2.to = question3;
    question2Answer3.to = question3;

    question3Answer1.to = question7;
    question3Answer2.to = question4;
    question3Answer3.to = question4;
    question3Answer4.to = question7;

    question4Answer1.to = question7;
    question4Answer2.to = question7;

    question6Answer1.to = question9;
    question6Answer2.to = question9;
    question6Answer3.to = question9;

    question7Answer1.to = question6;
    question7Answer2.to = question9;
    question7Answer3.to = question9;

    question9Answer1.to = question10;
    question9Answer2.to = question10;

    question10Answer1.to = question12;
    question10Answer2.to = question18;
    question10Answer3.to = question12;

    question12Answer1.to = question18;
    question12Answer2.to = question18;
    question12Answer3.to = question18;

    question18Answer1.to = question13;
    question18Answer2.to = question13;
    question18Answer3.to = question13;

  }
  transManQuestionBuilder(){

    question2Answer1.to = question3;
    question2Answer2.to = question3;
    question2Answer3.to = question3;

    question3Answer1.to = question5;
    question3Answer2.to = question4;
    question3Answer3.to = question4;
    question3Answer4.to = question5;

    question4Answer1.to = question5;
    question4Answer2.to = question5;

    question5Answer1.to = question6;
    question5Answer2.to = question8;
    question5Answer3.to = question8;

    question6Answer1.to = question8;
    question6Answer2.to = question8;
    question6Answer3.to = question8;

    question8Answer1.to = question10;
    question8Answer2.to = question10;

    question10Answer1.to = question12;
    question10Answer2.to = question17;
    question10Answer3.to = question12;

    question12Answer1.to = question17;
    question12Answer2.to = question17;
    question12Answer3.to = question17;

    question17Answer1.to = question13;
    question17Answer2.to = question13;
    question17Answer3.to = question13;

  }
  transWomanQuestionBuilder(){

    question2Answer1.to = question3;
    question2Answer2.to = question3;
    question2Answer3.to = question3;

    question3Answer1.to = question5;
    question3Answer2.to = question4;
    question3Answer3.to = question4;
    question3Answer4.to = question5;

    question4Answer1.to = question5;
    question4Answer2.to = question5;

    question5Answer1.to = question6;
    question5Answer2.to = question8;
    question5Answer3.to = question8;

    question6Answer1.to = question8;
    question6Answer2.to = question8;
    question6Answer3.to = question8;

    question8Answer1.to = question10;
    question8Answer2.to = question10;

    question10Answer1.to = question12;
    question10Answer2.to = question17;
    question10Answer3.to = question12;

    question12Answer1.to = question17;
    question12Answer2.to = question17;
    question12Answer3.to = question17;

    question17Answer1.to = question13;
    question17Answer2.to = question13;
    question17Answer3.to = question13;

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.01,
                  MediaQuery.of(context).size.height * 0.1,
                  MediaQuery.of(context).size.width * 0.01,
                  MediaQuery.of(context).size.height * 0.2
              ),
              child: Container(child: Text(model.body, style: TextStyle(fontSize: 25), textAlign: TextAlign.center,)),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  itemCount: model.answers.length,
                    itemBuilder: (context, index){
                  return Container(
                    child: CustomButton(
                      text: model.answers[index].body,
                      onPressed: (){
                        if(model.answers[index].to != null){
                          setState(() {
                            model = model.answers[index].to;
                          });
                        }
                        else{
                          Navigator.pushNamed(context, Routes.test_warning);
                        }
                      },
                    ),
                  );
                })
            )
          ],
        ),
      ),
    );
  }
}


class SexQuestions extends StatefulWidget {
  @override
  _SexQuestionsState createState() => _SexQuestionsState();
}

class _SexQuestionsState extends State<SexQuestions> {

  var question1 = new TestTreeModel(body: "Я", value: 0,);
  var question1Answer1 = new TestTreeModel(body: "Мужчина", value: 0, );
  var question1Answer2 = new TestTreeModel(body: "Женщина", value: 0, );
  var question1Answer3 = new TestTreeModel(body: "Трансгендерный мужчина", value: 0, );
  var question1Answer4 = new TestTreeModel(body: "Трансгендерная женщина", value: 0, );
  bool showNext = false;
  int type;

  @override
  void initState() {
    question1.answers = [question1Answer1, question1Answer2, question1Answer3,question1Answer4];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return showNext ? QuestionBuilder(type: type,) :Container(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.01,
                  MediaQuery.of(context).size.height * 0.2,
                  MediaQuery.of(context).size.width * 0.01,
                  MediaQuery.of(context).size.height * 0.2
              ),
              child: Container(child: Text(question1.body, style: TextStyle(fontSize: 25),)),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                    itemCount: question1.answers.length,
                    itemBuilder: (context, index){
                      return Container(
                        child: CustomButton(
                          text: question1.answers[index].body,
                          onPressed: (){
                            setState(() {
                              type = index;
                              showNext = true;
                            });
                          },
                        ),
                      );
                    })
            )
          ],
        ),
      ),
    );
  }
}

class ManQuestions extends StatefulWidget {
  @override
  _ManQuestionsState createState() => _ManQuestionsState();
}

class _ManQuestionsState extends State<ManQuestions> {

  List<TestTreeModel> allNeededQuestions = new List<TestTreeModel>();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

