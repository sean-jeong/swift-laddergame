//
//  main.swift
//  LadderGame
//
//  Created by JK on 09/10/2017.
//  Copyright © 2017 Codesquad Inc. All rights reserved.
//

import Foundation

typealias Settings = (userNumber: Int?, ladderHeight: Int?)

/// 사다리 부품 타입 정의
enum LadderPart: Character {
    case rung = "|"
    case bar = "-"
    case empty = " "
    
    init(_ isEmpty: Bool) {
        self = isEmpty ? .empty : .bar
    }
}

/// 게임 실행에 필요한 유저 숫자와 사다리 높이를 설정합니다.
/// - returns: 유저 숫자와 사다리 높이를 포함한 튜플
func setupGame() -> Settings {
    let userNumber = setUserNumber()
    let ladderHeight = setLadderHeight()
    
    return (userNumber, ladderHeight)
}

/// 게임을 시작합니다.
/// - parameter settings: 유저 숫자와 사다리 높이를 포함한 게임 실행에 필요한 설정
/// - returns: bool 타입 배열을 갖는 2차원 배열
func startGame(_ settings: Settings) -> [[Bool]]? {
    guard let userNumber = settings.userNumber,
        let ladderHeight = settings.ladderHeight else { return nil }
    let result = buildLadder(width: userNumber, height: ladderHeight)
    
    return result
}

/// 게임의 결과인 사다리를 출력합니다.
/// - parameter settings: bool 타입 배열
func endGame(_ result: [[Bool]]) {
    let ladder = getLadder(result)

    print(ladder)
}

/// 유저수를 설정합니다.
/// - returns: 둘 중 하나:
///     - 유저 숫자 정수형
///     - 입력을 정수형으로 형변환 실패시 Nil
func setUserNumber() -> Int? {
    print("참여할 사람은 몇 명 인가요?")
    guard let input = readLine() else { return nil }
    
    return Int(input)
}

/// 사다리의 높이를 설정합니다.
/// - returns: 둘 중 하나:
///     - 사다리 높이 정수형
///     - 입력을 정수형으로 형변환 실패시 Nil
func setLadderHeight() -> Int? {
    print("최대 사다리 높이는 몇 개인가요?")
    guard let input = readLine() else { return nil }
    
    return Int(input)
}

/// 사다리를 구성합니다.
/// - parameters:
///     - width: 사다리의 가로 길이 정수형
///     - height: 사다리의 세로 길이 정수형
/// - returns: bool 타입 배열을 갖는 2차원 배열
func buildLadder(width: Int, height: Int) -> [[Bool]] {
    return Array(0..<height).map { _ in createLadderLayer(width - 1) }
}

/// 사다리 층을 생성합니다.
/// - parameter width: 사다리의 가로 길이인 정수
/// - returns: bool 타입을 갖는 배열
func createLadderLayer(_ length: Int) -> [Bool] {
    var _isLadderPartEmpty: Bool = false
    var isLadderPartEmpty: Bool {
        _isLadderPartEmpty = _isLadderPartEmpty ? Bool.random() : true
        return _isLadderPartEmpty
    }
    
    return Array(1..<length).map { _ in isLadderPartEmpty }
}

/// 사다리를 출력합니다.
/// - parameter matrix: bool 타입 배열을 갖는 2차원 배열
func getLadder(_ layers: [[Bool]]) -> String {
    let ladder = layers.map { getLayer($0) }.joined(separator: "\n")
    
    return ladder
}

/// 사다리 층을 나타내는 문자열을 가져옵니다.
/// - parameter parts: bool 타입 배열
/// - returns: 사다리 층을 나타내는 문자열
func getLayer(_ parts: [Bool]) -> String {
    let rung = LadderPart.rung.rawValue.description
    let joined = parts.map { LadderPart($0).rawValue.description }.joined(separator: rung)
    let layer = "\(rung)\(joined)\(rung)"
    
    return layer
}

// 게임 실행
let settings = setupGame()
if let result = startGame(settings) {
    endGame(result)
}
