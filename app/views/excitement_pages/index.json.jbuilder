json.array!(@excitement_pages) do |excitement_page|
  json.extract! excitement_page, :id, :title, :text
  json.url excitement_page_url(excitement_page, format: :json)
end
