//
//  AssociatedObjects.swift
//  AssociatedObjects
//
//  Created by Jay on 2016-09-27.
//  Copyright © 2016 Jay Abbott. All rights reserved.
//

import Foundation

public protocol Associable: AnyObject {
	func associate<T: Hashable>(value: Any, withKey: T)
	func associatedValue<T: Hashable>(forKey: T) -> Any?
}

private class AssociatedObjects {

	private typealias AssociationDictionary = [AnyHashable:Any]
	private static var allAssociations = [WeakProxy:AssociationDictionary]()

	fileprivate static func getValue<T: Hashable>(forKey key: T, fromOwner owner: AnyObject) -> Any? {
		partialCleanUp()
		if let associations = allAssociations[WeakProxy(target: owner)] {
			return associations[key]
		}
		return nil
	}

	fileprivate static func set<T: Hashable>(value: Any, forKey key: T, onOwner owner: AnyObject) {
		partialCleanUp()
		let ownerKey = WeakProxy(target: owner)
		var associations = allAssociations[ownerKey]
		if(associations == nil) {
			associations = AssociationDictionary()
		}
		associations![key] = value
		allAssociations[ownerKey] = associations
	}

	private static var cleaningOffset = 0
	private static let maxChecks = 16
	private static func partialCleanUp() {
		for _ in 0 ..< maxChecks {
			if let checkIndex = allAssociations.index(allAssociations.startIndex,
			                                          offsetBy: cleaningOffset,
			                                          limitedBy: allAssociations.endIndex), checkIndex < allAssociations.endIndex {
				let key = allAssociations[checkIndex].key
				if key.target == nil {
					allAssociations[key] = nil
				} else {
					cleaningOffset += 1
				}
			} else {
				cleaningOffset = 0
				break
			}
		}
	}
}

extension Associable {
	public func associate<T: Hashable>(value: Any, withKey key: T) {
		AssociatedObjects.set(value: value, forKey: key, onOwner: self)
	}
	public func associatedValue<T: Hashable>(forKey key: T) -> Any? {
		return AssociatedObjects.getValue(forKey: key, fromOwner: self)
	}
}
