## [1.0.1] - 2025-07-21

- Fix namespacing bug

## [1.0.0] - 2025-07-09

- Add .default_llm_model

## [0.0.14] - 2025-07-05

- o1 models don't support temperature so force it to 1

## [0.0.13] - 2025-06-27

- Add GenerateChatCompletion command

## [0.0.12] - 2025-05-27

- Do not load service models in parallel due to undiagnosed race condition somewhere

## [0.0.11] - 2025-03-06

- Fix bug that broke ListModels
- Change default model to Claude 3.7

## [0.0.10] - 2025-03-05

- Do not require all 3 services to function. Let user require which services they want to use.

## [0.0.4] - 2025-03-04

- Add an instructions input that translates to a system prompt

## [0.0.2] - 2025-03-03

- Release as a gem

## [0.0.0] - 2025-02-16

- Project birth
