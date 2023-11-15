# LLM 环境和模型相关

> 镜像压缩方法：`docker-squash -t test   hgfkeep/llm:hf-cuda11.8-torch11.4`

基于 HuggingFace 套件的 私有化 LLM 训练和部署方案。

本工程主要包含如下几个部分：
1. `HuggingFace`：基于HuggingFace套件的通用LLM 训练、开发、运行环境
    - pytorch 1.14.0a0+410ce96
    - cuda 11.8
    - transformers 
    - jupyterlab[dev, 密码：`hgfgood`]
    - sshd [dev, root 密码：`hgfgood`]
    > 注意需要Nvidia drive 版本 > 450.*
1. `inference`：推理环境
    1. [llama.cpp](https://github.com/ggerganov/llama.cpp)：支持模型量化，高效的LLM部署和推理环境。
    1. [lmql](https://lmql.ai): 支持可控输出的推理框架
    1. [vllm](https://github.com/vllm-project/vllm)：支持张量并行的高性能推理框架
1. `get_hf`：HF模型和数据集跨网络搬运
   1. `models.md`:已经支持的模型;
   2. `datasets.md`:已经支持数据集;
   3. `to_get_models.txt`:需要搬运的模型;
   4. `to_get_datasets.txt`:需要搬运的数据集;
1. `pip_offline`: 离线环境的pip simple server
1. `llm-factory`: 大模型训练
   
   > 已搬运模型和数据集通过docker 镜像的形式，分别托管于hgfkeep/models 或hgfkeep/datasets 仓库，tags 为hf repo id的转写形式。
   > 转写规则为：将repo_id 中包含的`/` 转为`--`，例如模型`facebook/opt-125m`转写为`facebook--opt-125m`

## HuggingFace 环境说明

* 默认的huggingface 离线路径为： `/workspace/.cache/huggingface/hub`
* 使用huggingface 离线模式，配置： `TRANSFORMERS_OFFLINE=1`


## 模型

### LLaMA

原生的LLaMA模型参数结构HuggingFace 不支持，需要进行模型转换，代码为 `tools/convert_llama_weights_to_hf.py`
> 也可以基于他人已经转换好的模型，例如 `decapoda-research/llama-7b-hf`（也有其他参数量级模型）

测试部署方案步骤：
1. 转换模型：`python tools/convert_llama_weights_to_hf.py  --input_dir LLaMA --model_size 7B --output_dir output`
    * 转换工具位于tools 文件夹
    *  --input_dir：转换的原始模型位于LLaMA 文件夹， 里面可能包含多个模型量级的模型
    * --model_size：配置转换的模型参数级别
    * --output_dir：转换后模型输出文件夹

    输出类似(时间较长，请耐心等待)：
    ```
    Fetching all parameters from the checkpoint at LLaMA/7B.
    Loading the checkpoint in a Llama model.
    Loading checkpoint shards: 100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 33/33 [00:22<00:00,  1.46it/s]
    Saving in the Transformers format.
    Saving a LlamaTokenizerFast to output.
    ```
2. 运行测试代码：`MODEL_LLAMA=./output python example/start.py`
    * `MODEL_LLAMA`： 模型名/路径；

## 开发环境说明

启动： `docker run -p 18888:8888 hgfkeep/llama:hf_torch_chat_dev jupyter-lab`
默认密码： hgfgood



## HF模型和数据集跨网络搬运

### 搬运思路

1. 利用github action 监测搬运目标：模型(`to_get_models.txt`)；数据集(`to_get_datasets.txt`)
2. 使用github action workflow 自动同步huggingface 模型和数据集，并打包为镜像，上传到dockerhub。

> base是busybox，即可与k8s 集成，直接部署到系统中，也可通过docker cp 将容器中的数据集/模型复制到特定的文件系统中使用。

### 搬运方法

1. 搬运模型：将需要搬运的模型repo_id 写入 `get_hf/to_get_models.txt`（一行一个repo_id），提交代码，等待github action workflow 执行完成，一般 GB级别的 10分钟 左右。
2. 搬运数据集：将需要搬运的模型repo_id 写入 `get_hf/to_get_datasets.txt`（一行一个repo_id），提交代码，等待github action workflow 执行完成，一般 GB级别的 10分钟 左右。
3. workflow 执行成功后，会将repo_id 写入对应的文件
    1. 成功搬运的模型： [`models.md`](./models.md) 
    2. 成功搬运的数据集： [`datasets.md`](./datasets.md) 

### 定制化搬运方法

修改 `get_hf/prepare.sh`。

1. 输入的数据为 `REPO_URL`
2. 环境默认带有 `git huggingface_hub huggingface_cli curl wget`
3. 所有需要保留的数据存储到 `/x` 文件夹，在第二阶段构建镜像时会将此目录下所有数据复制到 `/REPO`

主要的使用场景包括：
1. 部分模型仓库中包含了多种序列化方法的权重，我们只需要选择一种即可，不需要每种都复制下来。
2. 使用命令行工具下载其他数据，甚至不限于huggingface上的数据。

### 获取方法

1. 下载镜像。
   1. 模型仓库`hgfkeep/models`
   2. 数据集仓库`hgfkeep/datasets`
2. 镜像中数据统一存储路径：`/REPO`

### 从镜像中提取模型或数据集

以 `hgfkeep/models:facebook--opt-125m` 为例：
1. 拉取镜像：`docker pull hgfkeep/models:facebook--opt-125m`；
2. 运行容器`docker run --name opt125m --it hgfkeep/models:facebook--opt-125m sh`；
3. 从容器中复制模型或者数据集`docker cp opt125m:/REPO /your_path`
