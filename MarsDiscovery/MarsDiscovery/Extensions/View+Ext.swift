//
//  View+Ext.swift
//  MarsDiscovery
//
//  Created by   Liza Kotova on 14.07.2024.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
