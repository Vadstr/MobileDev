//
//  ShowPieChart.swift
//  Lab2
//
//  Created by Vadim on 14.03.2021.
//

import UIKit

class ShowPieChart: UIView {
    
    private var units = [Unit(value: 0.05, color: .blue),
                         Unit(value: 0.05, color: .brown),
                         Unit(value: 0.1, color: .orange),
                         Unit(value: 0.8, color: .systemBlue)]
        
    override func draw(_ rect: CGRect) {
        
        var lastAngle: CGFloat = 0
        
        units.forEach { unit in
            
            let path = UIBezierPath()
            let endAngle: CGFloat = lastAngle + CGFloat(unit.value * 2 * Double.pi)
            let radius = frame.width / 3
            
            path.addArc(withCenter: CGPoint(x: frame.width / 2, y: frame.height / 2),
                        radius: radius,
                        startAngle: lastAngle,
                        endAngle: endAngle,
                        clockwise: true)
            
            path.lineWidth = radius / 3
            unit.color.setStroke()
            path.stroke()
            
            lastAngle = endAngle
        }
    }
    struct Unit {
        let value: Double
        let color: UIColor
    }
}

