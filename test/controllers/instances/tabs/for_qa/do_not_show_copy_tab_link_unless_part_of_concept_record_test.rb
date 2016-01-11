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

class InstancesQADoNotShowCopyTabLinksUnlessPartOfConceptRecordTest < ActionController::TestCase
  tests InstancesController
  setup do
    @instance = instances(:britten_created_angophora_costata)
  end

  # would be better to test the controller method
  test "do not show copy tab links unless part of concept record" do
    @request.headers["Accept"] = "application/javascript"
    get(:show, { id: @instance.id, tab: "tab_show_1", "row-type" => "instance" }, username: "fred", user_full_name: "Fred Jones", groups: ["qa"])
    assert_response :success
    assert_select 'li.active a#instance-show-tab', /Details/, "Should show 'Details' tab link."
    assert_select 'a#instance-edit-tab', false, "Should not show 'Edit' tab link."
    assert_select 'a#instance-edit-notes-tab', false, "Should not show 'Notes' tab link."
    assert_select 'a#instance-cite-this-instance-tab', false, "Should not show 'Syn' tab link."
    assert_select 'a#unpublished-citation-tab', false, "Should not show 'Unpub' tab link."
    assert_select 'a#instance-apc-placement-tab', false, "Should not show 'APC' tab link."
    assert_select 'a#instance-comments-tab', false, "Should not show 'Adnot' tab link."
    assert_select 'a#instance-copy-to-new-reference-tab', false, "Should not show 'Copy' tab link because not part of concept record."
  end
end
