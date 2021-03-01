user = User.create(username: "user_1", email: "user@email.com", password: "password")

tweet = Tweet.create(content: "here i am")

tweet.user = user