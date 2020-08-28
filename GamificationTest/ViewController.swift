//
//  ViewController.swift
//  GamificationTest
//
//  Created by Caroline Viana on 28/08/20.
//  Copyright © 2020 Caroline Viana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bntComida: UIButton!
    @IBOutlet weak var bntRoupas: UIButton!
    @IBOutlet weak var bntPerfumes: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bntComida.addTarget(self, action: #selector(botaoPressionado), for: .touchUpInside)
        bntRoupas.addTarget(self, action: #selector(botaoPressionado), for: .touchUpInside)
        bntPerfumes.addTarget(self, action: #selector(botaoPressionado), for: .touchUpInside)
    }
    
    @objc func botaoPressionado(){
        performSegue(withIdentifier: "paraFila", sender: self)
    }
    


}

