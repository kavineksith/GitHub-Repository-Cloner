# GitHub Repository Cloner

A simple bash script to clone all your GitHub repositories (public and private) in one go.

## Features

- ✅ Clones all public and private repositories
- ✅ Interactive prompts for username and token
- ✅ Secure token input (hidden while typing)
- ✅ Pagination support (handles 100+ repositories)
- ✅ Color-coded output for better readability
- ✅ Progress tracking with repository count
- ✅ Works on Windows Git Bash, Linux, and macOS

## Prerequisites

- Git installed on your system
- GitHub account with repositories
- GitHub Personal Access Token

## Getting Your GitHub Personal Access Token

1. Go to [GitHub Settings → Developer Settings → Personal Access Tokens](https://github.com/settings/tokens)
2. Click **"Generate new token (classic)"**
3. Give it a name (e.g., "Repo Cloner")
4. Select expiration time
5. Check the **`repo`** scope (full control of private repositories)
6. Click **"Generate token"**
7. **Copy the token immediately** (you won't see it again!)

## Installation

1. Download the script:
   ```bash
   wget https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/clone_all_repos.sh
   ```
   
   Or clone this repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
   cd YOUR_REPO
   ```

2. Make the script executable:
   ```bash
   chmod +x clone_all_repos.sh
   ```

## Usage

Run the script:

```bash
bash clone_all_repos.sh
```

Or if you made it executable:

```bash
./clone_all_repos.sh
```

The script will prompt you for:
1. Your GitHub username
2. Your Personal Access Token (input will be hidden)

## Example Output

```
========================================
  GitHub Repository Cloner
========================================

Enter your GitHub username: kavineksith
Enter your GitHub Personal Access Token:
(Your input will be hidden for security)

Starting repository cloning process...

[INFO] Fetching page 1 from GitHub API...
[INFO] Found 15 repositories on page 1

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[CLONING] kavineksith/awesome-project
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Cloning into 'awesome-project'...
✓ Successfully cloned: kavineksith/awesome-project

========================================
✓ Clone process completed!
Total repositories cloned: 15
Location: /path/to/github_repos_kavineksith
========================================
```

## Output Structure

All repositories will be cloned into a directory named:
```
github_repos_<your_username>/
├── repo1/
├── repo2/
├── repo3/
└── ...
```

## Troubleshooting

### SSL Certificate Error
If you encounter SSL certificate errors on Windows, the script automatically handles this by setting `GIT_SSL_NO_VERIFY=1`.

### Authentication Failed
- Verify your Personal Access Token is correct
- Ensure the token has the `repo` scope enabled
- Check if the token hasn't expired

### No Repositories Found
- Confirm your username is spelled correctly
- Verify the token belongs to the correct account
- Check that you have repositories in your account

## Security Notes

⚠️ **Important**: 
- Never commit your Personal Access Token to a repository
- Keep your token secure and private
- Use token expiration for better security
- Revoke tokens you no longer need

## Platform Compatibility

| Platform | Status |
|----------|--------|
| Windows (Git Bash) | ✅ Supported |
| Linux | ✅ Supported |
| macOS | ✅ Supported |
| WSL | ✅ Supported |

## License

This project is open source and available under the MIT License.

## Contributing

Contributions, issues, and feature requests are welcome!

## Author

Created for easy batch cloning of GitHub repositories.

## Changelog

### Version 1.0.0
- Initial release
- Interactive username and token input
- Color-coded output
- Pagination support
- Cross-platform compatibility
