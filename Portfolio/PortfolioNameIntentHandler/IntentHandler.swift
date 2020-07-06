//
//  IntentHandler.swift
//  PortfolioNameIntentHandler
//
//  Created by MIsono on 2020/07/06.
//

import Intents

class IntentHandler: INExtension, ConfigurationIntentHandling {
    func providePortfolioNameOptionsCollection(for intent: ConfigurationIntent, with completion: @escaping (INObjectCollection<PortfolioName>?, Error?) -> Void) {
        let portfolioNames: [PortfolioName] = PortfolioDetail.availableCharacters.map { character in
            let portfolioName = PortfolioName(identifier: character.name, display: character.name)
            
            return portfolioName
        }
        
        let collection = INObjectCollection(items: portfolioNames)
        
        completion(collection, nil)
    }

    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
