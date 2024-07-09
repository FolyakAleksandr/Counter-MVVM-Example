protocol CounterViewModel: AnyObject {
    func decrementCounter()
    func incrementCounter()

    var updateCounterLabel: ((String) -> Void)? { get set }
}

final class DefaultCounterViewModel: CounterViewModel {
    var updateCounterLabel: ((String) -> Void)?

    private var counter = 0 {
        didSet {
            updateCounterLabel?("\(counter)")
        }
    }

    func decrementCounter() {
        counter -= 1
        logicUpdateCounter()
    }

    func incrementCounter() {
        counter += 1
        logicUpdateCounter()
    }

    private func logicUpdateCounter() {
        switch counter {
        case -1:
            counter = 0
            updateCounterLabel?("Min 0")
        case 11:
            counter = 10
            updateCounterLabel?("Max 10. Limit")
        default:
            updateCounterLabel?("Counter  ->  \(counter)")
        }
    }
}
