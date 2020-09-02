//
//  SwiftUIView.swift
//  MultiplicationGame
//
//  Created by Design Work on 2020-08-27.
//  Copyright © 2020 Ling Lu. All rights reserved.
//

import SwiftUI

struct dur: View {
    @State private var correctAnswerIndex = 3
    @State var qlist = [Question]()
    
    var body: some View {
        ForEach(0..<4){number in
                            Button(action:{
                                print("hi")
        
                            }){
                                Text(number == self.correctAnswerIndex ? "5":"Answer")
                        }
    }
}
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
