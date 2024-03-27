// @ts-nocheck
import resourceManager from '@ohos.resourceManager';
import HashMap from '@ohos.util.HashMap';
import display from '@ohos.display';
import app from '@system.app';
import prompt from '@ohos.prompt';
import { list, setInput } from '../api/index';

@Entry
@Component
struct Index {
  // 列表
  @State List:object = new HashMap();
  // 时间
  @State timeNews:number = new Date().getTime();

  // 用户名
  @State userName: string = 'Fourin';
  public numb: number = 1;
  @State managerList: Array<string> = [];;

  //加载显示
  @State loadingShow: boolean = false;

  //test
  @State Test:Array<any> = [];
  @State bool:boolean = false;
  @State appleVisible: Visibility = Visibility.Visible

  /*
   *设备信息 phone information
   */
  private resManager: resourceManager.ResourceManager;
  private displayClass: object = {};
  private lastExitTime:number = -1;

  build() {
    Column() {
      Row(){
        TextInput()
          .backgroundColor("#ffb9c8d6")
          .size({width:280,height:36})
          .fontColor(Color.Black)
          .onChange((event)=>{
            setInput({"key":event}).then((data)=>{
              this.Test = data.data;
              console.log(JSON.stringify(data.data))
            }).catch((error)=>{
              console.log(JSON.stringify(error))
            })
          })

      }.size({width:"100%",height:"10%"}).justifyContent(FlexAlign.Center)
      Row(){
        //列表 list
        Flex({direction: FlexDirection.Column}) {
          ForEach(this.Test, (value, index: number) => {
            Row() {
              Row(){
                Text()
                Image()
              }
              Row(){
                Text()
              }
            }.size({width:(this.displayClass.width-12*6)+"px",height:'500px'})
              .backgroundColor(Color.Blue)
              .margin(12)
              .borderRadius(10)
          })
        }
      }.size({width:'100%',height:'80%'}).justifyContent(FlexAlign.Center)
      Row(){
        // 获取标签列表
        Button("查看")
          .size({width: 180, height: 50})
          .fontSize(23)
          .backgroundColor("#ff0a7eee")
          .stateStyles({
            pressed: { // 设置手指摁下时的显示样式
              .backgroundColor("#ff2590f3")
            }
          })
          .onClick(() => {
            // 处理回调
            list().then((data)=>{
              this.Test = data.data;
              console.log(JSON.stringify(data.data));
            }).catch((error)=>{
              console.log(error)
            })
          })
      }.size({width:'100%',height:'10%'}).justifyContent(FlexAlign.Center)
      //加载 loading...
      if(this.loadingShow){
        LoadingProgress().width(70).height(70).color(Color.Red);
      }
      //跳转
      Flex(){
        Text("xxx")
          // .size({width: 50,height: 50})
          .backgroundColor(Color.black)
      }.size({width: 80,height: 200})
      .position({x:(this.displayClass.width-160)+"px",y:(this.displayClass.height/2-400)+"px"})
      .backgroundColor(Color.Red)

    }.size({width:'100%',height:'100%'}).backgroundColor("#fff6f8f8")
  }

  aboutToAppear(){
    try {
      this.displayClass = display.getDefaultDisplaySync();
    } catch (exception) {
      console.error('Failed to obtain the default display object. Code: ' + JSON.stringify(exception));
    }

    this.resManager = getContext(this).resourceManager
    /*
     *获取字符串数组资源
     */
    this.resManager.getStringValue(0x1000001,(err,data)=>{
      this.managerList[0] = JSON.stringify(data?data:err)
    })
    /*
     * 获取设备信息
     */
    this.resManager.getDeviceCapability((err,data)=>{
      this.managerList[1] = JSON.stringify(data?data:err)
    })
    /*
     * 获取设备设置
     */
    this.resManager.getConfiguration((err,data)=>{
      this.managerList[2] = JSON.stringify(data?data:err)
    })

    this.loadingShow = false
  }

  aboutToDisappear(){
    this.resManager?.release()
  }

  onBackPress() {
    if (-1 == this.lastExitTime) {                 // 第一次点击返回键，提示toast
      this.lastExitTime = new Date().getTime();
      prompt.showToast({
        message: "再按一次退出应用"
      })
      return true;
    } else {
      let currentTime = new Date().getTime();
      if(currentTime - this.lastExitTime > 2000) { // 时间大于2000提示
        prompt.showToast({
          message: "再按一次退出应用"
        })
        this.lastExitTime = currentTime;
        console.log("two");
        return true;
      } else {                                     // 2秒内点击，退出APP
        console.log("xx");
        app.terminate();
      }
    }
    return false;
  }
}