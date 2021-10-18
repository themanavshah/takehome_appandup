import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import 'package:take_home/helpers/responsiveness.dart';

class BookLoadingShimmer extends StatelessWidget {
  const BookLoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
      child: Shimmer.fromColors(
        child: Responsivness().isSmall(context)
            ? ListView.builder(
                itemCount: 5,
                itemBuilder: (_, __) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 15.0),
                    child: BookLoadingObject(),
                  );
                },
              )
            : GridView.builder(
                itemCount: 15,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsivness().isMedium(context) ? 2 : 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: (2 / 1),
                ),
                itemBuilder: (_, __) {
                  return const BookLoadingObject();
                },
              ),
        baseColor: Colors.grey[300] ?? Colors.grey,
        highlightColor: Colors.grey[100] ?? Colors.white,
      ),
    );
  }
}

class BookLoadingObject extends StatelessWidget {
  const BookLoadingObject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: Responsivness().isSmall(context) ? 180 : 150,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          flex: 7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 140,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 160,
                height: 15,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: 120,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 130,
                height: 15,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
