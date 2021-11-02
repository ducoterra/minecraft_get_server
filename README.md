# Adding the "common" subtree as your .gitlab folder

```bash
# Add the subtree as a remote
git subtree add --prefix .gitlab git@gitlab.ducoterra.net:services/common.git main --squash --message "Add Common .gitlab Subtree"

# Now you can run the following to update
make make-update
```
