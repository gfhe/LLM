
## 镜像

* hgfkeep/llm:hf-cuda11.8-torch11.4：基于huggingface transformers的基础镜像
    * torch="1.14.0a0+410ce96"
    * cuda="11.8.89"
    * nvidia_driver="520.61.05"
    * base_env_instruction="https://docs.nvidia.com/deeplearning/frameworks/pytorch-release-notes/rel-22-12.html#rel-22-12"
* hgfkeep/llm:hf-cuda11.8-torch11.4-dev： 开发环境镜像
    * jupyter-lab 端口8888
    * ssh 端口22

> 说明： 如果物理机的cuda 版本低于11.8，需要安装 **cuda11.8 的驱动** 才能正常使用`bitsandbytes`，即使torch.cuda.is_available() 为True。

## 使用
开发环境运行： 
```
docker run -d \
           --gpus all \
           -p 122:22 -p 8888:8888 \
           -v $PWD:/workspace/code \
           hgfkeep/llm:hf-cuda11.8-torch11.4-dev
```

* ssh 登录：`ssh root@127.0.0.1 -p 122`
* 启动jupyter-lab: `jupyter-lab`
* 使用浏览器访问jupyter： `http://127.0.0.1:8888` 密码`hgfgood`
