import 'package:flutter/material.dart';
import 'package:pet_appoinment_app/values/size_config.dart';

import '../utils/text_styles.dart';
import '../values/my_colors.dart';
import '../values/my_imgs.dart';

class HospitalContainer extends StatelessWidget {
  // final Hospital hospital;
  final String hospitalName;
  final String hospitalAddress;
  final String hospitalEmail;
  final String hospitalPhone;
  final VoidCallback function;

  const HospitalContainer({
    super.key,
    required this.hospitalAddress,
    required this.hospitalName,
    required this.hospitalEmail,
    required this.hospitalPhone,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                height: getHeight(100),
                width: getWidth(80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage(MyImgs.imageIcon2),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              GestureDetector(
                onTap: function,
                child: Container(
                  width: getWidth(90),
                  height: getHeight(36),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                      child: Text(
                    'Book Now',
                    style: kSize14WhiteW400Text,
                  )),
                ),
              ),
            ],
          ),
          SizedBox(width: getWidth(20)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: getWidth(250),
                child: Text(
                  hospitalName,
                  overflow: TextOverflow.fade,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: getFont(24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: getHeight(10)),
              SizedBox(
                width: getWidth(200),
                child: Text(
                  hospitalAddress,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: getFont(16),
                    color: Colors.grey[600],
                  ),
                ),
              ),
              SizedBox(height: getHeight(16)),
              Text(
                'Phone: $hospitalPhone',
                style: TextStyle(
                  fontSize: getFont(14),
                  color: Colors.grey[500],
                ),
              ),
              Text(
                'Email: $hospitalEmail',
                style: TextStyle(
                  fontSize: getFont(14),
                  color: Colors.grey[500],
                ),
              ),
              SizedBox(height: getHeight(12)),
            ],
          ),
        ],
      ),
    );
  }
}
