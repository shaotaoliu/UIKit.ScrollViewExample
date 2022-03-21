import Foundation

class ItemViewModel {
    
    var items: [Item] = []
    
    private let pageSize: Int
    private var pageNum = 0
    
    init(_ pageSize: Int = 15) {
        self.pageSize = pageSize
        
        loadNextPage()
    }
    
    @discardableResult
    func loadNextPage() -> Int {
        if items.count >= 100 {
            return 0
        }
        
        var num = 0
        
        for i in 1...pageSize {
            items.append(Item(id: pageNum * pageSize + i))
            num += 1
            
            if items.count >= 100 {
                break
            }
        }
        
        pageNum += 1
        return num
    }
    
    func addRow() {
        let maxId = items.map({ item in item.id }).max() ?? 0
        items.append(Item(id: maxId + 1))
    }
    
    func removeRow() {
        if let maxId = items.map({ item in item.id }).max() {
            items.removeAll { $0.id == maxId }
        }
    }
    
    func print() {
        for item in items {
            Swift.print(item.description)
        }
    }
}

struct Item {
    let id: Int
    
    var description: String {
        "Item \(id)"
    }
}
