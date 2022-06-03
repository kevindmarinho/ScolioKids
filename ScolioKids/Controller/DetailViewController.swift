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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
