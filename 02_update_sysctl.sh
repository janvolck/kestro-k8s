sudo sysctl fs.inotify.max_user_instances=1048576
sudo sysctl fs.inotify.max_queued_events=1048576  
sudo sysctl fs.inotify.max_user_watches=1048576  
sudo sysctl vm.max_map_count=262144