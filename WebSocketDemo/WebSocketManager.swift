//
//  WebSocketManager.swift
//  WebSocketDemo
//
//  Created by Manav on 30/12/19.
//  Copyright © 2019 Manav. All rights reserved.
//

import Foundation
import Combine

class WebSocketManager: NSObject {
    
    static let shared = WebSocketManager()
    
    var webSocketTask: URLSessionWebSocketTask?
    private override init() {}
    
    func create(_ channel: String = "", completion: ()->Void) {
        if let url = URL(string: "ws://quick-chat-manav.herokuapp.com") {
            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
            urlSession.webSocketTask(with: url)
            webSocketTask = urlSession.webSocketTask(with: url)
            establishConnection()
        }
    }
    
    
    func establishConnection() {
        webSocketTask?.resume()
        receiveMessage()
        
    }
    
    func closeConnection() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
    
    func receiveMessage() {
        webSocketTask?.receive { result in
            switch result {
            case .failure(let error):
                print("Error in receiving message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    print("Received string: \(text)")
                case .data(let data):
                    print("Received data: \(data)")
                @unknown default:
                    fatalError()
                }
                
                self.receiveMessage()
            }
        }
    }
    
    func sendPing() {
        webSocketTask?.sendPing { (error) in
            if let error = error {
                print("Sending PING failed: \(error)")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                self.sendPing()
            }
        }
    }
    
    deinit {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
    
    func send(text: String) {
        webSocketTask?.send(URLSessionWebSocketTask.Message.string(text)) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func send(data: Data) {
        webSocketTask?.send(URLSessionWebSocketTask.Message.data(data)) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
}

extension WebSocketManager: URLSessionWebSocketDelegate {
    
    func urlSession(_ session: URLSession,
                    webSocketTask: URLSessionWebSocketTask,
                    didCloseWith
        closeCode: URLSessionWebSocketTask.CloseCode,
                    reason: Data?) {
        // connection established
        print(String(data: reason ?? Data(), encoding: .utf16) ?? "x")
    }
    
    func urlSession(_ session: URLSession,
                    webSocketTask: URLSessionWebSocketTask,
                    didOpenWithProtocol protocol: String?) {
        print("Connection Established")
        
    }
    
}
