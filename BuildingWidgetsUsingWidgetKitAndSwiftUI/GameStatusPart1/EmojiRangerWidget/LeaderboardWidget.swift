//
//  LeaderboardWidget.swift
//  EmojiRangerWidgetExtension
//
//  Created by MIsono on 2020/06/30.
//  Copyright © 2020 Apple. All rights reserved.
//

import WidgetKit
import SwiftUI

struct LeaderboardProvider: TimelineProvider {
    public typealias Entry = LeaderboardEntry

    public func snapshot(with context: Context, completion: @escaping (LeaderboardEntry) -> Void) {
        let entry = LeaderboardEntry(date: Date(), characters: CharacterDetail.availableCharacters)

        completion(entry)
    }

    public func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        CharacterDetail.loadLeaderboardData { (characters, error) in
            guard let characters = characters else {
                let timeline = Timeline(entries: [LeaderboardEntry(date: Date(), characters: CharacterDetail.availableCharacters)], policy: .atEnd)

                completion(timeline)

                return
            }
            let timeline = Timeline(entries: [LeaderboardEntry(date: Date(), characters: characters)], policy: .atEnd)
            completion(timeline)
        }
    }
}

struct LeaderboardEntry: TimelineEntry {
    public let date: Date
    var characters: [CharacterDetail]?
}

struct LeaderboardPlaceholderView: View {
    var body: some View {
        LeaderboardWidgetEntryView(entry: LeaderboardEntry(date: Date(), characters: nil))
    }
}

struct LeaderboardWidgetEntryView: View {
    var entry: LeaderboardProvider.Entry

    var body: some View {
        ZStack {
            Color.gameBackground
        AllCharactersView(characters: entry.characters)
            .padding()
        }
    }
}

struct LeaderboardWidget: Widget {
    private let kind: String = "LeaderboardWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: LeaderboardProvider(), placeholder: LeaderboardPlaceholderView()) { entry in
            LeaderboardWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Ranger Leaderboard")
        .description("See all the rangers.")
        .supportedFamilies([.systemLarge])
//        .onBackgroundURLSessionEvents { (sessionIdentifier, completion) in
            /*
             - Note: what about background sessions?
             The widget responds to all of the URLSessions it creates, including background session. But there's no app delegate.
             so how does a widget know what to do?
             
             There's a modifier on widget configuration called onBackgroundURLSessionEvents, and that's analogous to the application delegate method. You're provided the session identifier, and a completion block. And you'd manage those just the same as you'd manage them in an app. And that's URL sessions.
             */
//            print(sessionIdentifier)
//            completion()
//        }
    }
}

struct LeaderboardWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LeaderboardWidgetEntryView(entry: LeaderboardEntry(date: Date(), characters: nil))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}

@main
struct EmojiBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        EmojiRangerWidget()
        LeaderboardWidget()
    }
}

