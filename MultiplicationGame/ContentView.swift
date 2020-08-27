//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Design Work on 2020-08-27.
//  Copyright © 2020 Ling Lu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var maxMultRange = 1
    @State private var numQuestions = 0
    @State private var state = "settings"
    @State var question = Question(first_num: 2)
    
    let questionAmounts = [5,10,20]
    var body: some View {
        VStack{
            if state == "settings"{
                Form{
                    Section{
                        Stepper("Multiplication Range: \(maxMultRange)", value: $maxMultRange,  in: 1...12)
                        Picker("Number of Questions", selection: $numQuestions){
                            ForEach(0..<questionAmounts.count){
                                Text("\(self.questionAmounts[$0])")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Text("Hello, World! \(maxMultRange) \(numQuestions)")
                    }
                Button("Press me"){
                    self.state = "active"
                    self.question = Question(first_num: Int.random(in: 1 ... self.maxMultRange))
                }
            }else if state == "active"{
                
                Text("\(question.first_num) x \(question.second_num)")
                Button("Press me"){
                    self.state = "settings"
                }
            }
        }
        
    }
}
func generateQuestions(range: Int, numQuestions: Int){
    var qlist = [Question]()
    ForEach(0..<numQuestions){_ in 
        qlist.append(Question(first_num: range))
    }
    
    
}
struct Question{
    var first_num: Int
    var second_num = Int.random(in: 1 ..< 13)
    var answer: Int {first_num * second_num}
    
    
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
