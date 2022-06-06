//  Created by Anne Victoria Batista Auzier on 05/06/22.

import Foundation
import UIKit

class ScolioScene: UIViewController{
    
    var imageView: UIImageView = {
        
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "backgroundOficial")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "O que é?"
        
        view.insertSubview(imageView, at: 0)
                    NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

class DicasScene: UIViewController{
    
    var imageView: UIImageView = {
        
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "backgroundOficial")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Dicas"
        
        view.insertSubview(imageView, at: 0)
                    NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
    }
}

class ColunaSaudavelScene: UIViewController{
    
    var imageView: UIImageView = {
        
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "backgroundOficial")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.insertSubview(imageView, at: 0)
                    NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        
    }
}


