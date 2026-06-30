import AppKit

let size = 1024
let s = CGFloat(size)
let image = NSImage(size: NSSize(width: size, height: size))
image.lockFocus()

let rect = NSRect(x: 0, y: 0, width: s, height: s)
let bgPath = NSBezierPath(roundedRect: rect, xRadius: s * 0.22, yRadius: s * 0.22)
bgPath.addClip()

let bgGradient = NSGradient(colors: [
    NSColor(calibratedRed: 1.0, green: 0.93, blue: 0.88, alpha: 1.0),
    NSColor(calibratedRed: 0.85, green: 0.95, blue: 0.88, alpha: 1.0)
])
bgGradient?.draw(in: rect, angle: -45)

func ellipse(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) -> NSBezierPath {
    NSBezierPath(ovalIn: NSRect(x: x - w / 2, y: y - h / 2, width: w, height: h))
}

func fillEllipse(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat, _ color: NSColor) {
    color.setFill()
    ellipse(x, y, w, h).fill()
}

// All animal drawing functions are written in LOCAL coordinates where
// (0, 0) is the animal's ground center. A transform is pushed before
// calling them to place + scale + rotate each animal on the canvas.

func drawKoala() {
    let gray = NSColor(calibratedRed: 0.62, green: 0.63, blue: 0.66, alpha: 1.0)
    let grayDark = NSColor(calibratedRed: 0.5, green: 0.51, blue: 0.55, alpha: 1.0)
    let belly = NSColor(calibratedRed: 0.93, green: 0.93, blue: 0.93, alpha: 1.0)

    let bodyCy: CGFloat = 0.185
    let headCy: CGFloat = 0.38

    // legs
    fillEllipse(-0.05, 0.07, 0.10, 0.14, gray)
    fillEllipse(0.07, 0.07, 0.10, 0.14, gray)
    // raised arm (dancing)
    fillEllipse(-0.135, 0.305, 0.075, 0.16, gray)
    // other arm down
    fillEllipse(0.10, 0.145, 0.08, 0.13, gray)
    // body + belly
    fillEllipse(0, bodyCy, 0.225, 0.235, gray)
    fillEllipse(0, bodyCy - 0.02, 0.13, 0.155, belly)
    // ears (big fuzzy)
    fillEllipse(-0.105, headCy + 0.085, 0.135, 0.135, grayDark)
    fillEllipse(0.105, headCy + 0.085, 0.135, 0.135, grayDark)
    fillEllipse(-0.105, headCy + 0.085, 0.075, 0.075, NSColor(calibratedWhite: 0.97, alpha: 1.0))
    fillEllipse(0.105, headCy + 0.085, 0.075, 0.075, NSColor(calibratedWhite: 0.97, alpha: 1.0))
    // head
    fillEllipse(0, headCy, 0.165, 0.155, gray)
    // eyes
    fillEllipse(-0.04, headCy + 0.01, 0.02, 0.026, NSColor.black)
    fillEllipse(0.04, headCy + 0.01, 0.02, 0.026, NSColor.black)
    // nose
    fillEllipse(0, headCy - 0.035, 0.075, 0.05, NSColor(calibratedRed: 0.22, green: 0.2, blue: 0.2, alpha: 1.0))
}

