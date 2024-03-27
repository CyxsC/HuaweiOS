@Entry
@Component
struct User{
  @State name:String = ""

  onPageShow(){

  }

  build(){
    Flex(){
      Text("xxx")
        .backgroundColor(Color.Black)
        .width('200')
        .height('200')
    }
  }
}