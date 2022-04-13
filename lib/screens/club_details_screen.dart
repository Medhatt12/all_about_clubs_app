import 'package:all_about_clubs_app/providers/clubs_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClubDetailsScreen extends StatelessWidget {
  static const routeName = '/club-details-screen';

  @override
  Widget build(BuildContext context) {
    final clubId = ModalRoute.of(context).settings.arguments as String;
    final loadedClub =
        Provider.of<ClubsData>(context, listen: false).findById(clubId);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          loadedClub.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(children: [
                  Container(
                    //height: 300,
                    width: double.infinity,
                    child: Image.network(
                      loadedClub.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Text(
                      loadedClub.country,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
              ),
              Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  // Here is the explicit parent TextStyle
                  style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                  ),
                  children: <TextSpan>[
                    new TextSpan(
                        text: loadedClub.name,
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    new TextSpan(text: ' konnte bislang '),
                    new TextSpan(
                        text: loadedClub.europeanTitles.toString(),
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    new TextSpan(
                        text: ' Siege auf europäischer Ebene erreichen.')
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  // Here is the explicit parent TextStyle
                  style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                  ),
                  children: <TextSpan>[
                    new TextSpan(text: 'Der Club '),
                    new TextSpan(
                        text: loadedClub.name,
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    new TextSpan(text: ' aus '),
                    new TextSpan(
                        text: loadedClub.country,
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    new TextSpan(text: ' hat einen Wert von '),
                    new TextSpan(
                        text: loadedClub.value.toString(),
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    new TextSpan(text: ' Millionen Euro.'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
