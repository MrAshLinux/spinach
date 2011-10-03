# encoding: utf-8
require 'colorize'

module Spinach
  # Spinach reporter collects information from Runner hooks and outputs the
  # results
  #
  class Reporter
    # Initialize a reporter with an empty error container.
    def initialize(options = {})
      @errors = []
      @options = options
      @undefined_steps = []
      @failed_steps = []
      @error_steps = []
    end

    # A Hash with options for the reporter
    #
    attr_accessor :options

    attr_accessor :current_feature, :current_scenario

    attr_reader :undefined_steps, :failed_steps, :error_steps

    def bind
      Runner.after_run method(:after_run)
      Runner::Feature.before_run method(:before_feature_run)
      Runner::Feature.after_run method(:after_feature_run)
      Runner::Scenario.before_run method(:before_scenario_run)
      Runner::Scenario.after_run method(:after_scenario_run)
      Runner::Scenario.on_successful_step method(:on_successful_step)
      Runner::Scenario.on_failed_step method(:on_failed_step)
      Runner::Scenario.on_error_step method(:on_error_step)
      Runner::Scenario.on_skipped_step method(:on_skipped_step)
    end

    def after_run(*args); end;

    def before_feature_run(data)
      current_feature = data
    end

    def after_feature_run(data)
      current_feature = nil
    end

    def before_scenario_run(data)
      current_scenario = data
    end

    def after_scenario_run(data)
      current_scenario = nil
    end

    def on_successful_step(step); end;
    def on_failed_step(step, failure); end;
    def on_error_step(step, failure); end;
    def on_undefined_step(step); end;
    def on_skipped_step(step); end;

  end
end

require_relative 'reporter/stdout'
