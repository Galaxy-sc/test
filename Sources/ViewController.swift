import UIKit

class ViewController: UIViewController {
    private let resultLabel = UILabel()
    private let checkButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.font = .systemFont(ofSize: 22, weight: .medium)
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        resultLabel.text = "Tap the button to read secretValue()"

        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.setTitle("Check secretValue()", for: .normal)
        checkButton.addTarget(self, action: #selector(checkTapped), for: .touchUpInside)

        view.addSubview(resultLabel)
        view.addSubview(checkButton)

        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            resultLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 24),
            resultLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -24),

            checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 24)
        ])
    }

    @objc private func checkTapped() {
        let value = TestHookTarget.secretValue()
        resultLabel.text = "secretValue() = \(value)"
    }
}
