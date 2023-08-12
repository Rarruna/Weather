import UIKit
import SnapKit
#if DEBUG
import SwiftUI
#endif

class SearchPopUpView: UIView {
    private var cancelAction: (() -> Void)?
    private var searchAction: ((String) -> ())?
    private var deleteAction: (() -> Void)?
    
    private let searchView = UIView()
    private let searchTextField = UITextField()
    private let magnifyingImage = UIImageView()
    private let deleteTextButton = UIButton()
    private let cancelButton = UIButton()
    private let searchButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        searchView.layer.cornerRadius = 24
        searchTextField.layer.cornerRadius = 12.5
        searchButton.layer.cornerRadius = 12
        cancelButton.layer.cornerRadius = 12
    }
    
    func setCancelButtonAction(_ action: @escaping () -> Void) {
        cancelAction = action
    }
    
    func setSearchButtonAction(_ action: @escaping ((String) -> ())) {
        searchAction = action
    }
    
    func setDeleteButtonAction(_ action: @escaping () -> Void) {
        deleteAction = action
    }
}

private extension SearchPopUpView {
    private func setupView() {
        addSubview(searchView)
        searchView.addSubview(searchTextField)
        searchTextField.addSubview(magnifyingImage)
        searchTextField.addSubview(deleteTextButton)
        searchView.addSubview(cancelButton)
        searchView.addSubview(searchButton)
        
        setupConstraints()
        setupSearchView()
        setupSearchTextField()
        setupMagnifyingImage()
        setupDeleteTextButton()
        setupCancelButton()
        setupSearchButton()
    }
    
    func setupConstraints() {
        searchView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(343)
            make.height.equalTo(180)
            make.left.right.equalToSuperview().inset(16)
        }

        searchTextField.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(searchView.snp.width).inset(16)
            make.left.top.equalToSuperview().inset(16)
        }

        magnifyingImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(12)
        }

        deleteTextButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(14)
        }

        cancelButton.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview().inset(16)
            make.width.equalTo(searchTextField.snp.width).multipliedBy(0.5).inset(4)
            make.right.equalToSuperview()
            make.height.equalTo(searchTextField.snp.height)
        }

        searchButton.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview().inset(16)
            make.width.equalTo(searchTextField.snp.width).multipliedBy(0.5).inset(4)
            make.left.equalTo(cancelButton.snp.right)
            make.height.equalTo(cancelButton.snp.height)
        }
    }
    
    func setupSearchView() {
        searchView.clipsToBounds = true
        searchView.contentMode = .scaleToFill
        searchView.backgroundColor = .white
    }
    
    func setupSearchTextField() {
        searchTextField.backgroundColor = .white
        searchTextField.placeholder = "Поиск города"
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.searchTextFieldGrayBorderColor.cgColor
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: frame.size.height))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = .always
        searchTextField.rightView = paddingView
        searchTextField.rightViewMode = .always
    }
    
    func setupMagnifyingImage() {
        magnifyingImage.image = UIImage(systemName: "magnifyingglass")
        magnifyingImage.clipsToBounds = true
        magnifyingImage.contentMode = .scaleToFill
        magnifyingImage.tintColor = .magnifyingImageColor
    }
    
    func setupDeleteTextButton() {
        deleteTextButton.translatesAutoresizingMaskIntoConstraints = false
        deleteTextButton.setImage(UIImage(systemName: "multiply"), for: .normal)
        deleteTextButton.contentMode = .scaleToFill
        deleteTextButton.tintColor = .deleteButtonColor
        deleteTextButton.addTarget(self, action: #selector(onDeleteButtonTap), for: .touchUpInside)
    }
    
    func setupCancelButton() {
        cancelButton.setTitle("Отменить", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.backgroundColor = .cancelButtonColor
        cancelButton.setTitleColor(.cancelButtonTitleColor, for: .normal)
        cancelButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        cancelButton.addTarget(self, action: #selector(onCancelButtonTap), for: .touchUpInside)
    }
    
    func setupSearchButton() {
        searchButton.setTitle("Найти", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.backgroundColor = .blueSearchButton
        searchButton.setTitleColor(.searchButtonColor, for: .normal)
        searchButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        searchButton.addTarget(self, action: #selector(onSearchButtonTap), for: .touchUpInside)
    }
}

//MARK: - Actions
private extension SearchPopUpView {
    @objc func onCancelButtonTap() {
        cancelAction?()
    }
    
    @objc func onSearchButtonTap() {
        searchAction?(searchTextField.text ?? "")
    }
    
    @objc func onDeleteButtonTap() {
        searchTextField.text?.removeAll()
        searchTextField.resignFirstResponder()
    }
}

#if DEBUG
struct SearchPopUpView_Preview: PreviewProvider {
    static var previews: some View {
        let view = SearchPopUpView()
        return Group {
            UIPreviewView(view)
                .previewLayout(.fixed(width: 343, height: 180))
        }
    }
}
#endif
