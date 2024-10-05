import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gapopa_assignment/cubit/home_cubit.dart';
import 'package:gapopa_assignment/cubit/states/data_state.dart';
import 'package:gapopa_assignment/cubit/states/home_states.dart';
import 'package:gapopa_assignment/model/pixabay_response.dart';
import 'package:gapopa_assignment/resources/app_images.dart' as app_images;
import 'package:gapopa_assignment/resources/app_widgets.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final HomeCubit homeCubit = useBloc();
    final DataState cubitState = useBlocBuilder(homeCubit);
    final ScrollController scrollController = useScrollController();
    final ValueNotifier<List<Hits>> imageList = useState([]);

    void scrollListener() {
      homeCubit.onHomeScrollChange(
        scrollController.position.pixels,
        scrollController.position.maxScrollExtent,
      );
    }

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

    useBlocListener<HomeCubit, DataState>(
      homeCubit,
      (final cubit, final value, final context) {
        if (value is HomeSuccessState) {
          imageList.value = List.from(imageList.value)..addAll(value.data?.hits ?? []);
        }
      },
      listenWhen: (final _) => _ is HomeSuccessState,
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
              : cubitState is HomeErrorPromptState
                  ? APIErrorWidget(error: cubitState.errorMessage)
                  : APIEmptyWidget(),
    );
  }
}

class _ImageGrid extends StatelessWidget {
  const _ImageGrid({required this.imageList, required this.scrollController});

  final List<Hits> imageList;
  final ScrollController scrollController;

  @override
  Widget build(final BuildContext context) => LayoutBuilder(
        builder: (final context, final constraints) => HookBuilder(
          builder: (final context) {
            final crossAxisCount = useMemoized(
              () {
                const itemWidth = 200;
                return (constraints.maxWidth / itemWidth).floor();
              },
              [constraints.maxWidth],
            );

            return GridView.builder(
              controller: scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
                childAspectRatio: 1 / 0.93,
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

class _ImageTile extends StatelessWidget {
  const _ImageTile({required this.image, required this.likesCount, required this.viewsCount});

  final String? image;
  final int? likesCount;
  final int? viewsCount;

  @override
  Widget build(final BuildContext context) => Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              Text(
                'Likes: ${likesCount ?? 0}',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                'Views: ${viewsCount ?? 0}',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      );
}
