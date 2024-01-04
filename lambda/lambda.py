import os
value = os.environ["FOO"]

def handler(event,context):
    a=4
    b=5
    sum = a+b
    print(sum)
    print(f"Hello from Lambda, this env value is {value}")