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
    NSBezierPath(ovalIn: NSRect(x: x - w/2, y: y - h/2, width: w, height: h))
}

func fillEllipse(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat, _ color: NSColor) {
    color.setFill()
    ellipse(x, y, w, h).fill()
}

// ===== Ground shadow =====
NSColor.black.withAlphaComponent(0.07).setFill()
ellipse(s * 0.5, s * 0.155, s * 0.62, s * 0.07).fill()

// ===== KOALA (left, dancing - leaning right with raised arm) =====
let koalaGray = NSColor(calibratedRed: 0.62, green: 0.63, blue: 0.66, alpha: 1.0)
let koalaGrayDark = NSColor(calibratedRed: 0.5, green: 0.51, blue: 0.55, alpha: 1.0)
let koalaBelly = NSColor(calibratedRed: 0.93, green: 0.93, blue: 0.93, alpha: 1.0)

NSGraphicsContext.saveGraphicsState()
let koalaTransform = NSAffineTransform()
koalaTransform.translateX(by: s * 0.34, yBy: s * 0.40)
koalaTransform.rotate(byDegrees: -8)
koalaTransform.translateX(by: -s * 0.34, yBy: -s * 0.40)
koalaTransform.concat()

let koalaCx = s * 0.34
let koalaBodyCy = s * 0.34
// legs
fillEllipse(koalaCx - s * 0.05, s * 0.165, s * 0.10, s * 0.14, koalaGray)
fillEllipse(koalaCx + s * 0.07, s * 0.165, s * 0.10, s * 0.14, koalaGray)
// raised arm (left arm up, dancing)
fillEllipse(koalaCx - s * 0.135, s * 0.46, s * 0.075, s * 0.16, koalaGray)
// other arm down, toward rabbit
fillEllipse(koalaCx + s * 0.10, s * 0.30, s * 0.08, s * 0.13, koalaGray)
// body
fillEllipse(koalaCx, koalaBodyCy, s * 0.225, s * 0.235, koalaGray)
// belly
fillEllipse(koalaCx, koalaBodyCy - s * 0.02, s * 0.13, s * 0.155, koalaBelly)
// head
let koalaHeadCy = s * 0.535
// ears (big fuzzy)
fillEllipse(koalaCx - s * 0.105, koalaHeadCy + s * 0.085, s * 0.135, s * 0.135, koalaGrayDark)
fillEllipse(koalaCx + s * 0.105, koalaHeadCy + s * 0.085, s * 0.135, s * 0.135, koalaGrayDark)
fillEllipse(koalaCx - s * 0.105, koalaHeadCy + s * 0.085, s * 0.075, s * 0.075, NSColor(calibratedWhite: 0.97, alpha: 1.0))
fillEllipse(koalaCx + s * 0.105, koalaHeadCy + s * 0.085, s * 0.075, s * 0.075, NSColor(calibratedWhite: 0.97, alpha: 1.0))
fillEllipse(koalaCx, koalaHeadCy, s * 0.165, s * 0.155, koalaGray)
// eyes
fillEllipse(koalaCx - s * 0.04, koalaHeadCy + s * 0.01, s * 0.02, s * 0.026, NSColor.black)
fillEllipse(koalaCx + s * 0.04, koalaHeadCy + s * 0.01, s * 0.02, s * 0.026, NSColor.black)
// big oval nose
fillEllipse(koalaCx, koalaHeadCy - s * 0.035, s * 0.075, s * 0.05, NSColor(calibratedRed: 0.22, green: 0.2, blue: 0.2, alpha: 1.0))

NSGraphicsContext.restoreGraphicsState()

// ===== RABBIT (right, white, holding christmas tree) =====
NSGraphicsContext.saveGraphicsState()
let rabbitTransform = NSAffineTransform()
rabbitTransform.translateX(by: s * 0.665, yBy: s * 0.40)
rabbitTransform.rotate(byDegrees: 7)
rabbitTransform.translateX(by: -s * 0.665, yBy: -s * 0.40)
rabbitTransform.concat()

let rabbitWhite = NSColor(calibratedWhite: 0.99, alpha: 1.0)
let rabbitShade = NSColor(calibratedWhite: 0.90, alpha: 1.0)
let rabbitPink = NSColor(calibratedRed: 1.0, green: 0.78, blue: 0.82, alpha: 1.0)

let rabbitCx = s * 0.665
let rabbitBodyCy = s * 0.335
// legs
fillEllipse(rabbitCx - s * 0.065, s * 0.165, s * 0.095, s * 0.135, rabbitWhite)
fillEllipse(rabbitCx + s * 0.06, s * 0.165, s * 0.095, s * 0.135, rabbitWhite)
// raised arm (dancing, right arm up)
fillEllipse(rabbitCx + s * 0.135, s * 0.46, s * 0.07, s * 0.155, rabbitWhite)
// body
fillEllipse(rabbitCx, rabbitBodyCy, s * 0.205, s * 0.225, rabbitWhite)
fillEllipse(rabbitCx, rabbitBodyCy - s * 0.015, s * 0.115, s * 0.14, rabbitShade)

