//
//  HeaderView.swift
//  Multitimer
//
//  Created by Danil Nurgaliev on 09.07.2021.
//

import UIKit
protocol HeaderViewDelegate: AnyObject {
    func showAlert()
    func fillCellWith(name: String, time: Int)
}

class HeaderView: UIView {
    weak var delegate: HeaderViewDelegate?

    private var pickerView = UIPickerView()

    let timerNameTF: UITextField = {
        let textField = UITextField()

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Название таймера"
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.font = .systemFont(ofSize: 13)
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing;
        textField.backgroundColor = .systemGray6

        return textField
    }()

    let timerTF: UITextField = {
        let textField = UITextField()

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Время таймера в секундах"
        textField.font = .systemFont(ofSize: 13)
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6

        return textField
    }()

    let addButton: UIButton = {
        let button = UIButton(type: .system)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Добавить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = .systemGray5
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 25

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        timerNameTF.delegate = self

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        self.addGestureRecognizer(tap)
        self.addSubview(timerNameTF)
        self.addSubview(timerTF)
        self.addSubview(addButton)
    }

    private func setupConstraints() {
        let layout = self.safeAreaLayoutGuide

        timerNameTF.topAnchor.constraint(equalTo: layout.topAnchor, constant: 20).isActive = true
        timerNameTF.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 20).isActive = true
        timerNameTF.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -20).isActive = true

        timerTF.topAnchor.constraint(equalTo: timerNameTF.bottomAnchor, constant: 20).isActive = true
        timerTF.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        timerTF.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 20).isActive = true
        timerTF.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -20).isActive = true

        addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -20).isActive = true
        addButton.leftAnchor.constraint(equalTo: layout.leftAnchor, constant: 20).isActive = true
        addButton.rightAnchor.constraint(equalTo: layout.rightAnchor, constant: -20).isActive = true
    }

    @objc private func addButtonTapped() {
        guard let timerName = timerNameTF.text, let timeString = timerTF.text, let time = Int(timeString) else {
            delegate?.showAlert()
            return 
        }
        delegate?.fillCellWith(name: timerName, time: time)

        timerNameTF.text = ""
        timerTF.text = ""

        self.endEditing(true)
    }

    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
}

extension HeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
