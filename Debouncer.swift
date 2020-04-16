//
//  Debouncer.swift
//  Debouncer
//
//  Created by Pedro Vasconcelos on 16/04/2020.
//  Copyright © 2020 PMV Peter. All rights reserved.
//

import Foundation

class Debouncer {

    private var pendingWorkItem: DispatchWorkItem?

    func debounce(for timeInterval: TimeInterval, on queue: DispatchQueue = .main, block: @escaping () -> Void) {
        pendingWorkItem?.cancel()

        let workItem = DispatchWorkItem(block: block)
        pendingWorkItem = workItem

        let deadline = DispatchTime.now() + timeInterval

        queue.asyncAfter(deadline: deadline, execute: workItem)
    }

}
