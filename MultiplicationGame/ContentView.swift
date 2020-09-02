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
                            Spacer()
                            Spacer()
                            Stepper("Multiplication Range: \(maxMultRange)", value: $maxMultRange,  in: 1...12).foregroundColor(.white)
                            Text("How many questions?")
                            Picker("Number of Questions", selection: $numQuestions){
                                ForEach(0..<questionAmounts.count){
                                    Text("\(self.questionAmounts[$0])")
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                            
                        }
                        Spacer()
                            Button(action:{
                                withAnimation(.default){
                                       self.state = "active"
                                }})
                            {Text("Start!").foregroundColor(.white)
                            .font(.system(size: 50, weight: .bold, design: .rounded))
                                
                            }
                            .frame(width: 200, height: 100)
                            .background(Color.orange)
                            .cornerRadius(10)
                            
                                Spacer()
                            
                        }.padding(20)
                    }.transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
               
                
            }else if state == "active" {
                
                
                ZStack{
                    Color.blue
                        .edgesIgnoringSafeArea(.all)
//
                    VStack{
                        Spacer()
                        Text("\(qlist[questionIndex].first_num) x \(qlist[questionIndex].second_num)")
                        .foregroundColor(.white)
                            .font(.system(size: 50, weight: .bold, design: .rounded))
//                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        Spacer()
                        VStack{
                            ForEach(self.qlist[questionIndex].options, id:\.self){number in
                                Button(action:{
                                        self.turn(number)
                                   
                                }){
                                    Text("\(number)")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                }
                            }.foregroundColor(.blue)
                            .frame(width: 200, height: 100)
                            .background(Color.white)
                            .cornerRadius(15)
                            .padding(10)
                        }
                        Spacer()

                    Button("Restart"){
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
                    LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
                    VStack{
                        Text("Congratulations! \n You got \(self.correctCount) out of \(self.questionAmounts[self.numQuestions]) questions right.")
                            .foregroundColor(Color.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        Button("Restart"){
                            withAnimation(.default){
                                self.state = "settings"
                                self.reset()
                            }
                        }.foregroundColor(.white)
                    }.padding(20)
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
                self.state = "endGame"}
//            }
        }
//
    }
    
    func reset(){
        self.correctCount = 0
        self.questionIndex = 0
                    withAnimation(.default){
                        self.endGame=true
                    }
    }

    func generateQuestions(){
        qlist = [Question]()
        for _ in 0 ..< questionAmounts[numQuestions] {
            qlist.append(Question(maxMultRange:maxMultRange, first_num:Int.random(in: 1...maxMultRange)))
        }
        print("Generated qlist")
        print(qlist)

        
    }
    
}


    
    
    

struct Question{
    let maxMultRange: Int
    let first_num: Int
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
                var neg: Bool
                var num: Int
                
                repeat{
                    neg = Bool.random()
                    num = Int.random(in: 1...4)*first_num
                    if neg{
                        num = answer - num
                    }else{
                        num = answer + num
                    }
                } while num <= 0 || nums.contains(num)
                
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

