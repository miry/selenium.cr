require "../spec_helper"

module Selenium::Command
  describe "screenshots", tags: "feature" do
    Spec.after_each { File.delete("result.png") if File.exists?("result.png") }

    it "can be taken of whole page" do
      TestServer.route "/home", "<h1>The Title</h1>"
      driver = Driver.new

      with_session(driver) do |session|
        session.navigate_to("localhost:3002/home")
        session.screenshot("result.png")
        File.exists?("result.png").should be_true
      end
    end

    it "can be taken of specific element" do
      TestServer.route "/home", <<-HTML
      <div>
        <p>First Element</p>
        <p id="target">Second Element</p>
      </div>
      HTML
      driver = Driver.new

      with_session(driver) do |session|
        session.navigate_to("localhost:3002/home")
        element = session.find_element(LocationStrategy::CSS, "#target")
        element.screenshot("result.png")
        File.exists?("result.png").should be_true
      end
    end
  end
end
