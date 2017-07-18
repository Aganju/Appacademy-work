DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  fname VARCHAR(100) NOT NULL,
  lname VARCHAR(100) NOT NULL
);


CREATE TABLE questions (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT,
  author_id INTEGER,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id SERIAL PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE replies (
  id SERIAL PRIMARY KEY,
  parent_id INTEGER,
  question_id INTEGER NOT NULL,
  body TEXT NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  id SERIAL PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);


INSERT INTO
  users(fname, lname)
VALUES
  ('Bob', 'Mcadoo'),
  ('James', 'Buchannan'),
  ('Hilary', 'Clinton');

INSERT INTO
  questions(title, body, author_id)
VALUES
  ('First question', 'What is it like to be the first question?', 1),
  ('Second question', 'Am I doomed to always come in second?', 3),
  ('Hello', 'Who am I?', 2);

INSERT INTO
  replies(parent_id, question_id, body, author_id)
VALUES
  ( NULL, 1, "I don't know but it feels good to be the first reply", 3),
  ( 1, 1, "How do you ask a question?", 2);

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  (1, 2);

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (1, 3);
