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

# Single instance note model test.
class InstanceNoteCannotUpdateto2ApcDistNoteTest < ActiveSupport::TestCase
  test "cannot update instance note to produce 2 APC Dist Notes" do
    instance_note = InstanceNote.new(
      instance: instances(:has_apc_dist_note),
      instance_note_key: instance_note_keys(:text),
      value: "some string",
      created_by: "test",
      updated_by: "test",
      namespace: namespaces(:apni)
    )
    instance_note.save!
    # assert_raises ActiveRecord::RecordInvalid, "Record should be invalid" do
    instance_note.instance_note_key_id = instance_note_keys(:apc_dist).id
    assert_not instance_note.valid?, "Should now be invalid"
    # end
  end
end
