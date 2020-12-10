import 'package:aps/Controller/ComunityPostController.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/model/error.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  CarouselController buttonCarouselController = CarouselController();
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  final NewsAPI _newsAPI = NewsAPI("aa67d8d98c8e4ad1b4f16dbd5f3be348");
  Widget _buildTopHeadlinesTabView() {
    return FutureBuilder<List<Article>>(
        future: _newsAPI.getTopHeadlines(country: "br"),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? snapshot.hasData
                  ? _buildArticleListView(snapshot.data)
                  : _buildError(snapshot.error)
              : _buildProgress();
        });
  }

  Widget _buildProgress() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildError(ApiError error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error.code ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 4),
            Text(error.message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleListView(List<Article> articles) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 100.0,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            aspectRatio: 2.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            var article = articles[index];
            return Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: ListTile(
                  title: Text(article.title, maxLines: 2),
                  subtitle: Text(article.description ?? "", maxLines: 3),
                  trailing: article.urlToImage == null
                      ? null
                      : Image.network(article.urlToImage),
                ),
              ),
            );
          },
          itemCount: articles.length,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ComunityPostController comunityPostController = ComunityPostController();
    return Container(
      padding: EdgeInsets.all(15),
      child: ListView(
        children: [
          Text(
            "Útimos posts",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: comunityPostController.list().snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data.size >= 4 ? 3 : snapshot.data.size,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var document = snapshot.data.docs[index];
                    return Row(
                      children: [
                        Expanded(
                            child: Card(
                                color: Colors.blueAccent,
                                child: ListTile(
                                  title: Text(
                                    "${document.data()['title']}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    "${document.data()['description']}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, 'viewcomunitypost/${document.id}');
                          },
                        ),
                      ],
                    );
                  },
                );
              }),
          SizedBox(
            height: 15,
          ),
          Text(
            "Suas últimas finanças",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                percent: 0.1,
                center: new Text(
                  "70.0%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: new Text(
                  "Valor recebido",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.blueAccent,
              ),
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                percent: 0.7,
                center: new Text(
                  "70.0%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: new Text(
                  "Valor Investido",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.green,
              ),
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 13.0,
                animation: true,
                percent: 0.7,
                center: new Text(
                  "70.0%",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                footer: new Text(
                  "Valor gasto",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.red,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "últimas notícias",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          _buildTopHeadlinesTabView(),
        ],
      ),
    );
  }
}
