//
//  FishBreadCountReactor.swift
//  FishBreadCounter
//
//  Created by Langpeu on 12/21/24.
//

import Foundation
import ReactorKit

// 붕어빵 아저씨
class FishBreadCountReactor: Reactor {
    
    init() {
        
    }
    
    // 붕어빵 아저씨한테 주문, 요청, 액션, 입력
    // represent user actions
    enum Action {
        case fishBreadCountUp(value: Int)
        case fishBreadCountDown(value: Int)
    }
    
    // 붕어빵 아저씨가 일을 한다 - 연산 , 주문이 들어와서 요리를 한다, 결과물을 만든다.
    // represent state changes
    // mutate - change
    // 상태를 변경 - 즉 결과물을 만든다.
    enum Mutation {
        case doFishBreadCountCalculate(resultCount: Int)
    }
    
    // 연산이 끝난 최종 결과물 - 데이터
    // represents the current view state
    struct State {
        var fishBreadResultCount: Int = 0
        var fishBreadResultCountInfo: String  {
            get {
                return  "붕어빵 갯수: \(fishBreadResultCount)"
            }
        }
    }
    
    let initialState: State = State()
    
    // 입력 -> 연산
    // mutate - change: state 를 changing
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fishBreadCountUp(let value):
            var currentFishBreadCount = self.currentState.fishBreadResultCount
            currentFishBreadCount += value
            return .just(.doFishBreadCountCalculate(resultCount: currentFishBreadCount))
        case .fishBreadCountDown(let value):
            var currentFishBreadCount = self.currentState.fishBreadResultCount
            currentFishBreadCount -= value
            return .just(.doFishBreadCountCalculate(resultCount: currentFishBreadCount))
        }
    }
    
    // 요리에서 여러가지 조리된 것들을 플레이팅 하는 느낌.
    // 연산이 끝난 데이터를 -> State 에 넣어서 리턴하는 과정
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state // create a copy of the old state
        switch mutation {
        case .doFishBreadCountCalculate(let resultCount):
            state.fishBreadResultCount = resultCount
            return state
        }
    }
}
