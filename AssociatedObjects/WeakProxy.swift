//
//  WeakProxy.swift
//  AssociatedObjects
//
//  Created by Jay on 2016-09-27.
//  Copyright © 2016 Jay Abbott. All rights reserved.
//

import Foundation

public struct WeakProxy: Hashable {

	private let originalHash: Int
	public weak var target: AnyObject?

	init(target: AnyObject) {
		self.originalHash = ObjectIdentifier(target).hashValue
		self.target = target
	}

	public var hashValue: Int {	get { return originalHash }}

	public static func ==(lhs: WeakProxy, rhs: WeakProxy) -> Bool { return lhs.target === rhs.target }
}
