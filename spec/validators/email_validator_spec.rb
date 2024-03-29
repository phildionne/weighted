# encoding: UTF-8
require 'spec_helper'

class Validatable
  include ActiveModel::Validations
  attr_accessor :email
  validates :email, email: true
end

describe EmailValidator do

  subject { Validatable.new }

  context "with a valid email" do
    let(:emails) do
      [
        'james@gmail.com',
        'man@8.8.8.8',
        'woman@address.tld',
        '$@f.c'
      ]
    end

    # @TODO Use fixtures
    it "validates the email" do
      emails.each do |email|
        subject.email = email
        should be_valid
      end
    end
  end

  context "with an invalid email" do
    let(:emails) do
      [
        # 'can@haz', @FIXME: This is currently valid
        'haxors',
        '@blah',
        'test1@a.com, test2@b.com'
      ]
    end

    it "validates the email" do
      emails.each do |email|
        subject.email = email
        should_not be_valid
      end
    end

    it "adds an error to the model" do
      emails.each do |email|
        subject.email = email
        should have(1).error_on(:email)
      end
    end

  end
end
