//
//  GameScene.swift
//  GamificationTest
//
//  Created by Caroline Viana on 29/08/20.
//  Copyright © 2020 Caroline Viana. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let pallete = SKSpriteNode(imageNamed: "colorPick")
    var collum = 0
    var line = 0
    var text = true
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: init
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = .white
    }
    
    //MARK: CreatePallete
    func createPallete(){
        pallete.position = CGPoint(x: frame.midX, y: (frame.midY - frame.midY/3))
        pallete.name = "pallete"
        addChild(pallete)
    }
    
    //MARK: TouchBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let local = touch.location(in: self)
        
        if pallete.contains(local){
            quickSwap(local: local)
        }
    }
    
    //MARK: QuickSwap
    func quickSwap(local: CGPoint){
        if local.x < 80 {
            collum = 1
        }
        else if local.x < 140 {
            collum = 2
        }
        else if local.x < 200{
            collum = 3
        }
        else if local.x < 260{
            collum = 4
        }
        else if local.x < 320{
            collum = 5
        }
        else if local.x < 380{
            collum = 6
        }
        
        if local.y < 65 {
            line = 8
        }
        else if local.y < 125 {
            line = 7
        }
        else if local.y < 185{
            line = 6
        }
        else if local.y < 245{
            line = 5
        }
        else if local.y < 305{
            line = 4
        }
        else if local.y < 365{
            line = 3
        }
        else if local.y < 425{
            line = 2
        }
        else if local.y < 485{
            line = 1
        }
        
        let color = colors()
        let emiter = SKEmitterNode(fileNamed: "emitterClick")!
        emiter.position = local
        addChild(emiter)
        self.backgroundColor = color
        
    }
    
    //MARK: Colors
    func colors() -> UIColor{
        switch (line,collum) {
        case (1,1):
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case (1,2):
            return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        case (1,3):
            return #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        case (1,4):
            return #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        case (1,5):
            return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        case (1,6):
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case (2,1):
            return #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        case (2,2):
            return #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        case (2,3):
            return #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        case (2,4):
            return #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        case (2,5):
            return #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
        case (2,6):
            return #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
        case (3,1):
            return #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        case (3,2):
            return #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        case (3,3):
            return #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        case (3,4):
            return #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        case (3,5):
            return #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        case (3,6):
            return #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        case (4,1):
            return #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        case (4,2):
            return #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        case (4,3):
            return #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        case (4,4):
            return #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        case (4,5):
            return #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        case (4,6):
            return #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        case (5,1):
            return #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        case (5,2):
            return #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        case (5,3):
            return #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        case (5,4):
            return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case (5,5):
            return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        case (5,6):
            return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case (6,1):
            return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        case (6,2):
            return #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        case (6,3):
            return #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        case (6,4):
            return #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        case (6,5):
            return #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        case (6,6):
            return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case (7,1):
            return #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        case (7,2):
            return #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        case (7,3):
            return #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        case (7,4):
            return #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        case (7,5):
            return #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        case (7,6):
            return #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        case (8,1):
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case (8,2):
            return #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case (8,3):
            return #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        case (8,4):
            return #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        case (8,5):
            return #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        case (8,6):
            return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        default:
            return .white
        }
    }
    
    
}
