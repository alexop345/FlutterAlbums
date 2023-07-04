import 'package:albums/models/album_list_data.dart';
import 'package:albums/screens/album_list/album_list_view_model.dart';
import 'package:albums/themes/app_diments.dart';
import 'package:albums/widgets/album_list_item_widget.dart';
import 'package:albums/widgets/common/overlay_loading.dart';
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
    _albumListViewModel = AlbumListViewModel(Input(
      BehaviorSubject<void>(),
      PublishSubject<bool>(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appBarTitle),
      ),
      body: Stack(
        children: [
          StreamBuilder<AlbumListData>(
            stream: _albumListViewModel.output.albumList,
            builder: (ctx, snapshot) {
               _albumListViewModel.input.reload.add(false);
              if (snapshot.hasData || snapshot.hasError) {
                final AlbumListData albumListData =
                    snapshot.data ?? AlbumListData.recent(albums: []);
                return (albumListData.albums.isNotEmpty)
                    ? Column(
                        children: [
                          Text(
                            albumListData.isRecent
                                ? AppLocalizations.of(context)!
                                    .resultsUpdatedNow
                                : AppLocalizations.of(context)!.resultsUpdated(
                                    albumListData.lastUpdate!.period,
                                    albumListData.lastUpdate!.time),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () {
                              _albumListViewModel.input.getList.add(null);
                              _albumListViewModel.input.reload.add(true);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Icon(
                              Icons.refresh,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: AppDimens.containerDefaultSpacingAll,
                              itemCount: albumListData.albums.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: AppDimens.bottomDefaultSpacing,
                                  child: AlbumListItemWidget(
                                      albumListData.albums[index]),
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
          StreamBuilder<bool>(
            stream: _albumListViewModel.output.onReload,
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == true) {
                  return const OverlayLoading();
                }
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
