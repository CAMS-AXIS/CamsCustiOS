/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct MapsPinsData : Codable {
	let aTMID : Int?
	let aTMDescription : String?
	let locationID : Int?
	let address1 : String?
	let city : String?
	let stateCode : String?
	let postalCode : String?
	let latitude : String?
	let longitude : String?
	let aTMPhoto : String?
	let institutionAssignedID : String?

	enum CodingKeys: String, CodingKey {

		case aTMID = "ATMID"
		case aTMDescription = "ATMDescription"
		case locationID = "LocationID"
		case address1 = "Address1"
		case city = "City"
		case stateCode = "StateCode"
		case postalCode = "PostalCode"
		case latitude = "Latitude"
		case longitude = "Longitude"
		case aTMPhoto = "ATMPhoto"
		case institutionAssignedID = "InstitutionAssignedID"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		aTMID = try values.decodeIfPresent(Int.self, forKey: .aTMID)
		aTMDescription = try values.decodeIfPresent(String.self, forKey: .aTMDescription)
		locationID = try values.decodeIfPresent(Int.self, forKey: .locationID)
		address1 = try values.decodeIfPresent(String.self, forKey: .address1)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		stateCode = try values.decodeIfPresent(String.self, forKey: .stateCode)
		postalCode = try values.decodeIfPresent(String.self, forKey: .postalCode)
		latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
		aTMPhoto = try values.decodeIfPresent(String.self, forKey: .aTMPhoto)
		institutionAssignedID = try values.decodeIfPresent(String.self, forKey: .institutionAssignedID)
	}

}
