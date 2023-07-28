//
//  DestinationFilters.swift
//
//  Created by Prayansh Srivastava on 10/12/22.
//

import Foundation
import Segment

public class MetricsPlugin: Plugin {
    public let type: PluginType = .enrichment

    public var analytics: Analytics? = nil

    private var activeDestinations = [String]()

    public init(setOfActiveDestinations: Set<String>) {
        activeDestinations = Array(setOfActiveDestinations)
    }

    public func configure(analytics: Analytics) {
        self.analytics = analytics
    }

    public func execute<T: RawEvent>(event: T?) -> T? {
        guard var workingEvent = event else { return event }
        if var context = workingEvent.context?.dictionaryValue {
            context[keyPath: "plugins.destinations-filters"] = [
              "version": __destinationFilters_version,
              "active": activeDestinations
            ] as [String : Any]
            do {
                workingEvent.context = try JSON(context)
            } catch {
                print("Unable to convert context to JSON: \(error)")
            }
        }
        return workingEvent
    }
}
