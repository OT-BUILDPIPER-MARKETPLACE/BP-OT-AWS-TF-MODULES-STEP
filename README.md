# BP-OT-AWS-TF-MODULES-STEP
I'll let people to use all the available OpsTree tf module via this step

## Setup
* Clone the code available at [BP-OT-AWS-TF-MODULES-STEP](https://github.com/OT-BUILDPIPER-MARKETPLACE/BP-OT-AWS-TF-MODULES-STEP)
* Build the docker image

```
git submodule init
git submodule update
docker build -t ot/tf-modules-step:0.0.1 .
```


* Do local testing via image only

```
# terraform with default(apply, Elasticache)
docker run -it --rm -v $PWD:/src -e WORKSPACE=/src -e CODEBASE_DIR=/ ot/tf-modules-step:0.0.1

# terraform with plan(Elasticache))
docker run -it --rm -v $PWD:/src  -e INSTRUCTION=plan -e WORKSPACE=/src -e CODEBASE_DIR=/ ot/tf-modules-step:0.0.1

# debug
docker run -it --rm -v $PWD:/src -e WORKSPACE=/src -e CODEBASE_DIR=/ --entrypoint sh ot/tf-modules-step:0.0.1

```