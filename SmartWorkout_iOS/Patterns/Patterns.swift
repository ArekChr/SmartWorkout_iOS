//
//  Patterns.swift
//  SmartWorkout_iOS
//
//  Created by Arkadiusz Chrabaszczewski on 01/05/2020.
//  Copyright © 2020 Arkadiusz Chrabaszczewski. All rights reserved.
//

import Foundation

class Patterns {
    static func calcRepMax(weight: Float, reps: Int) -> Float {
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
}

