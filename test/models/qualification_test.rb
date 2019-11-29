require 'test_helper'

class QualificationTest < ActiveSupport::TestCase

  def setup
    @user_id = get_admin_user().id
  end

  test 'should not save a qualification without a user id' do
    qualification = Qualification.new do |q|
      q.name = "Mphys Physics"
      q.awarded_date = Date.yesterday()
    end
    assert_not qualification.save
    assert qualification.errors.size == 2
    assert qualification.errors.of_kind?(:user, :blank), 'No error on user'
    assert qualification.errors.of_kind?(:user_id, :blank), 'No error on user id'
  end

  test 'should not save a qualification without a name' do
    qualification = Qualification.new do |q|
      q.user_id = @user_id
      q.awarded_date = Date.yesterday()
    end
    assert_not qualification.save
    assert qualification.errors.size == 2
    assert qualification.errors.of_kind?(:name, :blank), 'No error on name'
    assert qualification.errors.of_kind?(:name, :too_short), 'Name length not triggered'
  end

  test 'should not save a qualification without an awarded date' do
    qualification = Qualification.new do |q|
      q.user_id = @user_id
      q.name = "Mphys Physics"
    end
    assert_not qualification.save
    assert qualification.errors.size == 2
    assert qualification.errors.of_kind?(:awarded_date, :blank), 'No error on awarded date'
    assert qualification.errors.of_kind?(:awarded_date, :invalid_date), 'Awarded date format not triggered'
  end

  test 'should not save a qualification with a name that\'s too short' do
    qualification = Qualification.new do |q|
      q.name = 'a'*2
      q.awarded_date = Date.yesterday()
      q.user_id = @user_id
    end
    assert_not qualification.save
    assert qualification.errors.size == 1
    assert qualification.errors.of_kind?(:name, :too_short), 'Name length not triggered'
  end

  test 'should not save a qualification with a name that\'s too long' do
    qualification = Qualification.new do |q|
      q.name = 'a'*46
      q.awarded_date = Date.yesterday()
      q.user_id = @user_id
    end
    assert_not qualification.save
    assert qualification.errors.size == 1
    assert qualification.errors.of_kind?(:name, :too_long), 'Name length not triggered'
  end

  test 'should not save a qualification with a badly formatted awarded date' do
    qualification = Qualification.new do |q|
      q.name = 'MPhys Physics'
      q.awarded_date = 'Frank'
      q.user_id = @user_id
    end
    assert_not qualification.save
    assert qualification.errors.size == 2, "Found #{qualification.errors.size} errors"
    assert qualification.errors.of_kind?(:awarded_date, :invalid_date), "Awarded date format not triggered"
    assert qualification.errors.of_kind?(:awarded_date, :blank), 'No error on awarded date'
  end

  test 'should not save a qualification with a future awarded date' do
    qualification = Qualification.new do |q|
      q.name = 'MPhys Physics'
      q.awarded_date = Date.tomorrow()
      q.user_id = @user_id
    end
    assert_not qualification.save
    assert qualification.errors.size == 1, "Found #{qualification.errors.size} errors"
    assert qualification.errors.of_kind?(:awarded_date, :on_or_before), 'Awarded date restriction not triggered'
  end

  test 'should save a qualification with all necessary information filled in correctly' do
    qualification = Qualification.new do |q|
      q.name = 'MPhys Physics'
      q.awarded_date = Date.current()
      q.user_id = @user_id
    end
    assert qualification.save
    assert qualification.errors.size == 0
  end

  test 'should not save a qualification with an expiry date before its awarded date' do
    qualification = Qualification.new do |q|
      q.name = 'MPhys Physics'
      q.awarded_date = Date.yesterday()
      q.user_id = @user_id
      q.expiry_date = Date.yesterday() - 1.day
    end
    assert_not qualification.save
    assert qualification.errors.size == 1, "Found #{qualification.errors.size} errors"
    assert qualification.errors.of_kind?(:expiry_date, :after), 'Awarded date restriction not triggered'
  end

  test 'should save a qualification with an expiry date after its awarded date' do
    qualification = Qualification.new do |q|
      q.name = 'MPhys Physics'
      q.awarded_date = Date.yesterday()
      q.user_id = @user_id
      q.expiry_date = Date.current()
    end
    assert qualification.save
  end
end
