# Setting Up Dotfiles

1. Navigate to your home directory:
   ```bash
   cd $HOME
   ```

2. Clone your dotfiles repository:
   ```bash
   git clone https://github.com/manangulati9/.dotfiles.git
   ```

3. Install GNU Stow (if not already installed):
   - For Fedora:
     ```bash
     sudo dnf install stow
     ```
   - For Debian/Ubuntu:
     ```bash
     sudo apt-get install stow
     ```

4. Navigate into the `.dotfiles` directory:
   ```bash
   cd .dotfiles
   ```

5. Use Stow to symlink your dotfiles:
   ```bash
   stow .
   ```

This setup will create symbolic links for your dotfiles in your home directory, allowing you to manage them centrally in your `.dotfiles` repository.
