import 'package:flutter/material.dart';

class RecommendedScreen extends StatefulWidget {
  const RecommendedScreen({super.key});

  @override
  _RecommendedScreenState createState() => _RecommendedScreenState();
}

class _RecommendedScreenState extends State<RecommendedScreen> {
  List<String> images = [
    'assets/images/home1.jpeg',
    'assets/images/home2.jpeg',
    'assets/images/home3.jpeg',
    // Add more asset paths here
  ];

  List<String> priceList = [
    '\$5000 - \$6000',
    '\$45000 - \$48000',
    '\$10000 - \$10500',
    // Add more descriptions here
  ];

  List<String> addressList = [
    '17th street hamington road',
    'broadway road, NJ',
    '7th street nY',
    // Add more descriptions here
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16.0), // Add padding to the GridView
      itemCount: images.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0, // Increase the horizontal spacing between cards
        mainAxisSpacing: 8.0, // Increase the vertical spacing between cards
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8.0), // Add additional padding around the Container
          child: Container(
            height: 250, // Set the desired height of the card
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Set the border radius of the card
              ),
              elevation: 4.0, // Add elevation for the shadow effect
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0), // Set the border radius for the image
                    child: SizedBox(
                      width: double.infinity, // Make the image width fill the card
                      height: 100, // Set the desired height of the image
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.cover, // Adjust the image fit to cover the available space
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    priceList[index],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    addressList[index],
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

