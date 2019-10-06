# Building docker image on m/c with at least 3.75GB memory, otherwise it might fail.
# Building docker image on m/c with userns remapping enabled might fail due to high container ID (ex: 100049) not being
# able to be mapped to host ID. The workaround could be to extend host subordinate UID & GID ranges to contain the mapping of high container ID
# by modifying '/etc/subuid' & '/etc/subgid' files on host.
#
FROM tensorflow/tensorflow:1.13.1-py3-jupyter 
RUN apt-get update && apt-get install curl -y
RUN mkdir -p /notebooks

# Install python pystan & plotly before installing fbprophet.

RUN pip install --upgrade pip plotly && pip install pystan && \
    pip install seaborn pipdeptree statsmodels fbprophet tqdm missingno faker babel librosa jupyter_http_over_ws \
   && jupyter serverextension enable --py jupyter_http_over_ws
RUN pip install tensorflow-datasets tensorflow-hub
WORKDIR /notebooks
CMD ["jupyter","notebook","--ip=0.0.0.0","--allow-root", "--no-browser"] 
