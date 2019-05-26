//
//  LabelProviding.swift
//  Transitions
//
//  Created by Nelson Gonzalez on 5/23/19.
//  Copyright © 2019 Spencer Curtis. All rights reserved.
//

import UIKit

//Anything can conform to this protocol as long as it has a label property
//Because The label is the only thing we care about to perform the transition.
protocol LabelProviding: UIViewController {
    var label: UILabel! { get }
}
