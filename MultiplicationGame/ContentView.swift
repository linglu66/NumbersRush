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
    @State private var correctAnswerIndex = Int.random(in:0...3)
    @State private var state = "settings"{
        didSet{
            generateQuestions()
        }
    }
    @State var questionIndex = 0
    
    @State var qlist = [Question]()
    @State private var endGame=false
    @State private var correctCount = 0
    @State private var numsInCurrentQuestion = [Int]()
    @State private var randomNumCounter = 0
    
    let questionAmounts = [5,10,20]
    var body: some View {
            
        ZStack{
           
            if state == "settings"{
                ZStack{
                     LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
                    VStack{
                    Section{
                        Stepper("Multiplication Range: \(maxMultRange)", value: $maxMultRange,  in: 1...12)
                        Picker("Number of Questions", selection: $numQuestions){
                            ForEach(0..<questionAmounts.count){
                                Text("\(self.questionAmounts[$0])")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Button("Start"){
                        withAnimation(.default){
                                   self.state = "active"
                        }
                                   
                    }.foregroundColor(.white)
                    }
                }.transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
               
                
            }else if state == "active" {
                
                
                ZStack{
                    Color.white
//
                    VStack{
                        Text("\(qlist[questionIndex].first_num) x \(qlist[questionIndex].second_num)")
                        VStack{
                            ForEach(self.qlist[questionIndex].options, id:\.self){number in
                                Button(action:{
                                        self.turn(number)
                                   
                                }){
                                    Text("\(number)")
//                                                            number == self.correctAnswerIndex ? "\(self.qlist[self.questionIndex].answer)":"\(Int.random(in: 1...self.maxMultRange*12))")
                                                   }
                            }
                        }
//                    dur()
    //                Text("LOL")
    ////                dur{potato:"Hi"}
    ////                Text("\(question.first_num) x \(question.second_num)")
                    Button("Settings"){
                        withAnimation(.default){
                        self.state = "settings"
                            self.reset()
                        }
                    }
                    }.onAppear{print("Hi")
                 
                    }
                }.transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
//                    .alert(isPresented: $endGame){
//                    Alert(title: Text("good"),
//                        dismissButton: .default(Text("Continue")){
//                            self.state = "settings"
//                    })
//                }
//                }
            }else if state == "endGame"{
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Congratulations! End of game. You got \(self.correctCount) out of \(self.questionAmounts[self.numQuestions]) questions right.")
                    Button("Settings"){
                        withAnimation(.default){
                            self.state = "settings"
                            self.reset()
                        }
                    }.foregroundColor(.white)
                    }
                }.transition(.move(edge: .bottom))
                
            }
        }
        
    }
    
   
    func turn(_ number: Int){
        
        
        if number == qlist[questionIndex].answer{
            self.correctCount += 1
            print("Correct!")
        }else{
            print("Incorrect")
        }
//        print(number)
//        self.correctAnswerIndex = Int.random(in:0...3)
        self.questionIndex += 1
        print("in turn function")
        print(qlist.count)
       
       
        if self.questionIndex == qlist.count{
            self.questionIndex -= 1
            withAnimation(.default){
//            qlist = [Question]()
                self.state = "endGame"}
         
//        reset()
            
//            }
        }
//
    }
    
    func reset(){
        self.correctCount = 0
        self.questionIndex = 0
                    withAnimation(.default){
//                    self.state = "endGame"
                        self.endGame=true
                    }
        
    }

    func generateQuestions(){
        qlist = [Question]()
        for _ in 0 ..< questionAmounts[numQuestions] {
            
//            get options
            
            qlist.append(Question(maxMultRange:maxMultRange))
            
            
        }
        print("Generated qlist")
        print(qlist)
        print(qlist.count)
        
    }
    
}


    
    
    

struct Question{
    let maxMultRange: Int
    var first_num: Int {Int.random(in: 1...maxMultRange)}
    let second_num = Int.random(in: 1 ..< 13)
    var answer: Int {first_num * second_num}
    let correctAnswerIndex = Int.random(in:0...3)
    var options: [Int] {
        print("answer is \(answer)")
        var nums  = [Int]()
        for i in 0..<4{
            
            if i == self.correctAnswerIndex{
                nums.append(answer)
                
            }else{
                
                var num: Int
                repeat{
                    num = Int.random(in: 1...1*12)
                    print("im trapped")
                } while num == answer || nums.contains(num)
                
                nums.append(num)}
            print("nums looks like this: \(nums)")
        }
        
        return nums
        
    }
    

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

