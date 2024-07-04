import { promptAction, router } from '@kit.ArkUI';



// 定义一个组件结构体，用于在UI中显示一对名称和值的组合
@Component
struct firstitemChildView {
  // 名称字段，用于显示该项的名称
  name: ResourceStr = '';
  // 值字段，用于显示该项的值
  value: ResourceStr = '';

  build() {
    // 使用Row布局水平排列组件内容
    Row() {
      // 使用Column布局垂直排列名称和值
      Column() {
        Row() {
          // 显示名称文本
          Text(this.name)
            .fontSize("18fp") // 设置字体大小
          // 显示值文本，并应用红色字体和左侧5个单位的外边距
          Text(this.value)
            .fontSize("18fp")
            .fontColor(Color.Red)
            .margin({
              left: 5
            })
        }
        .padding(10) // 在名称和值的周围添加10个单位的内边距
      }
    }
  }
}

/**
 * 构建第一个item的视图结构。
 *
 * 该结构使用Row和Column组件来布局，包含两个并列的列，每列显示相同的三个子项。
 * 子项通过firstitemChildView组件创建，并传入不同的名称和值来区分。
 * 整个结构设置了背景色、边框宽度、边框圆角和宽度等样式属性。
 */
@Component
export struct firstitemView {

  /**
   * 构建并返回firstitemView的视图实例。
   *
   * 该方法设置了视图的布局和样式，包括内边距、外边距、背景色、边框宽度和圆角等。
   * 使用Row和Column来实现两列布局，每列包含三个子项，子项通过传入不同的参数来展示不同的内容。
   *
   * @returns 返回构建好的视图实例。
   */
  build() {
    Row() {
      Column() {

        firstitemChildView({ name: "测试1-1" , value : "测试1-2" })

        firstitemChildView({ name: "测试2-1" , value : "测试2-2" })

        firstitemChildView({ name: "测试3-1" , value : "测试3-2" })

      }
      .width("50%")

      Column() {

        firstitemChildView({ name: "测试1-1" , value : "测试1-2" })

        firstitemChildView({ name: "测试2-1" , value : "测试2-2" })

        firstitemChildView({ name: "测试3-1" , value : "测试3-2" })

      }
      .width("50%")
    }
    .padding(
      {
        left: 10,
        right: 10,
        top: 10,
        bottom: 10
      }
    )
    .margin(
      {
        left: 10,
        right: 10,
        top: 10,
        bottom: 10
      }
    )
    .backgroundColor(Color.Yellow)
    .borderWidth(1)
    .borderRadius(24)
    .width("90%")
  }

}
/**
 * itemView 结构体定义了一个item的视图组件，包含图标和标题。
 * 该组件通过构建一个Column来展示图标和标题，并且设置了一些固定的样式和行为。
 * 当组件被点击时，会显示一个提示信息，包含标题的具体内容。
 */
@Component
export struct itemView {
  /* 图标的资源路径 */
  icon: ResourceStr = '';
  /* 标题的资源路径 */
  title: ResourceStr = '';
  /* 跳转页面的路径url */
  url : string  = '';

  /**
   * 构建并返回一个Column组件，该Column包含一个图标和一个标题。
   * - 图标使用this.icon路径加载，并设置了一些样式属性，如宽度、长宽比、背景色和图片适应方式。
   * - 标题使用this.title文本，并设置了一些样式属性，如字体大小、字体颜色和文本对齐方式。
   * 整个Column组件设置了宽度、高度、垂直对齐方式，并且配置了点击事件处理器。
   * 当Column被点击时，会显示一个包含标题信息的提示框。
   */
  build() {
    Column({ space: 10 }) {
      Image(this.icon)
        .width(40)
        .aspectRatio(1)
        .backgroundColor(Color.Green)
        .objectFit(ImageFit.Contain)

      Text(this.title)
        .fontSize(16)
        .fontColor(Color.Black)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(95)
    .justifyContent(FlexAlign.Center)

    .onClick(() => {

      if (this.url != "") {

        router.pushUrl({
          url : this.url,
          params: {
            requestCode: 1, //随便写,后期看是否能自动生成随机code
            indexMsg: '来自主页'
          }
        })


      }else {

        promptAction.showToast({ message: "跳转具体实现" + this.title });

      }

    })
  }
}
/*
 * 测试用
 * */
@Component
export struct iconViewTest {
  build() {

    Column(){

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

    }
  }

}