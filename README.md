# Jenkins

> ℹ️ current implementation is only tested on linux

## Setup

> make sure that you have [terraform](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#id2) and [ansible](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#id2) installed locally

To Start with terraform or if you want to interact with terraform manually, first setup your environment

- rename aws_setup.sh.example => aws_setup.sh

- put your env variables in aws_setup.sh

- then source that file

```bash
source ./setup.sh
```

> ℹ️ Every time when the terminal is closed
> you should repeat this step

- To initialize everything with one command

```bash
bash init.sh
```
