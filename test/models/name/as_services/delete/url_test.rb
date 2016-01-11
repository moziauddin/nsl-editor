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

class NameAsServicesDeleteURLTest < ActiveSupport::TestCase
  test "url" do
    url = Name::AsServices.delete_url(12_345, "this is the reason.....")
    assert url.match(Regexp.escape(%(#{Rails.configuration.name_services}12345/api/delete?apiKey=#{Rails.configuration.api_key}&reason=this%20is%20the%20reason.....))), "URL is wrong."
  end
end
