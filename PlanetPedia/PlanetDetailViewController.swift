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
    @IBOutlet weak var dimView: UIView!
    var initialOffsetY = CGFloat(0)
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
        detailCollectionView.delegate = self
        let img = UIImage(named: "\(planet.englishName.lowercased())")
        backgroundImageView.image = img
        setupLayout()
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 중요
        DispatchQueue.main.async {
            self.adjustContentInset() // 얘는 cell의 높이를 계산해야 해서 cell이 생성된 후에 호출되어야 하지. viewDidAppear에서 하면 어색함, viewDidAppear보다는 빨라야함
        }
        
    }
    
    func adjustContentInset() {
        let indexPath = IndexPath(item: 0, section: 0)
        if let first = detailCollectionView.cellForItem(at: indexPath) {
            let topInset = detailCollectionView.frame.height - first.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 20
            detailCollectionView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
            // cell을 원하는 위치로 이동
            detailCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
            initialOffsetY = detailCollectionView.contentOffset.y
        }
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
                
                // 위성 정보
            case 2:
                // item 크기 생성
                var size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
                // item 객체 생성
                let item = NSCollectionLayoutItem(layoutSize: size)
                size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .estimated(200))                
                // 그룹 생성
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
                // 섹션 생성
                let section = NSCollectionLayoutSection(group: group)
                // 섹션 여백
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                section.interGroupSpacing = 20
                // 스크롤 활성화
                section.orthogonalScrollingBehavior = .groupPaging
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
            switch indexPath.item {
            case 0:
                cell.titleImageView.image = UIImage(systemName: "ruler")
                cell.titleLabel.text = "크기"
                cell.valueLabel.text = planet.sizeString
                cell.unitLabel.text = "km"
            case 1:
                cell.titleImageView.image = UIImage(systemName: "arrow.circlepath")
                cell.titleLabel.text = "공전 주기"
                cell.valueLabel.text = planet.orbitalPeriodString
                cell.unitLabel.text = planet.orbitalPeriod > 365 ? "년" : "일"
            case 2:
                cell.titleImageView.image = UIImage(systemName: "airplane")
                cell.titleLabel.text = "지구와의 거리"
                cell.valueLabel.text = planet.distanceString
                cell.unitLabel.text = "km"
            default:
                break
            }
            
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

extension PlanetDetailViewController: UICollectionViewDelegate {
    // 스크롤 위치
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffest = scrollView.contentOffset.y
        let half = scrollView.bounds.height / 2
        
        if yOffest <= initialOffsetY {
            dimView.alpha = 0.0
        } else if yOffest <= -half {
            let progress = (initialOffsetY - yOffest) / (initialOffsetY + half)
            dimView.alpha = progress * 0.5
        } else {
            dimView.alpha = 0.5
        }
    }
    
}
