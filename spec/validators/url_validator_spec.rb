# encoding: UTF-8
require 'spec_helper'

class Validatable
  include ActiveModel::Validations
  attr_accessor :url
  validates :url, url: true
end

describe UrlValidator do

  subject { Validatable.new }

  context "with a valid url" do
    let(:urls) do
      [
        'http://google.com',
        'http://www.google.com',
        'http://google.com/doodles',
        'http://google.com/doodles/finder',
        'http://google.com/?withparam=true',
        'http://google.com/?withparam=true&otherparam=true',
        'http://google.com/#with_anchor',
        'http://google.com/#with_anchor?and=params',
        'http://google.com/#with_anchor?and=param&other=params'
      ]
    end

    # @TODO Use fixtures

    it "validates the url" do
      urls.each do |url|
        subject.url = url
        should be_valid
      end
    end
  end

  context "with an invalid url" do
    let(:urls) do
      [
        '',
        'test',
        'http://s.c',
        'http://.ru',
        'test.ca',
        'http://test.ca.c',
        'http://test?xsxa',
        'bla://service.com',
        'http://test.toolongdomain',
        'http://énon.ch',
        'http://do main.com/#with_anchor'
      ]
    end

    it "validates the url" do
      urls.each do |url|
        subject.url = url
        should_not be_valid
      end
    end

    it "adds an error to the model" do
      urls.each do |url|
        subject.url = url
        should have(1).error_on(:url)
      end
    end

  end
end
