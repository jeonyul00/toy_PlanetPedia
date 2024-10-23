//
//  PlanetDetailViewController.swift
//  PlanetPedia
//
//  Created by 전율 on 10/22/24.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    private let planet: Planet
    
    init?(planet: Planet, coder:NSCoder) {
        self.planet = planet
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        detailCollectionView.dataSource = self
        let img = UIImage(named: "\(planet.englishName.lowercased())")
        backgroundImageView.image = img
        setupLayout()
    }
    
    func setupLayout() {
        
        // 컴포지셔널 레이아웃 생성
        let layout = UICollectionViewCompositionalLayout {  sectionIndex, environment in
            switch sectionIndex {
            case 1:
                // item 크기 생성
                var size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(130))
                // item 객체 생성
                var item = NSCollectionLayoutItem(layoutSize: size)
                size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(130))
                // 그룹 생성
                var group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
                // 그룹 내 여백
                group.interItemSpacing = .flexible(20)
                size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(130))
                item = NSCollectionLayoutItem(layoutSize: size)
                
                group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [group,item])
                group.interItemSpacing = .fixed(20)
                
                // 섹션 생성
                let section = NSCollectionLayoutSection(group: group)
                // 섹션 여백
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                section.interGroupSpacing = 20
                return section
            default:
                // item 크기 생성
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
                // item 객체 생성
                let item = NSCollectionLayoutItem(layoutSize: size)
                // 그룹 생성
                let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
                // 섹션 생성
                let section = NSCollectionLayoutSection(group: group)
                // 섹션 여백
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                section.interGroupSpacing = 20
                return section
            }
        }
        // 컬렉션 뷰 레이아웃을 CompositionalLayout으로 변경
        detailCollectionView.collectionViewLayout = layout
    }
            
}

extension PlanetDetailViewController:UICollectionViewDataSource {
    
    // 섹션 개수 반환
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return planet.satellites.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PlanetSummaryCollectionViewCell.self), for: indexPath) as! PlanetSummaryCollectionViewCell
            cell.korNameLabel.text = planet.koreanName
            cell.engNameLabel.text = planet.englishName
            cell.descriptionLabel.text = planet.description
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PlanetInfoCollectionViewCell.self), for: indexPath) as! PlanetInfoCollectionViewCell
            cell.titleLabel.text = "distance"
            cell.valueLabel.text = "value"
            cell.unitLabel.text = "km"
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SatelliteCollectionViewCell.self), for: indexPath) as! SatelliteCollectionViewCell
            let target = planet.satellites[indexPath.item]
            cell.satelliteNameLabel.text = target.koreanName
            cell.satelliteSummaryLabel.text = target.summary
            return cell
        default:
            fatalError("check section count")
        }
    }
}
