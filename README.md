# Lucene 4.8.1 Dev Environment

This Dockerfile will give you a basic Ubuntu-based dev environment for building Apache Lucene 4.8.1
and running the unit tests. When running in the shell, you can feel free to modify things as you please.

Created by the Apache Lucene.NET team to give us a quick and easy container to test out code changes.
This is not an official project of the Apache Software Foundation and is intended for internal contributor use only.
The base image and installed dependencies may have vulnerabilities due to their age; use at your own risk.

## Running

```bash
./start.sh
```

This Bash script will build the Docker image and run it, dropping you into a Bash shell in the container.

It will have already built the modules with Apache Ant, but if you want to build them again, just run:

```bash
ant build-modules
```

You can also run all unit tests with:

```bash
ant test
```
