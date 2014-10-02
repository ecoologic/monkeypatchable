require "monkeypatchable/version"

module Monkeypatchable
  # Define these constants
  # RUBY_VERSION = '2.1.3'
  # RAILS_VERSION = '4.1.5'

  def self.add(&block)
    VersionsChecker.()

    before = Metadata.new(self)
    result = yield
    AfterAdd.new(before, self, &block)

    result
  end

  def self.override
    VersionsChecker.()

    result = yield
    # TODO

    result
  end

  class Metadata < Struct.new(:original_class)
    attr_reader :original_class_methods,
                :original_instance_methods
    def initialize
      super
      @original_class_methods    = original_class.methods
      @original_instance_methods = original_class.instance_methods
    end
  end

  class AfterAdd
    attr_reader :before, :after, :block

    def initialize(before, after, &block)
      @before = before
      @after  = after
      @block  = block

      raise_already_existing unless all_methods_added?
    end

    private
    def all_methods_added?
      double = Object.new.instance_exec(&@block;) # BIG TODO: adds methods to Object class? class Double ...
      expected_added_methods = double.methods - Object.new.methods # TODO? doesn't cover public / private visibility
      actual_added_methods   = after.methods  - before.original_instance_methods
      # TODO: and clas methods

      actual_added_class_methods    == expected_added_class_methods &&
      actual_added_instance_methods == expected_added_instance_methods
    end

    def already_existing
      raise LoadError.new %(You're thinking to create a method, but you're
        actually overriding one. If that's what you intended, use Monkeypatchable.override
        instead of Monkeypatchable.add
      ) # TODO: smart stacktrace
    end
  end

  module VersionsChecker
    def self.call
      check_ruby_version  if Monkeypatchable::RUBY_VERSION
      check_rails_version if Monkeypatchable::RAILS_VERSION
    end

    private
    def self.check_ruby_version
      unless ::RUBY_VERSION == Monkeypatchable::RUBY_VERSION # todo
        raise LoadError.new("...")
      end
    end

    def self.check_rails_version
      unless ::RAILS_VERSION == Monkeypatchable::RAILS_VERSION # todo
        raise LoadError.new("...")
      end
    end
  end
end
