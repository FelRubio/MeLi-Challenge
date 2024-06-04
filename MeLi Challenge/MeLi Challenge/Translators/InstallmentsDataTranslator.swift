//
//  InstallmentsDataTranslator.swift
//  MeLi Challenge
//
//  Created by Felipe on 28/05/24.
//

public struct InstallmentsDataTranslator {
    private init() { }
    
    public static func translate(from dto: InstallmentsDataDTO) -> InstallmentsData {
        .init(quantity: dto.quantity, amount: dto.amount, currencyId: dto.currencyId)
    }
}
