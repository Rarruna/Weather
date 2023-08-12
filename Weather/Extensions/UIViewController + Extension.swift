import UIKit

extension UIViewController {
    func createCustomNavigationBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    func createCustomTitleView(cityName: String) -> UIView {
        let width = view.frame.width
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: width, height: 130)

        let cityLabel = UILabel()
        cityLabel.text = cityName
        cityLabel.textAlignment = .center
        cityLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 20)
        cityLabel.font = .boldSystemFont(ofSize: 18)
        view.addSubview(cityLabel)
        cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        return view
    }
    
    func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate), for: .normal)
        let tintColor = UIColor(red: 0.561, green: 0.588, blue: 0.631, alpha: 1)
        button.tintColor = tintColor
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        let buttonBackgroundColor = UIColor(red: 0.953, green: 0.961, blue: 0.973, alpha: 1)
        button.backgroundColor = buttonBackgroundColor
        button.layer.cornerRadius = button.frame.height / 4
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}
