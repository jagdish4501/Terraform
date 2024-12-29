### This repository provisions the same resources as the Terraform script in the `example-1` directory. The difference is that we’ve created an **EC2 module** to avoid rewriting the same code for multiple EC2 instances. This modular approach makes the code more readable, easier to debug, and ensures consistency across the system.