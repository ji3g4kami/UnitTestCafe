//
//  UnitTestCafeTests.swift
//  UnitTestCafeTests
//
//  Created by 吳登秝 on 2018/6/18.
//  Copyright © 2018年 DavidWu. All rights reserved.
//

import XCTest
@testable import UnitTestCafe

class UnitTestCafeTests: XCTestCase {
    
    var orderController: DVOrderViewController?
    
    override func setUp() {
        super.setUp()

        guard let orderController = UIStoryboard(name: "Order", bundle: nil).instantiateViewController(withIdentifier:String(describing: DVOrderViewController.self)) as? DVOrderViewController else {
            return
        }
        
        orderController.customizedItems = [
            CustomizedItem(name: "Tea", iced: true, sugar: false)
        ]
    }
    
    override func tearDown() {
        orderController = nil
        super.tearDown()
    }
    
    func testSegues() {
        orderController?.confirmButtonPressed(ConfirmCell())
        guard let receivedItems = orderController?.nextController?.customizedItems else { return }
        XCTAssertEqual(receivedItems[0].name, orderController?.customizedItems[0].name)
    }

    
}
