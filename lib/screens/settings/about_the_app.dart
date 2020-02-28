import 'package:flutter/material.dart';
import 'package:maintein/themes/apptheme.dart';
import 'package:maintein/widgets/bottomnavbar.dart';
import 'package:maintein/widgets/my_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutTheApp extends StatelessWidget{
  static final String routeName = "/about";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavBar(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MyAppBar(
          flexibleSpaceChild: FlatButton(
            child: Text("About the App", style: Theme.of(context).textTheme.title.copyWith(color: MyBlue.light),),
            onPressed: null,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: CustomScrollView(
          slivers: <Widget>[SliverList(delegate: SliverChildListDelegate([
            Text("Maintein was built to help college students maintein a positive mental wellbeing. By facilitating activities that develop emotional intelligence, we hope that these skills help students cope and thrive in their everyday life.\n",
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.body1,),
            ExpansionTile(
              title: Text("Relevance of Activities & Additional Reads"),
              children: <Widget>[
                _makeSource("https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5714897/", "Self-Reflection"),
                Text("The reflective journal writing module of Maintein that focuses on developing self-awareness and self-regulation uses Gibb’s Reflective Cycle. Gibb’s Reflective Cycle, created by Graham Gibbs, is a step by step or phase by phase guide in order to structure learning from experiences. Because of its cyclic nature, it is good for standalone experiences or repeated ones.\n",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.body1,),
                _makeSource("http://www.bumc.bu.edu/facdev-medicine/files/2016/10/Active-Listening-Handout.pdf", "Active Listening"),
                Text("Active listening involves both verbal and non-verbal communications and is sometimes defined more of what is not done by what is. This module targets two components of emotional intelligence, namely Social Awareness and Social skills.\n",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.body1,),
                _makeSource("https://www.umassd.edu/fycm/goal-setting/resources/smartgoals/", "Goal Setting"),
                Text("The goal-setting tracker encourages the EI component motivation. Maintein uses the SMART Method in defining personal goals. This method helps clarify ideas, focus efforts, use time and resources productively, and increase your chances of achieving what you want in life. To make your personal goals clearer and reachable, each goal should be specific, measurable, achievable, relevant and time-bound.\n",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.body1,),
                _makeSource("https://www.tandfonline.com/doi/abs/10.1080/00049538308255070", "Mental Wellbeing Assessments"),
                Text("The Mental Well-being Assessment questions came from the Affectometer 2. The Affectometer 2 Scale consists of 40 items that assess how much your positive emotions outweighs the negative ones. Each item is being rated from Strongly Agree to Strongly Disagree. After finishing the 40-item module, the results will range from -80 to 80.\n",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.body1,),
                _makeSource("https://www.researchgate.net/publication/216626162_The_Assessing_Emotions_Scale", "Emotional Intelligence Assessment"),
                Text("The Emotional Intelligence Assessment questions came from the Emotional Intelligence Scale. The Emotional Intelligence Scale consists of 33 items that assess your level of emotional intelligence. Each item is being rated from Strongly Agree to Strongly Disagree. After finishing the 33-item module, the results will range from 33 to 165.\n",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.body1,),
                _makeSource("https://www.ijhsr.org/IJHSR_Vol.9_Issue.5_May2019/32.pdf", "Breathing Guide"),
                Text("Maintein's breathing guide is based on the 4-7-8 breathing guide, which has been found to be effective reducing dyspnea, anxiety, and depression.\n",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.body1,),
              ],
            ),
            ExpansionTile(
              title: Text("Contact Us"),
              children: <Widget>[
                SelectableText("For questions, clarifications and other concerns, contact us through the email cs199maintein@gmail.com.\n\n")
              ],
            )
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