# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
20.times do |i|
    is_published = i < 10
    blog = Blog.create!(
      title: "Blog Post #{i}", 
      published: is_published
    )
    
    # Only add comments to published ones to respect your validation
    if is_published
      blog.comments.create!(body: "Great post!")
    end
  end