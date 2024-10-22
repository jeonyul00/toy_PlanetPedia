//
//  PlanetDetailViewController.swift
//  PlanetPedia
//
//  Created by 전율 on 10/22/24.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    
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
        let img = UIImage(named: "\(planet.englishName.lowercased())")
        backgroundImageView.image = img
    }
    
    
    
}
