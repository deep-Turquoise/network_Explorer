//  main.swift

import Foundation

func outputToText(giv: String, file_Name: String) {
    do{
        try giv.write(toFile: file_Name + ".txt", atomically: true, encoding: String.Encoding.utf8 )
    } catch{
        print("Problem outputting to \(file_Name) at function outputToText")
    }
}

func build_Str(org: String, giv: String) -> String {
    let new_Str = org + giv + "/"
    return new_Str
}

func file_Size(cur_Long_Path: String) -> UInt64 {
    var fileSizeNumber = UInt64()
    // Remove the dash at the end of the path
    var path : String = cur_Long_Path
    if(path.characters.last == "/") {path.remove(at: path.index(before: path.endIndex))}
    
    if let fileAttributes = try? FileManager.default.attributesOfItem(atPath: path) {
        fileSizeNumber = fileAttributes[FileAttributeKey.size] as! UInt64
    } else {
        print("no good - at function file_Size: common fix is to see if there is a dash at the end of the path")
    }
    
    return fileSizeNumber
}

func exploration(path: String, tab_Depth: Int, file: String, bytes: inout UInt64) -> String {
    var container = String()
    var temp = String()
    var bytes = UInt64()
    
    if(tab_Depth != 0) {for _ in 0 ... tab_Depth{container += "\t"}}
    container += file
    
    if let manager = try? FileManager.default.contentsOfDirectory(atPath: path) {
        for index in manager {
            // hitting a folder here
            temp = exploration(path: build_Str(org: path, giv: index), tab_Depth: tab_Depth+1, file: index, bytes: &bytes)
        }
    } else {
        bytes += file_Size(cur_Long_Path: path)
    }
    
    container += "\t(Bytes: \(bytes))"
    container += "\n"
    container += temp
    
    return container
}

func main() {
    var path: String = "/Volumes/"
    
    if let manager = try? FileManager.default.contentsOfDirectory(atPath: path) {
        for index in manager {
            var bytes2: UInt64 = 0
            
            if index != "Apple SSD" {
                print("Started looking at: \(index)")
                outputToText(giv: exploration(path: build_Str(org: path, giv: index), tab_Depth: 0, file: index + "/", bytes: &bytes2), file_Name: index)
                print("Completed looking at: \(index) \n")
            }
        }
    } else {
    }
}

main()
