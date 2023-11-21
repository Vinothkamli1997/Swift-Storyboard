## Customized Dropdown Item

```swift
//Line Number 414 
// Customized Dropdown item
cell!.textLabel!.text = "\(dataArray[indexPath.row])"

let pattern = "Best Price \\d+"

let text = "\(dataArray[indexPath.row])"
let attributedText = "\(dataArray[indexPath.row])"

if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
    let range = NSRange(text.startIndex..<text.endIndex, in: text)
    let matches = regex.matches(in: text, options: [], range: range)

    for match in matches {
        let matchRange = match.range

        if let range = Range(matchRange, in: text) {
            let price = String(text[range])
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: matchRange)

            cell!.textLabel!.numberOfLines = 0  // Allow multiple lines
            cell!.textLabel!.attributedText = attributedText

            // You can access the extracted price value here (e.g., "250")
            print("Extracted price:", price)
        }
    }
}
```

This code customizes a dropdown item by highlighting the price in red, assuming it follows the pattern "Best Price <price>". It uses `NSRegularExpression` to find matches and modifies the attributed text to apply the desired formatting. The extracted price value is also printed for further use.

