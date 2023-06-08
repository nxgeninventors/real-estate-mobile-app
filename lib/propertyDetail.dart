import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:readmore/readmore.dart';
import 'Calendar/calender.dart';

class PropertyDetail extends StatefulWidget {
  final String title;
  final String description;

  const PropertyDetail({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  _PropertyDetailState createState() => _PropertyDetailState();
}

class _PropertyDetailState extends State<PropertyDetail> {
  final List<String> imageList = [
    'assets/images/home1.jpeg',
    'assets/images/home2.jpeg',
    'assets/images/home3.jpeg',
  ];
  final List<String> featureList = [
    'Space',
    'Parking',
    'Bedroom',
    'Swimming pool',
    'Lawn',
    'Garden',
  ];
  final List<IconData> iconList = [
    Icons.space_dashboard_outlined,
    Icons.local_parking,
    Icons.bed,
    Icons.pool,
    Icons.grass,
    Icons.foundation,
  ];

  final List<String> detailList = [
    '2500Sq.ft',
    'available',
    '2 rooms',
    'available',
    'not available',
    'available',
  ];

  final CarouselController _carouselController = CarouselController();

  int _currentImageIndex = 0;
  bool _isFavorite = false;
  var selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Detail'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        // Wrap the Column with SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      height: 375,
                      // Set the desired height of the images
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: .98,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                    ),
                    items: imageList
                        .map((item) => ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        item,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ))
                        .toList(),
                  ),
                  Positioned(
                    bottom: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imageList.map((item) {
                        int index = imageList.indexOf(item);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentImageIndex == index
                                ? Colors.blue
                                : Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "\$ 4500 - \$5500",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "17th street, hamington road NY",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                ),
              ),
              Divider(
                // Add the Divider widget here
                height: 2,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReadMoreText(
                  'This unique property is not only steeped in history but is also designed with striking features making it the perfect blend of old-world charm and modern luxury. Featuring 3 spacious bedrooms and 1 bathroom and large spacious Great Room and so much more. ',
                  trimLines: 2,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  lessStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.blueAccent),
                  moreStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.blueAccent),
                ),
              ),
              Divider(
                // Add the Divider widget here
                height: 2,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Features',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                // Add shrinkWrap: true to avoid conflicts with SingleChildScrollView
                padding: EdgeInsets.zero,
                // Remove any padding
                itemCount: featureList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    horizontalTitleGap: 0,
                    minVerticalPadding: 2,
                    textColor: Colors.grey,
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    // Adjust the content padding
                    leading: Icon(iconList[index]),
                    // Left-aligned icon
                    title: Padding(
                      padding: EdgeInsets.only(left: 1),
                      // Add left padding to the title
                      child: Text(
                        featureList[index],
                        textAlign: TextAlign.left,
                      ),
                    ),
                    // Left-aligned text
                    trailing: Text(
                      detailList[index],
                      textAlign: TextAlign.right,
                      style: TextStyle(),
                    ), // Right-aligned text
                  );
                },
              ),
              Divider(
                // Add the Divider widget here
                height: 2,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Schedule',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                height: 100,
                child: AnimatedHorizontalCalendar(
                  tableCalenderIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                  date: DateTime.now(),
                  textColor: Colors.black45,
                  backgroundColor: Colors.white,
                  tableCalenderThemeData: ThemeData.light().copyWith(
                    primaryColor: Colors.green,
                    buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
                    colorScheme: ColorScheme.light(primary: Colors.green)
                        .copyWith(secondary: Colors.lightBlue),
                  ),
                  selectedColor: Colors.lightBlue,
                  onDateSelected: (date) {
                    selectedDate = date;
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add appointment button logic here
                    },
                    child: Text("Fix appointment"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Card(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
          title: Text(
            'John Doe',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            'Real Estate Agent',
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.phone,
                  color: Colors.blue,
                ),
                onPressed: () {
                  // Perform call action
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.message,
                  color: Colors.blue,
                ),
                onPressed: () {
                  // Perform message action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
