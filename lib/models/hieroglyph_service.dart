class HieroglyphService {
  List<String> splitName(String name) {
    name = name.trim().toUpperCase();
    name = name.replaceAll(" ", "");
    name = name.replaceAll(RegExp(r'[^A-Za-z ]'), '');
    List<String> result = [];

    int i = 0;
    while (i < name.length) {
      if (i < name.length - 1) {
        String pair = name.substring(i, i + 2);

        if (pair == "SH" || pair == "TH") {
          result.add(pair);
          i += 2;
          continue;
        }
      }
      result.add(name[i]);
      i++;
    }
    return result;
  }

  List<String> getImages(List<String> letters) {
  List<String> images = [];

  for (String letter in letters) {
    images.add("assets/charach/$letter.png");
  }
  return images;
}

}

