# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ~/.zshrc — merged config with Oh My Zsh and custom settings

# ---------------------------------------------
# Oh My Zsh base setup
# ---------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions you-should-use)

source $ZSH/oh-my-zsh.sh

# ---------------------------------------------
# PATH cleanup: add personal bins if missing
# ---------------------------------------------
if [[ ${path[(i)$HOME/.local/bin]} -gt ${#path} ]]; then
  path=($HOME/.local/bin $HOME/bin $path)
fi

# ---------------------------------------------
# Spark, Java, Hadoop environment
# ---------------------------------------------
export SPARK_HOME=$HOME/usr/local/spark-3.5.5-bin-hadoop3
path=($SPARK_HOME/bin $SPARK_HOME/sbin $path)

export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
export HADOOP_HOME=$SPARK_HOME
path=($HADOOP_HOME/bin $path)

export PYSPARK_PYTHON=python3
export LD_LIBRARY_PATH=$SPARK_HOME/lib/native:$LD_LIBRARY_PATH

# Add kitty to PATH
export PATH="$HOME/.local/kitty.app/bin:$PATH"
export TERMINAL=kitty


export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH


# ---------------------------------------------
# Preferred editors
# ---------------------------------------------
export EDITOR=vi
export VISUAL=vi
export GIT_EDITOR=vi

# ---------------------------------------------
# SDKMAN setup (must be at end)
# ---------------------------------------------
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# ---------------------------------------------
# PostgreSQL tools
# ---------------------------------------------
path+=(/usr/pgsql/bin)

# ---------------------------------------------
# Rust setup
# ---------------------------------------------
[[ -s "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# ---------------------------------------------
# Aliases
# ---------------------------------------------
alias config='code --new-window ~/.config/sway/config'
alias swaylock='swaylock --color 000000'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


# ---------------------------------------------
# Optional: load additional .zshrc.d/* files
# ---------------------------------------------
if [[ -d $HOME/.zshrc.d ]]; then
  for rc in $HOME/.zshrc.d/*(.N); do
    source "$rc"
  done
fi
unset rc

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(zoxide init zsh)"