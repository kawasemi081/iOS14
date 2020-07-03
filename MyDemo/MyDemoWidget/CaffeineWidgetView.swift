//
//  CaffeineWidgetView.swift
//  MyDemo
//
//  Created by MIsono on 2020/07/03.
//

import SwiftUI
import WidgetKit

struct CaffeineWidgetData {
    let caffeineAmount: Measurement<UnitMass>
    let drinkName: String
    let drinkDate: Date
    var photoName: String? = nil
}

extension CaffeineWidgetData {
    static let previewData = CaffeineWidgetData(
        caffeineAmount: Measurement<UnitMass>(value: 56.23, unit: .milligrams),
        drinkName: "Cappucino",
        drinkDate: Date().advanced(by: -60 * 29 + 5),
        photoName: "capccino")
}

struct CaffeineWidgetView: View {
    let data: CaffeineWidgetData
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        ZStack {
            Color("capccino")
            HStack {
                VStack(alignment: .leading) {
                    CaffeineAmountView(data: data)
                    
                    Spacer()
                    
                    DrinkView(data: data)
                }
                .padding(.all)
                
                if widgetFamily == .systemMedium, let photoName = data.photoName {
                    Image(photoName).resizable()
                    
                }
            }
            
        }
        .background(Color.orange)

    }
}

struct CaffeineWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CaffeineWidgetView(data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            CaffeineWidgetView(data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemSmall)).environment(\.colorScheme, .dark)
            CaffeineWidgetView(data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
//                .environment(\.sizeCategory, .exstraExtraExtraLarge)
            CaffeineWidgetView(data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
//                .isPlaceholder(true)
            CaffeineWidgetView(data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            //                .isPlaceholder(true)
            // you must need `isPlaceholder` when it sets API response data
            
        }
    }
}

struct CaffeineAmountView: View {
    let data: CaffeineWidgetData
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Caffeine")
                    .font(.body)
                    .foregroundColor(Color("espresso"))
                    .bold()
//                    .isPlaceholder(true)
                Spacer()
//                measurementFormatter.string(from: data.caffeineAmount)
                Text("56.23 mg")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("espresso"))
                    .minimumScaleFactor(0.8)
            }
            
            Spacer(minLength: 0)
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 8.0)
        .background(ContainerRelativeShape().fill(Color("latte")))

    }
}

struct DrinkView: View {
    let data: CaffeineWidgetData

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(data.drinkName) ☕️")
                .font(.body)
                .bold()
                .foregroundColor(Color("milk"))
                .minimumScaleFactor(0.8)
            Text("\(data.drinkDate, style: .relative) ago")
                .font(.caption)
                .foregroundColor(Color("milk"))
        }
    }
}
