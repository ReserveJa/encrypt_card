import Adyen
import UIKit


public class SwiftEncryptCardPlugin: NSObject {


    private func encryptedCard(_ arguments: NSDictionary,completion: @escaping Completion<NSDictionary>) throws {
        let publicKeyToken = arguments["publicKeyToken"] as? String
        let cardNumber = arguments["cardNumber"] as? String
        let cardSecurityCode = arguments["cardSecurityCode"] as? String
        let cardExpiryMonth = arguments["cardExpiryMonth"] as? String
        let cardExpiryYear = arguments["cardExpiryYear"] as? String



        let card =  CardEncryptor.Card.init(number: cardNumber, securityCode: cardSecurityCode, expiryMonth: cardExpiryMonth, expiryYear: cardExpiryYear)
        let generationDateString = arguments["generationDate"] as? String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        let generationDate = dateFormatter.date(from: generationDateString!)

        let encrypCard = try CardEncryptor.encryptedCard(for:card, publicKey: publicKeyToken!)

        let dict = [
               "encryptedNumber":encrypCard.number,
               "encryptedSecurityCode":encrypCard.securityCode,
               "encryptedExpiryMonth":encrypCard.expiryMonth,
              "encryptedExpiryYear":encrypCard.expiryYear
                        ]
                        completion(dict as NSDictionary)


    }


}
