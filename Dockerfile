FROM ubuntu:16.04

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH
RUN apt-get update && \
    apt-get -y install \
    locales \
    rsync \
    openssh-server \
    sudo \
    procps \
    wget \
    unzip \
    mc \
    ca-certificates \
    curl \
    tzdata \
    netcat \
    vim \
    tmux \
    python \
    python3 \
    python-pip \
    python3-pip \
    nodejs \
    software-properties-common \
    python-software-properties \
    build-essential \
    cmake \
    python-dev \
    bash-completion && \
    mkdir /var/run/sshd && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 1000 -G users,sudo -d /home/user --shell /bin/bash -m user && \
    usermod -p "*" user && \
    add-apt-repository ppa:git-core/ppa && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb http://download.mono-project.com/repo/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/mono-official.list && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install \
    mono-devel \
    mono-complete \
    referenceassemblies-pcl \
    ca-certificates-mono \
    git \
    subversion && \
    apt-get clean && \
    apt-get -y autoremove && \
    sudo apt-get install openjdk-8-jdk-headless=8u131-b11-2ubuntu1.16.04.3 openjdk-8-source=8u131-b11-2ubuntu1.16.04.3 -y && \
    sudo update-ca-certificates -f && \
    sudo sudo /var/lib/dpkg/info/ca-certificates-java.postinst configure && \
    apt-get -y clean && \
    pip3 install -U pip && \
    pip2 install -U pip && \
    pip3 install ipython pandas numpy tqdm toolz matplotlib Pillow && \
    pip2 install ipython==5.4 pandas numpy tqdm toolz matplotlib Pillow && \
    rm -rf /var/lib/apt/lists/*

ENV LANG en_GB.UTF-8
ENV LANG en_US.UTF-8
ENV HOME /home/user
USER user
COPY open-jdk-source-file-location /open-jdk-source-file-location
COPY config/.bashrc /home/user/.bashrc
COPY config/.shrc /home/user/.shrc
COPY config/.profile /home/user/.profile
COPY config/.tmuxline /home/user/.tmuxline
COPY config/.tmux.conf /home/user/.tmux.conf

COPY config/.vimrc /home/user/.vimrc
RUN mkdir -p /home/user/.vim/colors
COPY config/monokai.vim /home/user/.vim/colors/monokai.vim

RUN sudo locale-gen en_US.UTF-8 && \
    svn --version && \
    cd /home/user && ls -la && \
    sed -i 's/# store-passwords = no/store-passwords = yes/g' /home/user/.subversion/servers && \
    sed -i 's/# store-plaintext-passwords = no/store-plaintext-passwords = yes/g' /home/user/.subversion/servers && \
    git clone https://github.com/VundleVim/Vundle.vim.git /home/user/.vim/bundle/Vundle.vim && \
    vim +PluginInstall +qall && \
    cd /home/user/.vim/bundle/YouCompleteMe/third_party/ycmd && \
    git submodule update --init --recursive && \
    export NoCompilerStandardLib=false && \
    ./build.py --all && \
    cp /home/user/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py /home/user/.vim/
    
EXPOSE 22 4403
WORKDIR /projects

# The following instructions set the right
# permissions and scripts to allow the container
# to be run by an arbitrary user (i.e. a user
# that doesn't already exist in /etc/passwd)
RUN for f in "/home/user" "/etc/passwd" "/etc/group" "/projects"; do\
           sudo chgrp -R 0 ${f} && \
           sudo chmod -R g+rwX ${f}; \
        done && \
        # Generate passwd.template \
        cat /etc/passwd | \
        sed s#user:x.*#user:x:\${USER_ID}:\${GROUP_ID}::\${HOME}:/bin/bash#g \
        > /home/user/passwd.template && \
        # Generate group.template \
        cat /etc/group | \
        sed s#root:x:0:#root:x:0:0,\${USER_ID}:#g \
        > /home/user/group.template && \
        sudo sed -ri 's/StrictModes yes/StrictModes no/g' /etc/ssh/sshd_config && \
        echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAokUVgSOW5+AS65hDO4yC1DBdoBN31zpOdsSR9DgkuxuZAVIX14kNXcbMpDDkloV7lA0rXKARlXYBYueiH/wGqgx7om7C+fixh4+USiKZhFbEtJ2sm4oF/ZZpcqRuo4EW47hR8KZTvDV3XbRx2ATTmrR0tQs++8+KO5WR/11CUqfdWSU+9P74FL/NFLA/6KvF7qMlLm8BzEUVar7FYSPUe3wff+3UD7nafqNSpUntTP2E+eajjH2oDPHogan5zPigcrk140ZfXkbCVe00oFowxbZ6srR+adkFvWef4VjjCzqH494SiC1nVqgN7OfQzFrb4uD3KNwjh3zTi9Hc/QsoHQ== codenvy' >> /home/user/.ssh/authorized_keys
COPY ["entrypoint.sh","/home/user/entrypoint.sh"]
ENTRYPOINT ["/home/user/entrypoint.sh"]
CMD tail -f /dev/null
