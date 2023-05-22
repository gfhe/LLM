# 加载模型和tokenizer
from transformers import AutoTokenizer, LlamaForCausalLM
import os 
import torch

MODEL = os.environ.get('MODEL_LLAMA', './model')
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(f"try load model @{MODEL}, device={device}")

model = LlamaForCausalLM.from_pretrained(MODEL)
tokenizer = AutoTokenizer.from_pretrained(MODEL)
model.to(device)
tokenizer.to(device)

prompt = input("[You]: ")

while (prompt != 'q'):
    inputs = tokenizer(prompt, return_tensors="pt")
    inputs.to(device)

    # Generate
    generate_ids = model.generate(inputs.input_ids, max_length=30)
    print(f"[Bot]: {tokenizer.batch_decode(generate_ids, skip_special_tokens=True, clean_up_tokenization_spaces=False)[0]}")

    prompt = input("[You]: ")