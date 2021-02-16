FROM continuumio/anaconda3:latest

RUN apt-get update && apt-get install -y unzip wget gnupg

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add && \
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable

ADD  https://chromedriver.storage.googleapis.com/88.0.4324.96/chromedriver_linux64.zip /opt/chrome/

RUN cd /opt/chrome/ && \
    unzip chromedriver_linux64.zip

ENV PATH /opt/conda/bin:/opt/conda/condabin:/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/chrome



WORKDIR /workspace

EXPOSE 3000

ENTRYPOINT ["jupyter-lab", "--ip=0.0.0.0", "--port=3000", "--no-browser", "--allow-root", "--LabApp.token=''"]

CMD ["--notebook-dir=/workspace"]