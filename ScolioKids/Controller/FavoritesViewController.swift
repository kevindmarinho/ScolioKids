//
//  FavoritesViewController.swift
//  ScolioKids
//
//  Created by Anne Victoria Batista Auzier on 21/06/22.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController{
    
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "backgroundOficial")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favoritos"
        
        view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
    
            navigationController?.setNavigationBarHidden(true, animated: false)
        }

        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
    
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
}