func drawRabbitWithTree() {
    let white = NSColor(calibratedWhite: 0.99, alpha: 1.0)
    let shade = NSColor(calibratedWhite: 0.90, alpha: 1.0)
    let pink = NSColor(calibratedRed: 1.0, green: 0.78, blue: 0.82, alpha: 1.0)

    let bodyCy: CGFloat = 0.18
    let headCy: CGFloat = 0.38

    // legs
    fillEllipse(-0.065, 0.07, 0.095, 0.135, white)
    fillEllipse(0.06, 0.07, 0.095, 0.135, white)
    // raised arm (dancing)
    fillEllipse(0.135, 0.305, 0.07, 0.155, white)

    // christmas tree, held in front by the other arm
    let treeCx: CGFloat = -0.155
    let treeBaseY: CGFloat = 0.045
    NSColor(calibratedRed: 0.55, green: 0.38, blue: 0.22, alpha: 1.0).setFill()
    NSBezierPath(rect: NSRect(x: treeCx - 0.018, y: treeBaseY, width: 0.036, height: 0.05)).fill()
    let treeGreen = NSColor(calibratedRed: 0.42, green: 0.56, blue: 0.4, alpha: 1.0)
    func tier(_ cy: CGFloat, _ w: CGFloat, _ h: CGFloat) {
        let tri = NSBezierPath()
        tri.move(to: NSPoint(x: treeCx, y: cy + h))
        tri.line(to: NSPoint(x: treeCx - w / 2, y: cy))
        tri.line(to: NSPoint(x: treeCx + w / 2, y: cy))
        tri.close()
        treeGreen.setFill()
        tri.fill()
    }
    tier(treeBaseY + 0.045, 0.16, 0.075)
    tier(treeBaseY + 0.095, 0.125, 0.07)
    tier(treeBaseY + 0.14, 0.09, 0.065)
    // gold star
    let starCy = treeBaseY + 0.215
    let star = NSBezierPath()
    let starOuter: CGFloat = 0.032
    let starInner: CGFloat = 0.013
    for i in 0..<10 {
        let angle = CGFloat(i) * .pi / 5 - .pi / 2
        let r = i % 2 == 0 ? starOuter : starInner
        let p = NSPoint(x: treeCx + r * cos(angle), y: starCy + r * sin(angle))
        if i == 0 { star.move(to: p) } else { star.line(to: p) }
    }
    star.close()
    NSColor(calibratedRed: 0.93, green: 0.73, blue: 0.25, alpha: 1.0).setFill()
    star.fill()

    // body + front hugging arm (drawn after tree so it overlaps the trunk)
    fillEllipse(0, bodyCy, 0.205, 0.225, white)
    fillEllipse(0, bodyCy - 0.015, 0.115, 0.14, shade)
    fillEllipse(-0.085, 0.145, 0.075, 0.12, white)

    // ears: one up, one folded (jellycat style)
    NSGraphicsContext.saveGraphicsState()
    let earUpT = NSAffineTransform()
    earUpT.translateX(by: -0.045, yBy: headCy + 0.12)
    earUpT.rotate(byDegrees: -12)
    earUpT.translateX(by: 0.045, yBy: -(headCy + 0.12))
    earUpT.concat()
    let earUp = NSBezierPath(roundedRect: NSRect(x: -0.045 - 0.04, y: headCy + 0.02, width: 0.08, height: 0.2), xRadius: 0.04, yRadius: 0.04)
    white.setFill(); earUp.fill()
    let earUpInner = NSBezierPath(roundedRect: NSRect(x: -0.045 - 0.02, y: headCy + 0.05, width: 0.04, height: 0.13), xRadius: 0.02, yRadius: 0.02)
    pink.setFill(); earUpInner.fill()
    NSGraphicsContext.restoreGraphicsState()

    NSGraphicsContext.saveGraphicsState()
    let earFoldT = NSAffineTransform()
    earFoldT.translateX(by: 0.075, yBy: headCy + 0.1)
    earFoldT.rotate(byDegrees: 55)
    earFoldT.translateX(by: -0.075, yBy: -(headCy + 0.1))
    earFoldT.concat()
    let earFold = NSBezierPath(roundedRect: NSRect(x: 0.075 - 0.038, y: headCy + 0.02, width: 0.076, height: 0.165), xRadius: 0.038, yRadius: 0.038)
    white.setFill(); earFold.fill()
    let earFoldInner = NSBezierPath(roundedRect: NSRect(x: 0.075 - 0.02, y: headCy + 0.045, width: 0.04, height: 0.105), xRadius: 0.02, yRadius: 0.02)
    pink.setFill(); earFoldInner.fill()
    NSGraphicsContext.restoreGraphicsState()

    // head
    fillEllipse(0, headCy, 0.165, 0.155, white)
    fillEllipse(-0.04, headCy + 0.01, 0.018, 0.024, NSColor.black)
    fillEllipse(0.04, headCy + 0.01, 0.018, 0.024, NSColor.black)
    fillEllipse(0, headCy - 0.025, 0.022, 0.016, pink)
}

// ===== Ground shadow =====
NSColor.black.withAlphaComponent(0.07).setFill()
ellipse(s * 0.5, s * 0.105, s * 0.62, s * 0.055).fill()

// ===== KOALA: full size, standing left of center =====
NSGraphicsContext.saveGraphicsState()
let koalaT = NSAffineTransform()
koalaT.translateX(by: s * 0.4, yBy: s * 0.12)
koalaT.rotate(byDegrees: -6)
koalaT.scaleX(by: s, yBy: s)
koalaT.concat()
drawKoala()
NSGraphicsContext.restoreGraphicsState()

// ===== RABBIT + TREE: half the koala's size, standing to the right =====
NSGraphicsContext.saveGraphicsState()
let rabbitT = NSAffineTransform()
rabbitT.translateX(by: s * 0.73, yBy: s * 0.12)
rabbitT.rotate(byDegrees: 6)
rabbitT.scaleX(by: s * 0.5, yBy: s * 0.5)
rabbitT.concat()
drawRabbitWithTree()
NSGraphicsContext.restoreGraphicsState()

image.unlockFocus()

guard let tiff = image.tiffRepresentation,
      let bitmap = NSBitmapImageRep(data: tiff),
      let png = bitmap.representation(using: .png, properties: [:]) else {
    fatalError("Could not generate PNG")
}

let outputPath = CommandLine.arguments[1]
try! png.write(to: URL(fileURLWithPath: outputPath))
print("Wrote \(outputPath)")
