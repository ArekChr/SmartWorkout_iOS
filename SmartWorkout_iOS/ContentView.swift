//
//  ContentView.swift
//  SmartWorkout_iOS
//
//  Created by Arkadiusz Chrabaszczewski on 01/05/2020.
//  Copyright © 2020 Arkadiusz Chrabaszczewski. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var selection = 1
 
    var body: some View {
        TabView(selection: $selection){
            
            Text("Second View")
                .font(.title)
                .tabItem {
                    if(selection == 0){
                        Image(systemName: "person.fill").font(.system(size: 25))
                    } else {
                        Image(systemName: "person").font(.system(size: 25))
                    }
                }
                .tag(0)
            TrainingStack()
                .tabItem {
                    if(selection == 1){
                        Image(systemName: "flame.fill").font(.system(size: 25))
                    } else {
                        Image(systemName: "flame").font(.system(size: 25))
                    }
                }
                .tag(1)
            Text("Tortoise")
                .font(.title)
                .tabItem {
                    if(selection == 2){
                        Image(systemName: "tortoise.fill").font(.system(size: 25))
                    } else {
                        Image(systemName: "tortoise").font(.system(size: 25))
                    }
                }
                .tag(2)
            Text("Ant")
                .font(.title)
                .tabItem {
                    if(selection == 3){
                        Image(systemName: "ant.fill").font(.system(size: 25))
                    } else {
                        Image(systemName: "ant").font(.system(size: 25))
                    }
                }
                .tag(3)
            Text("Bolt")
                 .font(.title)
                 .tabItem {
                     if(selection == 4){
                         Image(systemName: "bolt.circle.fill").font(.system(size: 25))
                     } else {
                         Image(systemName: "bolt.circle").font(.system(size: 25))
                     }
                 }
                 .tag(4)
        }
    }
}

struct TrainingStack: View {
    
    @State private var exercises: [Exercise] = [Exercise(id: "1", sequence: 1, name: "Cwiczenie 1")]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack() {
                   HStack {
                       Text("Data Rozpoczęcia:")
                       Text("Wczoraj")
                       Spacer()
                    }.padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
                    ForEach(exercises, id: \.self.sequence) { ex in
                        ExerciseItem(sets: ex.sets, exerciseName: ex.name, onAddSet: ex.addNewSet)
                    }
                    HStack {
                       Button(action: {
                        self.exercises.append(
                            Exercise(id: "123", sequence: (self.exercises.last?.sequence != nil) ? self.exercises.last!.sequence + 1 : 1, name: "test test"))
                       }) {
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
    
    @State var sets: [ExerciseSet]
    var exerciseName: String
    
    var onAddSet: () -> Void
    
    var body: some View {
        VStack {
            HStack() {
                Text(exerciseName)
                Spacer()
                ElipsisButton(action: {})
            }
            SetHeader()
            ForEach(sets, id: \.self.sequence) { set in
                SetRow(setSequence: set.sequence)
            }
            HStack {
                Button(action: {
                    self.sets.append(ExerciseSet(sequence: (self.sets.last != nil) ? self.sets.last!.sequence + 1 : 1))
                }) {
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
                }.font(.system(size: 15)).foregroundColor(Color.gray)
                
                ElipsisButton(action: {})
            }
            Divider()

        }
    }
}

struct SetRow: View {
    @State private var showingSheet = false
    var setSequence: Int
    var goal: ExerciseResults?
    var acheivement: ExerciseResults?
    
    var oneRepMax: Float {
        return Patterns.calcRepMax(weight: acheivement?.weight ?? 0, reps: acheivement?.repetitions ?? 0)
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
                ElipsisButton(action: {
                    self.showingSheet = true
                })
            }
            Divider()
                .actionSheet(isPresented: $showingSheet) {
                ActionSheet(title: Text("What do you want to do?"), message: Text("There's only one choice..."), buttons: [.default(Text("Dismiss Action Sheet"))])
            }
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

class Workout {
    var notes: String?
    var name: String?
    var startDate: Date?
    var durationInMinutes: Double?
    var exercises: [Exercise]?
    
    init(notes: String? = nil, name: String? = nil, exercises: [Exercise]? = [], startDate: Date? = nil, durationInMinutes: Double? = nil) {
        self.notes = notes
        self.name = name
        self.exercises = exercises!
        self.startDate = startDate
        self.durationInMinutes = durationInMinutes
    }
}

class Exercise: Identifiable {
    var id: String
    var sequence: Int
    var name: String
    var isVerified: Bool
    var sets: [ExerciseSet] = [ExerciseSet(sequence: 1)]
    
    init(id: String, sequence: Int, name: String, isVerified: Bool? = false){
        self.id = id
        self.sequence = sequence
        self.name = name
        self.isVerified = isVerified!
    }
    
    func addNewSet(){
        print("added new set, sets length: \(String(describing: self.sets.count))")
        self.sets.append(
            ExerciseSet(sequence: self.sequence + 1, goal: ExerciseResults(), acheived: ExerciseResults())
        )
    }
}

class ExerciseSet {
    var sequence: Int
    var goal: ExerciseResults?
    var acheived: ExerciseResults?
    
    init(sequence: Int, goal: ExerciseResults? = nil, acheived: ExerciseResults? = nil){
        self.sequence = sequence
        self.goal = goal
        self.acheived = acheived
    }
}

struct ExerciseResults {
    var weight: Float?
    var repetitions: Int?
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone Xs")
    }
}
#endif
