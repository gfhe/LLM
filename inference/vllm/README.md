
# vllm 推理镜像使用方法
说明：

1. 默认的GPU 内存使用率为0.85，如果想要使用更多，可以通过参数`--gpu-memory-utilization`配置。
2. 默认的工作目录：`\workspace`

## 环境变量
1. `N_GPUS`: GPU个数，对应着张量并行度
2. `GPU_MEM_USAGE`: GPU 内存使用率， 默认会自动占用该比例的GPU内存，在推理时，KVCache 会从里面分配

## 一键启动

```
docker run --gpus all --shm-size=80gb \
-v $PWD/models:/workspace/models \
-p 8000:8000 \
--entrypoint python -m vllm.entrypoints.openai.api_server \
    --model models/llama-7b  \
    --tokenizer models/llama-7b  \
    --tensor-parallel-size 2 \
    --worker-use-ray \
    --host 0.0.0.0 \
    --port 8000
hgfkeep/vllm:latest
```

## 分步启动
启动容器：
```
docker run --rm -it --entrypoint sh --gpus all --shm-size=80gb -p 8000:8000 hgfkeep/vllm:latest
```

启动serving：
```
python -m vllm.entrypoints.openai.api_server \
    --model models/llama-7b  \
    --tokenizer models/llama-7b  \
    --tensor-parallel-size 2 \
    --worker-use-ray \
    --host 0.0.0.0 \
    --port 8000
```

> 接口api key为 `EMPTY`。



## 验证

1. 获取已经serving的模型列表
    ```
    curl http://localhost:8000/v1/models
    ```
2. 推理
    ```
        curl http://localhost:8000/v1/completions \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer EMPTY" \
      -d '{
        "model": "models/llama-7b",
        "prompt": "请介绍下北京",
        "max_tokens": 100,
        "temperature": 0
      }'
    
    
    
    
    curl http://localhost:8000/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer EMPTY" \
    -d '{
      "model": "models/llama-7b",
      "messages": [
        {
          "role": "user",
          "content": "请介绍下自己!"
        }
      ]
    }'
    ```
## 镜像构建注意

1. 如果需要自己编译vllm，那么需要nvidia devel 版本的镜像。因为vllm 底层使用c++开发，编译需要nvcc支持，runtime的镜像没有。
2. 如果不自己编译，那么可以查看 [vllm 的release列表](https://github.com/vllm-project/vllm/releases)。注意release的包名中著明了**cuda的版本**（主流cuda11.8）和**python的版本**（主流python3.11）。

## 参考
1. [openai_api的接口](https://platform.openai.com/docs/api-reference/completions/create)
