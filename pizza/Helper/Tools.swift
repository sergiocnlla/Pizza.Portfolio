//
//  Tools.swift
//  pizza
//
//  Created by Sergio Canella on 09/06/21.
//

import SwiftUI

func dataImage(image: Data) -> Image {
    if let image = UIImage(data: image) {
        return Image(uiImage: image)
    } else {
        return Image("bg")
    }
}

func GetImagem(url: String) throws -> Data
{
    do
    {
        if url != ""
        {
            let data = try? downloadImage(from: URL(string: url)!)
            if data != nil
            {
                return data!.pngData()!
            }
            else
            {
                throw APIErrors.internalServerError
            }
        }
        else
        {
            throw APIErrors.internalServerError
        }
    }
    catch _ as NSError
    {
        return Data()
    }
}

func downloadImage(from url: URL) throws -> UIImage?
{
    do
    {
        let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        if data != nil
        {
            return UIImage(data: data!)
        }
        else
        {
            throw APIErrors.internalServerError
        }
    }
    catch
    {
        throw APIErrors.internalServerError
        //return UIImage(named: "bg")
    }
}

enum APIErrors: Error {
    case notFound
    case swiftError
    case internalServerError
}

func formatNumber(number: Double) -> String? {
    let formater = NumberFormatter()
    formater.usesGroupingSeparator = true
    formater.numberStyle = .currency
    formater.locale = Locale(identifier: "pt_BR")
    return formater.string(from: NSNumber(value: number)) ?? "R$ 0,00"
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {

        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            // You can handle the failure here as you want
            return (0, 0, 0, 0)
        }

        return (r, g, b, o)
    }
}

public struct DarkModeViewModifier: ViewModifier {
@AppStorage("isDarkMode") var isDarkMode: Bool = true
public func body(content: Content) -> some View {
    content
        .environment(\.colorScheme, isDarkMode ? .dark : .light)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
