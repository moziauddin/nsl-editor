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
load "test/models/search/users.rb"

class SearchOnReferenceOnDuplicateOfIdTest < ActiveSupport::TestCase
  test "on duplicate of ID" do
    reference = references(:master)
    query_string = "duplicate-of-id: #{reference.id}"
    params = ActiveSupport::HashWithIndifferentAccess.new(query_target: "reference", query_string: query_string, current_user: build_edit_user)
    search = Search::Base.new(params)
    assert_equal search.executed_query.results.class, Reference::ActiveRecord_Relation, "Results should be a Reference::ActiveRecord_Relation."
    assert_equal 1, search.executed_query.results.size, "Exactly 1 result is expected."
  end
end