// ===== Christmas tree held by rabbit's other arm (in front of body, left side) =====
let treeCx = rabbitCx - s * 0.155
let treeBaseY = s * 0.205
// trunk
let trunkRect = NSRect(x: treeCx - s * 0.018, y: treeBaseY, width: s * 0.036, height: s * 0.05)
NSColor(calibratedRed: 0.55, green: 0.38, blue: 0.22, alpha: 1.0).setFill()
NSBezierPath(rect: trunkRect).fill()
// tree tiers
let treeGreen = NSColor(calibratedRed: 0.42, green: 0.56, blue: 0.4, alpha: 1.0)
func triangleTier(_ cy: CGFloat, _ w: CGFloat, _ h: CGFloat) {
    let tri = NSBezierPath()
    tri.move(to: NSPoint(x: treeCx, y: cy + h))
    tri.line(to: NSPoint(x: treeCx - w/2, y: cy))
    tri.line(to: NSPoint(x: treeCx + w/2, y: cy))
    tri.close()
    treeGreen.setFill()
    tri.fill()
}
triangleTier(treeBaseY + s * 0.045, s * 0.16, s * 0.075)
triangleTier(treeBaseY + s * 0.095, s * 0.125, s * 0.07)
triangleTier(treeBaseY + s * 0.14, s * 0.09, s * 0.065)
// gold star
let starCy = treeBaseY + s * 0.215
let star = NSBezierPath()
let starPoints = 5
let starOuter = s * 0.032
let starInner = s * 0.013
for i in 0..<(starPoints * 2) {
    let angle = CGFloat(i) * .pi / CGFloat(starPoints) - .pi / 2
    let r = i % 2 == 0 ? starOuter : starInner
    let p = NSPoint(x: treeCx + r * cos(angle), y: starCy + r * sin(angle))
    if i == 0 { star.move(to: p) } else { star.line(to: p) }
}
star.close()
NSColor(calibratedRed: 0.93, green: 0.73, blue: 0.25, alpha: 1.0).setFill()
star.fill()

// front arm hugging tree (drawn after tree so it overlaps slightly)
fillEllipse(rabbitCx - s * 0.085, s * 0.30, s * 0.075, s * 0.12, rabbitWhite)

// head
let rabbitHeadCy = s * 0.535
// ears: one up, one folded down (like jellycat bunny)
NSGraphicsContext.saveGraphicsState()
let earUpTransform = NSAffineTransform()
earUpTransform.translateX(by: rabbitCx - s * 0.045, yBy: rabbitHeadCy + s * 0.12)
earUpTransform.rotate(byDegrees: -12)
earUpTransform.translateX(by: -(rabbitCx - s * 0.045), yBy: -(rabbitHeadCy + s * 0.12))
earUpTransform.concat()
let earUp = NSBezierPath(roundedRect: NSRect(x: rabbitCx - s * 0.045 - s * 0.04, y: rabbitHeadCy + s * 0.02, width: s * 0.08, height: s * 0.2), xRadius: s * 0.04, yRadius: s * 0.04)
rabbitWhite.setFill()
earUp.fill()
let earUpInner = NSBezierPath(roundedRect: NSRect(x: rabbitCx - s * 0.045 - s * 0.02, y: rabbitHeadCy + s * 0.05, width: s * 0.04, height: s * 0.13), xRadius: s * 0.02, yRadius: s * 0.02)
rabbitPink.setFill()
earUpInner.fill()
NSGraphicsContext.restoreGraphicsState()

NSGraphicsContext.saveGraphicsState()
let earFoldTransform = NSAffineTransform()
earFoldTransform.translateX(by: rabbitCx + s * 0.075, yBy: rabbitHeadCy + s * 0.1)
earFoldTransform.rotate(byDegrees: 55)
earFoldTransform.translateX(by: -(rabbitCx + s * 0.075), yBy: -(rabbitHeadCy + s * 0.1))
earFoldTransform.concat()
let earFold = NSBezierPath(roundedRect: NSRect(x: rabbitCx + s * 0.075 - s * 0.038, y: rabbitHeadCy + s * 0.02, width: s * 0.076, height: s * 0.165), xRadius: s * 0.038, yRadius: s * 0.038)
rabbitWhite.setFill()
earFold.fill()
let earFoldInner = NSBezierPath(roundedRect: NSRect(x: rabbitCx + s * 0.075 - s * 0.02, y: rabbitHeadCy + s * 0.045, width: s * 0.04, height: s * 0.105), xRadius: s * 0.02, yRadius: s * 0.02)
rabbitPink.setFill()
earFoldInner.fill()
NSGraphicsContext.restoreGraphicsState()

// head shape
fillEllipse(rabbitCx, rabbitHeadCy, s * 0.165, s * 0.155, rabbitWhite)
// eyes
fillEllipse(rabbitCx - s * 0.04, rabbitHeadCy + s * 0.01, s * 0.018, s * 0.024, NSColor.black)
fillEllipse(rabbitCx + s * 0.04, rabbitHeadCy + s * 0.01, s * 0.018, s * 0.024, NSColor.black)
// nose
fillEllipse(rabbitCx, rabbitHeadCy - s * 0.025, s * 0.022, s * 0.016, rabbitPink)

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
