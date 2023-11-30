//
//  SwipeContainerManager.swift
//  PicFix
//
//  Created by Christopher on 11/29/23.
//
//  Swiping animation taken from
// https://exploringswift.com/blog/making-a-tinder-esque-card-swiping-interface-using-swift

import UIKit

extension PhotoSwipeViewController : SwipeCardsDataSource {
    func numberOfCardsToShow() -> Int {
        return cardViewData.count
    }

    func card(at index: Int) -> SwipeCardView {
        let card = SwipeCardView()
        card.dataSource = cardViewData[index]
        return card
    }

    func emptyView() -> UIView? {
        return nil
    }
}
