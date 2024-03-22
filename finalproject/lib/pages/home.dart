import 'package:finalproject/pages/work.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CusHome extends StatelessWidget {
  final List<String> imageUrls = [
    'assets/111.png',
    'assets/222.png',
    // เพิ่มรูปภาพเพิ่มเติมตามต้องการ
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'แอปพลิเคชั่น',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 245, 123, 57),
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                  items: imageUrls.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          //width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 2.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Image.network(
                            imageUrl,
                            width: 450, // กำหนดความกว้างของรูปภาพ
                            height: 250, // กำหนดความสูงของรูปภาพ
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20,
                ), // ระยะห่างระหว่าง Carousel Slider กับ ListView.builder
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Card(
                    color: Color.fromARGB(255, 255, 158, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 8,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CusWork()), // นำทางไปยังหน้า Work
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/22.png', // เปลี่ยนที่อยู่ของรูปภาพตามต้องการ
                            width: 250, // กำหนดความกว้างของรูปภาพ
                            height: 250, // กำหนดความสูงของรูปภาพ
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
