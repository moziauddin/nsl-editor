#   encoding: utf-8
# frozen_string_literal: true

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

require "test_helper"

# Single integration test.
class RequiredFieldsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test "for required fields" do
    visit_home_page
    fill_in "search-field", with: "test: create other name - required fields"
    load_new_other_name_form
    assert(page.has_selector?("#name_name_type_id[required]"),
           "Name type should be a required field.")
    assert(page.has_selector?("#name_name_status_id[required]"),
           "Name status should be a required field.")
    assert(page.has_selector?("#name_name_element[required]"),
           "Name element should be a required field.")
  end
end
