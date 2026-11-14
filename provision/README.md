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
| `tasks/06-dconf.yml` | `dconf load` from `dconf/dconf-settings.ini` |

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

## Migration status

Configs that used to live untracked in `~/.config` are now tracked in the
repo and stowed: **mise** (tool list), **nvim**, **applications** — plus the
rest of `stow_packages`. `fish` is not used on this machine.

Intentionally **not** tracked (managed manually; a new machine won't get
them from this playbook):
- `~/.local/bin` tools (`hermes`, `when`, `pulsemixer`)
- `~/.config/systemd/user` units (`hermes-gateway.service`)
