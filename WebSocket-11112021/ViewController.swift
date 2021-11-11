//
//  ViewController.swift
//  WebSocket-11112021
//
//  Created by Sergey Lukaschuk on 11.11.2021.
//

import UIKit

class ViewController: UIViewController, URLSessionWebSocketDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        
        let session = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: OperationQueue()
        )
        guard let url = URL(string: "wss://demo.piesocket.com/v3/channel_1?api_key=oCdCMcMPQpbvNjUIzqtvF1d2X2okWpDQj4AwARJuAgtjhzKxVEjQU6IdCjwm&notify_self") else { fatalError()}
        let webSocket = session.webSocketTask(with: url)
        webSocket.resume()
    }

    func ping() {}
    func close() {}
    func send() {}
    func receive() {}
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        <#code#>
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        <#code#>
    }
}

