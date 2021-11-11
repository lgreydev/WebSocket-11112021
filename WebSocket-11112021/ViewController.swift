//
//  ViewController.swift
//  WebSocket-11112021
//
//  Created by Sergey Lukaschuk on 11.11.2021.
//

import UIKit

class ViewController: UIViewController, URLSessionWebSocketDelegate {

    private var webSocket: URLSessionWebSocketTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        
        let session = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: OperationQueue()
        )
        guard let url = URL(string: "wss://demo.piesocket.com/v3/channel_1?api_key=oCdCMcMPQpbvNjUIzqtvF1d2X2okWpDQj4AwARJuAgtjhzKxVEjQU6IdCjwm&notify_self") else { fatalError()}
        webSocket = session.webSocketTask(with: url)
        webSocket?.resume()
    }

    func ping() {
        webSocket?.sendPing { error in
            if let error = error {
                print("Ping error: \(error)")
            }
        }
    }
                        
    func close() {
        webSocket?.cancel(with: .goingAway, reason: "Demo ended".data(using: .utf8))
    }
    
    func send() {
        webSocket?.send(.string("Send new message \(Int.random(in: 0...100))"), completionHandler: { error in
            if let error = error {
                print("Send error \(error)")
            }
        })
    }
    
    func receive() {
        webSocket?.receive(completionHandler: { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    print("Data: \(data)")
                case .string(let message):
                    print("Got string: \(message)")
                default:
                    break
                }
            case .failure(let error):
                print("Receive error \(error)")
                
            }
            
            self?.receive()
        })
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Did connect to socket")
        
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Did close connection with reason")
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
        ping()
        send()
        receive()
    }
}

