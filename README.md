# hospitalplanner-inf
Repository to host infrastructure for hospitalplanner

# Instructions to deploy

1. Install terraform from https://www.terraform.io/.

2. Go in your terminal to the root of the repo and run

```bash
terraform init
```

3. Set up credentials file. In the root of the repo, create a credentials.env with the following structure:

```
export TF_VAR_AWS_ACCESS_KEY=XXXX
export TF_VAR_AWS_SECRET_KEY=YYYYYYYYY
export TF_VAR_SUPABASE_ANON_KEY=ZZZZZZZZZZZZZ
```

and source it:

```bash
source credentials.env
```

4. Run terraform plan to debug and see the effect of your plan in the cloud, with respect to previous state:

```bash
terraform plan
```

**WARNING:** Watch out to apply changes because they do deploy the defined infrastructure on the cloud.