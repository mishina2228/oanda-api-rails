require 'application_system_test_case'

class ResqueSchedulesTest < ApplicationSystemTestCase
  setup do
    @resque_schedule = resque_schedules(:job1)
  end

  test 'visiting the index' do
    visit resque_schedules_url
    assert_selector 'h1', text: I18n.t('helpers.title.list', models: ResqueSchedule.model_name.human.pluralize(I18n.locale))
  end

  test 'updating a Resque schedule' do
    assert @resque_schedule.enabled?

    visit resque_schedules_url
    click_on @resque_schedule.name, match: :first
    click_on I18n.t('helpers.link.edit')
    page.assert_current_path(edit_resque_schedule_path(@resque_schedule.id))

    uncheck ResqueSchedule.human_attribute_name(:enabled)
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('helpers.notice.update')
    page.assert_current_path(resque_schedule_path(@resque_schedule.id))
    assert_not @resque_schedule.reload.enabled?
  end
end
