require "application_system_test_case"

class SchedulesTest < ApplicationSystemTestCase
  setup do
    @schedule = schedules(:one)
  end

  test "visiting the index" do
    visit schedules_url
    assert_selector "h1", text: "Schedules"
  end

  test "creating a Schedule" do
    visit schedules_url
    click_on "New Schedule"

    fill_in "Description", with: @schedule.description
    fill_in "End date", with: @schedule.end_date
    fill_in "End time", with: @schedule.end_time
    fill_in "Start date", with: @schedule.start_date
    fill_in "Start time", with: @schedule.start_time
    fill_in "Title", with: @schedule.title
    click_on "Create Schedule"

    assert_text "Schedule was successfully created"
    click_on "Back"
  end

  test "updating a Schedule" do
    visit schedules_url
    click_on "Edit", match: :first

    fill_in "Description", with: @schedule.description
    fill_in "End date", with: @schedule.end_date
    fill_in "End time", with: @schedule.end_time
    fill_in "Start date", with: @schedule.start_date
    fill_in "Start time", with: @schedule.start_time
    fill_in "Title", with: @schedule.title
    click_on "Update Schedule"

    assert_text "Schedule was successfully updated"
    click_on "Back"
  end

  test "destroying a Schedule" do
    visit schedules_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Schedule was successfully destroyed"
  end
end
