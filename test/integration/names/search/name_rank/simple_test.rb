#   encoding: utf-8

#   Copyright 2015 Australian National Botanic Gardens
#
#   This file is part of the NSL Editor.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

require 'test_helper'

class NamesSearchNameRankSimple < ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL

  test 'simple name rank search' do
    Capybara.default_driver = :selenium
    visit_home_page
    select 'Name', from: 'query-on'
    select 'with name rank', from: 'query-field'
    assert find("#query-field option[value='nr']")['selected'], 'nr should be selected for name rank search'
    fill_in 'search-field', with: 'varietas'
    click_button 'Search'
    sleep(inspection_time = 0.1)
    search_result_must_include('tuberosus', 'Name rank search should have returned a record for tuberosus.')
  end
end
