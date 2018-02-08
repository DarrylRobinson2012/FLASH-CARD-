//
//  CardProvider .swift
//  FLASH CARD
//
//  Created by Darryl Robinson  on 2/6/18.
//  Copyright © 2018 Darryl Robinson . All rights reserved.
//

import Foundation
//Errora that could happen while pulling the data
enum InvenoryError: Error {
    case InvalidResource
    case ConversionError
    case invalidSelection
}

//converts the plist into an array
class PlistConverter {
    static func array(fromFile name: String, ofType type: String) throws -> [AnyObject] {
        guard let path = Bundle.main.path(forResource: name, ofType: type ) else {
            throw InvenoryError.InvalidResource
        }
        guard let array = NSArray(contentsOfFile: path) as? [AnyObject] else {
            throw InvenoryError.ConversionError
        }
        return array
    }
}
// converts the array to a format that the array into a readable format
// reformat in as a dictionary for practice 
class inventoryUnarchiver {
    static func eventInventory(fromArray array: [AnyObject]) throws -> [flashCards] {
        
        var inventory: [flashCards] = []
        for value in array {
            if let term = value["term"] as? String, let definition = value["definition"] as? String, let UI = value["UI"] as? Int {
                let card = flashCards(term: term, definition: definition, UI: UI )
                inventory.append(card)
            }
        }
        return inventory
    }
}
//Rules for flash cards
protocol cards {
    var term: String  { get }
    var definition: String { get }
    var UI: Int { get }
    
}
//Actual flash cards
struct flashCards: cards {
    var term: String
    var definition: String
    var UI: Int

}


//Rules for each round
protocol quizRules {
    var cardKeyword: flashCards {get set }
    var cardTerm: flashCards { get set }
    var uniqueIdentifier1: Int {get}
    var uniqueIdentifier2:  Int { get }
    

}
//Actual quiz
class Quiz: quizRules {
    var cardKeyword: flashCards
    var cardTerm: flashCards
    var uniqueIdentifier1: Int
    var uniqueIdentifier2: Int
    
    func check() -> Bool {
        if uniqueIdentifier1 == uniqueIdentifier2 {
            return true
        }else   {
            return false
        }
    }
        init(cardKeyword: flashCards, cardTerm: flashCards, uniqueIdentifier1: Int, uniqueIdentifier2: Int){
            self.cardKeyword = cardKeyword
            self.cardTerm = cardTerm
            self.uniqueIdentifier1 = uniqueIdentifier1
            self.uniqueIdentifier2 = uniqueIdentifier2
            
        }

    }

//RULES FOR EACH SESSION
protocol session {
    var card: [flashCards ] {get set}
    var test: Quiz {get set }
    var wholecard: [flashCards] {get set}
    var count: Int {get set}
    var isOver : Bool {get set}
    
    func begin()
    func shuffleTheTerms(array: [flashCards]) -> [flashCards]
    func endQuiz()
    func nextCard()
    func checkTerm() -> Bool
    func doYouWantToSTOP()
    }
//The actual Study Session
class studySession {
    var card: [flashCards]
    var test: Quiz
    var wholecard: [flashCards]
    var count = 0
    var isOver = false
    
    func begin() {
        isOver = false
        count = 0
        card = wholecard
        nextCard()
    }
    //shuffles the events
    func shuffletheTerms(array: [flashCards]) -> [flashCards] {
        var tempArray = array
        var shuffled: [flashCards] = []
        for _  in 0..<tempArray.count
        {
            let random  = Int(arc4random_uniform(UInt32(tempArray.count)))
            shuffled.append(tempArray[random])
            tempArray.remove(at: random)
        }
        return shuffled
    }
    //ends the session
    func endQuiz() {
        isOver = true
    }
    //loads the next term
    func nextCard() {
        count += 1
        card = shuffletheTerms(array: card)
        test = Quiz(cardKeyword: card[0], cardTerm: card[0], uniqueIdentifier1: card[0].UI, uniqueIdentifier2: card[0].UI)
        card.remove(at: 0)
        print(card)
       
        if count >= 10{
            doYouWantToStop()
        }
    }
        //check answer
        func checkAnswer() -> Bool {
            let result = test.check()
            if result {
            
            }
            return test.check()
    }
    //Ask the user do they want to stop
    func doYouWantToStop(){
    }
 
    init(card: [flashCards]) {
        self.card = card
        self.wholecard = card
        self.test = Quiz(cardKeyword: card[0], cardTerm: card[0], uniqueIdentifier1: card[0].UI, uniqueIdentifier2: card[0].UI)
    }
}
    








