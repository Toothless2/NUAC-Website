require "application_system_test_case"

class PageContentsTest < ApplicationSystemTestCase
  setup do
    @page_content = page_contents(:one)
  end

  test "visiting the index" do
    visit page_contents_url
    assert_selector "h1", text: "Page Contents"
  end

  test "creating a Page content" do
    visit page_contents_url
    click_on "New Page Content"

    click_on "Create Page content"

    assert_text "Page content was successfully created"
    click_on "Back"
  end

  test "updating a Page content" do
    visit page_contents_url
    click_on "Edit", match: :first

    click_on "Update Page content"

    assert_text "Page content was successfully updated"
    click_on "Back"
  end

  test "destroying a Page content" do
    visit page_contents_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Page content was successfully destroyed"
  end
end
