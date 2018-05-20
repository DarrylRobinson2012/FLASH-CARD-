//
//  CardProvider .swift
//  FLASH CARD
//
//  Created by Darryl Robinson  on 2/6/18.
//  Copyright © 2018 Darryl Robinson . All rights reserved.
//

import Foundation
import UIKit
//Errora that could happen while pulling the data
//Rules for flash cards
protocol cards {
    var term: String  { get }
    var definition: String { get }
    // var UI: Int { get }
    
}
//Actual flash cards
struct flashCards: cards {
    var term: String
    var definition: String
    // var UI: Int
    
}

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
            if let term = value["term"] as? String, let definition = value["definition"] as? String {
                let card = flashCards(term: term, definition: definition )
                inventory.append(card)
            }
        }
        return inventory
    }
}


//Rules for each round
protocol quizRules {
    var r1: flashCards {get set}
    var d1: flashCards  {get set}
    var cardKeyword: String {get set }
    var cardTerm: String { get set }
    //var uniqueIdentifier1: Int {get}
    //var uniqueIdentifier2:  Int { get }
    

}
//Actual quiz
class Quiz: quizRules   {
    var r1: flashCards
    var d1: flashCards
    var cardKeyword: String
    var cardTerm: String
    //var uniqueIdentifier1: Int
    //var uniqueIdentifier2: Int
    
    /*func check() -> Bool {
        if  cardTerm.term == cardTerm.term {
            return true
        }else   {
            return false
        }
    }*/
    init(r1: flashCards, d1: flashCards, cardKeyword: String, cardTerm: String){
            self.r1 = r1
            self.d1 = d1
            self.cardKeyword = cardKeyword
            self.cardTerm = cardTerm
           // self.uniqueIdentifier1 = uniqueIdentifier1
            //self.uniqueIdentifier2 = uniqueIdentifier2
            
        }
}
    

//RULES FOR EACH SESSION
protocol session {
    var card: [flashCards ] {get set}
    var previousCards: [flashCards] { get set }
    var test: Quiz {get set }
    var wholecard: [flashCards] {get set}
    var count:Int {get set}
    var count2:Int {get set}

    var isOver : Bool {get set}
    
    func begin()
    func shuffleTheTerms(array: [flashCards]) -> [flashCards]
    func endQuiz()
    func nextCard()
    func checkTerm()
    func doYouWantToStop()
    }
//The actual Study Session
class studySession: session {
    var card: [flashCards]
    var previousCards: [flashCards]
    var test: Quiz
    var wholecard: [flashCards]
    var count = 0
    var count2 = 0
    var isOver = false
    
    func begin() {
        isOver = false
        count = 0
        card = wholecard
        nextCard()
    }
    //shuffles the events
    func shuffleTheTerms(array: [flashCards]) -> [flashCards] {
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
        
        //card = shuffleTheTerms(array: card)
        
        test = Quiz(r1: card[count], d1: card[count], cardKeyword: card[count].term, cardTerm: card[count].definition)
    
       
        count += 1
        print(card)
       
        if count == card.count{
            doYouWantToStop()
        }
    }
    
    //previous card
    func previousCard() {
        count -= 1
        test = Quiz(r1: card[count ], d1: card[count], cardKeyword: card[count].term, cardTerm: card[count].definition)
        
        
        
        
        
    }
    
    
    
        //check answer
    func checkTerm(){} //-> Bool {
           /* let result = test.check()
            if result {
            
            }
            return test.check()
    }*/
    //Ask the user do they want to stop
    func doYouWantToStop(){
       var done = true
    }
 
    init(card: [flashCards]) {
        self.card = card
        self.previousCards = card
        self.wholecard = card
        self.test = Quiz(r1: card[0], d1: card[0], cardKeyword: card[0].term, cardTerm: card[0].definition)
    
    }
}
    



