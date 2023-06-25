//
//  Double.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 24.06.2023.
//

import Foundation

extension Double {
    func toHhMmSs(style: DateComponentsFormatter.UnitsStyle) -> String {
        let dcf = DateComponentsFormatter()
        dcf.allowedUnits = [.hour, .minute, .second, .nanosecond]
        dcf.unitsStyle = style
        return dcf.string(from: self) ?? "0hr 0min 0sec"
    }
    func toInt() -> Int? {
        if self >= Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}
