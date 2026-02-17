class PublishBlogJob < ApplicationJob
  queue_as :default

  def perform(blog_id)
    blog = Blog.find(blog_id)
    BlogPublisher.new(blog).call
  end
end