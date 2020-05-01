//
//  ContentView.swift
//  SmartWorkout_iOS
//
//  Created by Arkadiusz Chrabaszczewski on 01/05/2020.
//  Copyright © 2020 Arkadiusz Chrabaszczewski. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 1
 
    var body: some View {
        TabView(selection: $selection){
            
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Second")
                    }
                }
                .tag(0)
            TrainingStack()
                .tabItem {
                    VStack {
                        Image("first")
                        Text("First")
                    }
                }
                .tag(1)
        }
    }
}

struct TrainingStack: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack() {
                   HStack {
                       Text("Data Rozpoczęcia:")
                       Text("Wczoraj")
                       Spacer()
                    }.padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
                    ExerciseItem(exerciseName: "Wyciskanie na ławce płaskiej.")
                    ExerciseItem(exerciseName: "Wiosłowanie sztangi w opadzie tułowia")
                    ExerciseItem(exerciseName: "Podciąganie podchwytem")
                    ExerciseItem(exerciseName: "Wyciskanie francuskie")
                    ExerciseItem(exerciseName: "Rozpiętki na ławce płaskiej")
                    
                    HStack {
                       Button(action: {}) {
                           Text("Dodaj Ćwiczenie").accentColor(Color.orange)
                       }.padding(EdgeInsets(top: 5, leading: 0,bottom: 0,trailing: 0 ))
                       Spacer()
                   }
                }
                }
            .navigationBarTitle("Mój Trening", displayMode: .large)
            .navigationBarItems(
            trailing:
                HStack {
                    Button(action: {}) {
                        Image(systemName: "ellipsis").accentColor(Color.blue)
                    }
                    Button(action: {}) {
                        Text("Zakończ")
                    }
                }
            )
        }
    }
}


struct ExerciseItem: View {
    var exerciseName: String
    var sets: Array<Exercises> = []

    func onAddSetPress(){
        
    }
    
    var body: some View {
        VStack {
            HStack() {
                Text(exerciseName)
                Spacer()
                ElipsisButton(action: {})
            }
            SetHeader()
            SetRow(setSequence: 1, onAddSetPress: self.onAddSetPress)
            HStack {
                Button(action: {}) {
                    Text("Dodaj Serie").accentColor(Color.orange)
                }
                Spacer()
            }
        }
    }
}

struct SetHeader: View {
    var body: some View {
        VStack {
            HStack() {
                Text("SERIA")
                Spacer()
                Text("CEL")
                Spacer()
                Text("OSIĄGNIĘCIA")
                Spacer()
                Text("1RM")
                Spacer()
                Text("OBJĘTOŚĆ")
                ElipsisButton(action: {})
                
            }
            Divider()

        }
    }
}

struct SetRow: View {
    var setSequence: Int
    var goal: ExerciseResults?
    var acheivement: ExerciseResults?
    
    var onAddSetPress: () -> Void
    
    var oneRepMax: Float {
        return calcRepMax(weight: acheivement?.weight ?? 0, reps: acheivement?.repetitions ?? 0)
    }
    
    var volume: Int {
        get {
            return Int(acheivement?.weight ?? 0) * Int(acheivement?.repetitions ?? 0)
        }
    }

    var body: some View {
        VStack {
            HStack() {
                Text(String(setSequence))
                Spacer()
                Text(goal != nil ? "\(goal?.weight ?? 0) x \(goal?.repetitions ?? 0)" : "-")
                Spacer()
                Text(acheivement != nil ? "\(acheivement?.weight ?? 0) x \(acheivement?.repetitions ?? 0)" : "kg x powt")
                Spacer()
                Text(String(oneRepMax))
                Spacer()
                Text(String(volume))
                ElipsisButton(action: {})
            }
            Divider()
        }
    }
}

struct ElipsisButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: self.action) {
            Image(systemName: "ellipsis").accentColor(Color.orange)
        }.padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
    }
}

func calcRepMax(weight: Float, reps: Int) -> Float {
    if(weight == 0 || reps == 0){
        return 0
    }
    
    let freps = Float(reps)
    
    let lomonerm = weight * pow(freps, 1 / 10);
    let brzonerm = weight * (36 / (37 - freps));
    let eplonerm = weight * (1 + freps / 30);
    let mayonerm = (weight * 100) / (52.2 + 41.9 * exp(-1 * (freps * 0.055)));
    let ocoonerm = weight * (1 + freps * 0.025);
    let watonerm = (weight * 100) / (48.8 + 53.8 * exp(-1 * (freps * 0.075)));
    let lanonerm = (weight * 100) / (101.3 - 2.67123 * freps);

    return (lomonerm + brzonerm + eplonerm + mayonerm + ocoonerm + watonerm + lanonerm) / 7.0
}

class Exercises {
    
}

struct ExerciseResults {
    var weight: Float?
    var repetitions: Int?
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone Xs")
    }
}
