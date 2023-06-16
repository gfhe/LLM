# LLM

基于 HuggingFace 套件的 私有化 LLM 训练和部署方案。

本工程主要包含如下几个部分：
1. `HuggingFace`：基于HuggingFace套件的通用LLM 训练、开发、运行环境
    - pytorch 1.14.0a0+410ce96
    - cuda 11.8
    - transformers 
    - jupyterlab[dev, 密码：`hgfgood`]
    > 注意需要Nvidia drive 版本 > 450.*
2. `model`：特定大模型的训练、开发、运行环境（不包含模型，仅包含代码）
    1. `LLaMA`： 原始LLaMA的相关代码和脚本
        0. 原始LLaMA模型下载脚本
        1. 权重结构转换脚本
        2. 模型运行例子
3. `inference`：推理环境
    1. huggingface：HuggingFace 原生的推理，用于简单测试。
    2. llama.cpp：支持模型量化，高效的LLM部署和推理环境。
    3. privateGPT：

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