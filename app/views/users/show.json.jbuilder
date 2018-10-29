json.array! @posts do |post|
    json.extract! post, :id, :text
    json.start post.created_at
    json.allDay false
    json.url post_url(post, format: :html)
    json.color "royalblue"
    json.title "投稿完了"
end
# json.extract! @user, :id, :created_at
# json.scores(@posts, :created_at, :updated_at, :image)