import XCTest
import Segment
import AnalyticsFilters

final class AnalyticsFilters_SwiftTests: XCTestCase {
    func testFilterJSExecution() throws {
        // a simple test to make sure the LivePlugin is actually getting executed.
        let analytics = Analytics(configuration: Configuration(writeKey: "filterTest"))

        let outputReader = OutputReaderPlugin()
        // we want the output reader on the segment plugin
        // cuz that's the only place the metadata is getting added.
        let segmentDest = analytics.find(pluginType: SegmentDestination.self)
        segmentDest?.add(plugin: outputReader)
        
        let filters = DestinationFilters()
        
        analytics.add(plugin: filters)
        
        waitUntilStarted(analytics: analytics)
        
        analytics.track(name: "sampleEvent")
        
        RunLoop.main.run(until: Date.distantPast)
        
        let trackEvent: TrackEvent? = outputReader.lastEvent as? TrackEvent
        let metadata = trackEvent?._metadata
        

    }
}
