# Provision

Ansible playbook that rebuilds this machine's system state from the dotfiles
repo. Configs are synced by **git + stow symlinks**; this playbook only handles
**system state**: repositories, packages, mise tools, symlinks, services,
dconf.

**You never maintain scripts here.** Everything you'd ever change lives in
`group_vars/all.yml` — one line per COPR, one word per package.

---

## Fresh machine (the payoff)

```bash
sudo dnf install -y ansible git
git clone git@github.com:MAHcodes/dotfiles.git ~/dotfiles
cd ~/dotfiles/provision
ansible-playbook playbook.yml -K     # -K asks for the sudo password
reboot
```

One command does: RPM Fusion → COPRs → docker repo → all packages
(NVIDIA, docker, dms, dux-*, niri, ghostty...) → mise + tools → stow
symlinks → docker group → dconf. Log in, launch niri.

## This machine

Safe to run anytime — everything is idempotent:

```bash
cd ~/dotfiles/provision
ansible-playbook playbook.yml -K --check --diff   # preview only
ansible-playbook playbook.yml -K                  # apply
```

## Structure

| File | Purpose |
|---|---|
| `playbook.yml` | entry point — system play (root) then user play |
| `group_vars/all.yml` | **THE file you edit** — COPRs, packages, stow list |
| `inventory.ini` | localhost |
| `ansible.cfg` | points ansible at the inventory |
| `tasks/01-repos.yml` | RPM Fusion, docker-ce repo, COPRs |
| `tasks/02-packages.yml` | dnf install from the list (one transaction) |
| `tasks/03-post-system.yml` | docker group + service, login shell |
| `tasks/04-mise.yml` | install mise + `mise install` |
| `tasks/05-stow.yml` | `stow` each package into `$HOME` |
| `tasks/06-systemd-user.yml` | enable user units (guarded) |
| `tasks/07-dconf.yml` | `dconf load` from `dconf/dconf-settings.ini` |

## Day-to-day scenarios

| Situation | Action |
|---|---|
| Change any config | edit file in repo + `git commit` (symlink is live) |
| Keep a new RPM app | `sudo dnf install X` → add `X` to `packages:` → commit |
| Keep a new COPR app | `dnf copr enable a/b && dnf install X` → add both to vars → commit |
| New dev tool | `mise use -g X` → commit (after mise config is tracked) |
| Remove an app | `sudo dnf remove X` → delete its line from vars → commit |
| Repair / pull on long-lived machine | re-run the playbook (skips what's fine) |
| Preview changes | `--check --diff` |

Note: the playbook guarantees **presence** — it never removes packages, so a
typo in the list can't delete anything. A package name missing from repos
fails the run with a clear message; fix the list and re-run.

## Migration TODO (not done yet, by design — nothing outside this dir changed)

These are configs living in `~/.config` but not yet tracked in the repo.
Until migrated, they're **not** restored on a new machine:

1. **mise tool list** — `~/.config/mise` is a real dir, not tracked:
   ```bash
   mkdir -p ~/dotfiles/mise/.config
   mv ~/.config/mise ~/dotfiles/mise/.config/mise
   stow -d ~/dotfiles -t ~ mise
   ```
   Then uncomment `mise` in `stow_packages:`.
2. **fish** — same pattern as above; uncomment `fish` in `stow_packages:`.
3. **nvim** — `lua/` and `colors/` live outside the repo (drift risk):
   ```bash
   cp -r ~/.config/nvim/lua ~/dotfiles/nvim/.config/nvim/
   cp -r ~/.config/nvim/colors ~/dotfiles/nvim/.config/nvim/
   rm -rf ~/.config/nvim && stow -d ~/dotfiles -t ~ nvim
   ```
4. **applications** — `~/.local/share/applications` has real copies of the
   synced `.desktop` files; stow would conflict. Fix with
   `stow --adopt -d ~/dotfiles -t ~ applications` (adopts live files into the
   repo, diff + commit them) and uncomment it.
5. **`bin/`** — `hermes`, `when`, `pulsemixer` in `~/.local/bin` are not
   tracked. Create a `bin/.local/bin/` package in the repo, move them in,
   stow, uncomment `bin`.
6. **`systemd/`** — `hermes-gateway.service` is not in the repo. Create
   `systemd/.config/systemd/user/` in the repo, move it in, stow, uncomment.
   (Task `06-systemd-user.yml` enables it automatically once present.)
