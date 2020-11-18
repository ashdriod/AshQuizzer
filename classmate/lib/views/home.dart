import 'package:classmate/services/database.dart';
import 'package:classmate/views/Createquiz.dart';
import 'package:classmate/views/play_quiz.dart';
import 'package:classmate/widget/widgets.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  Widget quizList() {

    return Container(

      child:
          StreamBuilder(
            stream: quizStream,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return QuizTile(
                      noOfQuestions: snapshot.data.documents.length,
                      imageUrl:
                      snapshot.data.documents[index].data['quizImgUrl'],
                      title:
                      snapshot.data.documents[index].data['quizTitle'],
                      description:
                      snapshot.data.documents[index].data['quizDesc'],
                      id: snapshot.data.documents[index].data["quizId"],
                    );
                  });
            },
          )


    );

  }

  @override
  void initState() {
    databaseService.getQuizData().then((value) {
      quizStream = value;
      setState(() {});
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.yellow,
        elevation: 2.2,
        brightness: Brightness.light,
        centerTitle: true,
      ),
      body:quizList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imageUrl, title, id, description;
  final int noOfQuestions;

  QuizTile(
      {@required this.title,
        @required this.imageUrl,
        @required this.description,
        @required this.id,
        @required this.noOfQuestions});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> PlayQuiz(
        id
        )));



      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: 157,
        margin:EdgeInsets.only(bottom: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),

          child: Stack(
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width-48,
              ),
              Container(
                color: Colors.black26,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        description,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
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

