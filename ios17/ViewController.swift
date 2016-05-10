//
//  ViewController.swift
//  ios17
//
//  Created by EndoTakashi on 2016/05/08.
//  Copyright © 2016年 tak. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    var imageName: String = "IMGP1588.jpg"
    var FilterName:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //UIImageオブジェクト生成
        let image: UIImage = UIImage(named: imageName)!
        imageView.image = image
    }

    @IBAction func filter(sender: UIButton){
        //UIImageオブジェクト生成
        var image: UIImage = UIImage(named: imageName)!

        // 編集用データを生成
        var ciImage: CIImage = CIImage(CGImage: image.CGImage!)
        
        //let filter = CIFilter(name: "CIPhotoEffectTransfer")
        
        // フィルタをかける
        // モノクロームのフィルタを生成
        if sender.titleLabel!.text! == "モノクローム"{
            FilterName =  "CIColorMonochrome"
        }else{
            FilterName =  "CISepiaTone"
        }
        var filter: CIFilter = CIFilter(name: FilterName)!
        // フィルタをかける画像を指定
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        // 範囲を指定
        filter.setValue(1.0 , forKey:"inputIntensity")
        
        // 色は現在の割合で
        if sender.titleLabel!.text! == "モノクローム"{
            filter.setValue(CIColor(red: 0.7, green: 0.7, blue: 0.7), forKey: "inputColor")
        }
        
        // フィルタ処理のオブジェクト
        let filteredImage: CIImage = filter.outputImage!
        
        // CPUのみを利用するCIContextオブジェクトを生成
        // ソフトウェアレンダラを利用
        let ciContext: CIContext = CIContext(options:[kCIContextUseSoftwareRenderer: true])
        
        // レンダリングを行い、CGImageRefオブジェクトを生成
        let imageRef = ciContext.createCGImage(filteredImage, fromRect: filteredImage.extent)
        
        // CGImageRefオブジェクトから画像データを生成して表示
        let outputImage = UIImage(CGImage: imageRef, scale: 1.0, orientation: UIImageOrientation.Up)
        imageView.image = outputImage

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

