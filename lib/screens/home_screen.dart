import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gapopa_assignment/cubit/home_cubit.dart';
import 'package:gapopa_assignment/cubit/states/data_state.dart';
import 'package:gapopa_assignment/cubit/states/home_states.dart';
import 'package:gapopa_assignment/model/pixabay_response.dart';
import 'package:gapopa_assignment/resources/app_hooks.dart';
import 'package:gapopa_assignment/resources/app_images.dart' as app_images;
import 'package:gapopa_assignment/resources/app_widgets.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final homeCubit = useBloc<HomeCubit>();
    final cubitState = useBlocBuilder(homeCubit);
    final scrollController = useScrollController();
    final imageList = useValue<List<Hits>>([]);

    final _refreshCounter = useState(0);
    void refreshPage() => _refreshCounter.value++;

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
          imageList.value.addAll([...?value.data?.hits]);
          refreshPage();
        }
      },
      listenWhen: (final _) => _ is HomeSuccessState,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        centerTitle: true,
      ),
      body: cubitState is HomeLoadingState ? APILoadingWidget(loadingText: cubitState.loadingMessage) : cubitState is HomeSuccessState ? LayoutBuilder(
        builder: (final context, final constraints) {
          const itemWidth = 200;
          final crossAxisCount = (constraints.maxWidth / itemWidth).floor();

          return GridView.builder(
            controller: scrollController,
            padding: EdgeInsets.symmetric(vertical: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemCount: imageList.value.length,
            itemBuilder: (final BuildContext context, final int index) {
              final item = imageList.value[index];
              return _ImageGrid(
                image: item.webformatURL,
                likesCount: item.likes,
                viewsCount: item.views,
              );
            },
          );
        },
      ) : cubitState is HomeErrorPromptState ? APIErrorWidget(error: cubitState.errorMessage) : APIEmptyWidget(),
    );
  }
}

class _ImageGrid extends StatelessWidget {
  const _ImageGrid({required this.image, required this.likesCount, required this.viewsCount});

  final String? image;
  final int? likesCount;
  final int? viewsCount;

  @override
  Widget build(final BuildContext context) => Card(
        elevation: 3,
        child: Column(
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
            SizedBox(height: 10),
            Text(
              'Likes: ${likesCount ?? 0}',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Views: ${viewsCount ?? 0}',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      );
}
