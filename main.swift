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

class charachterGrid{
  var charMatrix: [[String]]
  var visited: [[Bool]]
  var currentString: String
  var myTrie: Trie
  var width: Int
  var height: Int
  var resultList: [String]

  init(_ width: Int,_ height: Int,_ trie: Trie,_ matrix: [[String]]){
    self.width = width
    self.height = height
    self.charMatrix = matrix
    self.visited = Array(repeating: Array<Bool>(repeating: false, count: self.height),count: self.width)
    self.myTrie = trie
    self.currentString = ""
    self.resultList = [String]()
  }

  func search(_ row: Int,_ col: Int){
    let result: Int = myTrie.find(currentString)

    if result != 0{
      if result == 2 && !self.resultList.contains(currentString){
          resultList.append(currentString)
      }
      for r in (row-1)...(row+1){
        for c in (col-1)...(col+1){
          if r >= 0 && r < self.width && c >= 0 && c < self.height && visited[r][c] == false{
            visited[r][c] = true
            currentString.append(charMatrix[r][c])
            search(r, c)
            currentString.remove(at: currentString.index(before: currentString.endIndex))
            visited[r][c] = false
          }
        }
      }
    }
  }

  func traverseGrid(){
    for r in 0..<self.width{
      currentString = ""
      for c in 0..<self.height{
        visited[r][c] = true
        currentString.append(charMatrix[r][c])
        search(r, c)
        currentString.remove(at: currentString.index(before: currentString.endIndex))
        visited[r][c] = false
      }
    }
  }

}

var trie = Trie()

let words = readLine()!.components(separatedBy: " ")
let widthnHight = readLine()!.components(separatedBy: " ")
let x = Int(widthnHight[0])!
let y = Int(widthnHight[1])!

for word in words{
  trie.insert(word)
}

var matrix: [[String]] = Array(repeating: Array<String>(repeating: "",count: y), count: x)
for i in 0..<x{
  let row = readLine()!.components(separatedBy: " ")
  for j in 0..<y{
    matrix[i][j] = row[j]
  }
}

let charGrid = charachterGrid(x, y, trie, matrix)
charGrid.traverseGrid()
if !charGrid.resultList.isEmpty{
  for x in charGrid.resultList{
    print(x)
  }
}
