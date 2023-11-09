class UsageData {
  int promptTokens; // input
  int completionTokens; // output
  int totalTokens; // input + output

  UsageData(
      {required this.promptTokens,
      required this.completionTokens,
      required this.totalTokens});

  factory UsageData.fromJson(Map<String, dynamic> json) => UsageData(
      promptTokens: json['promptTokens'],
      completionTokens: json['completionTokens'],
      totalTokens: json['totalTokens']);

  Map<String, dynamic> toJson() => {
        'prompt_tokens': promptTokens,
        'completion_tokens': completionTokens,
        'total_tokens': totalTokens,
      };
}
