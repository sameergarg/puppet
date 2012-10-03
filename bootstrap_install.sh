
echo
echo
echo "Installing subversion and ruby"
echo "=============================="
yum -y install subversion ruby rsync

echo
echo
echo "Installing puppet and facter"
echo "============================"
# Get the latest tarball:
wget -nc http://puppetlabs.com/downloads/facter/facter-latest.tgz
# Untar and install facter:
gzip -d -c facter-latest.tgz | tar xf -
cd facter-*
ruby install.rb # or become root and run install.rb

# get the latest tarball
wget -nc http://puppetlabs.com/downloads/puppet/puppet-latest.tgz
# untar and install it
gzip -d -c puppet-latest.tgz | tar xf -
cd puppet-*
ruby install.rb # or become root and run install.rb

echo
echo
echo "Creating /development folder tree"
echo "================================="
mkdir -p /development/downloads
echo "done"

echo
echo
echo "Downloading installation binaries"
echo "================================="
echo "(Please enter password when prompted for epicftp@app1)"
rsync -az --progress --rsh=ssh --partial --delete epicftp@212.64.133.157:~/webpim/downloads/installs /development/downloads/

echo
echo
echo "Downloading puppet configuration"
echo "================================"
rm -rf /etc/puppet
svn checkout --force --username webpim-build --password uFg67b325 --non-interactive https://projectepic.jira.com/svn/OD/PIM-DMS-COMMON/trunk/infrastructure/puppet /etc/puppet

echo
echo
echo "Going to apply puppet configuration"
echo "==================================="

puppet apply /etc/puppet/manifests/site.pp -v --debug --detailed-exitcodes
# An exit code of '2' means there were changes, an exit code of '4' means there were failures
# during the transaction, and an exit code of '6' means there were both changes and failures.
[[ $? -le 2 ]]

