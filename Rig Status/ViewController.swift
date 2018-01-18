//
//  ViewController.swift
//  Rig Status
//
//  Created by Clean on 1/9/18.
//  Copyright © 2018 Beosoft. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var timer = Timer()
    
    @IBOutlet weak var gpu1: UILabel!
    @IBOutlet weak var gpu2: UILabel!
    @IBOutlet weak var gpu3: UILabel!
    @IBOutlet weak var gpu4: UILabel!
    @IBOutlet weak var gpu5: UILabel!
    @IBOutlet weak var gpu6: UILabel!
    @IBOutlet weak var gpu7: UILabel!
    @IBOutlet weak var gpu8: UILabel!
    
    @IBOutlet weak var gpu1Tmp: UILabel!
    @IBOutlet weak var gpu2Tmp: UILabel!
    @IBOutlet weak var gpu3Tmp: UILabel!
    @IBOutlet weak var gpu4Tmp: UILabel!
    @IBOutlet weak var gpu5Tmp: UILabel!
    @IBOutlet weak var gpu6Tmp: UILabel!
    @IBOutlet weak var gpu7Tmp: UILabel!
    @IBOutlet weak var gpu8Tmp: UILabel!
    
    @IBOutlet weak var ukupno: UILabel!
    @IBOutlet weak var prosecna: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        getJson()
        scheduledTimerWithTimeInterval()
       
    }


    
    func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.getJson), userInfo: nil, repeats: true)
    }
    
    
    let myUrl = "http://06e8f7.ethosdistro.com/?json=yes"
    
  
    
    @objc func getJson() {
        
        if let url = URL(string: myUrl) {
            
            do {
                
                let contents = try NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
                
                let convertedString = contents.mutableCopy() as! NSMutableString
                let jData = convertedString.data(using: String.Encoding.utf8.rawValue)
                
                
                do {
                    
                    guard let json = try JSONSerialization.jsonObject(with: jData!, options: []) as? [String:Any] else { return }
                    
                    guard let rigs = json["rigs"] as? [String:Any]  else { return }
                    guard let myRig = rigs["5f2d72"] as? [String:Any]  else { return }
                    guard let hashrate = myRig["miner_hashes"] as? String else { return }
                    guard let temp = myRig["temp"] as? String else { return }
                    
                    
                   
                    
                    print(temp)
                    print(hashrate)
                    
                    
                    var privBroj = ""
                    var nizBr = [String]()
                    
                    for i in hashrate + " " {
                        if i != " " {
                            privBroj += String(i)
                        } else {
                            nizBr.append(privBroj)
                            privBroj = ""
                        }
                    }
                    
                    
                    var privTemp = ""
                    var nizTemp = [String]()
                    
                    for i in temp + " " {
                        if i != " " {
                            privTemp += String(i)
                        } else {
                            nizTemp.append(privTemp)
                            privTemp = ""
                        }
                    }
                    
                    
                    var zbir : Float = 0
                    
                    
                    for i in 0...nizBr.count - 1 {
                        
                        if let br = Float(nizBr[i]) {
                            
                            zbir += br
                            
                                
                            switch i {
                                case 0:
                                    provera(broj: br, labela: gpu1)
                                case 1:
                                    provera(broj: br, labela: gpu2)
                                case 2:
                                    provera(broj: br, labela: gpu3)
                                case 3:
                                    provera(broj: br, labela: gpu4)
                                case 4:
                                    provera(broj: br, labela: gpu5)
                                case 5:
                                    provera(broj: br, labela: gpu6)
                                case 6:
                                    provera(broj: br, labela: gpu7)
                                case 7:
                                    provera(broj: br, labela: gpu8)
                                default:
                                    gpu1.backgroundColor = .lightGray
                            }
                            
                        }
                        
                        provera(broj: zbir, labela: ukupno)
                        
                    }
                    
                    
                    var prosek : Float = 0
                    
                    for i in nizTemp {
                        if let tmp = Float(i) {
                            prosek += tmp
                        }
                    }
                    
                    prosecna.text = String(prosek/8)
                    ukupno.text = String(zbir)
                    
                    gpu1.text = nizBr[0]
                    gpu2.text = nizBr[1]
                    gpu3.text = nizBr[2]
                    gpu4.text = nizBr[3]
                    gpu5.text = nizBr[4]
                    gpu6.text = nizBr[5]
                    gpu7.text = nizBr[6]
                    gpu8.text = nizBr[7]
                    
                    gpu1Tmp.text = nizTemp[0]
                    gpu2Tmp.text = nizTemp[1]
                    gpu3Tmp.text = nizTemp[2]
                    gpu4Tmp.text = nizTemp[3]
                    gpu5Tmp.text = nizTemp[4]
                    gpu6Tmp.text = nizTemp[5]
                    gpu7Tmp.text = nizTemp[6]
                    gpu8Tmp.text = nizTemp[7]
                   
                    
                }catch{
                    print("nije proslo")
                }
                
            } catch{
                print("nije proslo")
            }
            
        } else {
            print ( "Nije dobar url")
        }
        
        
    }

  
    func provera(broj: Float,labela: UILabel) {
        
        if broj == 0 {
            labela.backgroundColor = .red
        } else {
            labela.backgroundColor = .lightGray
        }
        
    }

}

