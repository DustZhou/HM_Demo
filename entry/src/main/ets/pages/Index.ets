import util from '@ohos.util';


class Contact {
  key: string = util.generateRandomUUID(true);
  name: string;
  icon: Resource;

  constructor(name: string, icon: Resource) {
    this.name = name;
    this.icon = icon;
  }
}


@Entry
@Component
struct Index {
  @State message: string = '首页';
  private context = getContext(this)
  private scrollerForScroll: Scroller = new Scroller();
  private scrollerForList: Scroller = new Scroller();

  private contacts: Array<object> = []



  initData(){
    // 循环添加联系人
    for(let i = 0; i < 100 ; i++) {
      this.contacts.push(new Contact("测试" + i,$r('app.media.foreground')))
    }
  }

  constructor() {
    super();
    this.initData(); // 如果需要在组件加载时立即初始化
  }

  @Builder
  listBuilder() {
    List({ space: this.contacts.length, scroller: this.scrollerForList }) {
      ForEach(this.contacts, (item: Contact) => {
        ListItem() {
          Row() {
            Image(item.icon)
              .width("100%")
              .height("100%")
              .border({ width: 1 })
                // 保持宽高比进行缩小或者放大，使得图片完全显示在显示边界内。
              .objectFit(ImageFit.Contain)
              .margin(15)
              .overlay('Contain', { align: Alignment.Center, offset: { x: 0, y: 20 } })

            Text(item.name)
              .width("100%")
              .height("100%")
              .textAlign(TextAlign.Center)
              .borderRadius("24vp")
              .fontSize("16fp")
              .fontWeight("500")
              .padding({ left: "12vp" })
              .backgroundColor(Color.White)
            }
            .width("100%")
            .alignItems(VerticalAlign.Center)
        }
        .width("100%")
        .height("50vp")

      }, (item: string) => JSON.stringify(item))
    }
    .padding({
      left: "10vp",
      right: "10vp"
    })
    .height("80%")
    .width("100%")
    .edgeEffect(EdgeEffect.None)
    .scrollBar(BarState.Off)
    .borderWidth(1)
    .gridSpan(4)
    .lanes(4)
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.SELF_FIRST
    })
  }




  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize("30fp")
          .fontWeight(FontWeight.Bold)
          .height("56vp")
          .textAlign(TextAlign.Start)
          .width("100%")
          .padding({
            top: "10vp",
            left: "25vp",
            right: "10vp",
            bottom: "10vp"
          })
        Stack({ alignContent: Alignment.Top }) {
          Scroll(this.scrollerForScroll) {

            Column() {

              RowSplit() {

                Column() {
                  Text('测试1-1')
                    .fontSize("30fp")
                  Divider()
                  Text("测试1-2")
                    .fontSize("30fp")
                    .fontColor(Color.Red)
                }
                .width("50%")


                Column() {
                  Text('测试2-1')
                    .fontSize("30fp")
                  Divider()
                  Text("测试2-2")
                    .fontSize("30fp")
                    .fontColor(Color.Red)
                }
                .width("50%")

              }
              .height("20%")
              .borderWidth(1)
              .width("90%")
              .visibility(Visibility.None)

              Column({ space: 5 }) {
                // 设置子元素垂直方向间距为5
                Text('space').width('90%')
                Column({ space: 5 }) {
                  Column().width('100%').height(30).backgroundColor(0xAFEEEE)
                  Column().width('100%').height(30).backgroundColor(0x00FFFF)
                }.width('90%').height(100).border({ width: 1 })

                // 设置子元素水平方向对齐方式
                Text('alignItems(Start)').width('90%')
                Column() {
                  Column().width('50%').height(30).backgroundColor(0xAFEEEE)
                  Column().width('50%').height(30).backgroundColor(0x00FFFF)
                }.alignItems(HorizontalAlign.Start).width('90%').border({ width: 1 })

                Text('alignItems(End)').width('90%')
                Column() {
                  Column().width('50%').height(30).backgroundColor(0xAFEEEE)
                  Column().width('50%').height(30).backgroundColor(0x00FFFF)
                }.alignItems(HorizontalAlign.End).width('90%').border({ width: 1 })

                Text('alignItems(Center)').width('90%')
                Column() {
                  Column().width('50%').height(30).backgroundColor(0xAFEEEE)
                  Column().width('50%').height(30).backgroundColor(0x00FFFF)
                }.alignItems(HorizontalAlign.Center).width('90%').border({ width: 1 })

                // 设置子元素垂直方向的对齐方式
                Text('justifyContent(Center)').width('90%')
                Column() {
                  Column().width('90%').height(30).backgroundColor(0xAFEEEE)
                  Column().width('90%').height(30).backgroundColor(0x00FFFF)
                }.height(100).border({ width: 1 }).justifyContent(FlexAlign.Center)

                Text('justifyContent(End)').width('90%')
                Column() {
                  Column().width('90%').height(30).backgroundColor(0xAFEEEE)
                  Column().width('90%').height(30).backgroundColor(0x00FFFF)
                }.height(100).border({ width: 1 }).justifyContent(FlexAlign.End)
              }.width('100%').padding({ top: 5 }).visibility(Visibility.None)

              Column() {
                Text('The secant line can be dragged').fontSize(9).fontColor(0xCCCCCC).width('90%')
                ColumnSplit(){

                  Text('1').height(50).backgroundColor(0xF5DEB3).textAlign(TextAlign.Center).layoutWeight(1)
                  Text('2').height(50).backgroundColor(0xD2B48C).textAlign(TextAlign.Center).layoutWeight(1)
                  Text('3').height(50).backgroundColor(0xF5DEB3).textAlign(TextAlign.Center).layoutWeight(1)
                  Text('4').height(50).backgroundColor(0xD2B48C).textAlign(TextAlign.Center).layoutWeight(1)
                  Text('5').height(50).backgroundColor(0xF5DEB3).textAlign(TextAlign.Center).layoutWeight(1)

                }
                .borderWidth(1)
                .resizeable(true) // 可拖动
                .width('90%')
              }
              .width('100%')
              .visibility(Visibility.None)

              this.listBuilder()

            }
          }
          .scrollBar(BarState.Off)
          .width("100%")
          .height("100%")
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}