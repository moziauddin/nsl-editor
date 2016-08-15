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

# Single Name model test.
class NamesAreSetFromServiceTest < ActiveSupport::TestCase
  test "names are set from service" do
    name = names(:without_names_from_service)
    assert name.full_name.blank?,
           "This test needs to start with a blank full_name."
    assert name.full_name_html.blank?,
           "This test needs to start with a blank full_name_html."
    assert name.simple_name.blank?,
           "This test needs to start with a blank simple_name."
    assert name.simple_name_html.blank?,
           "This test needs to start with a blank simple_name_html."

    name.set_names!
    assert name.full_name.present?, "Full_name should now be populated."
    assert name.full_name_html.present?,
           "Full_name_html should now be populated."
    assert name.simple_name.present?, "Simple_name should now be populated."
    assert name.simple_name_html.present?,
           "Simple_name_html should now be populated."
  end
end
