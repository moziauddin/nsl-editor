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

class AuthorCannotBeDeletedIfHasExBaseNameTest < ActiveSupport::TestCase
  test "author cannot be deleted if dependent ex base name" do
    author = authors(:has_no_dependents)
    bentham = authors(:bentham)
    hooker = authors(:hooker)
    name = Name.first
    name.author = bentham # must have to pass validation
    name.base_author = hooker # for validation
    name.ex_base_author = author
    name.save!
    assert_not author.can_be_deleted?, "Should not be able to delete author of ex base name"
  end
end
