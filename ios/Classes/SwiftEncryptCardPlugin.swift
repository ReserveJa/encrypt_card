import Flutter
import UIKit
import Adyen

public class SwiftEncryptCardPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "encrypt_flutter", binaryMessenger: registrar.messenger())
        let instance = SwiftEncryptCardPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    private func encryptedCard(_ arguments: NSDictionary,completion: @escaping Completion<NSDictionary>) throws {
        let publicKeyToken = arguments["publicKeyToken"] as? String
        let cardNumber = arguments["cardNumber"] as? String
        let cardSecurityCode = arguments["cardSecurityCode"] as? String
        let cardExpiryMonth = arguments["cardExpiryMonth"] as? String
        let cardExpiryYear = arguments["cardExpiryYear"] as? String
        let card = CardEncryptor.Card.init(number: cardNumber, securityCode: cardSecurityCode, expiryMonth: cardExpiryMonth, expiryYear: cardExpiryYear)
        let generationDateString = arguments["generationDate"] as? String
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        let generationDate = dateFormatter.date(from: generationDateString!)

        let encryptedCard = try CardEncryptor.encryptedCard(for: card, publicKey: publicKeyToken!)

        let dict = [
            "encryptedNumber":encryptedCard.number,
            "encryptedSecurityCode":encryptedCard.securityCode,
            "encryptedExpiryMonth":encryptedCard.expiryMonth,
            "encryptedExpiryYear":encryptedCard.expiryYear
        ]
        completion(dict as NSDictionary)

    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) throws {
            let arguments = call.arguments as? NSDictionary
            switch (call.method) {
            case "encryptedCard":
               try encryptedCard(arguments!) { (encryptedCard) in
                    result(encryptedCard)
                }
            default:
                result(FlutterMethodNotImplemented)

            }
        }
}