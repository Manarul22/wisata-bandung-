import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wisata_bandung/model/tourism_place.dart';

class DetailScreen extends StatelessWidget {
  final TourismPlace place;

  DetailScreen({required this.place});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 800) {
        return DetailWebPage(place: place);
      } else {
        return DetailMobilePage(place: place);
      }
    });
  }
}

class DetailWebPage extends StatelessWidget {
  final informationTextStyle = TextStyle(fontFamily: 'Oxygen');
  final TourismPlace place;

  DetailWebPage({required this.place});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 64),
        child: Center(
          child: Container(
            width: 1200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wisata Bandung',
                  style: TextStyle(fontSize: 32, fontFamily: 'Staatliches'),
                ),
                SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            child: Image.asset(place.imageAsset),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          Container(
                            height: 150,
                            padding: const EdgeInsets.only(bottom: 16),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: 
                                place.imageUrls.map((url) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(url),
                                    ),
                                  );
                                }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 32),
                    Expanded(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Container(
                                child: Text(
                                  place.name,
                                  style: TextStyle(
                                      fontSize: 30, fontFamily: 'Staatliches'),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today),
                                      SizedBox(width: 8),
                                      Text(place.openDays,
                                          style: informationTextStyle),
                                    ],
                                  ),
                                  FavoriteButton(),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.access_time),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(place.openTime, style: informationTextStyle),
                                ],
                              ),
                              SizedBox(width: 10),
                              Row(
                                children: [
                                  Icon(Icons.monetization_on),
                                  SizedBox(width: 8),
                                  Text(place.ticketPrice)
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  place.description,
                                  textAlign: TextAlign.justify,
                                  style:
                                      TextStyle(fontFamily: 'Oxygen', fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailMobilePage extends StatelessWidget {
  final informationTextStyle = TextStyle(fontFamily: 'Oxygen');

  final TourismPlace place;

  DetailMobilePage({required this.place});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.asset(place.imageAsset),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        FavoriteButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Text(
                place.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0, fontFamily: 'Staatliches'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(height: 8.0),
                      Text(place.openDays, style: informationTextStyle),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.access_time),
                      SizedBox(height: 8.0),
                      Text(place.openTime, style: informationTextStyle),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.monetization_on),
                      SizedBox(height: 8.0),
                      Text(place.ticketPrice, style: informationTextStyle),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: Text(
                place.description,
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: place.imageUrls.map((url) {
                  return Padding(
                    padding: EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(url),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
        color: Colors.red,
        onPressed: () {
          setState(() {
            isFavorite = !isFavorite;
          });
        });
  }
}
