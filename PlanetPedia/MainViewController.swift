//
//  ViewController.swift
//  PlanetPedia
//
//  Created by 전율 on 10/21/24.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var planetCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        planetCollectionView.dataSource = self
        planetCollectionView.delegate = self
        planetCollectionView.showsVerticalScrollIndicator = false
    }
    
    // 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell, let index = planetCollectionView.indexPath(for: cell) {
            let selected = solarSystemPlanets[index.item]
            if let vc = segue.destination as? PlanetDetailViewController {
                vc.planet = selected
            }
            
        }
    }

}
/*
 UICollectionViewDelegate: 셀과 사용자가 상호작용할 때 (셀을 선택하거나 스크롤 등) 어떤 동작을 할지 설정.
 UICollectionViewDelegateFlowLayout: 셀의 레이아웃, 즉 셀의 크기나 간격 등을 설정.
 */

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return solarSystemPlanets.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlanetCollectionViewCell
        let target = solarSystemPlanets[indexPath.item]
        cell.planetImageView.image = UIImage(named: "\(target.englishName.lowercased())-icon")
        cell.planetNameLabel.text = target.englishName
        return cell
    }
            
}

extension MainViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        
        let width = Int((collectionView.bounds.width - (flowLayout.minimumInteritemSpacing + flowLayout.sectionInset.left + flowLayout.sectionInset.right)) / 2)
        return CGSize(width: width, height: width)
    }
}

