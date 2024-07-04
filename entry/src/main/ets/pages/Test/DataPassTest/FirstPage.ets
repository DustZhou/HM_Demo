import router from '@ohos.router';

@Component
@Entry
struct FirstPage {

  /**
   * 显示从第一个页面传过来的消息。
   */
  @State routermessage: string = (router.getParams() as Record<string,string|number>)['indexMsg'] as string
  /**
   * 显示请求码。
   */
  @State requestCode: number = (router.getParams() as Record<string,string|number>)['requestCode'] as number

  @State message: string = '第一个页面';
  //后期看是否可以自动生成code
  firstRequestCode: number = 1
  secondRequestCode: number = 2
  @State backMessage2: string = '测试第二个界面返回的值'
  @State backMessage3: string = '测试第三个界面返回的值'

  onPageShow(): void {
    // 获取传递进来的参数。
    let record = router.getParams() as Record<string, string | number>
    // 检查是否有请求码，用于区分不同的请求。
    // Code绑定请求和回调。所以第二个界面回来需要返回之前传的值
    if (record && record['requestCode']) {
      switch (record['requestCode']) {
        case this.firstRequestCode:
          this.backMessage2 = record['Msg'] as string
          break
        case this.secondRequestCode:
          this.backMessage3 = record['Msg'] as string
          break
      }
    }
  }

  /**
   * 构建页面布局。
   *
   * 在这个函数中定义了页面的布局结构，包括文本和按钮等元素。
   * 使用了Row和Column组件来组织元素，并通过onClick事件处理函数来实现按钮的点击行为。
   */
  build() {
    Row() {
      Column() {


        // 显示主页消息。
        Text(this.routermessage)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)

        // 返回按钮
        Button('返回')
          .fontSize(20)
          .width(100)
          .height(40)
          .onClick(() => {
            router.back({
              url: 'pages/Index',
              params: {
                requestCode: 1,
                Msg: '返回主页测试消息'
              }
            })
          })

        // 显示页面消息。
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        // 显示从第二个页面返回的消息。
        Text(this.backMessage2)
          .fontSize(30)
        // 创建跳转到第二个页面的按钮，并设置点击事件。
        Button('跳转到第二个页面')
          .fontSize(30)
          .onClick(() => {
            // 跳转到第二个页面，并传递参数。
            router.pushUrl({
              url: "pages/Test/DataPassTest/SecondPage",
              params: {
                requestCode: 1, //随便写,后期看是否能自动生成随机code
                firstMsg: '王二'
              }
            })
          })
        // 显示从第三个页面返回的消息。
        Text(this.backMessage3)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
        // 创建跳转到第三个页面的按钮，并设置点击事件。
        Button('跳转到第三个页面')
          .fontSize(30)
          .onClick(() => {
            // 跳转到第三个页面，并传递参数。
            router.pushUrl({
              url: 'pages/Test/DataPassTest/ThreePage',
              params: {
                requestCode: this.secondRequestCode, //随便写,后期看是否能自动生成随机code
                firstMsg: '张三'
              }
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}
