class SuperGrydStory {
  final String? thumbUrl;
  final List<SuperGrydStoryData>? storyData;
  final String? title;

  SuperGrydStory({
    this.storyData,
    this.thumbUrl,
    this.title,
  });
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
