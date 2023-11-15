import 'package:flutter/material.dart';
import 'package:movie/models/openai_model.dart';

class RecommendationScreen extends StatelessWidget {
  final GPTData? gptResponseData;

  const RecommendationScreen({Key? key, this.gptResponseData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(gptResponseData);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Movie Recommendations',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Recommended Movies',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              if (gptResponseData?.choices != null &&
                  gptResponseData!.choices.isNotEmpty)
                Column(
                  children: gptResponseData!.choices
                      .map((choice) => MovieRecommendationItem(
                            movieTitle: choice.text,
                          ))
                      .toList(),
                )
              else
                Center(
                  child: const Text(
                    'No movie recommendations available.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieRecommendationItem extends StatelessWidget {
  final String movieTitle;

  const MovieRecommendationItem({Key? key, required this.movieTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(),
    );
  }
}
