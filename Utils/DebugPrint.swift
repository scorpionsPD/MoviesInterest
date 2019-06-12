//
//  DebugPrint.swift
//  
//
//  Created by Pradeep Dahiya on 21.07.18.
//  Copyright © Pradeep Dahiya. All rights reserved.
//

import Foundation

func releasePrint(_ object: Any) {
    Swift.print(object)
}

func print(_ object: Any) {
    #if DEBUG
    Swift.print(object)
    #endif
}
