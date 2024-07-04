import util from '@ohos.util';
import { itemView, firstitemView } from './itemView';
import { promptAction, router } from '@kit.ArkUI';


class Contact {
  key: string = util.generateRandomUUID(true);
  name: string;
  icon: Resource;
  url : string;

  constructor(name: string, icon: Resource ,url : string) {
    this.name = name;
    this.icon = icon;
    this.url  = url;
  }
}

@Entry
@Component
struct Index {
  // 页面展示的消息状态
  @State message: string = '首页';
  // 获取当前组件的上下文环境
  private context = getContext(this)
  // 初始化用于滚动展示的Scroller实例，用于展示内容
  private scrollerForScroll: Scroller = new Scroller();
  // 初始化用于列表展示的Scroller实例，用于展示联系人列表
  private scrollerForList: Scroller = new Scroller();
  // 联系人列表状态
  @State
  private contacts: Array<object> = []
  @State
  private mgs: string = '测试消息'

  aboutToAppear() {
    this.initData()
  }
  /**
   * 页面显示时执行的逻辑
   */
  onPageShow() {
    this.funBack()
  }
  funBack() {
    // 获取传递进来的参数。
    let record = router.getParams() as Record<string, string | number>

    if (record !== null && record !== undefined) {
      // 确保记录存在且'Msg'的值为string类型后再进行赋值
      const msg = record['Msg'] as string | undefined;
      if (msg !== undefined) {
        this.mgs = msg;
        // 检查是否有请求码，用于区分不同的请求。
        // Code绑定请求和回调。所以第二个界面回来需要返回之前传的值
        // if (record && record['requestCode']) {
        //   switch (record['requestCode']) {
        //     case this.firstRequestCode:
        //       this.backMessage2 = record['Msg'] as string
        //       break
        //     case this.secondRequestCode:
        //       this.backMessage3 = record['Msg'] as string
        //       break
        //   }
        // }

        // 若有更多属性处理，也应明确其类型，例如：
        // if ('requestCode' in record && typeof record['requestCode'] === 'number') {
        //     // 根据requestCode处理不同逻辑...
        // }
      } else {
        this.mgs = 'Message is undefined in the returned record.'
      }
    } else {
      this.mgs = 'Record is null.'
    }

    promptAction.showToast({ message: this.mgs });

  }

  /**
   * 初始化联系人数据
   * 通过循环创建并添加100个测试联系人到联系人列表中
   */
  initData() {

    this.contacts.push(
      new Contact("第一个页面", $r('app.media.foreground'), 'pages/Test/DataPassTest/FirstPage'),
      new Contact("第二个页面", $r('app.media.foreground'), 'pages/Test/DataPassTest/SecondPage'),
      new Contact("第三个页面", $r('app.media.foreground'), 'pages/Test/DataPassTest/ThreePage')
    )
    // 循环添加联系人
    for (let i = 0; i < 20; i++) {
      this.contacts.push(new Contact("测试" + i, $r('app.media.foreground'), ""))
    }
  }

  /**
   * 创建一个列表构建器，用于构建可滚动的联系人列表。
   * @Builder 注解指示这是一个构建器方法。
   */
  @Builder
  listBuilder() {
    // 使用List组件，并设置其属性
    List({ space: 5, scroller: this.scrollerForList }) {
      // 遍历联系人列表，为每个联系人创建一个列表项
      ForEach(this.contacts, (item: Contact) => {
        ListItem() {
          // 设置列表项的图标和标题
          itemView({ icon: item.icon, title: item.name , url : item.url})
        }
      }, (item: string) => JSON.stringify(item))
    } // 设置列表的内边距、宽度、边缘效果、滚动条状态、网格跨度和列数
    .padding({
      left: "10vp",
      right: "10vp"
    })
    .width("100%")
    .edgeEffect(EdgeEffect.Fade)
    .scrollBar(BarState.Off)
    .gridSpan(4)
    .lanes(4)
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.SELF_FIRST
    })
  }

  /**
   * 构建整个视图，包含消息区域和可滚动的联系人列表区域。
   */
  build() {
    // 创建主视图列，并设置其属性
    Column() {
      // 创建显示消息的文本，并设置其样式和布局属性
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
      // 创建包含可滚动区域的堆栈，并设置其属性
      Stack({ alignContent: Alignment.Top }) {
        // 创建可滚动视图，并设置其背景颜色和滚动条状态
        Scroll(this.scrollerForScroll) {
          Column() {
            firstitemView()
            // 插入列表构建器创建的联系人列表
            Column() {
              this.listBuilder()
            }.height("100%")
          }.backgroundColor(Color.Pink)
        }
        .backgroundColor(Color.Orange)
        .scrollBar(BarState.Off)
        .width("100%")
        .height("100%")
      }
      // 设置堆栈的背景颜色、高度和宽度
      .backgroundColor(Color.Pink)
      .height("calc(100% - 60vp)")
      .width('100%')
    }
    // 设置主视图列的高度、背景颜色
    .height("100%")
    .backgroundColor(Color.Gray)
  }
}

