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
require 'models/reference/update/if_changed/test_helper'

class ForAChangedPublishedTest < ActiveSupport::TestCase
  test 'changed published' do
    reference = Reference::AsEdited.find(references(:for_change_detection).id)
    new_column_value = !reference.published
    assert reference.update_if_changed({ 'published' => new_column_value }, {}, 'a user'), 'Reference should have been changed.'
    changed_reference = Reference.find_by(id: reference.id)
    assert_equal new_column_value, changed_reference.published, 'The published column value should have changed to the new value'
    assert_match 'a user', changed_reference.updated_by, 'Reference.updated_by should have changed to the updating user'
    assert reference.created_at < changed_reference.updated_at, 'Reference updated at should have changed.'
  end
end
