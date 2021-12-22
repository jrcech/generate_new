#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rails'
require 'rainbow'
require 'tty-command'

logger = Logger.new('generation.log')

cmd = TTY::Command.new(printer: :quiet, pty: true)

applications = [
  'rails new default',
  'rails new mysql --database=mysql',
  'rails new postgresql --database=postgresql',
  'rails new skip_git --skip-git',
  'rails new skip_keeps --skip-keeps',
  'rails new skip_action_mailer --skip-action-mailer',
  'rails new skip_action_mailbox --skip-action-mailbox',
  'rails new skip_action_text --skip-action-text',
  'rails new skip_active_record --skip-active-record',
  'rails new skip_active_job --skip-active-job',
  'rails new skip_active_storage --skip-active-storage',
  'rails new skip_action_cable --skip-action-cable',
  'rails new skip_asset-pipeline --skip-asset-pipeline',
  'rails new propshaft --asset-pipeline=propshaft',
  'rails new skip_javascript --skip-javascript',
  'rails new skip_hotwire --skip-hotwire',
  'rails new skip_jbuilder --skip-jbuilder',
  'rails new skip_test --skip-test',
  'rails new skip_system_test --skip-system-test',
  'rails new skip_bootsnap --skip-bootsnap',
  'rails new api --api',
  'rails new minimal --minimal',
  'rails new webpack --javascript=webpack',
  'rails new esbuild --javascript=esbuild',
  'rails new rollup --javascript=rollup',
  'rails new tailwind --css=tailwind',
  'rails new bootstrap --css=bootstrap',
  'rails new postcss --css=postcss'
]

applications.each do |application|
  running_message = Rainbow("Running '#{application}'").yellow
  finished_message = Rainbow("Finished running '#{application}'").green

  puts running_message
  logger.info running_message

  result = cmd.run application
  logger.info result.out

  puts finished_message
  logger.info finished_message
end
