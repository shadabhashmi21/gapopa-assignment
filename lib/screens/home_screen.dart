import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gapopa_assignment/cubit/home_cubit.dart';
import 'package:gapopa_assignment/cubit/states/data_state.dart';
import 'package:gapopa_assignment/cubit/states/home_states.dart';
import 'package:gapopa_assignment/model/pixabay_response.dart';
import 'package:gapopa_assignment/resources/app_constants.dart' as app_constants;
import 'package:gapopa_assignment/resources/app_images.dart' as app_images;
import 'package:gapopa_assignment/resources/app_utils.dart';
import 'package:gapopa_assignment/resources/app_widgets.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

/// A screen that displays a gallery of images in a grid format.
/// The [HomeScreen] is a HookWidget that manages state and data fetching using a [HomeCubit].
class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    // Hook for accessing the HomeCubit instance.
    final HomeCubit homeCubit = useBloc();

    // Hook for observing the current state of the HomeCubit.
    final DataState cubitState = useBlocBuilder(homeCubit);

    // Scroll controller to track the user's scrolling position.
    final ScrollController scrollController = useScrollController();

    // State management for holding the list of images.
    final ValueNotifier<List<Hits>> imageList = useState([]);

    // Function that listens to scroll changes and triggers API accordingly.
    void scrollListener() {
      homeCubit.onHomeScrollChange(
        scrollController.position.pixels,
        scrollController.position.maxScrollExtent,
      );
    }

    // Hook to fetch data once and add a scroll listener.
    useEffect(
      () {
        homeCubit.fetchHomeData(firstCall: true);
        scrollController.addListener(scrollListener);
        return () {
          scrollController.removeListener(scrollListener);
        };
      },
      [],
    );

    // Bloc listener to listen different states from the HomeCubit.
    useBlocListener<HomeCubit, DataState>(
      homeCubit,
      (final cubit, final value, final context) {
        if (value is HomeSuccessState) {
          // Adds new data to the existing list when the fetch is successful.
          imageList.value = List.from(imageList.value)..addAll(value.data?.hits ?? []);
        } else if (value is HomeErrorPromptState) {
          // Shows an error message in case of failure, using the snackbar,
          // but don't stop the user from seeing the already loaded data.
          showSnackBar(context, value.errorMessage);
        }
      },
      // Only listen when the state is HomeSuccessState or HomeErrorPromptState.
      // added this code to avoid unnecessary state listen
      listenWhen: (final state) => state is HomeSuccessState || state is HomeErrorPromptState,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        centerTitle: true,
      ),
      body: cubitState is HomeLoadingState
          ? APILoadingWidget(loadingText: cubitState.loadingMessage)
          : cubitState is HomeSuccessState
              ? _ImageGrid(
                  imageList: imageList.value,
                  scrollController: scrollController,
                )
              : cubitState is HomeErrorState
                  ? APIErrorWidget(error: cubitState.errorMessage)
                  : APIEmptyWidget(),
    );
  }
}

/// A grid view widget that displays a list of images.
/// The grid adjusts the number of columns based on the available width.
class _ImageGrid extends StatelessWidget {
  const _ImageGrid({required this.imageList, required this.scrollController});

  /// The list of images to be displayed.
  final List<Hits> imageList;

  /// The scroll controller for managing the scroll position.
  final ScrollController scrollController;

  @override
  Widget build(final BuildContext context) => LayoutBuilder(
        builder: (final context, final constraints) => HookBuilder(
          builder: (final context) {
            // Dynamically calculates the number of columns based on the available width.
            // useMemoized is used to avoid unnecessary code execution.
            // This code will be executed only when the width of screen is changed
            final crossAxisCount = useMemoized(
              () {
                const itemWidth = 200;
                return (constraints.maxWidth / itemWidth).floor();
              },
              [constraints.maxWidth],
            );

            // Builds a grid view with a fixed number of columns.
            return GridView.builder(
              controller: scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
                childAspectRatio: app_constants.gridAspectRatio,
              ),
              itemCount: imageList.length,
              itemBuilder: (final BuildContext context, final int index) {
                final item = imageList[index];
                return _ImageTile(
                  image: item.webformatURL,
                  likesCount: item.likes,
                  viewsCount: item.views,
                );
              },
            );
          },
        ),
      );
}

/// A tile widget that displays an individual image along with likes and views count.
class _ImageTile extends StatelessWidget {
  const _ImageTile({required this.image, required this.likesCount, required this.viewsCount});

  /// The image URL to be displayed.
  final String? image;

  /// The number of likes for the image.
  final int? likesCount;

  /// The number of views for the image.
  final int? viewsCount;

  @override
  Widget build(final BuildContext context) => Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Fades in the image with a placeholder if loading.
              FadeInImage(
                height: 120,
                fit: BoxFit.fitWidth,
                placeholder: AssetImage(app_images.placeholder),
                image: NetworkImage(image ?? ''),
                imageErrorBuilder: (final context, final error, final stackTrace) => Flexible(
                  child: Image.asset(app_images.placeholder),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Displays the likes count.
                  Icon(Icons.thumb_up, size: 15,),
                  Text(
                    '${likesCount ?? 0}',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(width: 10,),
                  // Displays the views count.
                  Icon(Icons.remove_red_eye, size: 15,),
                  Text(
                    '${viewsCount ?? 0}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
