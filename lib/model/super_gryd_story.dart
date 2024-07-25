class SuperGrydStory {
  final String? thumbUrl;
  final List<SuperGrydStoryData>? storyData;

  SuperGrydStory({this.storyData, this.thumbUrl});
}

class SuperGrydStoryData {
  final String? title;
  final String? url;
  final String? imageUrl;

  SuperGrydStoryData({
    this.title,
    this.url,
    this.imageUrl,
  });
}
