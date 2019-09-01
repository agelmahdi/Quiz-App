//
//  ViewController.swift
//  Quiz App
//
//  Created by Ahmed El-Mahdi on 8/20/19.
//  Copyright © 2019 Ahmed El-Mahdi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, QuizProtocol, UITableViewDataSource ,UITableViewDelegate{
    
    @IBOutlet weak var questionLable: UILabel!
    
    
    @IBOutlet weak var answersTableView: UITableView!
    
    
    var model = QuizModel()
    var questions = [Questions]()
    var questionIndex = 0
    var numCorrect = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        answersTableView.delegate = self
        answersTableView.dataSource = self
        
        
        model.delegate=self
        model.getQuestions()
    }
    
    func displayQuestion(){
        // check if that the correct quetion is not beyonds the question array
        
        guard questionIndex < questions.count else {
            print("trying to dispay a question index that out of pounds ")
            return
        }
        
        questionLable.text = questions[questionIndex].question!
        
        answersTableView.reloadData()
    }
    
    func questionRetieved(questions: [Questions]) {
        
        self.questions = questions
        
        displayQuestion()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard questions.count > 0 && questions[questionIndex].answers != nil else {
            return 0
        }
        
        return questions[questionIndex].answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        let label = cell.viewWithTag(1) as! UILabel
        label.text = questions[questionIndex].answers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard questions[questionIndex].correctAnswerIndex! > indexPath.row else {
               print("trying to dispay a question index that out of pounds ")
               return
           }

        if questions[questionIndex].correctAnswerIndex == indexPath.row {
            
            numCorrect += 1
            
        }
        else{
            
        }
        questionIndex += 1
        displayQuestion()
    }
}

