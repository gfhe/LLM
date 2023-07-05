from huggingface_hub import snapshot_download

result = snapshot_download('ziqingyang/chinese-alpaca-lora-7b')
print(result)
result = snapshot_download('ziqingyang/chinese-alpaca-lora-13b')
print(result)
result = snapshot_download('ziqingyang/chinese-alpaca-lora-30b')
print(result)
result = snapshot_download('ziqingyang/chinese-alpaca-lora-65b')
print(result)