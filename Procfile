web: RAILS_ENV=production thin start -p 80
resque: RAILS_ENV=production QUEUE=* rake resque:work
scheduler: RAILS_ENV=production rake resque:scheduler