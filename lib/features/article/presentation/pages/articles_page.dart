import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/utils/string_constant.dart';
import '../../../../shared/presentation/pages/background_page.dart';
import '../../../../shared/presentation/widgets/app_loader.dart';
import '../../../../shared/presentation/widgets/custom_app_bar_widget.dart';
import '../../../../shared/presentation/widgets/reload_widget.dart';
import '../../../../shared/presentation/widgets/text_field_widget.dart';
import '../../data/models/articles_model.dart';
import '../bloc/articles_bloc.dart';
import '../widgets/article_card_widget.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  // Key for scaffold to open drawer
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  // Refresh controller for list view
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  bool isSearching = false;

  // List of articles
  List<ArticleModel> nyTimesArticles = [];

  // Search text field
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Period
  int selectedPeriod = 1;

  @override
  void initState() {
    // Call event to get ny times article
    //callArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      scaffoldKey: _key,
      withDrawer: true,
      child: Column(
        children: [
          // Custom App Bar
          CustomAppBarWidget(
            title:
                isSearching
                    ? TextFieldWidget(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      hintText: /*StringConstant.search*/ 'Search',
                      onChanged: (value) {
                        context.read<ArticlesBloc>().add(
                          SearchArticleEvent((value?.trim() ?? "")),
                        );
                      },
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            isSearching = !isSearching;
                            if (isSearching) {
                              _searchFocusNode.requestFocus();
                            } else {
                              _searchFocusNode.unfocus();
                              _searchController.clear();
                              callArticles();
                            }
                          });
                        },
                        icon: Icon(Icons.close, size: 20),
                      ),
                    )
                    : Text(
                      /* StringConstant.ny_times_most_popular*/
                      'NY Times Most Popular',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
            leading: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                _key.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu, size: 20),
            ),
            actions: [
              // Search
              if (!isSearching) ...{
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    setState(() {
                      isSearching = !isSearching;
                      if (isSearching) {
                        _searchFocusNode.requestFocus();
                      } else {
                        _searchFocusNode.unfocus();
                        _searchController.clear();
                        callArticles();
                      }
                    });
                  },
                  icon: Icon(Icons.search, size: 20),
                ),
              },

              // Menu
              PopupMenuButton(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onSelected: (value) {
                  selectedPeriod = int.tryParse(value) ?? 1;
                  callArticles();
                },
                elevation: 3,
                tooltip: StringConstant.period,
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      value: '1',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "1",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (selectedPeriod == 1) ...{
                            Icon(
                              Icons.check,
                              color: Theme.of(context).iconTheme.color,
                              size: 20,
                            ),
                          },
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: '7',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "7",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (selectedPeriod == 7) ...{
                            Icon(
                              Icons.check,
                              color: Theme.of(context).iconTheme.color,
                              size: 20,
                            ),
                          },
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: '30',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "30",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (selectedPeriod == 30) ...{
                            Icon(
                              Icons.check,
                              color: Theme.of(context).iconTheme.color,
                              size: 20,
                            ),
                          },
                        ],
                      ),
                    ),
                  ];
                },
                child: Row(
                  children: [
                    Text(
                      StringConstant.period,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(width: 1.sp),
                    Icon(Icons.arrow_drop_down, size: 20),
                  ],
                ),
              ),
            ],
          ),

          // Space
          SizedBox(height: Helper.getVerticalSpace()),

          // List of articles
          Expanded(
            child: BlocConsumer<ArticlesBloc, ArticlesState>(
              bloc: context.read<ArticlesBloc>(),
              listener: (context, state) {
                if (state is GetArticleSuccessState) {
                  nyTimesArticles.clear();
                  nyTimesArticles = List.from(state.articles);
                  _refreshController.refreshCompleted(resetFooterState: true);
                } else if (state is SearchState) {
                  nyTimesArticles.clear();
                  nyTimesArticles = state.articles;
                }
              },
              builder: (context, state) {
                if (state is StateLoading) {
                  return const AppLoader();
                } else if (state is ErrorState) {
                  return ReloadWidget.error(
                    content: state.errorMessage,
                    onPressed: () {
                      callArticles();
                    },
                  );
                }

                // Check if there is no data
                if (nyTimesArticles.isEmpty) {
                  return ReloadWidget.empty(content: StringConstant.no_data);
                }

                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropHeader(
                    waterDropColor: Theme.of(context).cardColor,
                  ),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: null,
                  child: ListView.builder(
                    itemCount: nyTimesArticles.length,
                    itemBuilder: (context, index) {
                      return ArticleCardWidget(
                        nyTimesModel: nyTimesArticles[index],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Refresh method called when pull down list
  void _onRefresh() async {
    _refreshController.requestRefresh();
    callArticles(withLoading: false);
  }

  // Call articles
  callArticles({bool withLoading = true}) {
    context.read<ArticlesBloc>().add(
      GetArticlesEvent(
        _searchController.text.trim(),
        selectedPeriod,
        withLoading: withLoading,
      ),
    );
  }
}
