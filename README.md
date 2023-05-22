# LLM

基于 huggingface 框架，私有化LLM 训练和部署方案

## 离线部署

基础模型： LLaMA
默认的huggingface 离线路径为： `/workspace/.cache/huggingface/hub`
使用huggingface 离线模式，配置： `TRANSFORMERS_OFFLINE=1`

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
2. 运行测试代码：`MODEL_LLAMA=./output python examples/start.py`
    * `MODEL_LLAMA`： 模型名/路径；
