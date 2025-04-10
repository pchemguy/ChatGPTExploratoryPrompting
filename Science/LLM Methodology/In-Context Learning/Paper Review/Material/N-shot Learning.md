### N-shot Learning (Learning by Example)

Beyond defining context directly, models can also learn from examples provided within the prompt. One-shot (single example) and few-shot (multiple examples) prompting - collectively known as _N-shot_ learning - involve providing demonstrations of the desired input, output, or input-output relationship.

A key feature is that the _transformation_ process often remains _implicit_ in pure N-shot learning. The model infers the appropriate transformation based on the examples, relying on its underlying training.

N-shot examples can illustrate any aspect: input format, transformation logic, or output style. For instance:
- **Reformatting**: Provide examples pairing paragraphs with their corresponding bulleted lists.
- **Code Style**: Show multiple code examples following specific guidelines, perhaps with brief explanations.    
- **Reverse-engineering**: Offer sample files of serialized objects (e.g., electrical component symbols) for the model to infer a class implementation.

Generally, more diverse and numerous examples improve performance, but the total number is constrained by the model's _context window length_.

---


[Retrieval-Augmented Generation](https://en.wikipedia.org/wiki/Retrieval-augmented_generation) (RAG) represents a set of advanced methods specifically for supplying relevant input context dynamically, often requiring additional tools and API access.


<!-- References -->


