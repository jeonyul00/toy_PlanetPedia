//
//  PlanetDetailViewController.swift
//  PlanetPedia
//
//  Created by 전율 on 10/22/24.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    var planet: Planet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let planet {
            let img = UIImage(named: "\(planet.englishName.lowercased())")
            backgroundImageView.image = img
        }

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
