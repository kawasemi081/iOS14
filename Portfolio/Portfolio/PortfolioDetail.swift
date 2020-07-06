//
//  PortfolioDetail.swift
//  Portfolio
//
//  Created by MIsono on 2020/07/05.
//

import Foundation

struct PortfolioDetail: Hashable, Codable, Identifiable {
    let name: String
    let url: URL
    let profitLoss: Int
    let daybeforeRatio: Int
    let fundName: String
    let fundCode: String
    let fundProfitLoss: Double
    let fundDaybeforeRatio: Double
    var id: String {
        name
    }

    static let panda = PortfolioDetail(
        name: "ポートフォリオ名１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０",
        url: URL(string: "game:///panda")!,
        profitLoss: -29489400,
        daybeforeRatio: 4264735,
        fundName: "ひふみ投信",
        fundCode: "9C31108A",
        fundProfitLoss: 50647.0,
        fundDaybeforeRatio: 703.0)
    static let egghead = PortfolioDetail(
        name: "ポートフォリオ名てすと👀",
        url: URL(string: "game:///egghead")!,
        profitLoss: 5,
        daybeforeRatio: 1000,
        fundName: "ソフトバンク",
        fundCode: "9434.T",
        fundProfitLoss: 1365.0,
        fundDaybeforeRatio: -3.0)
    
    static let spouty = PortfolioDetail(
        name: "ポートフォリオ名chkyj",
        url: URL(string: "game:///spouty")!,
        profitLoss: 50,
        daybeforeRatio: 20_000,
        fundName: "AAPL",
        fundCode: "AAPL",
        fundProfitLoss: 364.11,
        fundDaybeforeRatio: 0.0)

    public static let availableCharacters = [panda, egghead, spouty]
    
    static func characterFromName(name: String?) -> PortfolioDetail {
        return (availableCharacters).first(where: { (character) -> Bool in
            return character.name == name
        }) ?? .panda
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

