# Clear old data to start fresh
Comment.destroy_all
Blog.destroy_all

20.times do |i|
  # First 10 are published (true), next 10 are unpublished (false)
  is_published = i < 10 
  
  blog = Blog.create!(
    title: "Blog Post #{i + 1}",
    body: "This is the content for post #{i + 1}",
    published: is_published
  )

  # Only add comments if the blog is published to avoid validation errors
  if is_published
    3.times { blog.comments.create!(body: "Great insight on post #{i + 1}!") }
  end
end

puts "Created #{Blog.count} blogs and #{Comment.count} comments!"