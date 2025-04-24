//
//  MoonPhaseViewModel.swift
//  MoonPhaseView
//
//  Created by Oren Leavitt on 4/23/25.
//

import Foundation
import SceneKit

@MainActor
public final class MoonPhaseViewModel: ObservableObject {
    @Published public var percentVisible: Double = -100

    public init() {

    }
}
