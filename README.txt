 					 __                   __             __             __      __  
					(_  _ _  _ _  _  _   (_  _ _. _ |_  |__)_ _ _  _     _)    /  \ 
					__)(_(_|| |||(_|| )  __)(_| ||_)|_  | \(-(_(_)| )   /__.   \__/ 
								     |                                        
		                                                                              
                             
								Créditos: 
						Cleyton S Santos & Sidkron CyberSecurity

							

							
Antes de tudo, de permissão de execução tanto para o instalador (install.sh) quanto para o script (Recon.sh)								
Cole as variaveis abaixo no .bashrc ou .zshrc dependendo da sua shell

# GoLang
export GOROOT=/home/user/.go
export PATH=$GOROOT/bin:$PATH
export GOPATH=/home/user/go
export PATH=$GOPATH/bin:$PATH

# Golang vars
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH

# Golang vars
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin

								Bot telegram.

Para configurar o bot do telegram, crie um bot com o BotFather do telegram, copie a API KEY; Invoque o bot e envie uma mensagem no chat.
Após isso, cole a API KEY nesse link https://api.telegram.org/bot(API_KEY)/getUpdates
Remova o (API_KEY), deixe o /bot e cole a api ali.
Após, localize no JSON da api o parâmetro ' from":{"id" ' e copie o ID, vai ser parecido com esse 885305895
Inicie a instalação e cole a API Key e o Chat ID e o bot estará configurado.

Se preferir, mova o script para a /usr/bin/ para não precisar entrar na pasta sempre que for executar o script.

comando: 

mv Recon.sh /usr/bin/
