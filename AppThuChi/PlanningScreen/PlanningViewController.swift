import UIKit

class PlanningViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let renderer1 = UIGraphicsImageRenderer(size: CGSize(width: 500, height: 500))
        let img1 = renderer1.image { ctx in
            ctx.cgContext.setStrokeColor(UIColor.white.cgColor)
            ctx.cgContext.setLineWidth(3)

            ctx.cgContext.move(to: CGPoint(x: 50, y: 450))
            ctx.cgContext.addLine(to: CGPoint(x: 250, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 450, y: 450))
            ctx.cgContext.addLine(to: CGPoint(x: 50, y: 450))

            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
    }

}
