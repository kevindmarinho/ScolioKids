//
//  DetailViewController.swift
//  ScolioKids
//
//  Created by Anne Victoria Batista Auzier on 01/06/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var InstructionView: UITableView!
    
    var nameTrainning: String = ""
    var dicEx: [String : [listaInst]] = [
        "Lombar" : [
            listaInst(textoCelula: "Passo 1: Você deve primeiro flexionar os braços", imageCelula: "outralombar"),
            listaInst(textoCelula: "Passo 2: Agora você deve estender as pernas", imageCelula: "outralombar2"),
        ],
        "Cervical" : [
            listaInst(textoCelula: "Passo 1: Agora você deve levantar a cabeça", imageCelula: "outracervical"),
            listaInst(textoCelula: "Passo 2: Agora você deve girar o tronco sla", imageCelula: "outracervical2")
        ],
    ]
    
    var imageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "backgroundOficial")
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Instruções"
        
        view.insertSubview(imageView, at: 0)
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])

    
        InstructionView.delegate = self
        InstructionView.dataSource = self
    }
}
extension DetailViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dicEx[nameTrainning]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newcell = InstructionView.dequeueReusableCell(withIdentifier: "newcell", for: indexPath) as! CustomNewCell
        
        if let arrayEx = dicEx[nameTrainning] {
            newcell.imageCell.image = UIImage(named: arrayEx[indexPath.row].imageCelula)
            newcell.textCell.text = arrayEx[indexPath.row].textoCelula
        }
        return newcell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
}
