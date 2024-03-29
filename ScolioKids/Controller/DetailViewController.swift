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
        "Aviãozinho" : [
            listaInst(textoCelula: "1. De pé, você deve abrir os braços como um avião.", imageCelula: "aviao2"),
            listaInst(textoCelula: "2. Eleve a pernas para trás e segure a posiçao mantendo o corpo equilibrado. \n \n3. Faça o mesmo processo com a outra perna.", imageCelula: "aviao1"),

               ],
        "Prancha Lateral" : [
            listaInst(textoCelula: "1. Comece deitando de lado.\n2. Apoie um cotovelo no chão, na mesma direção do seu ombro, eleve o quadril e deixe as pernas retas, apenas com os pés encostados no chão./n3. Eleve seus braços na linha do ombro e mantenha o abdômem para dentro.\n4. Repita o processo e segure a posição\n5. Alterne os lados.", imageCelula: "prancha1"),
            //listaInst(textoCelula: "3. Eleve seus braços na linha do ombro e mantenha o abdômem para dentro.\n4. Repita o processo e segure a posição\n5. Alterne os lados.", imageCelula: ""),

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
        return 380
    }
}
