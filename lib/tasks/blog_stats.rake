namespace :blogs do
    desc "Print published and unpublished blog count"
    task stats: :environment do
      published = Blog.where(published: true).count
      unpublished = Blog.where(published: false).count
      puts "Published: #{published} | Unpublished: #{unpublished}"
    end
  end