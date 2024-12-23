//
//  ViewController.swift
//  FishBreadCounter
//
//  Created by Langpeu on 12/21/24.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, StoryboardView {
    
    typealias Reactor = FishBreadCountReactor
    var disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var fishCountLabel: UILabel!
    @IBOutlet weak var fishCountUpButton: UIButton!
    @IBOutlet weak var fishCountDownButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.reactor = FishBreadCountReactor()
        
        
    }

    func bind(reactor: FishBreadCountReactor) {
        
        //MARK: 리액터에게 보내는 액션
//        fishCountUpButton
//            .rx
//            .tap
//            .subscribe(onNext: { _ in
//                reactor.action.onNext(FishBreadCountReactor.Action.fishBreadCountUp(value: 1))
//            }).disposed(by: disposeBag)
//        
        fishCountUpButton
            .rx
            .tap
            .map{ FishBreadCountReactor.Action.fishBreadCountUp(value: 1) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        fishCountUpButton
            .rx
            .tap
            .map{ FishBreadCountReactor.Action.fishBreadCountDown(value: 1) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        //MARK: 리액터에서 받은 상태
        reactor
            .state
            .map(\.fishBreadResultCountInfo)
            .debug("state")
            .bind(to: self.fishCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        
    }

}

