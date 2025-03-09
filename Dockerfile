FROM ubuntu:xenial

# install apt packages
RUN apt update \
    && apt install -y \
        ant \
        git \
        sudo \
        vim \
        curl \
        openjdk-8-jdk \
        subversion

# install ivy 2.5.0, which fixes the https issue to Maven Central
RUN mkdir -p /root/.ant/lib \
    && cd /root/.ant/lib \
    && curl -O https://repo1.maven.org/maven2/org/apache/ivy/ivy/2.5.0/ivy-2.5.0.jar
	
# download and extract Lucene 4.8.1 source
WORKDIR /root
RUN git clone -b releases/lucene-solr/4.8.1 https://github.com/apache/lucene.git lucene
WORKDIR /root/lucene/lucene

# patch files for invalid Java 8 uninitialized field access
RUN sed -i 's/private final IndexInput data/private IndexInput data = null;/g' \
    core/src/java/org/apache/lucene/codecs/lucene42/Lucene42DocValuesProducer.java \
    core/src/java/org/apache/lucene/codecs/lucene45/Lucene45DocValuesProducer.java \
    codecs/src/java/org/apache/lucene/codecs/memory/MemoryDocValuesProducer.java \
    codecs/src/java/org/apache/lucene/codecs/memory/DirectDocValuesProducer.java

# make sure ant can build the code
RUN ant build-modules

# welcome message
RUN echo 'echo -e "Lucene 4.8.1 Dev Environment\nRun \"ant test\" to run unit tests.\nRun \"ant build-modules\" to rebuild all modules."' > /root/.bashrc;

CMD ["/bin/bash"]
