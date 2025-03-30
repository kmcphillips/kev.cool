# commands used to deploy a Rails application
namespace :fly do
  # BUILD step:
  #  - changes to the filesystem made here DO get deployed
  #  - NO access to secrets, volumes, databases
  #  - Failures here prevent deployment
  task :build => 'assets:precompile'

  # RELEASE step:
  #  - changes to the filesystem made here are DISCARDED
  #  - full access to secrets, databases
  #  - failures here prevent deployment
  task :release => 'db:migrate'

  # SERVER step:
  #  - changes to the filesystem made here are deployed
  #  - full access to secrets, databases
  #  - failures here result in VM being stated, shutdown, and rolled back
  #    to last successful deploy (if any).
  task :server => [:swapfile, :load_public] do
    sh 'bin/rails server'
  end

  # optional SWAPFILE task:
  #  - adjust fallocate size as needed
  #  - performance critical applications should scale memory to the
  #    point where swap is rarely used.  'fly scale help' for details.
  #  - disable by removing dependency on the :server task, thus:
  #        task :server do
  task :swapfile do
    sh 'fallocate -l 512M /swapfile'
    sh 'chmod 0600 /swapfile'
    sh 'mkswap /swapfile'
    sh 'echo 10 > /proc/sys/vm/swappiness'
    sh 'swapon /swapfile'
  end

  # This uses a GitHub public access token to load these assets from a private repo into the public folder here.
  # It would be better in the Dockerfile because it would be clear what failed, but it means juggling the secret in a
  # way that's annoying. This way it's just in `fly secrets set GITHUB_TOKEN=xxx` and runs on each server start.
  task :load_public do
    sh 'mkdir -p tmp/public && curl -H "Authorization: token ${GITHUB_TOKEN}" -L https://api.github.com/repos/kmcphillips/kev.cool_public/tarball | tar -xz --strip-components=1 -C tmp/public && cp -r tmp/public/public/* public/'
  end
end
