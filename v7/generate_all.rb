#!/usr/bin/env ruby
# frozen_string_literal: true

# Run `diff v7/generated/default v7/generated/mysql -ur -X .diffignore` for diff.

require 'rails'
require 'rainbow'
require 'tty-command'

logger = Logger.new('generation.log')
diff_logger = Logger.new('diff.log')

cmd = TTY::Command.new(printer: :quiet, pty: true)

applications = [
  'default',
  # 'mysql --database=mysql', NOT WORKING
  'postgresql --database=postgresql',
  'skip_git --skip-git',
  'skip_keeps --skip-keeps',
  'skip_action_mailer --skip-action-mailer',
  'skip_action_mailbox --skip-action-mailbox',
  'skip_action_text --skip-action-text',
  'skip_active_record --skip-active-record',
  'skip_active_job --skip-active-job',
  'skip_active_storage --skip-active-storage',
  'skip_action_cable --skip-action-cable',
  'skip_asset-pipeline --skip-asset-pipeline',
  'propshaft --asset-pipeline=propshaft',
  'skip_javascript --skip-javascript',
  'skip_hotwire --skip-hotwire',
  'skip_jbuilder --skip-jbuilder',
  'skip_test --skip-test',
  'skip_system_test --skip-system-test',
  'skip_bootsnap --skip-bootsnap',
  'api --api',
  'minimal --minimal',
  'webpack --javascript=webpack',
  'esbuild --javascript=esbuild',
  'rollup --javascript=rollup',
  'tailwind --css=tailwind',
  'bootstrap --css=bootstrap',
  'postcss --css=postcss'
]

applications.each do |application|
  running_message = Rainbow("Running 'rails new #{application}'").yellow
  finished_message = Rainbow("Finished running 'rails new #{application}'").green

  puts running_message
  logger.info running_message

  result = cmd.run "rails new generated/#{application}"
  logger.info result.out

  puts finished_message
  logger.info finished_message

  # next if application.split.first == 'default'
  #
  # diff_result = cmd.run "diff ./generated/default ./generated/#{application.split.first} -ur -X .diffignore"
  # # diff_logger.info diff_result.out
end
