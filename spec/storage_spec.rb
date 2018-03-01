RSpec.describe Storage do
  test_data = Hash[100.times.map do
    key   = (0...4).map { (97 + rand(26)).chr }.join
    value = (0...8).map { (97 + rand(26)).chr }.join

    [key, value]
  end]

  test_data.each do |key, value|
    it "works with '#{key} => #{value}'" do
      Storage.instance.set key, value

      expect(Storage.instance.get(key)).to eq(value)
    end
  end

  test_data.each do |key, value|
    it "has preserved the value for '#{key}'" do
      expect(Storage.instance.get(key)).to eq(value)
    end
  end
end
