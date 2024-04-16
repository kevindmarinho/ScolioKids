//
//  ViewController.swift
//  ScolioKids
//
//  Created by kevin marinho on 29/05/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstButtonHome: UIButton!
    // botoes que levam para as telas de dicas
    @IBOutlet weak var secondButtonHome: UIButton!
    @IBOutlet weak var thirdButtonHome: UIButton!
    @IBOutlet weak var fourthButtonHome: UIButton!
    
    // Porque a imagem de background foi colocada em view code?
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "backgroundOficial")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Início"
        
        view.insertSubview(imageView, at: 0)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Poderia ser colocada no storyboard em RunTime Attributes
        firstButtonHome.layer.cornerRadius = 20
        firstButtonHome.layer.masksToBounds = true
        
        secondButtonHome.layer.cornerRadius = 20
        secondButtonHome.layer.masksToBounds = true
        
        thirdButtonHome.layer.cornerRadius = 20
        thirdButtonHome.layer.masksToBounds = true
        
        fourthButtonHome.layer.cornerRadius = 20
        fourthButtonHome.layer.masksToBounds = true
        
    }
    /// GENERICS?
    func animateButton(_ button: UIButton) {
        UIView.animate(withDuration: 0.3) {
            button.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                button.transform = CGAffineTransform.identity
            }
        }
    }
    
    @IBAction func onClickfirstButtonHome(_ sender: Any) {
        // Animação atrasada
        animateButton(firstButtonHome)
    }
    
    @IBAction func onClickSecondButtonHome(_ sender: Any) {
        animateButton(secondButtonHome)
    }
    
    @IBAction func onClickThirdButtonHome(_ sender: Any) {
        animateButton(thirdButtonHome)
    }
    
    @IBAction func onClickFourthButtonHome(_ sender: Any) {
       animateButton(fourthButtonHome)
    }
}

// Porque essa classe foi criada?
class tabBarHome : UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

