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
require 'models/instance/as_typeahead/for_synonymy/test_helper.rb'

# This is a based on a real error in production.
class ForFullCitationWithNameRefYearPageTest < ActiveSupport::TestCase
  test 'full citation with name ref year page' do
    results = Instance::AsTypeahead::AsTypeahead.for_synonymy('Panicum brownei Hughes in Hughes, D.K. (1923), The genus Panicum of the Flora Australiensis. Bulletin of Miscellaneous Information 1923(9):1923 [305-332]')
    assert results.class == Array, 'Results should be an array.'
    assert results.size == 0, 'Not expecting any results - just want to check no exception is thrown.'
  end
end
