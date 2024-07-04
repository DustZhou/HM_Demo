import router from '@ohos.router';

@Component
@Entry
struct SecondPage {
  /**
   * 显示从第一个页面传过来的消息。
   */
  @State message: string = (router.getParams() as Record<string,string|number>)['firstMsg'] as string
  /**
   * 显示请求码。
   */
  @State requestCode: number = (router.getParams() as Record<string,string|number>)['requestCode'] as number



  /**
   * 构建页面布局。
   *
   * 在这个函数中定义了页面的布局结构，包括文本和按钮等元素。
   * 使用了Row和Column组件来组织元素，并通过onClick事件处理函数来实现按钮的点击行为。
   */
  build() {
    Row() {
      Column() {
        // 显示页面消息。
        Text('第二个界面')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        // 显示从第一个页面返回的消息。
        Text(`显示第一页面传来的消息${this.message}`)
          .fontSize(20)
        // 创建跳转到第二个页面的按钮，并设置点击事件。
        Button('回到第一个界面')
          .fontSize(30)
          .onClick(() => {
            // 回调跳转到第一个页面，并传递参数。
            router.back({
              url: 'pages/Test/DataPassTest/FirstPage',
              params: {
                requestCode: this.requestCode,
                Msg: '超级用户'
              }
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}
