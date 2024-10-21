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
    }


}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return solarSystemPlanets.count
    }
    
    // 셀이 표시되기 직전에 호출
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlanetCollectionViewCell
        let target = solarSystemPlanets[indexPath.item]
        cell.planetImageView.image = UIImage(named: "\(target.englishName.lowercased())-icon")
        cell.planetNameLabel.text = target.englishName
        return cell
    }
    
    
}
