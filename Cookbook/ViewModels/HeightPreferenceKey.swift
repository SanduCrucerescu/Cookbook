//
//  HeightPreferenceKey.swift
//  Cookbook
//
//  Created by Alex on 2022-08-22.
//

import SwiftUI

struct HeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
