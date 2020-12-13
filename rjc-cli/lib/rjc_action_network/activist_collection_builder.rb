require 'net/http'
require 'json'
require 'pry'
require 'csv'
require 'fileutils'

class RjcActionNetwork::ActivistCollectionBuilder
  def perform
    puts "fetching users..."
    users = build_paginated_requests('people')
    puts "User count: #{users.length}"

    puts "fetching forms..."
    forms = build_paginated_requests('forms')
    puts "Form count: #{forms.length}"

    data = {}
    data_collection_by_form = []
    by_activist = users.each_with_object({}) do |user, activists|
      activists[user['identifiers'].first.split(":").last] = []
    end

    puts "Collecting form submission data"
    forms.each_with_object(data_collection_by_form) do |form, data_collection_by_form|
      form_id = form["identifiers"].first
      request_form_id = form["identifiers"].first.split(":").last
      current_form_submissions = build_paginated_requests("forms/#{request_form_id}/submissions")
      activist_ids = current_form_submissions.map { |submission| submission["action_network:person_id"] }.uniq

      by_activist.each do |id, data|
        submitted = activist_ids.include? id
        data << { form_id: form_id, form_title: form['title'], submitted: submitted }
      end

      data_collection_by_form << {
        id: form_id,
        total_submissions: form['total_submissions'],
        title: form['title'],
        activist_ids: activist_ids
      }
    end

    csv_dir = RjcActionNetwork.data_dir.join(Time.now.utc.to_i.to_s)
    FileUtils.mkdir_p(csv_dir)
    CSV.open("#{csv_dir.join('data_by_activist.csv')}", 'wb') do |row|
      form_titles = data_collection_by_form.map { |form| form[:title] }.uniq.sort
      headers = ['activist_id'].tap do |header_data|
        header_data << form_titles
      end
      row << headers.flatten

      by_activist.each do |id, form_submissions|
        row << [id, form_data(form_submissions, form_titles)].flatten
      end
    end
  end

  def form_data(form_submissions, form_titles)
    [].tap do |row|
      form_submissions = form_submissions.sort_by { |form| form[:title] }
      form_titles.each do |title|
        if form_submissions.find { |form| form[:form_title] == title }[:submitted]
          row << 1
        else
          row << 0
        end
      end
    end
  end

  private

  def client
    @client ||= RjcActionNetwork::ActionNetworkClient.new
  end

  def build_paginated_requests(endpoint)
    client.build_paginated_requests(endpoint)
  end
end
