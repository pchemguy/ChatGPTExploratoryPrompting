# Linguistic Analysis Results Summary

Reminder: success vs. failure was judged solely based on whether the scope modifier "in the detection of the reactions
of O-containing functional groups" was correctly flagged as unsupported/unsubstantiated regardless of overall status, which was based on other components as well.

Note: letter label conventionally denotes day of running, all series with the same label were executed on the same day
- ChatGPT Plus o3
    - Series A
        - Full context
        - 20 runs (1 run excluded due to accidentally used wrong model, 4o)
        - 17 - passed, 2 - failed
    - Series B
        - Full context
        - 20 runs
        - 16 - passed, 4 - failed
    - Series B
        - Limited context
        - 20 runs
        - 20 - passed, 0 - failed
   Note: Series A - Limited context was not executed
- Gemini Pro 2.5 Pro
    - Series A
        - Limited context
        - 21 runs (1 run considered defective at run time turned out to be ok, hence one extra run)
        - 12 - passed, 9 - failed
        - Note: 3 failures in first 10 runs and 6 failures in the subsequent 11 runs
    - Series A
        - Full context
        - 20 runs
        - 14 - passed, 6 - failed
        - Note: 1 failure in first 10 runs and 5 failures in the subsequent 10 runs
        - Note: conducted soon after completion of limited context Series A 
    - Series B
        - Limited context
        - 40 runs
        - 14 - passed, 26 - failed
    - Series C
        - Limited context
        - 40 runs
        - 21 - passed, 19 - failed
    - Series B
        - Full context
        - 40 runs
        - 34 - passed, 6 - failed
    - Series C
        - Full context
        - 40 runs
        - 35 - passed, 5 - failed
