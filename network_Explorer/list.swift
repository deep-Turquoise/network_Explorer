//  list.swift

import Foundation

class tree
{
    private struct node {
        var path = String()
        var file_Name = String()
        var tab_Depth = Int()
        var bytes = UInt64()
        
        var parent: UnsafeMutablePointer<node>?
        var childern = [UnsafeMutablePointer<node>]()
    }
    private var root: UnsafeMutablePointer<node>?
    
    init() {
        root = nil
    }
    
    public func add_To_List(path: String, file_Name: String, tab_Depth: Int, bytes: UInt64) {
        var new_node = node()
        
        new_node.path = path
        new_node.file_Name = file_Name
        new_node.bytes = bytes
        new_node.tab_Depth = tab_Depth
        
        if root ==  nil {
            root = UnsafeMutablePointer<node>(&new_node)
        } else {
            
        }
    }
    
    public func traverse(cur: UnsafeMutablePointer<node>?)
    {
        
    }
}
