# refresher - A simble database schema cache refresh

Imagine you are prototyping a Rails application with much table (let say 30+ 
tables) at the first time. You might end up with this:

    20151210051128_create_orders.rb
    20151210113138_add_payment_commit_time_to_orders.rb
    20151213090513_remove_payment_hash_from_order.rb
    20151214042001_add_payment_to_order.rb
    20151214051032_create_payments.rb

There might be so much `add` and `remove` migration file. In fact, you 
are _prototyping_ so database schema is expected to change in this early
stage. Also, **there is no single overview about current schema in migration
files.** You might need to see `db/schema.rb` or use model annotation tools
like [annotate] to get a summary of current schema/table.

[annotate]: https://github.com/ctran/annotate_models

When prototyping, you might want to see everything about a table
in a single migration file. You might only want `create_orders.rb` in contrast
of four migration files describing a single table. Unfortunately, you can't
simply add field to `create_orders` then run `rake db:migrate`
because Rails won't notice the different of migration file if 
the migration timestamp id has been existed in db. You must `db:rollback`
and then `db:migrate` again, for every single migration you change (but
has been persisted to db).

Another way is to just drop the entire db, then create the db again, then
run the migration (rake db:drop db:create db:migrate). That is okay
if you are prototyping 10 tables, but imagine you are prototyping with
60 tables, and you only want to change last 5 tables, it might take 20+
seconds just to drop and populate 60 tables. In this case, perhaps rollback
is better.

With refresher, you can populate db with SQL cache, so let say your
latest checkpoint for you is migration id 2015, and you change 2016

    2014_create_a
    2015_create_b    <-- latest schema in cache
    2016_create_c
    2017_create_d

## refresher With Cache

    rake db:refresh

    rake db:refresh_invalidate_cache

    rake db:refresh_persist_cache
