//
//  BCPickerDate.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/5/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//


import UIKit

public class CSDatePicker {
    // MARK:- Attributes
    fileprivate var datePicker: UIDatePicker!
    fileprivate var toolBar: UIToolbar!
    fileprivate var bgView: UIView!
    var delegate: CSDatePickerDelegate? = nil
    var tag = 0
    
    
    // MARK:- Methods
    func showWith(minDate: Date?,
                  maxDate: Date?,
                  andDefaultDate: Date?,
                  withDateMode: UIDatePicker.Mode?,
                  andLocale: Locale?) {
        
        let window: UIWindow = UIApplication.shared.delegate!.window!!
        let screenSize = UIScreen.main.bounds.size
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.destroyPicker))
        bgView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        bgView.backgroundColor = CSColor.black
        bgView.alpha = 0.0
        bgView.addGestureRecognizer(tapGesture)
        let pickerFrame = CGRect(x: 0,
                                 y: screenSize.height,
                                 width: screenSize.width,
                                 height: Keys.pickerHeight)
        datePicker = UIDatePicker(frame: pickerFrame)
        datePicker.timeZone = TimeZone(abbreviation: "UTC")
        datePicker.backgroundColor = CSColor.white
        datePicker.datePickerMode = .date
        
        if let dateMode = withDateMode {
            datePicker.datePickerMode = dateMode
        }
        if let locale = andLocale {
            datePicker.locale = locale
        }
        if minDate != nil {
            datePicker.minimumDate = minDate
        } else {
            datePicker.minimumDate = Date.newDate(fromYear: 1917, month: 01, day: 01)
        }
        if maxDate != nil {
            datePicker.maximumDate = maxDate
        }
        if let defaultDate = andDefaultDate,
            let minD = minDate,
            let maxD = maxDate,
            minD <= defaultDate,
            defaultDate <= maxD {
            datePicker.setDate(defaultDate, animated: true)
        }
        
        let btnAcept = UIBarButtonItem(title:"   " + CSString.ok,
                                       style: .plain,
                                       target: self,
                                       action: #selector(self.selectItem))
        let toolbarFrame = CGRect(x: 0,
                                  y: screenSize.height,
                                  width: screenSize.width,
                                  height: Keys.toolbarHeight)
        toolBar = UIToolbar(frame: toolbarFrame)
        toolBar.tintColor = CSColor.primaryColor
        toolBar.setItems([btnAcept], animated: true)
        
        window.addSubview(bgView)
        window.addSubview(toolBar)
        window.addSubview(datePicker)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.bgView.alpha = 0.5
            self.toolBar.frame.origin.y = screenSize.height - (Keys.toolbarHeight + Keys.pickerHeight)
            self.datePicker.frame.origin.y = screenSize.height - Keys.pickerHeight
        })
    }
    
    @objc func selectItem(){
        delegate?.onDateSelected(date: datePicker.date, pickerDate: self)
        destroyPicker()
    }
    
    @objc func destroyPicker(){
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
            self.bgView.alpha = 0
        }, completion: {(finished) in
            self.bgView = nil
        })
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
            let screenSize = UIScreen.main.bounds.size
            self.datePicker.frame.origin.y = screenSize.height
            self.toolBar.frame.origin.y = screenSize.height
        }, completion: {[weak self] finished in
            self?.datePicker = nil
            self?.toolBar = nil
        })
    }
    
    
    // MARK:- Keys
    public struct Keys {
        static let pickerHeight = CGFloat(150)
        static let toolbarHeight = CGFloat(40)
    }
}

protocol CSDatePickerDelegate {
    func onDateSelected(date: Date, pickerDate: CSDatePicker)
}
