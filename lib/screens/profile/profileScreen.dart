import 'package:destino_quisqueya_front/generated/l10n.dart';
import 'package:destino_quisqueya_front/screens/auth/login/loginScreen.dart';
import 'package:destino_quisqueya_front/screens/itineraries/itinerariesScreen.dart';
import 'package:destino_quisqueya_front/widgets/customProfileButtom.dart';
import 'package:destino_quisqueya_front/widgets/scaffold.widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size base = MediaQuery.of(context).size;
    return DQScaffoldWidget(
      currentIndex: 3,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: base.height * 0.01),
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/profilePicture.png'),
              ),
              buildPersonalInfo(base),
              SizedBox(height: base.height * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    CustomProfileButtom(
                      label: S.of(context).editProfile,
                      onTap: () {
                        print("object");
                      },
                      icon: Icons.edit,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomProfileButtom(
                        label: S.of(context).favorites,
                        onTap: () {
                          print("object");
                        },
                        icon: Icons.favorite,
                      ),
                    ),
                    CustomProfileButtom(
                      label: S.of(context).myReviews,
                      onTap: () {
                        print("object");
                      },
                      icon: Icons.messenger,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: CustomProfileButtom(
                        label: "Itinearios",
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ItinerariesScreen.routeName,
                          );
                        },
                        icon: Icons.view_list_rounded,
                      ),
                    ),
                    CustomProfileButtom(
                      label: S.of(context).logout,
                      icon: Icons.logout,
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginScreen.routeName,
                          (result) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildPersonalInfo(Size base) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            "John Doe",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text("john.doe@example.com", style: TextStyle(fontSize: 16)),
          SizedBox(height: 5),
          Text("123 Main St, Anytown, USA", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
