#!/bin/bash
apt-get -y install git

apt-get -y install screen
apt-get -y install psmisc

apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python \
        python-dev \
        python-pip \
        rsync \
        software-properties-common \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

curl -O https://bootstrap.pypa.io/get-pip.py && \
python get-pip.py && \
rm get-pip.py

pip --no-cache-dir install \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        scipy \
        sklearn \
        pandas \
        Pillow \
        && \
    python -m ipykernel.kernelspec

pip install -U tensorflow

chown -R $(whoami) .local

jupyter-notebook --generate-config && \
echo "c.NotebookApp.ip = '*'" >> .jupyter/jupyter_notebook_config.py
mkdir -p .jupyter/notebooks
echo "c.NotebookApp.notebook_dir = u'.jupyter/notebooks'" >> .jupyter/jupyter_notebook_config.py

iptables -A  INPUT -p tcp --dport 8888 -j ACCEPT
iptables -A  INPUT -p tcp --dport 6006 -j ACCEPT

mkdir -p /tmp/tensorboard
screen -d -m tensorboard --logdir=/tmp/tensorboard
screen -d -m jupyter-notebook

python -m pip install --upgrade pip
pip install -U --user ipython sympy nose

apt-get update -y
apt-get install -y wget
wget http://pyyaml.org/download/pyyaml/PyYAML-3.12.tar.gz
tar -xzf PyYAML-3.12.tar.gz
sh -c "cd PyYAML-3.12; python setup.py install"
rm -r -f PyYAML-3.12
rm -f PyYAML-3.12.tar.gz

apt-get install -y libhdf5-dev

wget https://bootstrap.pypa.io/ez_setup.py -O - | python

pip install -U simplejson plotly mpld3
pip install -U pydot pydot-ng
apt-get install graphviz -y
pip install -U h5py keras tflearn theano wheel python-dateutil pytz scikit-learn
pip install -U jupyter-client jupyter-console notebook tinydb
pip install -U opencv-python s3transfer scikit-image six subprocess32 toolz Werkzeug requests
pip install -U dask decorator docutils Flask funcsigs functools32 futures itsdangerous Jinja2 jmespath MarkupSafe mock networkx olefile pbr protobuf pyparsing flask_cors