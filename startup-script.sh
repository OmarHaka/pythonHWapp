# Echo commands and fail on error
set -ev

# [START getting_started_gce_startup_script]
# Install or update needed software
apt-get update
apt-get install -yq git supervisor python python-pip python3-distutils
pip install --upgrade pip virtualenv

# Fetch source code
export HOME=/root
git clone https://github.com/OmarHaka/pythonHWapp.git /opt/app/gce


# Account to own server process
useradd -m -d /home/pythonapp pythonapp

# Python environment setup
virtualenv -p python3 /opt/app/gce/env
/bin/bash -c "source /opt/app/gce/env/bin/activate"
/opt/app/gce/env/bin/pip install -r /opt/app/gce/requirements.txt

# Set ownership to newly created account
chown -R pythonapp:pythonapp /opt/app/gce

# Put supervisor configuration in proper place
cp /opt/app/gce/python-app.conf /etc/supervisor/conf.d/python-app.conf

# Start service via supervisorctl
supervisorctl reread
supervisorctl update
# [END getting_started_gce_startup_script]
