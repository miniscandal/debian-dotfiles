# 🦙 Ollama: Setup Guide (Windows + WSL)

Quick guide to install and configure Ollama so that Windows and your WSL distribution communicate seamlessly.

---

## 1. Installation on Windows

Run the official installation command in your Windows PowerShell:

irm <https://ollama.com/install.ps1> | iex

### Stop previous processes to avoid conflicts in shell powershell

Stop-Process -Name "Ollama" -ErrorAction SilentlyContinue

## 2. Installation in WSL

Run the official script in your Linux terminal (Ubuntu/Debian/etc.):

curl -fsSL <https://ollama.com/install.sh> | sh

### Stop previous processes to avoid conflicts in shell bash

sudo systemctl stop ollama
sudo pkill ollama

---

## 3. WSL Network Configuration

To let WSL know where to find the Windows server, we must point to the Gateway IP. This command dynamically finds your Windows IP and sets it as the host.

### For Bash

echo 'export OLLAMA_HOST=$(ip route show default | awk "{print \$3}"):11434' >> ~/.bashrc
source ~/.bashrc

### For Fish

set -Ux OLLAMA_HOST (ip route show default | awk '{print $3}'):11434

---

## 4. Windows Configuration

We must prepare Windows to "listen" to external requests and allow incoming traffic.

### Environment Variables

Create a new System Environment Variable:

* Name: OLLAMA_HOST
* Value: 0.0.0.0

### Firewall Rule (PowerShell Admin)

Run this in a PowerShell terminal with Administrator privileges to open port 11434:

New-NetFirewallRule -Name "Ollama_Service_WSL_Inbound" `
-DisplayName "Ollama API Service (WSL)" `
    -Description "Allow inbound traffic for Ollama Local LLM Server on Port 11434" `
-Direction Inbound `
    -Protocol TCP `
-LocalPort 11434 `
    -Action Allow

Tip: If you need to remove the rule later:
Remove-NetFirewallRule -DisplayName "Ollama API Service (WSL)"

---

## 5. Start the Server

In Windows Terminal (PowerShell), ensure the variable is active and launch the service:

$env:OLLAMA_HOST="0.0.0.0"
ollama serve

---

## 6. Usage in WSL

You are all set! Now you can download and run models directly from your Linux terminal.

### Example: Run Gemma 3

ollama run gemma3:4b

### 💡 Useful Commands in WSL

| Command               | Description                          |
|-----------------------|--------------------------------------|
| ollama list           | View downloaded models.              |
| ollama pull [name]    | Download a model without running it. |
| ollama rm [name]      | Delete a model to save space.        |
