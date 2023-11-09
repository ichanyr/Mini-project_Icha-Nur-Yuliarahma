class ChoiceData {
  String text;
  int index;
  dynamic logprobs;
  String finishReason;

  ChoiceData({
    required this.text,
    required this.index,
    this.logprobs,
    required this.finishReason,
  });

  factory ChoiceData.fromJson(Map<String, dynamic> json) => ChoiceData(
      text: json['text'],
      index: json['index'],
      finishReason: json['finish_reason'],
      logprobs: json['logprobs']);

  Map<String, dynamic> toJson() => {
        'text': text,
        'index': index,
        'logprobs': logprobs,
        'finish_reason': finishReason,
      };
}
