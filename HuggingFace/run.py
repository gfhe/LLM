# 加载模型和tokenizer
from transformers import AutoTokenizer, LlamaForCausalLM

model = LlamaForCausalLM.from_pretrained(MODEL)
tokenizer = AutoTokenizer.from_pretrained(MODEL)

prompt = "Hey, are you consciours? Can you talk to me?"
inputs = tokenizer(prompt, return_tensors="pt")

# Generate
generate_ids = model.generate(inputs.input_ids, max_length=30)
tokenizer.batch_decode(generate_ids, skip_special_tokens=True, clean_up_tokenization_spaces=False)[0]