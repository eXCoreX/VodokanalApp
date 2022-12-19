//
//  Color+Extension.swift
//  
//
//  Created by Litvinov Rostyslav on 16.12.2022.
//

import TokamakDOM

extension Color {
    init(rgb: UInt32) {
        let rgba = (rgb << 8) | 0xFF
        self.init(rgba: rgba)
    }

    init(rgba: UInt32) {
        let red = ((0xFF << 24) & rgba) >> 24
        let green = ((0xFF << 16) & rgba) >> 16
        let blue = ((0xFF << 8) & rgba) >> 8
        let alpha = ((0xFF) & rgba)

        self.init(red: Int(red), green: Int(green), blue: Int(blue), alpha: Int(alpha))
    }

    /// 0-255
    init(red: Int, green: Int, blue: Int, alpha: Int = 255) {
        [red, green, blue, alpha].forEach { assert((0...255).contains($0)) }
        
        self.init(red: Double(red) / 255, green: Double(green) / 255, blue: Double(blue) / 255, opacity: Double(alpha) / 255)
    }
}
