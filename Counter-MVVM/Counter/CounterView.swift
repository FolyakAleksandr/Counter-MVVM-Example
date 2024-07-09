import UIKit

final class DefaultCounterView: UIViewController {
    // MARK: - Private properties

    private let counterLabel = UILabel()
    private let stackButtons = UIStackView()
    private let decrementButton = UIButton()
    private let incrementButton = UIButton()

    // MARK: - Private variables

    var viewModel: CounterViewModel?

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private methods

    private func setupUI() {
        setupBackground()

        layoutCounterLabel()
        layoutStackButtons()

        configureCounterLabel()
        configureStackButtons()
        configureDecrementButton()
        configureIncrementButton()

        configureBindings()
    }

    private func layoutCounterLabel() {
        view.addSubview(counterLabel)
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        counterLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }

    private func layoutStackButtons() {
        view.addSubview(stackButtons)
        stackButtons.translatesAutoresizingMaskIntoConstraints = false

        stackButtons.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
        stackButtons.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackButtons.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }

    private func configureCounterLabel() {
        counterLabel.font = .systemFont(ofSize: 25, weight: .light)
        counterLabel.textColor = .black
        counterLabel.textAlignment = .center
        counterLabel.text = "Counter  ->  0"
    }

    private func configureStackButtons() {
        [decrementButton, incrementButton].forEach { stackButtons.addArrangedSubview($0) }
        stackButtons.axis = .horizontal
        stackButtons.distribution = .fillEqually
        stackButtons.alignment = .fill
        stackButtons.spacing = 12
    }

    private func configureDecrementButton() {
        decrementButton.configureButton()
        decrementButton.setTitle("Decrement ↓", for: .normal)
        decrementButton.backgroundColor = .systemRed
        decrementButton.addTarget(self, action: #selector(decrementButtonTapped), for: .touchUpInside)
    }

    private func configureIncrementButton() {
        incrementButton.configureButton()
        incrementButton.setTitle("Increment ↑", for: .normal)
        incrementButton.backgroundColor = .systemGreen
        incrementButton.addTarget(self, action: #selector(incrementButtonTapped), for: .touchUpInside)
    }

    private func configureBindings() {
        viewModel?.updateCounterLabel = { [weak self] text in
            guard let self = self else { return }
            counterLabel.text = text
        }
    }

    @objc private func decrementButtonTapped() {
        viewModel?.decrementCounter()
    }

    @objc private func incrementButtonTapped() {
        viewModel?.incrementCounter()
    }
}
