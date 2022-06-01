//
//  ViewController.swift
//  ScolioKids
//
//  Created by kevin marinho on 29/05/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var secondButtonHome: UIButton!
    @IBOutlet weak var firstButtonHome: UIButton!
    @IBOutlet weak var thirdButtonHome: UIButton!
    @IBOutlet weak var fourthButtonHome: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
               firstButtonHome.layer.cornerRadius = 20
               firstButtonHome.layer.masksToBounds = true
               firstButtonHome.contentHorizontalAlignment = .left
               
               secondButtonHome.layer.cornerRadius = 20
               secondButtonHome.layer.masksToBounds = true
               secondButtonHome.contentHorizontalAlignment = .left
               
               thirdButtonHome.layer.cornerRadius = 20
               thirdButtonHome.layer.masksToBounds = true
               thirdButtonHome.contentHorizontalAlignment = .left
               
               fourthButtonHome.layer.cornerRadius = 20
               fourthButtonHome.layer.masksToBounds = true
               fourthButtonHome.contentHorizontalAlignment = .left
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @IBAction func onClickfirstButtonHome(_ sender: Any) {
                    UIView.animate(withDuration: 0.3,
                               animations: {
                    self.firstButtonHome.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                },
                               completion: {_ in
                    UIView.animate(withDuration: 0.3) {
                        self.firstButtonHome.transform = CGAffineTransform.identity
                    }
                })
    }
    
    @IBAction func onClickSecondButtonHome(_ sender: Any) {
        UIView.animate(withDuration: 0.3,
                   animations: {
        self.secondButtonHome.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    },
                   completion: {_ in
        UIView.animate(withDuration: 0.3) {
            self.secondButtonHome.transform = CGAffineTransform.identity
            }
        })
    }
    
    @IBAction func onClickThirdButtonHome(_ sender: Any) {
        UIView.animate(withDuration: 0.3,
                   animations: {
        self.thirdButtonHome.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    },
                   completion: {_ in
        UIView.animate(withDuration: 0.3) {
            self.thirdButtonHome.transform = CGAffineTransform.identity
            }
        })
    }
    
    @IBAction func onClickFourthButtonHome(_ sender: Any) {
        UIView.animate(withDuration: 0.3,
                   animations: {
        self.fourthButtonHome.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    },
                   completion: {_ in
        UIView.animate(withDuration: 0.3) {
            self.fourthButtonHome.transform = CGAffineTransform.identity
            }
        })
    }
}

