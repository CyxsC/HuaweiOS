import request from '../lib/request';

/*
 * 列表
 */
export function list(){
  return request({
    url: "link/list",
    method: "get"
  })
}

/*
 * 查
 */
export function setInput(data){
  return request({
    url: "link/input",
    method: "post",
    params: data
  })
}