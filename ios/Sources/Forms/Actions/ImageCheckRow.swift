//
//  ImageCheckRow.swift
//  ___PACKAGENAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//  ___COPYRIGHT___
//

import UIKit
import ContactsUI

import Eureka
import QMobileUI


// name of the format
fileprivate let kImageCheck = "imageCheck"

public final class ImageCheckRow: Row<ImageCheckCell>, FieldRowConformance, SelectableRowType, RowType {

    public var selectableValue: Bool?
    public var titlePercentage: CGFloat?
    public var placeholder: String?
    public var placeholderColor: UIColor?
    public var formatter: Formatter?
    public var useFormatterDuringInput: Bool = false
    public var useFormatterOnDidBeginEditing: Bool?

    required public init(tag: String?) {
        super.init(tag: tag)
        self.displayValueFor =  { _ in self.placeholder }
    }
}

public class ImageCheckCell : Cell<Bool>, CellType {

    required public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy public var trueImage: UIImage = {
        return UIImage(systemName: "checkmark.circle")!
        // return UIImage(systemName: "circle.dashed.inset.filled") ?? UIImage(systemName: "circle.dashed.inset.fill")!
    }()
    
    lazy public var falseImage: UIImage = {
        return UIImage(systemName: "circle.dashed")!
    }()
    
    public override func update() {
        super.update()
        accessoryType = .none
        if let value = row.value, value {
            imageView?.image = trueImage
        } else {
            imageView?.image = falseImage
        }
    }

    public override func didSelect() {
        if let value = row.value {
            row.value = !value
        } else {
            row.value = true
        }
        row.reload()
        row.select()
        row.deselect()
    }
    
}

@objc(ImageCheckRowService)
class ImageCheckRowService: NSObject, ApplicationService, ActionParameterCustomFormatRowBuilder {
    @objc static var instance: ImageCheckRowService = ImageCheckRowService()
    override init() {}
    func buildActionParameterCustomFormatRow(key: String, format: String, onRowEvent eventCallback: @escaping OnRowEventCallback) -> ActionParameterCustomFormatRowType? {
        if format == kImageCheck {
            return ImageCheckRow(key).onRowEvent(eventCallback)
        }
        return nil
    }
}
