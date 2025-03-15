import 'package:tdd_with_dio/features/article/data/models/article_response_model.dart';
import 'package:tdd_with_dio/features/article/data/models/articles_model.dart';

Map<String, dynamic> actualArticlesEmptyJson = {
  "status": "OK",
  "copyright":
      "Copyright (c) 2023 The New York Times Company.  All Rights Reserved.",
  "num_results": 20,
  "results": [],
};

Map<String, dynamic> actualSuccessArticlesListJson = {
  "status": "OK",
  "copyright":
      "Copyright (c) 2023 The New York Times Company.  All Rights Reserved.",
  "num_results": 20,
  "results": [
    {
      "uri": "nyt://article/1222a343-a7ec-5850-9b72-fef4687b43fd",
      "url":
          "https://www.nytimes.com/2023/04/24/business/media/don-lemon-cnn.html",
      "id": 100000008872080,
    },
  ],
};

/*Expected*/

ApiResponse<List<ArticleModel>> expectedArticlesEmptyListData = ApiResponse(
  status: "OK",
  copyright:
      "Copyright (c) 2023 The New York Times Company.  All Rights Reserved.",
  numResults: 20,
  results: [],
);

ApiResponse<List<ArticleModel>> expectedSuccessArticlesListData = ApiResponse(
  status: "OK",
  copyright:
      "Copyright (c) 2023 The New York Times Company.  All Rights Reserved.",
  numResults: 20,
  results: [ArticleModel(id: 100000008872080)],
);
