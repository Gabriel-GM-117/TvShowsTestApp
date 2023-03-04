import Foundation
import UIKit

class LoginView: UIViewController {
    
    private let loginContentView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login")
        imageView.backgroundColor = .cyan
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        return button
    }()
    
    private let labelError: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 6)
        label.textColor = .red
        label.textAlignment = .center
        label.backgroundColor = UIColor(hexString: "#21242e")
        label.text = "Invalid user name and/or password"
        return label
    }()

    // MARK: Properties
    var presenter: LoginPresenterProtocol?
    var data: AuthToken?
    var requestAgain: Bool = false
    var showViewError: Bool = true

    
    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        self.presenter?.loadInfo()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginContentView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    private func setupLoginContentView() {
        view.addSubview(loginContentView)
        loginContentView.addSubview(userNameTextField)
        loginContentView.addSubview(passwordTextField)
        loginContentView.addSubview(loginButton)
        loginContentView.addSubview(labelError)
        loginButton.addTarget(self, action: #selector(nextFlow), for: .touchUpInside)
        loginContentView.translatesAutoresizingMaskIntoConstraints = false
        loginContentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        loginContentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        loginContentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loginContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupLabelError()
        
        labelError.isHidden = self.showViewError
    }
    
    @objc private func nextFlow() {
        Repository.userName = userNameTextField.text
        Repository.userPass = passwordTextField.text
        if self.requestAgain {
            self.presenter?.requestAgain()
        } else {
            self.presenter?.loadInfo()
        }
    }
}

extension LoginView {
    private func setupEmailTextField() {
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.backgroundColor = .white
        userNameTextField.frame.size.width = 200
        userNameTextField.frame.size.height = 20
        userNameTextField.topAnchor.constraint(equalTo: loginContentView.topAnchor,constant: 400).isActive = true
        userNameTextField.centerXAnchor.constraint(equalTo: loginContentView.centerXAnchor).isActive = true
        userNameTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        userNameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    private func setupPasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.backgroundColor = .white
        passwordTextField.frame.size.width = 200
        passwordTextField.frame.size.height = 20
        passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 40).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: loginContentView.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    private func setupLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = .white
        loginButton.frame.size.width = 100
        loginButton.frame.size.height = 30
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: loginContentView.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupLabelError() {
        labelError.translatesAutoresizingMaskIntoConstraints = false
        labelError.backgroundColor = self.view.backgroundColor
        labelError.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 40).isActive = true
        labelError.centerXAnchor.constraint(equalTo: loginContentView.centerXAnchor).isActive = true
        labelError.widthAnchor.constraint(equalToConstant: 200).isActive = true
        labelError.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

extension LoginView: LoginViewProtocol {
    
    // TODO: implement view output methods
    func showFailure(failure: Bool) {
        self.requestAgain = failure
    }
    
    func showViewError(failure: Bool) {
        DispatchQueue.main.async {
            self.labelError.isHidden = failure
        }
    }
}
