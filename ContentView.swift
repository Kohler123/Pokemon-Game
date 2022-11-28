//
//  ContentView.swift
//  PokemonFight
//
//  Created by SI CHEN on 9/7/22.
//

import SwiftUI

struct ContentView: View {
    @State var result:String = "Let's fight!"
    @State var randomNumber1 = Int.random(in:1...100)
    @State var randomNumber2 = Int.random(in:1...100)
    @State var pokemon1Shake: Bool = false
    @State var pokemon2Shake: Bool = false
    @State var player1 = 1000
    @State var player2 = 1000
    
    var body: some View {
        Text(result)
            .padding()
        let pokemon1:String = String(format: "%03d", randomNumber1)
        let pokemon2:String = String(format: "%03d", randomNumber2)
        var pokemon1IsAttacking = true
        
        VStack{
            HStack{
                VStack{
                    Image(pokemon1).offset(x: pokemon1Shake ? -10 : 0)
                        .animation(Animation.default.repeatCount(5))
                    Text("HP: \(player1)")
                }
                VStack{
                    Image(pokemon2).offset(x: pokemon2Shake ? -10 : 0)
                        .animation(Animation.default.repeatCount(5))
                    Text("HP: \(player2)")
                }
            }
            Button("Attack!") {
                while player1 > 0 && player2 > 0{
                    if(pokemon1IsAttacking){
                        self.pokemon1Shake.toggle()
                        result = ("Damage:\(randomNumber1)")
                        player2 = player2 - randomNumber1
                    }
                    else{
                        self.pokemon2Shake.toggle()
                        result = ("Damage: \(randomNumber2)")
                        player1 = player1 - randomNumber1
                    }
               
                }
                
                if (player1 <= 0){
                    result = ("Pokemon 1 Wins")
                }
                else if (player2 <= 0){
                    result = ("Pokemon 2 Wins")
                }
            }
            
            Button("Replay")
            {
                result = ""
                player1 = 1000
                player2 = 1000
                randomNumber1 = Int.random(in:1...100)
                randomNumber2 = Int.random(in:1...100)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

    struct Shake: GeometryEffect {
        var amount: CGFloat = 10
        var shakesPerUnit = 3
        var animatableData: CGFloat

        func effectValue(size: CGSize) -> ProjectionTransform {
            ProjectionTransform(CGAffineTransform(translationX:
                amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                y: 0))
        }
    }
