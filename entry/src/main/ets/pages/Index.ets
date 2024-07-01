
@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  private context = getContext(this)
  // private rdbStore: Rdb.RdbStore;

















  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Text("周海涛测试")
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Blue)
      }
      .width('100%')
    }
    .height('100%')
  }
}