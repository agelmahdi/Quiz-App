//
//  AnswerModel.swift
//  Quiz App
//
//  Created by Ahmed El-Mahdi on 8/20/19.
//  Copyright © 2019 Ahmed El-Mahdi. All rights reserved.
//

import Foundation
protocol QuizProtocol {
    func questionRetieved(questions:[Questions])
}
class QuizModel{
    
    var delegate: QuizProtocol?
    
    func getQuestions()  {
        
        getRemoteJsonFile()
       // delegate?.questionRetieved(questions: [Questions]())
    }
    
    func getLocalJsonFile(){
        //get a path to the json file
        let path = Bundle.main.path(forResource: "QuestionData", ofType: ".json")
        
        guard path != nil else {
            print("Coundn't found path")
            return
        }
        // create url object from path object
        
        let url = URL(fileURLWithPath: path!)
        
        //get data from url
        do{
            let data = try Data(contentsOf: url)
            
            let  decoder = JSONDecoder()
            
            let array = try decoder.decode([Questions].self, from: data)
            
            delegate?.questionRetieved(questions: array)
        }
        catch{
            print("couldn't get data from url")
        }
        //decode data into instance of the question struct
    }
    
    func getRemoteJsonFile(){
    // Get a URL object from a string
              let stringUrl = "https://codewithchris.com/code/QuestionData.json"
              let url = URL(string: stringUrl)
              
              guard url != nil else {
                  print("Couldn't get a URL object")
                  return
              }
              
              // Get a URLSession object
              let session = URLSession.shared
              
              // Get a DataTask object
              let dataTask = session.dataTask(with: url!) { (data, response, error) in
                  
                  if error == nil && data != nil {
                  
                      // Create a json decoder
                      let decoder = JSONDecoder()
                      
                      do {
                          // Try to parse the data
                          let array = try decoder.decode([Questions].self, from: data!)
                          
                          // Notify the view controller with results by passing the data back to the main thread
                          DispatchQueue.main.async {
                              self.delegate?.questionRetieved(questions: array)
                          }
                          
                      }
                      catch {
                          print("Couldn't parse the json")
                      }
                      
                      
                  }
              }
              
              // Call resume on the DataTask object
              dataTask.resume()
        

    }
}
