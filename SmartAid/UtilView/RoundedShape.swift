//
//  RoundedShape.swift
//  SmartAid
//
//  Created by mohdanas on 25/06/25.
//

import SwiftUI

struct RoundedShape:Shape {
    var corners : UIRectCorner
    var radius:CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii:CGSize(width: radius, height:radius))
        
        return Path(path.cgPath)
    }
}
