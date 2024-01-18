import 'package:flutter/material.dart';
import 'package:pet_appoinment_app/utils/text_styles.dart';
import 'package:pet_appoinment_app/values/values.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms and Condition"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Terms and Conditions for Pet Appointment App : \n",
                style: kSize32blackW400Text,
              ),
              const Text(
                  'These terms and conditions ("Terms") govern your use of the pet appointment application ("App") provided by [Company Name] ("we," "us," or "our"). By accessing or using the App, you agree to be bound by these Terms. If you do not agree to these Terms, please refrain from using the App.'),
              Text(
                "1. App Purpose and Services : \n",
                style: kSize24blackW400Text,
              ),
              const Text(
                  'The App is designed to facilitate the scheduling and management of pet appointments between pet owners ("Users") and veterinary clinics or pet service providers ("Service Providers"). The App enables Users to find, book, and manage appointments for their pets.'),
              Text(
                "2. User Responsibilities : \n",
                style: kSize24blackW400Text,
              ),
              Text(
                'a. Age Requirement :\n',
                style: kSize24blackW400Text,
              ),
              const Text(
                  'You must be at least 18 years old or the legal age of majority in your jurisdiction to use the App.'),
              Text(
                'b. Accurate Information:\n',
                style: kSize24blackW400Text,
              ),
              const Text(
                  'You are responsible for providing accurate and up-to-date information during the registration process and when using the App.'),
              Text(
                'c. Account Security :\n',
                style: kSize24blackW400Text,
              ),
              const Text(
                  'You are responsible for maintaining the confidentiality of your account credentials and are solely responsible for any activity that occurs under your account.'),
              Text(
                "3. Service Providers : \n",
                style: kSize24blackW400Text,
              ),
              Text(
                "a. Listings : \n",
                style: kSize24blackW400Text,
              ),
              const Text(
                  ' Service Providers are responsible for providing accurate information in their listings, including availability, services offered, pricing, and other relevant details.'),
              Text(
                "b. Quality of Services: \n",
                style: kSize24blackW400Text,
              ),
              const Text(
                  'We do not endorse or guarantee the quality, safety, or suitability of any Service Providers listed on the App. It is your responsibility to verify and evaluate the qualifications and credentials of any Service Provider before booking an appointment.'),
              Text(
                "c. Service Provider Relationships: \n",
                style: kSize24blackW400Text,
              ),
              const Text(
                  'Any agreements or interactions between Users and Service Providers are solely between the parties involved. We are not a party to such agreements or interactions and shall not be liable for any disputes, losses, or damages arising from them.'),
              Text(
                "4. Appointments : \n",
                style: kSize24blackW400Text,
              ),
              Text(
                'a. Availability :\n',
                style: kSize24blackW400Text,
              ),
              const Text(
                  ' The availability of appointments displayed on the App is based on the information provided by Service Providers. We do not guarantee the accuracy or availability of appointments and shall not be held responsible for any changes, cancellations, or unavailability of appointments.'),
              Text(
                'b. Appointment Modifications :\n',
                style: kSize24blackW400Text,
              ),
              const Text(
                  'Users may request appointment modifications or cancellations through the App\'s designated features, subject to Service Provider policies and availability.'),
              Text(
                'c. Fees and Payments :\n',
                style: kSize24blackW400Text,
              ),
              const Text(
                  'Service fees, cancellation fees, and other charges related to appointments may apply as determined by the Service Provider. Users are responsible for reviewing and complying with the applicable fees and payment terms.')
              ,Text(
                "5. Intellectual Property : \n",
                style: kSize24blackW400Text,
              ),
              Text(
                "a. Ownership: \n",
                style: kSize24blackW400Text,
              ),
            const Text('The App and all its content, including but not limited to text, graphics, logos, images, and software, are owned by us or our licensors and are protected by intellectual property laws.'),
              Text(
                "b. Limited License :\n",
                style: kSize24blackW400Text,
              ),
              const Text(' Subject to compliance with these Terms, we grant you a limited, non-exclusive, non-transferable, revocable license to use the App for personal, non-commercial purposes.'),
              Text(
                "6. User Content : \n",
                style: kSize24blackW400Text,
              ),
              Text(
                "a. User Content License :\n",
                style: kSize24blackW400Text,
              ),
              const Text('By submitting or providing any content, information, or material through the App, you grant us a non-exclusive, royalty-free, perpetual, worldwide, sublicensable, and transferable license to use, reproduce, modify, adapt, publish, translate, distribute, and display such content.'),
              Text(
                "b. Responsibility :\n",
                style: kSize24blackW400Text,
              ),
              const Text('You are solely responsible for any content you provide through the App, including its legality, accuracy, and compliance with applicable laws and regulations.')

            ],
          ),
        ),
      ),
    );
  }
}
