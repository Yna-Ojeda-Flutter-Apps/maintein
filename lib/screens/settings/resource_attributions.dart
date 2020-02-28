import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/widgets/bottomnavbar.dart';
import 'package:maintein/widgets/my_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceAttribution extends StatelessWidget{
  static final String routeName = "/attributions";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MyAppBar(
          flexibleSpaceChild: FlatButton(
            child: Text("Attributions", style: Theme.of(context).textTheme.title.copyWith(color: MyBlue.light),),
            onPressed: null,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: <Widget>[SliverList(delegate: SliverChildListDelegate([
            Image(
              image: AssetImage('lib/assets/images/thanks.png'),
              width: 300.0,
              height: 300.0,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text("A big thank you to these resources!", style: Theme.of(context).textTheme.display1.copyWith(color: MyBlue.light), textAlign: TextAlign.center,),
            ),
            ExpansionTile(
              title: Text("Affectometer 2"),
              children: <Widget>[
                Text("This scale was used for the Mental Wellbeing Assessment. The application used this scale with the permission of Dr. Ross Flett.\n",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.body1,),
                _makeSource("https://www.tandfonline.com/doi/abs/10.1080/00049538308255070", "Go to Source")
              ],
            ),
            ExpansionTile(
              title: Text("Reflection Prompts"),
              children: <Widget>[
                Text("The reflection prompts used in this application were from a collated list by Courtney E. Ackerman, an author of positive psychology books. She holds a  Master of Science in Positive Organizational Psychology from Claremont Graduate University. She is also the first author on a peer-reviewed article published in the International Journal of Wellbeing called Scaling The Heights Of Positive Psychology: A Systematic Review Of Measurement Scales.\n",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.body1,),
                _makeSource("https://positivepsychology.com/introspection-self-reflection/", "Go to Source")
              ],
            ),
            ExpansionTile(
              title: Text("Conversation Prompts"),
              children: <Widget>[
                Text("The conversation prompts used in this application were from a list of functional words was professionally selected to be the most useful for a child or adult who has difficulty using conversation starters. It was collated by Luke Barber and Holly Barber. They are holders of Bachelor of Science Degrees in Communicative Disorders and Deaf Education, Master's of Science Degrees in Speech Language Pathology, and Certificate of Clinical Competence or CCC in Speech Language Pathology.\n",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.body1,),
                _makeSource("https://www.home-speech-home.com/conversation-starters.html", "Go to Source")
              ],
            ),
            ExpansionTile(
              title: Text("Images and Icons"),
              children: <Widget>[
                _makeSource("https://www.flaticon.com/authors/freepik", "Freepik"),
                Text("The following icons were made by Freepik: the application logo, home icon, reflective journal icon, and breathing guide icon. These were taken and then edited from flaticon.com\n",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.body1,),
                _makeSource("https://www.flaticon.com/authors/monkik", "Monkik"),
                Text("The icon for the active listening checklist was made by Monkik. It was taken and edited from flaticon.com.\n",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.body1,),
                _makeSource("https://www.flaticon.com/authors/becris", "Becris"),
                Text("The icon for the goal setter and tracker was made by Becris. It was taken and edited from flaticon.com.\n",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.body1,),
                _makeSource("undraw.co", "unDraw"),
                Text("Special thanks to unDraw.co for their open-source illustrations.\n",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.body1,),
              ],
            ),
          ]),)],
        ),
      ),
    );
  }
  
  Padding _makeSource(String url, String text) => Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Align(
      alignment: Alignment.centerLeft,
      child: FlatButton(
        child: Text(text, textAlign: TextAlign.justify, style: TextStyle(color: MyBlue.picton),),
        onPressed: () async {
          if ( await canLaunch(url) ) {
            await launch(url);
          } else {
            throw "Could not launch $url";
          }
        }
      ),
    ),
  );

}