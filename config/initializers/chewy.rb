Chewy.settings = {host: "localhost:9200"}

Rails.application.config.after_initialize do
  if Rails.env.development? || Rails.env.test?
    BooksIndex.import(force: true)  
  end
end
