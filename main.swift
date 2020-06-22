import Foundation

class TrieNode{
    var key: String?
    var isEndOfWord: Bool
    var children: Array<TrieNode>
    var level: Int

    init(){
      self.isEndOfWord = false
      self.children = Array<TrieNode>()
      self.level = 0
    }
}

class Trie{
  var root: TrieNode

  init(){
    self.root = TrieNode()
  }

  func insert(_ string: String){
      if string.length == 0{
        return
      }
      var current: TrieNode = root

      while string.length != current.level{
         var usableChild: TrieNode!
         let searchKey: String = string.substring(to: current.level + 1)

         for child in current.children{
            if child.key == searchKey{
              usableChild = child
              break;
            }
         }
         if usableChild == nil{
           usableChild = TrieNode()
           usableChild.key = searchKey
           usableChild.level = current.level + 1
           current.children.append(usableChild)
         }
         current = usableChild
      }

      if string.length == current.level{
        current.isEndOfWord = true
        return
      }
  }

  func find(_ string: String) -> Int{
    if string.length <= 0 {
      return 0 
    }
    var current: TrieNode = root

    while string.length > current.level{

      var usableChild: TrieNode!
      let searchKey: String = string.substring(to: current.level + 1)

      for child in current.children{
        if searchKey == child.key{
          usableChild = child
          current = usableChild
          break;
        }
      }

      if usableChild == nil{
        return 0
      }
    }

    if current.key == string && current.isEndOfWord{
      return 2
    }

    return 1
  }
}
