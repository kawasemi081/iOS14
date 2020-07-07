//
//  PortfolioNameView.swift
//  Portfolio
//
//  Created by MIsono on 2020/07/05.
//
import SwiftUI
import WidgetKit

struct PortfolioNameView: View {
    let portfolioDetail: PortfolioDetail
    let updateDate: Date

    init(_ character: PortfolioDetail?, updateDate: Date) {
        self.portfolioDetail = character ?? PortfolioDetail.longName
        self.updateDate = updateDate
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(portfolioDetail.name)
                .font(.title)
                .fontWeight(.bold)
                .minimumScaleFactor(0.3)
            
            HStack {
                Text("損益: ")
                    .font(.caption)
                    .minimumScaleFactor(0.2)
                Text("\(portfolioDetail.profitLoss, specifier: "%d")")
                    .minimumScaleFactor(0.3)
                    .foregroundColor(.red)
            }
            
            HStack {
                Text("前日比: ")
                    .font(.caption)
                    .minimumScaleFactor(0.2)
                Text("+\(portfolioDetail.daybeforeRatio)")
                    .minimumScaleFactor(0.3)
                    .foregroundColor(.blue)
            }

            Spacer(minLength: 1)
            
            HStack {
                Text("\(updateDate, style: .time) 更新")
                    .font(.caption2)
                    .minimumScaleFactor(0.2)
                Spacer()
            }
        }
    }
}


struct PortfolioNameView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioNameView(PortfolioDetail.longName, updateDate: Date())
            .previewContext(WidgetPreviewContext(family: .systemSmall))

    }
}
