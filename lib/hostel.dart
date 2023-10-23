import 'package:flutter/material.dart';

class HostelsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostels Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
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

void main() {
  runApp(MaterialApp(
    home: HostelsWidget(),
  ));
}
