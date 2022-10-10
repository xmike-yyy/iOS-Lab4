//
//  ViewController.swift
//  Lab1
//
//  Created by Michael Sun on 9/13/22.
//

import UIKit
struct Flashcard{
    var question : String
    var answer : String
}
class ViewController: UIViewController {

    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    var flashcards = [Flashcard]()
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        card.clipsToBounds = true
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        readSavedFlashcards()
        if flashcards.count == 0{
            updateFlashcards(question: "What is the Capital of Brazil?", answer: "Brasilia")
        }else{
            updateLabels()
            updateNextPrevButtons()
        }



        // Do any additional setup after loading the view.
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    @IBAction func didtapFlashcard(_ sender: Any) {
        if frontLabel.isHidden == true {
            frontLabel.isHidden = false
        }
        else{ frontLabel.isHidden = true
        }
    }
    func updateFlashcards(question:String, answer: String){
        let flashcard = Flashcard(question:question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        flashcards.append(flashcard)
        print("Added new flashcard.")
        print("We now have \(flashcards.count) flashcards")
        currentIndex = flashcards.count-1
        print("Our current index is \(currentIndex).")
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    func updateNextPrevButtons(){
        prevButton.isEnabled = false

        if currentIndex == flashcards.count-1{
            nextButton.isEnabled = false
            prevButton.isEnabled = false
        }else{
            nextButton.isEnabled = true
        }
        if currentIndex > 0{
            prevButton.isEnabled = true
        }
    }
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
        
    }
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map{(card) -> [String:String] in return ["question":card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcard saved")
    }
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]]{
            let savedCards = dictionaryArray.map{ dictionary -> Flashcard in return Flashcard(question:dictionary["question"]!, answer: dictionary["answer"]!)}
            flashcards.append(contentsOf: savedCards)

        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
    }
    
}

