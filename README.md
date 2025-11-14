# My GitHub Codespaces Desktop Setup 🖥️

This is my personal setup for having a full desktop environment (GUI) in GitHub Codespaces or any dev container. Perfect for when you need more than just a terminal and want to run GUI applications in the cloud!

## ✨ What's Inside

- **XFCE Desktop**: Lightweight and snappy desktop environment
- **Browser Access**: Access your desktop through any web browser using noVNC
- **Ready-to-Code**: Comes with Java 17, Python 3, Git, and other dev essentials
- **VS Code Friendly**: Works seamlessly with VS Code dev containers
- **One-Click Access**: Just open port 6080 in your browser and you're good to go!

## 🚀 Getting Started

### What You'll Need

- VS Code with the Dev Containers extension
- Docker (if running locally)
- That's it! 🎉

### How to Use This

1. **Fork or clone this repo:**
   ```bash
   git clone <your-repo-url>
   cd <repo-name>
   ```

2. **Open in VS Code:**
   ```bash
   code .
   ```

3. **Launch the container:**
   - Hit `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
   - Type "Dev Containers: Reopen in Container"
   - Wait for the magic to happen ✨

4. **Access your desktop:**
   - Check the "Ports" tab in VS Code
   - Find port 6080 and click "Open in Browser"
   - Boom! You've got a desktop in your browser 🎯

## 🏗️ How It Works

### The Stack

- **Base Image**: Ubuntu 24.04 with dev container goodness
- **Desktop**: XFCE4 desktop environment (because it's fast and doesn't eat RAM)
- **VNC Server**: x11vnc to share the desktop
- **Web Magic**: noVNC + websockify so you can access it from your browser
- **Virtual Display**: Xvfb creates a virtual screen (no physical monitor needed!)

### Ports & Services

| Port | What's Running | Why You Care |
|------|----------------|--------------|
| 6080 | noVNC Web Interface | This is your desktop in the browser! |
| 5900 | VNC Server | The behind-the-scenes VNC magic |

## 📁 What's in Here

```
.
├── .devcontainer/
│   ├── devcontainer.json    # Dev container configuration
│   ├── Dockerfile          # The recipe for our container
│   └── novnc-index.html    # Custom noVNC landing page
├── scripts/
│   └── start.sh           # Script that starts all the desktop services
└── README.md              # This file you're reading!
```

## ⚙️ Configuration Details

### Dev Container Setup

- **Container Name**: XFCE Desktop (noVNC) 
- **Port Forwarding**: 6080 (your browser desktop access)
- **User**: vscode (because we're fancy like that)
- **Auto-start**: Desktop services fire up automatically when container starts
- **Permissions**: Scripts get execute permissions during setup

### What's Pre-installed

- **Desktop Stuff**: xfce4, xfce4-terminal, dbus-x11 (the desktop essentials)
- **VNC Magic**: x11vnc, xvfb (the screen sharing wizardry)
- **Dev Tools**: git, Java 17, Python 3 with pip & venv (ready to code!)
- **Utilities**: wget, curl, unzip, ca-certificates (the usual suspects)
- **Web VNC**: websockify, noVNC (browser desktop goodness)

## 🔧 Making It Yours

### Adding More Software

Want to install something? Just edit `.devcontainer/Dockerfile`:

```dockerfile
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    your-favorite-package \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
```

### Changing Screen Resolution

Edit `scripts/start.sh` and find the Xvfb line:

```bash
Xvfb :99 -screen 0 1920x1080x24 >/tmp/xvfb.log 2>&1 &
```

Replace `1920x1080x24` with whatever resolution makes you happy!

### Adding VS Code Extensions

Drop them into `devcontainer.json`:

```json
"customizations": {
  "vscode": {
    "extensions": [
      "ms-vscode.remote-repositories",
      "your-awesome-extension-id"
    ]
  }
}
```

## 🐛 When Things Go Wrong

### Desktop Won't Load
- Double-check that port 6080 is forwarded properly
- Check the logs in `/tmp/` for clues:
  ```bash
  tail -f /tmp/start.log
  tail -f /tmp/xvfb.log
  tail -f /tmp/x11vnc.log
  tail -f /tmp/websockify.log
  ```

### Performance Issues
- Close apps you're not using on the desktop
- Try lowering the screen resolution if things feel sluggish
- Make sure Docker has enough RAM allocated

### Connection Troubles
- Check your firewall and network settings
- Verify the container is actually running
- When in doubt, restart the dev container 🔄

## 📝 Technical Notes

### Environment Variables

- `DISPLAY=:99` - The X11 display number (where the magic happens)
- `WORKSPACE_DIR` - Your current working directory

### Log Files (for debugging)

All service logs live in `/tmp/`:
- `/tmp/start.log` - Main startup script
- `/tmp/xvfb.log` - Virtual display server
- `/tmp/xfce4.log` - Desktop environment
- `/tmp/x11vnc.log` - VNC server
- `/tmp/websockify.log` - Web proxy

## 🤝 Want to Contribute?

Feel free to make this setup even better:

1. Fork this repo
2. Create a feature branch (`git checkout -b feature/cool-new-thing`)
3. Make your changes
4. Push to your branch (`git push origin feature/cool-new-thing`)
5. Open a Pull Request

## 📄 License

Feel free to use this however you want! Add a license if you need one.

## 🙏 Shoutouts

Big thanks to these awesome projects that make this possible:
- [Microsoft Dev Containers](https://containers.dev/) - The container dev environment magic
- [noVNC](https://github.com/novnc/noVNC) - HTML5 VNC client awesomeness
- [XFCE](https://xfce.org/) - Lightweight desktop that doesn't hog resources
- [x11vnc](https://github.com/LibVNC/x11vnc) - The VNC server that makes it all work