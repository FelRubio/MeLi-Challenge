//
//  DescriptionDTO.swift
//  MeLi Challenge
//
//  Created by Felipe on 29/05/24.
//

public struct DescriptionDTO: Decodable {
    public let text: String
    
    public enum CodingKeys: String, CodingKey {
        case text = "plain_text"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decode(String.self, forKey: .text)
    }
}
