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

class TypeaheadsOnCitationForParentRefTypeRestrictionUnknownsForUnknown < ActiveSupport::TestCase
  test "reference typeahead on citation ref type restriction any type for unknown" do
    current_reference = references(:simple)
    results = Reference::AsTypeahead.on_citation_for_parent("%", current_reference.id, ref_types(:unknown).id)
    assert results.size > 0, "Should be at least one result"
    unknowns = 0
    others = 0
    results.each do |result|
      if result[:value].match(/\[unknown\]/)
        unknowns += 1
      else
        others += 1
      end
    end
    assert others == 0, "Expecting no other ref types."
    assert unknowns > 0, "Expecting at least 1 unknown ref type."
  end
end
