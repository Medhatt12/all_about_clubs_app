import 'package:all_about_clubs_app/widgets/club_card.dart';

import '../providers/clubs_data.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClubsOverview extends StatefulWidget {
  static const routeName = '/clubs-overview';

  @override
  State<ClubsOverview> createState() => _ClubsOverviewState();
}

class _ClubsOverviewState extends State<ClubsOverview> {
  Future<void> _showAllOrders() async {
    await Provider.of<ClubsData>(context, listen: false).fetchAndSetClubs();
  }

  bool nameAscending = true;
  var _isIit = true;
  var _isloading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isIit) {
      setState(() {
        _isloading = true;
      });
      Provider.of<ClubsData>(context, listen: false)
          .fetchAndSetClubs()
          .then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }
    _isIit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _showAllOrders();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final clubsData = Provider.of<ClubsData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All About Clubs',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.sort_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                nameAscending = !nameAscending;
                if (nameAscending == true) {
                  clubsData.getClubsSortedByNameAscending();
                } else {
                  clubsData.getClubsSortedByValueDescending();
                }
              });
            },
          ),
        ],
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: ListView.builder(
                itemCount: clubsData.getClubs.length,
                itemBuilder: (context, index) {
                  return ClubCard(
                    id: clubsData.getClubs[index].id,
                    name: clubsData.getClubs[index].name,
                    country: clubsData.getClubs[index].country,
                    value: clubsData.getClubs[index].value,
                    imageUrl: clubsData.getClubs[index].imageUrl,
                    europeanTitles: clubsData.getClubs[index].europeanTitles,
                  );
                },
              ),
            ),
    );
  }
}
