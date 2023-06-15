# 加载模型和tokenizer
from transformers import AutoTokenizer, LlamaForCausalLM
import os 

MODEL = os.environ.get('MODEL_LLAMA', './model')
print(f"try load model @{MODEL}")

model = LlamaForCausalLM.from_pretrained(MODEL)
tokenizer = AutoTokenizer.from_pretrained(MODEL)

prompt = input("[You]: ")

while (prompt != 'q'):
    inputs = tokenizer(prompt, return_tensors="pt")

    # Generate
    generate_ids = model.generate(inputs.input_ids, max_length=30)
    print(f"[Bot]: {tokenizer.batch_decode(generate_ids, skip_special_tokens=True, clean_up_tokenization_spaces=False)[0]}")

    prompt = input("[You]: ")