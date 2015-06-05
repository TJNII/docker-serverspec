# https://github.com/TJNII/DockerBases
FROM tjnii_base/debian_jessie
MAINTAINER Tom Noonan II <tom@tjnii.com>

# Install Rubygems
RUN apt-get install -y rubygems ruby-dev build-essential

# Copy in test support files (Rakefile, gemfile, starter script)
COPY files/ /testfiles

# Install a non-root user to test as
RUN useradd -d /source -s /bin/bash specrunner

# Install ServerSpec
RUN gem install bundler && cd /testfiles && bundle install

# Run the test
# The starter script ensures specrunner can access toe Docker socket and drops perms
CMD /testfiles/starter.sh
