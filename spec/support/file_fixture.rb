module FileFixtureHelpers
  def load_file_fixture(path)
    content = file_fixture(path).read
    JSON.parse(content).with_indifferent_access
  end
end

RSpec.configure do |config|
  config.include FileFixtureHelpers
end
