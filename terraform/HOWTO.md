# Bob's How To

1. First get credentials from [the portal](https://portal.exoscale.com/) under IAM.

2. Second put the credentials in env vars like this:

```bash
$ export TF_VAR_key=<my key>
$ export TF_VAR_secret=<my_secret>
```

3. Now we can use terraform like this:

```bash
$ terraform plan
```

```bash
$ terraform deploy
```
