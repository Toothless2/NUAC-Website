require "application_system_test_case"

class RecordsTest < ApplicationSystemTestCase
  setup do
    @record = records(:one)
  end

  test "visiting the index" do
    visit records_url
    assert_selector "h1", text: "Records"
  end

  test "creating a Record" do
    visit records_url
    click_on "New Record"

    fill_in "Achived at", with: @record.achived_at
    fill_in "Bowstyle", with: @record.bowstyle
    fill_in "Location", with: @record.location
    fill_in "Record name", with: @record.record_name_id
    fill_in "Round", with: @record.round
    fill_in "Score", with: @record.score
    click_on "Create Record"

    assert_text "Record was successfully created"
    click_on "Back"
  end

  test "updating a Record" do
    visit records_url
    click_on "Edit", match: :first

    fill_in "Achived at", with: @record.achived_at
    fill_in "Bowstyle", with: @record.bowstyle
    fill_in "Location", with: @record.location
    fill_in "Record name", with: @record.record_name_id
    fill_in "Round", with: @record.round
    fill_in "Score", with: @record.score
    click_on "Update Record"

    assert_text "Record was successfully updated"
    click_on "Back"
  end

  test "destroying a Record" do
    visit records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Record was successfully destroyed"
  end
end
