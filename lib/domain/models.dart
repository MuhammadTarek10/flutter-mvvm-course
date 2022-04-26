class SliderObject {
  String title;
  String subtitle;
  String image;

  SliderObject(this.title, this.subtitle, this.image);
}


class SliderViewObject {
  SliderObject sliderObject;
  int numberOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numberOfSlides, this.currentIndex);
}