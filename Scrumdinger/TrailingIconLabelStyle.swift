//
//  TrailingIconLabelStyle.swift
//  Scrumdinger (iOS)
//
//  Created by Guest User on 11/10/2022.
//

import Foundation
import SwiftUI

struct TrailingIconLabelStyle: LabelStyle{
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle{
    static var trailingIcon: Self { Self() }
}
