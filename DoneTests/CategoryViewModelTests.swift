import XCTest
@testable import Done

// swiftlint:disable trailing_whitespace
class CategoryViewModelTests: XCTestCase {
    
    let systemUnderTest = CategoryViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_default_number_of_rows_is_one() {
        let expectedNumberOfDefaultRows = 1
        XCTAssertEqual(systemUnderTest.defaultNumberOfRows, expectedNumberOfDefaultRows)
    }
    
    func test_default_number_of_rows_is_not_one() {
        let incorrectNumberOfDefaultRows = 2
        XCTAssertNotEqual(systemUnderTest.defaultNumberOfRows, incorrectNumberOfDefaultRows)
    }
    
    func test_default_background_color_is_white() {
        let expectedColor = "#FFFFFF"
        XCTAssertEqual(systemUnderTest.defaultBackgroundColor, expectedColor)
    }
    
    func test_default_background_color_is_not_white() {
        let incorrectBackgroundColor = "#00FFFF"
        XCTAssertNotEqual(systemUnderTest.defaultBackgroundColor, incorrectBackgroundColor)
    }
    
    /*
        TODO: - How to inject custom category amount for testing number of rows in section?
    */
    
//    func test_number_of_rows_in_section_is_three() {
//        let expectedNumberOfRowsInSection = 3
//        XCTAssertEqual(systemUnderTest.numberOfRowsInSection, expectedNumberOfRowsInSection)
//    }
//
//    func test_number_of_rows_in_section_is_not_three() {
//        let expectedNumberOfRowsInSection = 1
//        XCTAssertEqual(systemUnderTest.numberOfRowsInSection, expectedNumberOfRowsInSection)
//    }
    
    func test_screen_title_is_done() {
        let expectedScreenTitle = "Done"
        XCTAssertEqual(systemUnderTest.screenTitle, expectedScreenTitle)
    }
    
    func test_screen_title_is_not_done() {
        let incorrectScreenTitle = "incorrectTitle"
        XCTAssertNotEqual(systemUnderTest.screenTitle, incorrectScreenTitle)
    }
    
    func test_segue_identifier_is_goToItems() {
        let expectedSegueIdentifier = "goToItems"
        XCTAssertEqual(systemUnderTest.segueIdentifier, expectedSegueIdentifier)
    }
    
    func test_segue_identifier_is_not_goToItems() {
        let incorrectSegueIdentifier = "incorrectSegueIdentifier"
        XCTAssertNotEqual(systemUnderTest.segueIdentifier, incorrectSegueIdentifier)
    }
    
    func test_cell_text_color_is_label() {
        let expectedCellTextColor = UIColor.label
        XCTAssertEqual(systemUnderTest.cellTextColor, expectedCellTextColor)
    }
    
    func test_cell_text_color_is_not_label() {
        let incorrectCellTextColor = UIColor.darkText
        XCTAssertNotEqual(systemUnderTest.cellTextColor, incorrectCellTextColor)
    }
    
    func test_random_background_color_is_random() {
        let expectedRandomBackgroundColor = UIColor().hexStringFromColor(color: UIColor().generateRandomColor())
        XCTAssertNotEqual(systemUnderTest.randomBackgroundColor, expectedRandomBackgroundColor)
    }
    
    func test_setup_table_view_cell_is_correct() {
        let cell = systemUnderTest.setupTableViewCell(in: UITableView(),
                                                      with: UITableViewCell(),
                                                      at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.textLabel?.text, nil)
        XCTAssertEqual(cell.textLabel?.textColor, UIColor.label)
    }
    
    func test_setup_table_view_cell_is_incorrect() {
        let cell = systemUnderTest.setupTableViewCell(in: UITableView(),
                                                      with: UITableViewCell(),
                                                      at: IndexPath(row: 0, section: 0))
        XCTAssertNotEqual(cell.textLabel?.text, "testText")
        XCTAssertNotEqual(cell.textLabel?.textColor, UIColor.secondaryLabel)
    }

}
