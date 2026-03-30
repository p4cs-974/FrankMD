# frozen_string_literal: true

require "test_helper"

class FedScriptsTest < ActiveSupport::TestCase
  test "desktop helper scripts ship for posix shells and fish" do
    sh_script = Rails.root.join("config/fed/fed.sh")
    fish_script = Rails.root.join("config/fed/fed.fish")

    assert sh_script.exist?
    assert fish_script.exist?
    assert_includes fish_script.read, "function fed"
    assert_includes fish_script.read, "function fed-update"
    assert_includes fish_script.read, "function fed-stop"
  end

  test "fish desktop helper parses successfully when fish is installed" do
    skip "fish is not installed" unless system("command", "-v", "fish", out: File::NULL, err: File::NULL)

    fish_script = Rails.root.join("config/fed/fed.fish")

    assert system("fish", "-n", fish_script.to_s, out: File::NULL, err: File::NULL), "fish syntax check failed"
  end
end
