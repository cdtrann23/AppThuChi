import Foundation

func getImgCategoryName(_ category: String) -> String {
    
    switch category {
    case "Lương":
        return "Luong"
    case "Thưởng":
        return "Thuong"
    case "Trợ cấp":
        return "Trocap"
    case "Lì xì":
        return "Lixi"
    case "Đầu tư":
        return "Dautu"
    case "Ăn uống":
        return "eating"
    case "Điện":
        return "electric"
    case "Nước":
        return "water"
    case "Nhà":
        return "home"
    case "Đi lại":
        return "gas"
    case "Khác":
        return "more"

    default:
        return "no-image"
    }
}
