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

class ScientificNamesMustHaveAParentTest < ActiveSupport::TestCase
  test 'scientific name without parent is invalid' do
    name = names(:scientific_name)
    assert name.parent.present?, 'Should have a parent'
    assert name.valid?, 'scientific name with parent should be valid'
    name.parent = nil
    assert_not name.valid?, 'scientific name without a parent should be invalid'
  end
end
