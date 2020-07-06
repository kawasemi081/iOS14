//
//  PortfolioView.swift
//  Portfolio
//
//  Created by MIsono on 2020/07/05.
//

import SwiftUI
import WidgetKit

struct PortfolioView: View {
    var character: PortfolioDetail
    var updateDate: Date
    @Environment(\.widgetFamily) var widgetFamily

    init(_ character: PortfolioDetail, updateDate: Date) {
        self.character = character
        self.updateDate = updateDate
    }

    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    VStack {
                        PortfolioNameView(character, updateDate: updateDate)
                        Spacer(minLength: 2)
                    }
                    if widgetFamily == .systemSmall {
                        StockView(character: character)
                    } else {
                        let availableCharacters = PortfolioDetail.availableCharacters
                        HStack(spacing: 5) {
                            ForEach(availableCharacters, id: \.self) {
                                StockView(character: $0)
                            }
                        }
                    }
                }
                .padding(.all)
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PortfolioView(PortfolioDetail.egghead, updateDate: Date())
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            PortfolioView(PortfolioDetail.egghead, updateDate: Date())
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}

struct StockView: View {
    let character: PortfolioDetail
    
    var bgColor: Color {
        switch character.fundName {
        case "AAPL":
            return .gray
        case "ソフトバンク":
            return .red
        default:
            return .blue
        }
    }

    var body: some View {
            VStack {
                HStack {
                    VStack (alignment: .leading) {
                        Text(character.fundName)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.4)
                        
                        Text(character.fundCode)
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                            .minimumScaleFactor(0.4)
                    }

                    Spacer()
                }

                Spacer()
                
                HStack {
                    Spacer()
                    VStack (alignment: .trailing) {
                        if character.fundName == "AAPL" {
                            Text("\(character.fundProfitLoss, specifier: "%.2f")")
                                .font(.subheadline)
                                .multilineTextAlignment(.trailing)
                                .minimumScaleFactor(0.85)
                            Text("\(Int(character.fundDaybeforeRatio), specifier: "%d")")
                                .font(.subheadline)
                                .multilineTextAlignment(.trailing)
                                .minimumScaleFactor(0.85)
                        } else {
                            Text("\(Int(character.fundProfitLoss), specifier: "%d")")
                                .font(.subheadline)
                                .multilineTextAlignment(.trailing)
                                .minimumScaleFactor(0.85)
                            Text("\(Int(character.fundDaybeforeRatio), specifier: "%d")")
                                .font(.subheadline)
                                .multilineTextAlignment(.trailing)
                                .minimumScaleFactor(0.85)
                        }
                    }
                }
                
            }
            .padding(.all, 8.0)
            .background(ContainerRelativeShape().fill(bgColor))
        
    }
}
