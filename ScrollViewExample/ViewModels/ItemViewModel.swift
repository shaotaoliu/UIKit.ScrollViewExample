import Foundation

class ItemViewModel {
    
    var items: [Item] = []
    
    private let pageSize: Int
    var loading = false
    
    init(_ pageSize: Int = 15) {
        self.pageSize = pageSize
    }

    func loadNextPage(completion: @escaping () -> Void) {
        loading = true
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
            var index = self.items.map {
                $0.id
            }.max() ?? 0
            
            for _ in 1...self.pageSize {
                index += 1
                self.items.append(Item(id: index))

                if self.items.count >= 100 {
                    break
                }
            }
            
            self.loading = false
            completion()
        })
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
