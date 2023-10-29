import 'package:flutter/material.dart';
import 'package:studentlogin/admin/admin_add_hostel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studentlogin/login.dart';

class MenuContent extends StatelessWidget {
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                Icon(
                  Icons.person_2,
                  size: 40,
                ),
                Text(
                  'Admin',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 60),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddHostel()),
                    );
                  },
                  child: Container(
                    width: 400, // Set the width of the Card
                    height: 100, // Set the height of the Card
                    child: Card(
                      color: Color.fromARGB(255, 156, 225, 255),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Icon(
                            Icons.holiday_village,
                            size: 30,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Add Hostel',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {

                      
                  },
                  child: Container(
                    width: 400, // Set the width of the Card
                    height: 100, // Set the height of the Card
                    child: Card(
                      color: Color.fromARGB(255, 156, 225, 255),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Image.asset(
                            'images/transfer.png',
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Request Room Change',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Container(
                    width: 400, // Set the width of the Card
                    height: 50, // Set the height of the Card
                    child: Card(
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'LogOut',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
  }
}
=======
 @override
 Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7, // 70% of the screen height
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildCard(
                 'Card 1',
                 'https://images.unsplash.com/photo-1578589318433-39b5de440c3f?w=1280&h=720',
                ),
                _buildCard(
                 'Card 2',
                 'https://images.unsplash.com/photo-1579781354199-1ffd36bd7d30?w=1280&h=720',
                ),
                _buildCard(
                 'Card 3',
                 'https://images.unsplash.com/photo-1578309743751-5f1780eaf1dd?w=1280&h=720',
                ),
                _buildCard(
                 'Card 4',
                 'https://images.unsplash.com/photo-1579159286444-48ca14d5b3db?w=1280&h=720',
                ),
                _buildCard(
                 'Card 5',
                 'https://images.unsplash.com/photo-1551295022-de5522c94e08?w=1280&h=720',
                ),
                _buildCard(
                 'Card 6',
                 'https://images.unsplash.com/photo-1517505246386-7b6def3b0ef6?w=1280&h=720',
                ),
              ],
            ),
          ),
        ],
      ),
    );
 }

 Widget _buildCard(String title, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.blue, // You can change the card color as needed.
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.network(
              imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20),
              child: Text(
                title,
                style: TextStyle(
                 fontFamily: 'Readex Pro',
                 color: Color(0xFF101518),
                 fontSize: 28,
                 fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
 }
}
>>>>>>> 325edb51d7a653b2a5069a3b0841aa6fca3d0720
