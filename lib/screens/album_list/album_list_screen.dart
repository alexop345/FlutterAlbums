import 'package:albums/models/albums_local.dart';
import 'package:albums/screens/album_list/album_list_view_model.dart';
import 'package:albums/themes/app_diments.dart';
import 'package:albums/widgets/album_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({super.key});

  @override
  State<AlbumListScreen> createState() {
    return _AlbumListScreenState();
  }
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  late AlbumListViewModel _albumListViewModel;

  @override
  void initState() {
    super.initState();
    _albumListViewModel = AlbumListViewModel(Input(BehaviorSubject<void>()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appBarTitle),
      ),
      body: StreamBuilder<AlbumsLocal>(
        stream: _albumListViewModel.output.albumList,
        builder: (ctx, snapshot) {
          if (snapshot.hasData || snapshot.hasError) {
            final AlbumsLocal albumsLocal = snapshot.data ?? const AlbumsLocal(updatedDate: 0, albums: []);
            final Duration lastUpdateDuration =
                albumsLocal.passedTimeSinceLastUpdate;
            return (albumsLocal.albums.isNotEmpty)
                ? Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.resultsUpdated(
                            lastUpdateDuration.inDays,
                            lastUpdateDuration.inHours,
                            lastUpdateDuration.inMinutes),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: AppDimens.containerDefaultSpacingAll,
                          itemCount: albumsLocal.albums.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: AppDimens.bottomDefaultSpacing,
                              child: AlbumListItemWidget(
                                  albumsLocal.albums[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(AppLocalizations.of(context)!.noAlbums),
                  );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
