import init from '../interface/init';
import http from '@ohos.net.http';
import HashMap from '@ohos.util.HashMap';

export default class initialize implements init{
  private config;

  private list:object|HashMap<string,any>;

  //请求回调
  private  requestBack;

  public construct(){

  }

  //初始化
  public init():Boolean{
    try {
      return true
    }catch(e){
      return false
    }
  }
}