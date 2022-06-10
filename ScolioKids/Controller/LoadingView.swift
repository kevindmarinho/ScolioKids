//
//  LoadingView.swift
//  ScolioKids
//
//  Created by kevin marinho on 10/06/22.
//

import Foundation
import UIKit

class LoadingView: UIViewController {
    
    private let imageViewInicio: UIImageView = {
        let imageViewInicio = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageViewInicio.image = UIImage(named: "justIcon")
        return imageViewInicio
    }()
    
    override func  viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageViewInicio)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageViewInicio.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
    }
    
    private func animate(){
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 2
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size
            
            self.imageViewInicio.frame = CGRect(
            x: -(diffX/2),
            y: diffY/2,
            width: size,
            height: size
            )
            //self.imageViewInicio.alpha = 0
        })
        
        UIView.animate(withDuration: 1.5, animations: {
            self.imageViewInicio.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute:{
                    let LoadingView = tabBarHome()
                    LoadingView.modalTransitionStyle = .crossDissolve
                    //LoadingView.modalPresentationStyle = .fullScreen
                    self.present(LoadingView, animated: true)
                })
            }
        })
        
    }
}
