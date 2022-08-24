// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let empServices = try? newJSONDecoder().decode(EmpServices.self, from: jsonData)

import Foundation

// MARK: - EmpServices
struct EmpServices: Codable {
    let api: String?
    let result: EmpServicesResult?
    let bodyString: EmpServicesBodyString?
    let tag: String?
}

// MARK: - BodyString
struct EmpServicesBodyString: Codable {
}

// MARK: - Result
struct EmpServicesResult: Codable {
    let type, address: String?
    let body: EmpServicesBody?
}

// MARK: - Body
struct EmpServicesBody: Codable {
    let list: [EmpServicesModel]?
    let count: Int?
}

// MARK: - List
struct EmpServicesModel: Codable {
    let method: Method?
    let level: Int?
    let appName: String?
    let linkMapYn: LinkMapYn?
    let url: String?
    let nameLang1: String?
    let apiURL: APIURL?
    let parameter: String?
    let width: Int?
    let companyCode: String?
    let id: Int?
    let iconURL: String?
    let parentApps: ParentApps?
    let apiType: APIType?
    let apps: String?
    let height: Int?

    enum CodingKeys: String, CodingKey {
        case method, level, appName
        case linkMapYn = "link_map_yn"
        case url, nameLang1
        case apiURL = "apiUrl"
        case parameter, width
        case companyCode = "company_code"
        case id
        case iconURL = "iconUrl"
        case parentApps = "parent_apps"
        case apiType, apps, height
    }
}

enum APIType: String, Codable {
    case p = "P"
    case w = "W"
}

enum APIURL: String, Codable {
    case websocketInsertDMChannel = "websocket.insertDMChannel"
}

enum LinkMapYn: String, Codable {
    case n = "N"
}

enum Method: String, Codable {
    case methodGET = "GET"
}

enum ParentApps: String, Codable {
    case employeeservices = "EMPLOYEESERVICES"
    case employeeservices1 = "EMPLOYEESERVICES1"
    case employeeservices11 = "EMPLOYEESERVICES11"
    case employeeservices12 = "EMPLOYEESERVICES12"
    case employeeservices2 = "EMPLOYEESERVICES2"
    case employeeservices3 = "EMPLOYEESERVICES3"
    case empty = ""
}
