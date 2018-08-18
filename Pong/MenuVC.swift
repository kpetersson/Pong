//
//  MenuVC.swift
//  Pong
//
//  Created by Karl Petersson on 2018-08-18.
//  Copyright © 2018 Karl Petersson. All rights reserved.
//

import Foundation
import UIKit

enum gameMode {
    case onePlayer
    case twoPlayer
}

class MenuVC: UIViewController {
    @IBAction func OnePlayerMode(_ sender: Any) {
        moveToGame(gameMode: .onePlayer)
    }
    
    @IBAction func TwoPlayerMode(_ sender: Any) {
        moveToGame(gameMode: .twoPlayer)
    }
    
    func moveToGame(gameMode: gameMode)  {
        let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        currentGameMode = gameMode //learn pass values
        self.navigationController?.pushViewController(gameVC, animated: true)
        
    }
}
