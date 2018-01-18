// ITXMqttService.aidl
package com.qcloud.iot.service;

import com.qcloud.iot.service.TXDisconnectedBufferOptions;
import com.qcloud.iot.service.ITXMqttActionListener;
import com.qcloud.iot.service.ITXShadowActionListener;
import com.qcloud.iot.service.TXMqttConnectOptions;
import com.qcloud.iot.service.TXMqttClientOptions;
import com.qcloud.iot.service.TXMqttMessage;
import com.qcloud.iot.shadow.DeviceProperty;

interface ITXMqttService {
    /**
     * 注册mqttAction监听器
     */
    void registerMqttActionListener(in ITXMqttActionListener mqttActionListener);

    /**
     * 注册shadowAction监听器
     */
    void registerShadowActionListener(in ITXShadowActionListener shadowActionListener);

    /**
     * 初始化设备信息
     * @param clientOptions  客户端选项
     */
    void initDeviceInfo(in TXMqttClientOptions clientOptions);

    /**
     * 设置断连状态buffer缓冲区
     */
    void setBufferOpts(in TXDisconnectedBufferOptions bufferOptions);

    /**
     * 连接MQTT
     * @param  options
     * @param  userContextId
     * @return status
     */
    String connect(in TXMqttConnectOptions options, in long userContextId);

    /**
     * 重新连接
     */
    String reconnect();

    /**
     * MQTT断连
     * @param timeout       等待时间（必须>0）。单位：毫秒
     * @param userContextId 用户上下文
     */
    String disConnect(in long timeout, in long userContextId);

    /**
     * 订阅主题
     * @param topic
     * @param qos
     * @param userContextId
     */
    String subscribe(in String topic, in int qos, in long userContextId);

    /**
     * 取消订阅主题
     */
    String unSubscribe(in String topic, in long userContextId);

    /**
     * 发布主题
     * @param topic
     * @param message
     * @param userContextId
     */
    String publish(in String topic, in TXMqttMessage message, in long userContextId);

    /**
     * 获取连接状态
     *
     * @return 连接状态
     */
    String getConnectStatus();

    /**
     * 获取设备影子文档
     */
    String getShadow(in long userContextId);

    /**
     * 更新设备影子文档
     * @param devicePropertyList
     * @param userContextId
     */
    String updateShadow(in List<DeviceProperty> devicePropertyList, in long userContextId);

    /**
     * 注册设备属性
     * @param deviceProperty
     */
    void registerDeviceProperty(in DeviceProperty deviceProperty);

    /**
     * 取消注册设备属性
     * @param deviceProperty
     */
    void unRegisterDeviceProperty(in DeviceProperty deviceProperty);

    /**
     * 更新delta信息后，上报空的desired信息，通知服务器不再发送delta消息
     * @param reportJsonDoc 用户上报的JSON内容
     */
    String reportNullDesiredInfo(String reportJsonDoc);

}
