ZSH=$HOME/.oh-my-zsh
#############
# You can change the theme with another one from https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"
# Useful oh-my-zsh plugins for Le Wagon bootcamps
plugins=(git gitfast last-working-dir common-aliases zsh-syntax-highlighting)# history-substring-search pyenv)
# (macOS-only) Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/docs/Analytics.md
export HOMEBREW_NO_ANALYTICS=1
# Disable warning about insecure completion-dependent directories
ZSH_DISABLE_COMPFIX=true
# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)
# Load rbenv if installed (to manage your Ruby versions)
# export PATH="${HOME}/.rbenv/bin:${PATH}" # Needed for Linux/WSL
# type -a rbenv > /dev/null && eval "$(rbenv init -)"
# Load nvm (to manage your node versions)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# Call `nvm use` automatically in a directory with a `.nvmrc` file
autoload -U add-zsh-hook
load-nvmrc() {
  if nvm -v &> /dev/null; then
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use --silent
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      nvm use default --silent
    fi
  fi
}
type -a nvm > /dev/null && add-zsh-hook chpwd load-nvmrc
type -a nvm > /dev/null && load-nvmrc

# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
# Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export BUNDLER_EDITOR=code

# EDMZ: 20.02.2022 solved brew not found
export PATH="/opt/homebrew/bin:${PATH}"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'; fi

## >>> conda initialize >>>
## !! Contents within this block are managed by 'conda init' !!
conda config --set auto_activate_base false
__conda_setup="$('/Users/edmz/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/edmz/miniforge3/etc/profile.d/conda.sh" ]; then
# . "/Users/edmz/miniforge3/etc/profile.d/conda.sh"  # commented out by conda initialize
    else
        export PATH="/Users/edmz/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
## <<< conda initialize <<<
#export CONDA_DEFAULT_ENV=base
#conda activate $CONDA_DEFAULT_ENV #&& PROMPT=$(echo $PROMPT | sed "s/($CONDA_DEFAULT_ENV) //") && RPROMPT+="[🐍 $CONDA_DEFAULT_ENV]"

export GOOGLE_APPLICATION_CREDENTIALS=/Users/edmz/code/E-Dmz/gcp/le-wagon-bootcamp-328014-999b2fd36725.json

##################################
### CONNECT CONFIGURATION
##################################

export USERNAME_DESKTOP=edmz
export USERNAME_NAS=edmz
export PUBLIC_IP_HOME=90.0.239.50
export PRIVATE_IP_DESKTOP=192.168.1.52
export PRIVATE_IP_NAS=192.168.1.26
export PORT_SSH_DESKTOP=2449
export PORT_SSH_NAS=1224

alias cxnas="ssh ${USERNAME_DESKTOP}@${PUBLIC_IP_HOME} -p${PORT_SSH_NAS}"
alias cxdesktop="ssh ${USERNAME_DESKTOP}@${PUBLIC_IP_HOME} -p${PORT_SSH_DESKTOP}"

alias cxnash="ssh ${USERNAME_DESKTOP}@${PRIVATE_IP_NAS} -p${PORT_SSH_NAS}"
alias cxdesktoph="ssh ${USERNAME_DESKTOP}@${PRIVATE_IP_DESKTOP} -p${PORT_SSH_DESKTOP}"


export PORT_NOTEBOOK=8880
export PORT_LAB=8890
export PORT_API=5000
export PORT_STREAMLIT=8000

alias cxnotebook="ssh ${USERNAME_DESKTOP}@${PUBLIC_IP_HOME} -p${PORT_SSH_DESKTOP} -L ${PORT_NOTEBOOK}:localhost:${PORT_NOTEBOOK}"
alias cxlab="ssh ${USERNAME_DESKTOP}@${PUBLIC_IP_HOME} -p${PORT_SSH_DESKTOP} -L ${PORT_LAB}:localhost:${PORT_LAB}"
alias cxapi="ssh ${USERNAME_DESKTOP}@${PUBLIC_IP_HOME} -p${PORT_SSH_DESKTOP} -L ${PORT_API}:localhost:${PORT_API}"
alias cxstreamlit="ssh ${USERNAME_DESKTOP}@${PUBLIC_IP_HOME} -p${PORT_SSH_DESKTOP} -L ${PORT_STREAMLIT}:localhost:${PORT_STREAMLIT}"

alias cxnotebookh="ssh ${USERNAME_DESKTOP}@${PRIVATE_IP_DESKTOP} -p${PORT_SSH_DESKTOP} -L ${PORT_NOTEBOOK}:localhost:${PORT_NOTEBOOK}"
alias cxlabh="ssh ${USERNAME_DESKTOP}@${PRIVATE_IP_DESKTOP} -p${PORT_SSH_DESKTOP} -L ${PORT_LAB}:localhost:${PORT_LAB}"
alias cxapih="ssh ${USERNAME_DESKTOP}@${PRIVATE_IP_DESKTOP} -p${PORT_SSH_DESKTOP} -L ${PORT_API}:localhost:${PORT_API}"
alias cxstreamlith="ssh ${USERNAME_DESKTOP}@${PRIVATE_IP_DESKTOP} -p${PORT_SSH_DESKTOP} -L ${PORT_STREAMLIT}:localhost:${PORT_STREAMLIT}"


##################################

PATH_DB="Scripts/TwitterSQL/2022-03-25_v3/data/csv/db-v3_scraped-html.csv"
PATH_TARGET="/Users/edmz/code/OFB/OpenFeedback/data/csv_html/$(date +"%Y-%m-%d")_db-v3_scraped-html.csv"

alias cxscpdbh="scp -P ${PORT_SSH_NAS} edmz@${PRIVATE_IP_NAS}:${PATH_DB} ${PATH_TARGET}"
alias cxscpdb="scp -P ${PORT_SSH_NAS} edmz@${PUBLIC_IP_HOME}:${PATH_DB} ${PATH_TARGET}"

###################
#conda

#eval "$(register-python-argcomplete conda)"

# cant get autocomplete... https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/enable-tab-completion.html
# conflict with
alias cenvs="conda info --envs"
alias cact="conda activate"
alias cdeact="conda deactivate"
alias crev="conda list --revisions"
alias ccre="conda create --name"

alias tofb39="cd ~/code/OFB/OpenFeedback && conda activate ofb39 && pyenv local system"
alias tofb39jn="cd ~/code/OFB/OpenFeedback && conda activate ofb39 && pyenv local system && code . && jupyter notebook"
# alias tofbfront="cd ~/code/OFB/DemoFrontOFB && conda activate ofb-front"
# alias tofbapilaunch="cd ~/code/OFB/OpenFeedback && conda activate ofb-api-new && code ."
# alias tofbfrontlaunch="cd ~/code/OFB/DemoFrontOFB && conda activate ofb-front && code . && make streamlit"

# export PATH="$PYENV_ROOT/versions/3.8.12/bin:$PATH"
# export PATH="~/miniforge3/bin:$PATH"

alias pm="python -m"
alias ez="exec zsh"
alias rc="code ~/.zshrc"
alias cl="clear"

alias jn="jupyter notebook"
alias jl="jupyter lab"


# Load pyenv (to manage your Python versions)
conda deactivate

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init --path)"
#eval "$(pyenv init)"

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
type -a pyenv > /dev/null && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)" && RPROMPT+='[🐍 $(pyenv_prompt_info)]'
export PYTHONPATH="/Users/edmz/code/icm/ClearMap2/ClearMap:/Users/edmz/code/icm/ClearMap2:/Users/edmz/code/LeWagon/data-challenges/04-Decision-Science:$PYTHONPATH"
