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
                        Image("second")
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
                    }
                    ExerciseItem()
                    Spacer()
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
    var body: some View {
        VStack {
            HStack() {
                Text("Wyciskanie Sztangi Na Ławce Płaskiej")
                Spacer()
                Button(action: {
                    print(":D")
                }) {
                    Image(systemName: "ellipsis").accentColor(Color.orange)
                }
            }
            SetHeader()
            SetRow(setSequence: 1)
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
                Button(action: {}) {
                    Image(systemName: "ellipsis").accentColor(Color.orange)
                }
                
            }
            Divider()

        }
    }
}

struct SetRow: View {
    var setSequence: Int
    var goal: ExerciseResults?
    var acheivement: ExerciseResults?

    var body: some View {
        VStack {
            HStack() {
                Text(String(setSequence))
                Spacer()
                Text(goal != nil ? "\(goal?.weight ?? 0) x \(goal?.repetitions ?? 0)" : "-")
                Spacer()
                Text(acheivement != nil ? "\(acheivement?.weight ?? 0) x \(acheivement?.repetitions ?? 0)" : "kg x powt")
                Spacer()
                Text("0")
                Spacer()
                Text("0")
                Button(action: {}) {
                    Image(systemName: "ellipsis").accentColor(Color.orange)
                }
            }
            Divider()
        }
    }
}

struct ExerciseResults {
    var weight: Int?
    var repetitions: Int?
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone Xs")
    }
}
