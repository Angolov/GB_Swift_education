import PlaygroundSupport
import UIKit

// размеры прямоугольной области
let sizeOfArea = CGSize(width: 400, height: 400)

// создание экземпляра
var area = SquareArea(size: sizeOfArea, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))

area.setBalls(withColors: [#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)], andRadius: 30)

// установка экземпляра в качестве текущего отображения
PlaygroundPage.current.liveView = area
