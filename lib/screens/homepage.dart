import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/globals.dart';
import 'package:wallpaper/provider/home_provider.dart';
import 'package:wallpaper/resource/app_colors.dart';
import 'package:wallpaper/resource/app_images.dart';
import 'package:wallpaper/screens/fullscreen.dart';
import 'package:wallpaper/utils/extension.dart';
import 'package:wallpaper/widgets/custom_button.dart';
import 'package:wallpaper/widgets/custom_text.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String? authorName = "";

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).fetchAPI();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              title: CustomText(
                text: appName,
                style: GoogleFonts.getFont("Yesteryear",
                    fontSize: 30, color: AppColors.whiteColor),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Builder(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                            barrierColor: Colors.transparent,
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              Future.delayed(Duration(seconds: 5), () {
                                Navigator.of(context).pop();
                              });
                              return AlertDialog(
                                  elevation: 5.0, content: getContentItem());
                            });
                      },
                      child: Icon(
                        Icons.info_outline,
                        color: AppColors.whiteColor,
                      ),
                    );
                  }),
                )
              ],
            ),
            body: provider.getList.isNotEmpty
                ? Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 4,
                                  childAspectRatio: 2 / 3,
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 2),
                          itemCount: provider.getList.length,
                          reverse: false,
                          itemBuilder: (context, index) {
                            authorName =
                                provider.getList[index]['photographer'];
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Fullscreen(
                                            fullViewImage:
                                                provider.getList[index]['src']
                                                    ['large2x']),
                                      ));
                                },
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        shadowColor: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.4),
                                        elevation: 15,
                                        child: ClipPath(
                                          clipper: ShapeBorderClipper(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                          child: Image.network(
                                            provider.getList[index]['src']
                                                ['medium'],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    FadeTransition(
                                      opacity: _animation,
                                      child: FittedBox(
                                          child: CustomText(
                                        text: authorName.toString(),
                                        style: GoogleFonts.getFont("Yesteryear",
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 15),
                                      )),
                                    ),
                                  ],
                                ));
                          },
                        ),
                      ),
                      CustomButton(
                        onTap: provider.loadMoreImage,
                        text: "Loadmore",
                        isCenterLoaderEnable: provider.isCenterLoader,
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                    ),
                  ));
      },
    );
  }

  getContentItem() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50.0,
          backgroundImage: AssetImage(AppImages.myImage),
        ),
        CustomText(
          text: " amrish kumar \u{1F607}",
          style: GoogleFonts.getFont("Yesteryear",
              color: Theme.of(context).primaryColor, fontSize: 20),
        ),
        CustomText(
          text: " Flutter Developer",
        ),
        CustomText(
          text: " Made with Flutter \u{1F60E} and Pexels API \u{1F680}",
        ),
      ],
    ).withColumn(
      10.0,
      MainAxisAlignment.center,
      CrossAxisAlignment.center,
    );
  }
}
