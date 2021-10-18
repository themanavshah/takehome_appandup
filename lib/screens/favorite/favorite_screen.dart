import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:take_home/controllers/fav_books_controller.dart';
import 'package:take_home/helpers/responsiveness.dart';
import 'package:take_home/screens/favorite/widgets/favbooks_stream_list.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavBooksController favBooksController = FavBooksController();

  @override
  void initState() {
    favBooksController.eventSink.add({
      "event": userFavActions.getFavBook,
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 75.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Text(
                      "Favorite",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Responsivness().isSmall(context)
                            ? 26
                            : Responsivness().isMedium(context)
                                ? 34
                                : 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ];
      },
      body:
          FavBooksStreamList(favBooksStream: favBooksController.favBooksStream),
    );
  }
}
