//
//  CustomShape.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/02/2023.
//

import SwiftUI


struct CustomShape: Shape {
    
    var xAxis: CGFloat
    var curve: CGFloat = 25
    var depth: CGFloat = 35
    var animatableData: CGFloat {
        get{ return xAxis}
        set { xAxis = newValue }
    }
    func path(in rect: CGRect) -> Path {
        return Path{path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine (to: CGPoint (x: rect.width, y: 0))
            path.addLine (to: CGPoint (x: rect.width, y: rect.height))
            path.addLine (to: CGPoint (x: 0, y: rect.height))
            
            let center = xAxis
            
            path.move(to: CGPoint(x: center - 50, y: 0))
            let to1 = CGPoint(x: center, y: depth)
            let control1 = CGPoint(x: center - curve, y: 0)
            let control2 = CGPoint(x: center - curve, y: depth)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + curve, y: depth)
            let control4 = CGPoint(x: center + curve, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
        
    }
    
}

