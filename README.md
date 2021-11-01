# Adding the "common" subtree as your .gitlab folder

```bash
# Add the subtree as a remote
git remote add common git@gitlab.ducoterra.net:services/common.git
git subtree add --prefix .gitlab common main

# Now you can run the following to update
git subtree pull --prefix .gitlab common main
```
