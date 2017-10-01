#! /usr/bin/swift
import Glibc
import Foundation

let albert_op = ProcessInfo.processInfo.environment["ALBERT_OP"]

extension Dictionary where Key == String {
    func toPrettyJSON() throws -> String? {
        let jsonD = try JSONSerialization.data(withJSONObject: self,options: [.prettyPrinted])
        let jsonS = String(data: jsonD, encoding: String.Encoding.utf8)
        return jsonS 
    }   
}

if albert_op  == "METADATA" {
	let metadata : [String: Any] = [
        "iid": "org.albert.extension.external/v2.0",
        "name": "snippets",
        "version": "0.1",
        "author": "lf-araujo",
        "dependencies": [],
        "trigger": "snip "
    ]

   	let jsonData = try JSONSerialization.data(withJSONObject: metadata)
   	let JSONString = String(data: jsonData, encoding: String.Encoding.utf8)!
   	print(JSONString)

} else if albert_op == "QUERY"  {
 	let filemgr = FileManager.default
 	let filelist = try filemgr.contentsOfDirectory(atPath: ("~/.snippy" as NSString).expandingTildeInPath)

  func buildItem(name: String) -> [String:Any] {
    let action : [String: Any] = [
        "name": name
    ]
    return action
  }
    
  var items : [String: Any] = [:]
  items["items"] = filelist.map { buildItem(name: $0) }
   
  if let jsonStr = try? items.toPrettyJSON() {
      print(jsonStr!)
  }

}

exit(0)
