// import 'dart:convert';
// import 'package:movie/models/openai_model.dart';
// import 'package:movie/models/usage_model.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;

// class RecommendationService {
//   static Future<GPTData> getRecommendation({
//     required String title,
//     required String voteAverage,
//     required String voteCount,
//   }) async {
//     late GPTData gptData = GPTData(
//         id: '',
//         object: '',
//         created: 0,
//         model: '',
//         choices: [],
//         usage: UsageData(
//           promptTokens: 0,
//           completionTokens: 0,
//           totalTokens: 0,
//         ));

//     try {
//       var url = Uri.parse('https://api.openai.com/v1/completions');

//       Map<String, String> headers = {
//         'Content-Type': 'application/json',
//         'Charset': 'utf-8',
//         'Authorization': 'Bearer $apiKey'
//       };

//       final formatCurrency = NumberFormat.currency(
//         locale: 'id_ID',
//         symbol: 'Rp ',
//         decimalDigits: 0,
//       );

//       String movieTitle = formatCurrency.format(int.parse(title));

//       String promptData =
//           'You are a phone expert. Please give me a phone recommendation from ${movieTitle.toLowerCase()} manufacturers with price equals to $movieTitle';

//       final data = jsonEncode({
//         'model': 'text-davinci-003',
//         'prompt': promptData,
//         'temperature': 0.7,
//         'max_tokens': 200,
//         'top_p': 1,
//         'frequency_penalty': 0,
//         'presence_penalty': 0
//       });

//       var response = await http.post(
//         url,
//         headers: headers,
//         body: data,
//       );
//       if (response.statusCode == 200) {
//         gptData = gptDataFromJson(response.body);
//       }
//     } catch (e) {
//       print(e);
//     }
//     return gptData;
//   }
// }
