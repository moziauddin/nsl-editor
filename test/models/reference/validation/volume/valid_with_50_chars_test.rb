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

class VolumeValidWith50CharsTest < ActiveSupport::TestCase
  test 'volume valid with 50 chars' do
    reference = references(:simple)
    assert reference.valid?, 'Should start out valid'
    reference.volume = 'x' * 50
    assert reference.valid?, 'Should be valid with 50 chars'
    reference.volume = 'y' * 51
    assert_not reference.valid?, 'Should not be valid with 51 chars'
  end
end
