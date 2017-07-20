# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  User.destroy_all
  Question.destroy_all
  Poll.destroy_all
  AnswerChoice.destroy_all
  Response.destroy_all

  user1 = User.create({username: 'bob'})
  user2 = User.create({username: 'brian'})
  user3 = User.create({username: 'james'})
  user4 = User.create({username: 'john'})
  user5 = User.create({username: 'bill'})

  poll1 = Poll.create(author_id: user1.id, title: 'First poll')
  poll2 = Poll.create(author_id: user1.id, title: "bob's poll")
  poll3 = Poll.create(author_id: user1.id, title: 'Are blob people awsome')

  poll4 = Poll.create(author_id: user2.id, title: 'How many people are named brian')
  poll5 = Poll.create(author_id: user2.id, title: "How many people's names start with b")

  poll6 = Poll.create(author_id: user3.id, title: 'john poll')
  poll7 = Poll.create(author_id: user4.id, title: "james poll")
  poll8 = Poll.create(author_id: user5.id, title: 'Are blob people awesome* (get it right bob)')

  q1 = Question.create(poll_id: poll1.id, text: "have you ever made a first?")
    a1 = AnswerChoice.create(question_id: q1.id, text: 'true')
    a2 = AnswerChoice.create(question_id: q1.id, text: 'false')
        r1 = Response.create(answer_choice_id: a1.id, responder_id: user4.id)
        r2 = Response.create(answer_choice_id: a2.id, responder_id: user2.id)
        r3 = Response.create(answer_choice_id: a1.id, responder_id: user3.id)


  q2 = Question.create(poll_id: poll2.id, text: "have you ever met a bob?")
    a3 = AnswerChoice.create(question_id: q2.id, text: 'true')
    a4 = AnswerChoice.create(question_id: q2.id, text: 'false')
  q3 = Question.create(poll_id: poll3.id, text: "have you ever met a blob?")
    a5 = AnswerChoice.create(question_id: q3.id, text: 'true')
    a6 = AnswerChoice.create(question_id: q3.id, text: 'false')



  q4 = Question.create(poll_id: poll3.id, text: "have you ever talked to a blob?")
    a7 = AnswerChoice.create(question_id: q4.id, text: 'true')
    a8 = AnswerChoice.create(question_id: q4.id, text: 'false')
  q5 = Question.create(poll_id: poll3.id, text: "was the blob awesome?")
    a9 = AnswerChoice.create(question_id: q5.id, text: 'true')
    a10 = AnswerChoice.create(question_id: q5.id, text: 'false')


  q6 = Question.create(poll_id: poll4.id, text: "have you ever met a brian?")
  q7 = Question.create(poll_id: poll5.id, text: "have you ever talked to a b person?")
  q8 = Question.create(poll_id: poll6.id, text: "was the john awesome?")
  q9 = Question.create(poll_id: poll7.id, text: "was the james awesome?")
  q10 = Question.create(poll_id: poll8.id, text: "was the blob *awesome?")
