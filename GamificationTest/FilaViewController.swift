//
//  FilaViewController.swift
//  GamificationTest
//
//  Created by Caroline Viana on 28/08/20.
//  Copyright © 2020 Caroline Viana. All rights reserved.
//

import UIKit

class FilaViewController: UIViewController {

    @IBOutlet weak var progresso: UIProgressView!
    @IBOutlet weak var cupom: UILabel!
    @IBOutlet weak var instrução: UILabel!
    
    var timer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progresso.progress = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.progresso.progress += 0.01
            if self.progresso.progress == 1{
                self.done()
            }
        })
        
        timer.fire()
    }
    
    func done(){
        timer.invalidate()
        
        let cupons = ["CUPOMLEGAL", "ESSECUPOM", "OUTROCUPOM", "OLHAOCUPOM", "NAOECUPOM"]
        
        
        cupom.text = cupons.randomElement()
        instrução.text = "Anote seu cupom, e agora pode sair desta tela!\n\nSeu cupom:"
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
