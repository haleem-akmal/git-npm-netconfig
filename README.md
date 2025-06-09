# 🛠️ git-npm-netconfig.bat

A simple batch script to help configure, view, and remove proxy settings for both **Git** and **npm** via an interactive command-line menu.

---

## 📋 Overview

This batch script provides a user-friendly interface for:

- Setting HTTP/HTTPS or SOCKS5 proxies for Git
- Setting HTTP/HTTPS proxies for npm
- Viewing current proxy configurations
- Removing existing proxy settings
- Choosing between **default** or **custom** proxy addresses

---

## ⚙️ Usage

### ✅ Prerequisites

- Windows OS
- [Git](https://git-scm.com/) installed
- [Node.js](https://nodejs.org/) installed (for npm)

### ▶️ Running the Script

- Double-click `git-npm-netconfig.bat`  
  **OR**
- Run it from the **Command Prompt**

Follow the on-screen menu options to apply your configurations.

---

## ✨ Features

### 🔌 Proxy Selection

- **Default Proxy**: `http://127.0.0.1:10808`
- **Custom Proxy**: Any user-specified proxy (e.g., `http://host:port`)

---

### 🧰 Git Proxy Configuration

- Set HTTP/HTTPS proxy
- Set SOCKS5 proxy (automatically converts input to `socks5://`)
- View current Git proxy
- Unset Git proxy

---

### 📦 npm Proxy Configuration

- Set HTTP/HTTPS proxy
- View current npm proxy
- Unset npm proxy

---

## ⚠️ Error Handling

- Validates menu inputs and proxy format
- Prevents empty proxy entries
- Confirms `npm` and `git` availability before proceeding
- Displays success/failure messages for every operation

---

## 🧪 Technical Details

- **Logs**: Errors are saved in `%TEMP%\npm_proxy_error.log`
- **Encoding**: Uses UTF-8 (`chcp 65001`) for proper character display
- **Environment Isolation**: Uses `setlocal` to prevent system-wide changes

---

## 🗂️ Menu Options

| Option | Description                     |
|--------|---------------------------------|
| 1      | Set Git Proxy (HTTP/HTTPS)     |
| 2      | Set Git Proxy (SOCKS5)         |
| 3      | Set npm Proxy                  |
| 4      | Show Git Proxy                 |
| 5      | Show npm Proxy                 |
| 6      | Unset Git Proxy                |
| 7      | Unset npm Proxy                |
| 8      | Exit                           |

---

## ✅ Best Practices

- Always double-check your proxy address
- Use **Show** options to verify configurations
- Use **Unset** before switching proxies
- **Run as Administrator** if you face permission issues

---

## 🛠️ Troubleshooting

- Make sure `npm` and `git` are installed and in your system's `PATH`
- Check `%TEMP%\npm_proxy_error.log` for error messages
- For SOCKS5, verify the proxy server supports it

---

## 💡 Example Usage

```plaintext
1. Run the script
2. Choose [2] to enter custom proxy (e.g., http://company-proxy:8080)
3. Select [1] to set Git proxy
4. Select [3] to set npm proxy
5. Use [4] and [5] to view settings
6. Select [8] to exit
