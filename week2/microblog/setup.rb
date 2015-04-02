require "sqlite3"

DB = SQLite3::Database.new "microblog.db"

DB.execute <<-SQL
  create table if not exists posts (
    id integer primary key,
    body varchar(255)
  );
SQL

DB.execute <<-SQL
  create table if not exists tags (
    id integer primary key,
    body varchar(255)
  );
SQL

DB.execute <<-SQL
  create table if not exists posts_to_tags (
    post_id integer,
    tag_id integer
  );
SQL