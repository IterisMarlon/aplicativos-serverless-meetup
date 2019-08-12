//
//  ViewController.swift
//  Memeria
//
//  Created by Marlon Morato on 31/07/19.
//  Copyright © 2019 Marlon Morato. All rights reserved.
//

import UIKit
import Kingfisher
import Moya
import RxSwift
import RxCocoa


class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var refreshButton: UIButton!
    
    let api = MoyaProvider<MemeApi>()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bind()
        refreshImage()
    }
    
    func bind() {
        refreshButton.rx.tap.bind {
            self.refreshImage()
        }.disposed(by: disposeBag)
    }
    
    func refreshImage() {
        api.rx.request(MemeApi.getMeme).map(Meme.self).do(onSuccess: { (result) in
            self.imageView.kf.setImage(with: URL(string: result.memeUrl)!)
        }).subscribe().disposed(by: disposeBag)
    }
}

