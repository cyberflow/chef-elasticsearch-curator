# Contributing

Before starting your work on this module, you should [fork the project] to your GitHub account. This allows you to
freely experiment with your changes. When your changes are complete, submit a [pull request]. All pull requests will be
reviewed and merged if they suit some general guidelines:

* Changes are located in a topic branch
* For new functionality, proper tests are written
* Changes should not solve certain problems on special environments
* Your change does not handle third party software for which dedicated Puppet modules exist
  * such as creating databases, installing webserver etc.

## Branches
Choosing a proper name for a branch helps us identify its purpose and possibly find an associated bug or feature.
Generally a branch name should include a topic such as `fix` or `feature` or `release` or `travis` followed by a description and an issue number
if applicable. Branches should have only changes relevant to a specific issue.

  ```
  git checkout -b fix-issue-123
  git checkout -b feature-issue-123
  git checkout -b travis-new-update
  git checkout -b release-v0.0.0
  ```
