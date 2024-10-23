//
//  RoundedCollectionViewCell.swift
//  PlanetPedia
//
//  Created by 전율 on 10/24/24.
//

import UIKit

class RoundedCollectionViewCell: UICollectionViewCell {
    // 인스턴스 메소드 => 클래스 메소드 아님
    // 셀 초기화 중 한 번 호출하면 되는 것들 작성
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10
        self.contentView.subviews.first?.clipsToBounds = true // 경계를 벗어나는 부분을 클리핑
    }
    
}
