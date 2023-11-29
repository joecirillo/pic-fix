//
//  SwipeContainerDelegate.swift
//  PicFix
//
//  Created by Christopher on 11/29/23.
//

import UIKit

protocol SwipeCardsDataSource {
    func numberOfCardsToShow() -> Int
    func card(at index: Int) -> SwipeCardView
    func emptyView() -> UIView?
}

protocol SwipeCardsDelegate {
    func swipeDidEnd(on view: SwipeCardView)
}
