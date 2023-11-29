[Back to Main Page](../../README.md)

# Contents

1. [Setting up the repository ](#setting-up-the-repository)
2. [Add the original repository as a remote repository](#add-the-original-repository-as-a-remote-repository)
3. [Choose the branch to use](#choose-the-branch-to-use)
4. [Create the branch for changes](#create-the-branch-for-changes)
5. [Verify the current branch is valid](#verify-the-current-branch-is-valid)
5. [Make the changes needed](#make-the-changes-needed)
6. [Create a pull request](#create-a-pull-request)

## How to contribute to this repository

### Setting up the repository

1. Navigate to the repository's page on GitHub.
2. Click on the "Fork" button in the top-right corner of the repository page. This will create a personal copy (fork) of the repository under your GitHub account. (if develop exists, make sure you include all repositories).
3. Once the fork is created, navigate to your forked repository on GitHub.
4. Click on the "Code" button to get the repository's URL.
5. Open a terminal or command prompt on your local machine.
6. Clone the forked repository to your local machine using the following command:
    ```
        git clone <repository-url>
    ```

    Replace <repository-url> with the URL of your forked repository.
7. Change into the cloned repository's directory:
    ```
        cd <repository-directory>
    ```
    
    Replace <repository-directory> with the name of the cloned repository's directory.

### Add the original repository as a remote repository

8. Verify the current remotes configured for your repository by running the following command:
    ```
        git remote -v
    ```

    This will display the existing remotes, if any.

    if the upstream exists, go to the next section, this will look like this:
    ```
        origin  git@github.com:your_repo/survey_kit.git (fetch)
        origin  git@github.com:your_repo/survey_kit.git (push)
        upstream  git@github.com:QuickBirdEng/survey_kit.git (fetch)
        upstream  git@github.com:QuickBirdEng/survey_kit.git (push)
    ```
9. Add the original repository as a remote named "upstream" using the following command:
    ```
        git remote add upstream <original-repository-url>
    ```

    Replace <original-repository-url> with the URL of the original repository you want to add as a remote.
10.  Verify that the new remote has been added successfully by running the git remote -v command again. You should see the "upstream" remote listed along with its URL.
11. You have now added the original repository as a remote called "upstream" in your cloned repository. This allows you to fetch updates from the original repository and keep your forked repository in sync.

### Choose the branch to use

If the repository has a develop branch in it, you should branch out of there. 

12. Verify the available branches in your repository by running the following command:
    ```
        git branch -a
    ```

    This will display a list of both local and remote branches.
    ```
        main
        remotes/origin/HEAD -> origin/main
        remotes/origin/develop
        remotes/origin/feature-provider-stmt
        remotes/origin/feature/-navigator-transition-1
        remotes/origin/feature/keep-state
        remotes/origin/feature/navigator-transition
        remotes/origin/feature/progress-bar
        remotes/origin/fix/support-native-back-button
        remotes/origin/main
        remotes/origin/release
        remotes/upstream/develop
    ```
13. Fetch the latest updates from the upstream repository by running the following command:
    ```
        git fetch upstream
    ```

    This will fetch the latest changes from the upstream repository.
14. Switch to the upstream/develop branch by running the following command:
    ```
        git checkout upstream/develop
    ```

    This will switch your local repository to the upstream/develop branch.
15.  Verify that you have successfully switched to the upstream/develop branch by running the git branch command. 
    ```
        git checkout upstream/develop
    ```
    The current branch should be displayed as upstream/develop.

You have now switched to the upstream/develop branch in your local repository. You can now make changes or perform any necessary actions on this branch.

### Create the branch for changes

16. Create a new branch based on the upstream/develop branch using the following command:
    ```
        git checkout -b <branch-name>
    ```
    This will create a new branch named <branch-name> and switch to it.

17. Verify that you have successfully created and switched to the new branch by running the git branch command again. 
    ```
        git branch
    ```

    The new branch (documentation-updates) should be listed with an asterisk (*) next to it.
    ```
          develop
        * documentation-updates
          feature-provider-stmt
          main
    ```

### Verify the current branch is valid

18. Install the required dependancies with the command
    ```
        flutter pub get
    ```

19. Run the build runner to create the part of the json files with the following command
    ```
        dart run build_runner build
    ```

20. Validate that the tests are working by running the command
    ```
        flutter test
    ```

### Make the changes needed

21. Make the desired changes to the code using your preferred code editor or IDE.

For information on how the code is created view [Information on the code base](../code-base/information-on-code-base.md).

For coding standards [Coding Standards](../code-base/coding-standards.md)

22. Make sure that your tests compile
    ```
        flutter test
    ```

23. After making the changes, stage the modified files for commit using the following command:
    ```
        git add .
    ```

    This will stage all the changes in the repository.

24. Commit the changes with a descriptive commit message using the following command:
    ```
        git commit -m "Your commit message"
    ```

    Replace "Your commit message" with a brief and meaningful description of the changes you made.

25. Push the changes to your forked repository on GitHub using the following command:
    ```
        git push origin <branch-name>
    ```

### Create a pull request

26. Once the changes are pushed to your forked repository, navigate to your forked repository's page on GitHub.
27. Click on the "Pull Request" button to create a new pull request.
28. Review the changes you made and provide a descriptive title and comment for the pull request.
29. Click on the "Create Pull Request" button to submit the pull request to the upstream repository.
30. Wait for the repository maintainers to review your changes. They may provide feedback or request further modifications.
31. Make any necessary updates to your branch based on the feedback received.
32. Repeat steps 22 to 25 to push the updated changes and create a new pull request.
33. Once the pull request is approved, the maintainers will merge your changes into the upstream repository.

By following these steps, you can fork a repository, make changes, and create a pull request to contribute your changes back to the original repository on GitHub.

[Back To Top](#contents)
