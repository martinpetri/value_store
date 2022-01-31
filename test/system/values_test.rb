require "application_system_test_case"

class ValuesTest < ApplicationSystemTestCase
  setup do
    @value = values(:one)
  end

  test "visiting the index" do
    visit values_url
    assert_selector "h1", text: "Values"
  end

  test "creating a Value" do
    visit values_url
    click_on "New Value"

    fill_in "Measured at", with: @value.measured_at
    fill_in "Topic", with: @value.topic_id
    fill_in "Value", with: @value.value
    click_on "Create Value"

    assert_text "Value was successfully created"
    click_on "Back"
  end

  test "updating a Value" do
    visit values_url
    click_on "Edit", match: :first

    fill_in "Measured at", with: @value.measured_at
    fill_in "Topic", with: @value.topic_id
    fill_in "Value", with: @value.value
    click_on "Update Value"

    assert_text "Value was successfully updated"
    click_on "Back"
  end

  test "destroying a Value" do
    visit values_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Value was successfully destroyed"
  end
end
