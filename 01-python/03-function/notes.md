**Functions**
Functions in Python are blocks of reusable code that perform a specific task. They make our code organized, readable, and easier to maintain.
Function Definition
We use  "def" the keyword to define our function

`# Function Definition def hello():`

` print("hello from Prime")`

and to call the function i.e. to run it we write their name with parentheses

`hello() # Function Call`

Function call actually invokes the function & then all the block of code written in the functions definition is executed.

Functions with Parameters
We can also pass data to a function using parameters (inside the parentheses). Values actually passed when calling the function are called arguments.

```
# Fnx to compute sum of 2 nums
def sum(a, b):
print (a + b)
# a & b are parameters
print(sum(5, 10))
# 5 & 10 are arguments
```

wherever fnx → it means function

Functions can return a result using "return" the keyword.

```
# Fnx to computer average of 3 nums
def avg(a, b, c):
return (a + b + c) / 3 print(avg(1, 2, 3))
```

**Default Parameters**
We can assign default values to function parameters so that if the caller doesn’t provide that argument, Python uses the default values. And these default parameters must come last. We cannot have a non-default argument after a default argument.

```
Default Parameters
We can assign default values to function parameters so that if the caller doesn’t provide that argument, Python uses the default values. And these default parameters must come last. We cannot have a non-default argument after a default argument.
```

**Built-in Functions**
All the functions that we have studied till now are user-defined functions, but in Python we also have a lot of built-in functions too. The definition (logic) of built-in functions is already written in Python & we just have to use them.
Some built-in functions that we have already used till now:

print()
input()
type()
range()


**Lambda Functions**
Lambda functions are short, one-liner functions that are used to perform simple tasks. These are created using "**lambda**"  the keyword. These functions are anonymous & do not have a name like regular functions defined with "**def**" .
Lambda function Syntax:

```
lambda arguments: expression
# arguments -> 1 or more parameters
# express ion -> single expression whose result is automatically returned
```

Let’s see an example of a lambda function that computes square of a number

```
# fnx to compute x^2 square = lambda x: x * x print(square(5))
```
