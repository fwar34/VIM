. "$HOME/.cargo/env"

export PATH=$HOME/bin:/usr/local/bin:/sbin:/usr/bin:$PATH:/snap/bin:$HOME/.local/bin:$HOME/.local/share/nvim/lsp_servers/pylsp/venv/bin
#golang
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin:$HOME/.cargo/bin:$HOME/bin/maven/bin
#golang proxy
export GO111MODULE=on
export GOPROXY=https://goproxy.cn

if [ -d /usr/lib/jvm/java-11-openjdk-amd64 ];then
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
elif [ -d /usr/lib/jvm/java-8-openjdk-amd64 ];then
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
    export JRE_HOME=${JAVA_HOME}/jre
    export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
elif [ -d /usr/lib/jvm/java-8-openjdk ];then
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
    export JRE_HOME=${JAVA_HOME}/jre
    export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
else
    export JAVA_HOME=$HOME/jdk-13.0.2
fi
export PATH=$PATH:$JAVA_HOME/bin

export MAVEN_HOME=/usr/share/maven
export PATH=$PATH:$MAVEN_HOME/bin

export ROCKETMQ_HOME=$HOME/rocketMQ/rocketmq-all-4.6.1-bin-release
