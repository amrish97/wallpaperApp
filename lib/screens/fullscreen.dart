import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/globals.dart';
import 'package:wallpaper/provider/home_provider.dart';
import 'package:wallpaper/utils/extension.dart';
import 'package:wallpaper/widgets/custom_button.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

class Fullscreen extends StatefulWidget {
  final String fullViewImage;
  const Fullscreen({super.key, required this.fullViewImage});

  @override
  State<Fullscreen> createState() => _FullscreenState();
}

class _FullscreenState extends State<Fullscreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).fetchAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                  child: Image.network(
                widget.fullViewImage,
                fit: BoxFit.cover,
              )),
              CustomButton(
                onTap: () async {
                  await provider.setWallpaper(widget.fullViewImage, context);
                },
                text: "Set $appName",
                isCenterLoaderEnable: false,
              ),
            ],
          ).withColumn(
            10.0,
            MainAxisAlignment.center,
            CrossAxisAlignment.start,
          ),
        );
      },
    );
  }
}
