//
//  WebhookDestination.swift
//
//  Created by Prayansh Srivastava on 7/8/22.
//

import Foundation
import Segment

public class WebhookDestination: DestinationPlugin {
    public let timeline = Timeline()
    public let type = PluginType.destination
    
    public let key = "Webhooks"
    public var analytics: Analytics? = nil
    
    let webhookUrl: String
    
    public init(webhookUrl: String) {
        self.webhookUrl = webhookUrl
    }
    
    public func update(settings: Settings, type: UpdateType) {
        // Skip if you have a singleton and don't want to keep updating via settings.
        guard type == .initial else { return }
    }
    
    public func identify(event: IdentifyEvent) -> IdentifyEvent? {
        sendPayloadToWebhook(data: event)
        return event
    }
    
    public func track(event: TrackEvent) -> TrackEvent? {
        sendPayloadToWebhook(data: event)
        return event
    }
    
    public func screen(event: ScreenEvent) -> ScreenEvent? {
        sendPayloadToWebhook(data: event)
        return event
    }
    
    public func group(event: GroupEvent) -> GroupEvent? {
        sendPayloadToWebhook(data: event)
        return event
    }
    
    public func alias(event: AliasEvent) -> AliasEvent? {
        sendPayloadToWebhook(data: event)
        return event
    }
    
    public func reset() {
        // TODO: Do something with resetting partner SDK
    }
    
    func sendPayloadToWebhook(data: RawEvent){
        let url = URL(string: webhookUrl)
        guard let requestUrl = url else { fatalError() }

        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = data.toString()
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                // Network error. Retry.
                print("Error uploading request %@.", error)
                return
            }

            let code = (response as? HTTPURLResponse)?.statusCode ?? 0
            if code < 300 {
                // 2xx response codes. Don't retry.
                return
            }
            if code < 400 {
                // 3xx response codes. Retry.
                print("Server responded with unexpected HTTP code %d.", code)
                return
            }
        }
        task.resume()
    }
}
