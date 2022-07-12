//
//  SSCustPointAnnotation.swift
//  CamsCust
//
//  Created by charanjit singh on 12/07/22.
//

import Foundation
import MapKit


class SSCustPointAnnotation: MKPointAnnotation {
     var selectedAtmIndex: Int = -1

     init(customVariable: Int) {
          self.selectedAtmIndex = customVariable
     }
}
