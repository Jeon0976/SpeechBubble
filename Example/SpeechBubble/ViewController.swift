//
//  ViewController.swift
//  SpeechBubble
//
//  Created by Jeon0976 on 04/29/2024.
//  Copyright (c) 2024 Jeon0976. All rights reserved.
//

import UIKit
import SpeechBubble

class ViewController: UIViewController {

    private lazy var inputField: UITextField = {
        let field = UITextField()
        
        field.addTarget(self, action: #selector(updateSpeechBubblesText(_:)), for: .editingChanged)
        field.placeholder = "Edit speech bubble text here."
        field.textColor = .label
        field.borderStyle = .roundedRect
        
        return field
    }()
    
    private lazy var speechBubbleView1 = SpeechBubbleView(
        text: "안녕",
        style: .fill,
        arrowPosition: .top,
        arrowPositionRatio: 0.3
    )

    private lazy var speechBubbleView2 = SpeechBubbleView(
        text: "test text",
        style: [.fill, .line],
        arrowPosition: .bottom
    )
    
    private lazy var speechBubbleView3 = SpeechBubbleView(
        text: "test text",
        style: .line,
        arrowPosition: .left
    )
    
    private lazy var speechBubbleView4 = SpeechBubbleView(
        text: "test text",
        style: .dottedLine,
        arrowPosition: .right
    )
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var speechBubbleView5 = SpeechBubbleView(
        text: "Text",
        textColor: .black,
        filledColor: .systemYellow,
        borderColor: .darkGray,
        borderWidth: 2,
        style: [.fill],
        arrowPosition: .top
    )
    
    private lazy var button1: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("Position", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.addTarget(self, action: #selector(updateSpeechBubblePosition(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var button2: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("style", for: .normal)
        btn.setTitleColor(.label, for: .normal)
        btn.addTarget(self, action: #selector(updateSpeechBubbleStyle(_:)), for: .touchUpInside)

        return btn
    }()
    
    private lazy var speechBubbleView6 = SpeechBubbleView(text: "test", style: .fill, arrowPosition: .bottom)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [
            speechBubbleView1,
            speechBubbleView2,
            speechBubbleView3,
            speechBubbleView4
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        [
            inputField,
            stackView,
            speechBubbleView5,
            button1,
            button2,
            speechBubbleView6
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            inputField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6),
            inputField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            inputField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: self.inputField.bottomAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 400),
            speechBubbleView5.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            speechBubbleView5.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            speechBubbleView5.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            button1.topAnchor.constraint(equalTo: speechBubbleView5.bottomAnchor, constant: 16),
            button1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            button2.topAnchor.constraint(equalTo: speechBubbleView5.bottomAnchor, constant: 16),
            button2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            speechBubbleView6.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            speechBubbleView6.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            speechBubbleView6.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateSpeechBubble6()
    }

    @objc private func updateSpeechBubblesText(_ sender: UITextField) {
        guard let text = sender.text else { return }
        
        speechBubbleView1.text = text
        speechBubbleView2.text = text
        speechBubbleView3.text = text
        speechBubbleView4.text = text
        speechBubbleView5.text = text
    }
    
    @objc private func updateSpeechBubblePosition(_ sender: UIButton) {
        guard let randomPosition = [SpeechBubbleArrowPosition.top, .bottom, .left, .right].randomElement() else { return }
        
        speechBubbleView5.arrowPosition = randomPosition
    }
    
    @objc private func updateSpeechBubbleStyle(_ sender: UIButton) {
        var styles: SpeechBubbleStyleOptions = []
        let allStyles: [SpeechBubbleStyleOptions] = [.fill, .line, .dottedLine]
        
        allStyles.forEach { style in
            if Bool.random() {
                styles.insert(style)
            }
        }
        
        styles = styles.isEmpty ? .fill : styles
                
        speechBubbleView5.style = styles
    }
    
    private func updateSpeechBubble6() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { [weak self] in
            guard let self = self else { return }
            
            self.speechBubbleView6.filledColor = .systemPink
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.speechBubbleView6.textInset = 6
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.speechBubbleView6.style = [.fill,.dottedLine]
                    self.speechBubbleView6.borderWidth = 5
                    self.speechBubbleView6.borderColor = .black
                    self.speechBubbleView6.textInset = 16
                    self.speechBubbleView6.arrowSize = 20
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.speechBubbleView6.arrowPositionRatio = 0.7
                        self.speechBubbleView6.arrowPosition = .top
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        setEditing(true, animated: true)
    }
}
