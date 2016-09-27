//
//  AssociatedObjectsTests.swift
//  AssociatedObjectsTests
//
//  Created by Jay on 2016-09-27.
//  Copyright © 2016 Jay Abbott. All rights reserved.
//

import XCTest
@testable import AssociatedObjects

class GenericTestClass {

}

extension GenericTestClass: Associable { }

class AssociatedObjectsTests: XCTestCase {

	func testBasicAssociation() {

		let commonTestKey = "test"

		// Get value before set
		let someInstance = GenericTestClass()
		let emptyValue = someInstance.associatedValue(forKey: commonTestKey)
		XCTAssertNil(emptyValue, "attempting to get an associated value before one is set should return nil")

		// Get values after setting on multiple instances of same type
		someInstance.associate(value: 2.5, withKey: commonTestKey)
		let anotherInstance = GenericTestClass()
		anotherInstance.associate(value: 3.5, withKey: commonTestKey)
		let someValue = someInstance.associatedValue(forKey: commonTestKey) as? Double
		let anotherValue = anotherInstance.associatedValue(forKey: commonTestKey) as? Double
		XCTAssertEqual(someValue, 2.5, "first associated value should be 2.5")
		XCTAssertEqual(anotherValue, 3.5, "second associated value should be 3.5")
	}

	func testAssociatedObjectsGoAwayWhenOwnerGoesAway() {

		let testKey = "test"
		var someInstance: GenericTestClass? = GenericTestClass()
		var associatedObject: GenericTestClass? = GenericTestClass()

		someInstance!.associate(value: associatedObject!, withKey: testKey)

		weak var disappearingObject: GenericTestClass? = associatedObject

		// Associated object should stick around
		associatedObject = nil
		XCTAssertNotNil(disappearingObject, "associated object should be referenced and still exist")

		// Associated object should disappear
		someInstance = nil
		// Call an association function to ensure clean-up gets a chance to run
		let tmp = GenericTestClass()
		_ = tmp.associatedValue(forKey: testKey)
		XCTAssertNil(disappearingObject, "associated object should have been de-referenced and gone away")
	}
}
