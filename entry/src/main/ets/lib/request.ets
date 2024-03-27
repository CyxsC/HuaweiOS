// @ts-nocheck
import { apiBaseUrl, timeOut } from '../config/request';
import axios from '@ohos/axios';

let Service = axios.create({
  baseURL: apiBaseUrl,
  timeout: timeOut
});

//请求拦截器
Service.interceptors.request.use((config:InternalAxiosRequestConfig) => {
  // const token = getCookies('token');
  // const kefuToken = getCookies('kefu_token');
  // if (token || kefuToken) {
  //   config.headers['Authori-zation'] = config.kefu ? 'Bearer ' + kefuToken : 'Bearer ' + token;
  // }
  // 对请求数据做点什么
  return config;
}, (error:AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error);
});

export default Service