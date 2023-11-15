# `CMYKColor` for Swift

This small SPM that allows you to easily take a `String` or the CMYK color percent values and get a `Color` from it.

## Examples

### `CMYKColor` examples
```swift
let color = Color(cyan: 100, magenta: 50, yellow: 33, key: 25)
```

```swift
let color = Color(cmykString: "cmyk(100%, 50%, 33%, 25%)")
```
