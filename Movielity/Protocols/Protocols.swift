//
//  Protocols.swift
//  Movielity
//
//  Created by 이윤지 on 10/9/24.
//

import UIKit

protocol ReusableIdentifier {
    static var identifier: String { get }
}

extension UIView: ReusableIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}


//사진 탭했을 때 미디어상세 화면으로 이동할 때 사용하시면 되는 프로토콜 입니다.
//protocol ResultItemViewControllerDelegate: AnyObject {
//    func ResultItemViewControllerDidTapItem(_ viewModel: MediaDetailViewModel)
//}
