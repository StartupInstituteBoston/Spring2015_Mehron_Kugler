require './app/models/user.rb'

describe User, '#pass' do
  it "passes test when true" do

    user = User.new

    grade = user.pass(true)

    expect(grade).to be_truthy

  end

  it "fails test when false" do
    user = User.new

    grade = user.pass(false)

    expect(grade).to be_falsey
  end

describe User, "#integration" do
  it "converts a grade to pass or fail" do
    user = User.new
    grade = "C"
    passed = user.score(grade)
    expect(passed).to be_truthy

end

end