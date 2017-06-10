FROM nimbix/ubuntu-base:trusty
MAINTAINER hvarakhobava

# recreate nimbix user home to get the right skeleton files
RUN /bin/rm -rf /home/nimbix && /sbin/mkhomedir_helper nimbix

# install python libs including tensorflow, jupyter
RUN mkdir -p /etc/runtimescripts
ADD deploy.sh /etc/runtimescripts/deploy.sh
RUN chmod +x /etc/runtimescripts/deploy.sh && /etc/runtimescripts/deploy.sh

EXPOSE 5901
EXPOSE 443

WORKDIR "/home/nimbix"

# Set up our notebook config.
RUN mkdir -p .jupyter/
COPY jupyter_notebook_config.py .jupyter/

# Copy sample notebooks.
# RUN mkdir -p .jupyter/notebooks
# COPY notebooks .jupyter/notebooks

# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
COPY run_jupyter.sh .jupyter/
RUN chmod +x .jupyter/run_jupyter.sh

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888


CMD ["/home/nimbix/.jupyter/run_jupyter.sh", "--allow-root"]
