//
//  ViewController.swift
//  MqttClient_iOS
//
//  Created by NguyenQuocThanh on 7/26/21.
//

import UIKit
import CocoaMQTT

class ViewController: UIViewController {
    var mqtt: CocoaMQTT?
    let defaultHost = "mqtt.eclipseprojects.io"
    
    let controlTopic = "mv_jetbot_tnq_2020_439487293474234/desired"
    let updateTopic = "mv_jetbot_tnq_2020_439487293474234/update"
    
    let cmd_fwd = "{\"ctl\": \"fwd\"}"
    let cmd_bwd = "{\"ctl\": \"bwd\"}"
    let cmd_stop = "{\"ctl\": \"stop\"}"
    let cmd_left = "{\"ctl\": \"left\"}"
    let cmd_right = "{\"ctl\": \"right\"}"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mqttSetting()
        
        if let mqtt = mqtt {
            if(mqtt.connect())
            {
                print("connect ok")
            }
        }
    }
    
    func mqttSetting() {
        let clientID = "MqttClient12345678jkfnfjdsbfjds1" + String(ProcessInfo().processIdentifier)
        mqtt = CocoaMQTT(clientID: clientID, host: defaultHost, port: 1883)
        mqtt!.username = ""
        mqtt!.password = ""
        mqtt!.keepAlive = 60
        mqtt!.delegate = self
    }
    
    @IBAction func StopBtnPressed(_ sender: Any) {
        print("Stop")
        let buf: [UInt8] = Array(cmd_stop.utf8)
        let msg = CocoaMQTTMessage(topic: controlTopic, payload: buf)
        if let mqtt = mqtt {
            mqtt.publish(msg)
        }
    }
    
    @IBAction func UpBtnPressed(_ sender: Any) {
        print("Up")
        let buf: [UInt8] = Array(cmd_fwd.utf8)
        let msg = CocoaMQTTMessage(topic: controlTopic, payload: buf)
        if let mqtt = mqtt {
            mqtt.publish(msg)
        }
    }
    
    @IBAction func DownBtnPressed(_ sender: Any) {
        print("Down")
        let buf: [UInt8] = Array(cmd_bwd.utf8)
        let msg = CocoaMQTTMessage(topic: controlTopic, payload: buf)
        if let mqtt = mqtt {
            mqtt.publish(msg)
        }
    }
    
    @IBAction func LeftBtnPressed(_ sender: Any) {
        print("Left")
        let buf: [UInt8] = Array(cmd_left.utf8)
        let msg = CocoaMQTTMessage(topic: controlTopic, payload: buf)
        if let mqtt = mqtt {
            mqtt.publish(msg)
        }
    }
    
    
    @IBAction func RightBtnPressed(_ sender: Any) {
        print("Right")
        let buf: [UInt8] = Array(cmd_right.utf8)
        let msg = CocoaMQTTMessage(topic: controlTopic, payload: buf)
        if let mqtt = mqtt {
            mqtt.publish(msg)
        }
    }
    
}


extension ViewController: CocoaMQTTDelegate {
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {

    }
    

    
    // Optional ssl CocoaMQTTDelegate
    func mqtt(_ mqtt: CocoaMQTT, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        TRACE("trust: \(trust)")
        /// Validate the server certificate
        ///
        /// Some custom validation...
        ///
        /// if validatePassed {
        ///     completionHandler(true)
        /// } else {
        ///     completionHandler(false)
        /// }
        completionHandler(true)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        TRACE("ack: \(ack)")

        if ack == .accept {
            mqtt.subscribe(updateTopic, qos: CocoaMQTTQOS.qos0)
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didStateChangeTo state: CocoaMQTTConnState) {
        TRACE("new state: \(state)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        TRACE("message: \(message.string.description), id: \(id)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        TRACE("id: \(id)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        TRACE("message: \(message.string.description), id: \(id)")

        let name = NSNotification.Name(rawValue: "MQTTMessageNotification")
        NotificationCenter.default.post(name: name, object: self, userInfo: ["message": message.string!, "topic": message.topic])
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        TRACE("subscribed: \(success), failed: \(failed)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topics: [String]) {
        TRACE("topic: \(topics)")
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        TRACE()
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        TRACE()
    }

    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        TRACE("\(err.description)")
    }
}

extension ViewController: UITabBarControllerDelegate {
    // Prevent automatic popToRootViewController on double-tap of UITabBarController
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return viewController != tabBarController.selectedViewController
    }
}

extension ViewController {
    func TRACE(_ message: String = "", fun: String = #function) {
        let names = fun.components(separatedBy: ":")
        var prettyName: String
        if names.count == 2 {
            prettyName = names[0]
        } else {
            prettyName = names[1]
        }
        
        if fun == "mqttDidDisconnect(_:withError:)" {
            prettyName = "didDisconnect"
        }

        print("[TRACE] [\(prettyName)]: \(message)")
    }
}

extension Optional {
    // Unwrap optional value for printing log only
    var description: String {
        if let self = self {
            return "\(self)"
        }
        return ""
    }
}

