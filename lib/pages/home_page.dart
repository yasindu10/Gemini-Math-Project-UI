import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:math_ai_project/components/loadings.dart';
import 'package:math_ai_project/widgets/asset_thumbnails.dart';
import 'package:photo_manager/photo_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.isCameraFound,
    required this.controller,
  });

  final bool isCameraFound;
  final CameraController? controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  List<AssetEntity> assets = [];

  Future<void> _fetchAssets() async {
    assets = await PhotoManager.getAssetListRange(
      start: 0,
      end: 100,
    );

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getPermission() async {
    final result = await PhotoManager.requestPermissionExtend();

    if (result.isAuth) {
      await _fetchAssets();
    }
  }

  @override
  void initState() {
    getPermission();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Math AI'),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 17),
            child: const CircleAvatar(
              backgroundColor: Colors.black26,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const Gap(13),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black26,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt_rounded),
                    ),
                  ),
                  const Gap(15),
                  const Text(
                    'Solve Math With Your Camera',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Gap(10),
                ],
              ),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gallery',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(13),
            GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _isLoading ? 12 : assets.length,
              itemBuilder: (_, index) {
                if (_isLoading) {
                  return loadingWidget();
                }

                if (assets[index].type == AssetType.video) {
                  return const SizedBox();
                }
                return AssetThumbnail(asset: assets[0]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
