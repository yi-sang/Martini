//
//  FlavorPreferenceViewController.swift
//  Martini
//
//  Created by RONICK on 2021/08/25.
//

import UIKit

class FlavorPreferenceViewController: UIViewController {
    
    @IBOutlet var flavorPreferenceCollectionView: UICollectionView!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var btnPrev: UIButton!
    
    let identifier = "flavorPreferenceCollectionViewCell"
    let spacingRow = 15

    override func viewDidLoad() {
        super.viewDidLoad()

        flavorPreferenceCollectionView.dataSource = self
        flavorPreferenceCollectionView.delegate = self
        flavorPreferenceCollectionView.register(FlavorPreferenceCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        
        btnPrev.layer.cornerRadius = 6
        btnPrev.titleLabel?.text = "이전"
        btnPrev.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        btnNext.layer.cornerRadius = 6
        btnNext.titleLabel?.text = "다음"
        btnNext.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
    }
    
    @IBAction func btnPrevView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextView(_ sender: UIButton) {
        print(PreferenceDataStore.ingredients)
        
        let storyboard: UIStoryboard? = UIStoryboard(name: "IngredientsSelectionView", bundle: Bundle.main)
        
        guard let uvc = storyboard?.instantiateViewController(identifier: "ingredientsSelection") else { return }
        
        self.navigationController?.pushViewController(uvc, animated: true)
    }
}

extension FlavorPreferenceViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(spacingRow)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // 열은 하나이기 때문에 간격을 주지 않음
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 한 화면에 최대 6개의 셀만 세로로 보이기
        let width = flavorPreferenceCollectionView.bounds.width
        let height = flavorPreferenceCollectionView.bounds.height / 6 - CGFloat(spacingRow)
        
        return CGSize(width: width, height: height)
    }
}

extension FlavorPreferenceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Cocktail.Taste.TasteType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = flavorPreferenceCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FlavorPreferenceCollectionViewCell
        
        // 각 맛의 서브 타이틀로 셀 만들기
        if let taste = Cocktail.Taste.TasteType.init(rawValue: indexPath.row) {
            let subtitle = taste.type.subtitle
            
            cell.configure(subtitle: subtitle, taste: taste)
        }
        
        return cell
    }
}
