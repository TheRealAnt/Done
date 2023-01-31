import XCTest
@testable import Done

// swiftlint:disable trailing_whitespace
class LocalizableStringsTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_localizable_strings_are_correct() {
        var homeTitle: String { NSLocalizedString("homeTitle", comment: "") }
        XCTAssertEqual(homeTitle, "Home")
        var addNewCategoryTitle: String { NSLocalizedString("addNewCategoryTitle", comment: "") }
        XCTAssertEqual(addNewCategoryTitle, "Add a new category")
        var addTitle: String { NSLocalizedString("addTitle", comment: "") }
        XCTAssertEqual(addTitle, "Add")
        var cancelTitle: String { NSLocalizedString("cancelTitle", comment: "") }
        XCTAssertEqual(cancelTitle, "Cancel")
        var appearanceTitle: String { NSLocalizedString("appearanceTitle", comment: "") }
        XCTAssertEqual(appearanceTitle, "Appearance")
        var hapticFeedbackTitle: String { NSLocalizedString("hapticFeedbackTitle", comment: "") }
        XCTAssertEqual(hapticFeedbackTitle, "Haptic feedback")
        var autoTitle: String { NSLocalizedString("autoTitle", comment: "") }
        XCTAssertEqual(autoTitle, "Auto")
        var darkTitle: String { NSLocalizedString("darkTitle", comment: "") }
        XCTAssertEqual(darkTitle, "Dark")
        var lightTitle: String { NSLocalizedString("lightTitle", comment: "") }
        XCTAssertEqual(lightTitle, "Light")
    }
    
}
