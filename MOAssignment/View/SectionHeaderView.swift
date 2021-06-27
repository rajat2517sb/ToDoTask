//
//  SectionHeaderView.swift
//  MOAssignment
//
//  Created by Rajat Babhulgaonkar on 27/06/21.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {

    private lazy var addButton : UIButton = {
        let addBtn = UIButton()
        addBtn.setBackgroundImage(UIImage(named: "add"), for: .normal)
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        return addBtn
    }()
    
    private lazy var sectionNameLbl : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    var addTask : ((Int) -> ())?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI(){
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(containerView)
        
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 5).isActive = true
        
        containerView.addSubview(addButton)
        addButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        addButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        
        containerView.addSubview(sectionNameLbl)
        sectionNameLbl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        sectionNameLbl.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -10).isActive = true
        sectionNameLbl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        sectionNameLbl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
    }
    
    func setData(data:String,tag:Int)  {
        sectionNameLbl.text = data
        addButton.tag       = tag
    }
    
    @objc func addAction(){
        if let add = self.addTask {
            switch addButton.tag {
            case 0:
                add(0)
            case 1:
                add(1)
            case 2:
                add(2)
            default:
                add(0)
            }
        }
    }
}
