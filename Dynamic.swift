//
//  Dynamic.swift
//  PipedriveTask
//
//  Created by Maryam Alimohammadi on 8/18/18.
//  Copyright © 2018 Maryam Alimohammadi. All rights reserved.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener : Listener?
    
    var value: T {
        didSet{
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
    func bind(listener: Listener?){
        self.listener = listener
    }
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
}
