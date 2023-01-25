
<h1> Atividade Linux PB Compass </h1>

> Projeto realizado por Filipe Gomes, estagiário em Cloud & DevSecOps na Compass UOL.

## Finalidade da Documentação 
Mostrar o passo a passo da atividade proposta.

## Requisitos da atividade

* Criar uma instância EC2 na AWS, com o sistema Amazon linux 2, usando uma instância t3.small, de tamanho 16GB;

* A instância receber um ip elástico, ou seja, um ip fixo para que sempre que reinicializada, o endereço não ser alterado.

* Liberar as portas de comunicação para acesso
público: (22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80
/TCP, 443/TCP).

* Configurar o NFS entregue

* Criar um diretorio dentro do filesystem do NFS com
seu nome;

* Subir um apache no servidor - o apache deve estar
online e rodando;

* Criar um script que valide se o serviço esta online e
envie o resultado da validação para o seu diretorio no
nfs;

* O script deve conter - Data HORA + nome do serviço
+ Status + mensagem personalizada de ONLINE ou
offline;

* O script deve gerar 2 arquivos de saida: 1 para o
serviço online e 1 para o serviço OFFLINE;

* Preparar a execução automatizada do script a cada 5
minutos.

* Fazer o versionamento da atividade;

* Fazer a documentação explicando o processo de
instalação do Linux. 


## Passo a passo na AWS:

1. Após entrar no console AWS com uma conta, a primeira coisa é criar uma instância. Indo no serviço EC2 e selecionando em instâncias e depois clicando em executar instâncias;
2. Na criação da instância, colocar as tags (chave: valor);
3. Escolher a imagem (Sistema operacional) da máquina virtual que será criada. Na atividade foi escolhida a Amazon linux 2;
4. Escolher o tipo da instância. Nesse caso, o tipo de instância varia de acordo com a necessidade do projeto ou atividade. A escolhida foi t3.small;
5. Criar um par de chaves. Elas são importantes para logar na Virtual Machine posteriormente;
6. Selecionar uma VPC, uma subrede e selecionar o grupo de segurança. Os três utilizados foram os padrões, sendo a subnet privada 1A;
7. Em configurar armazenamento, foram utilizados 16GB SSD;
8. Após isso, já pode clicar em executar instância, fazendo com que ela seja criada;
9. Assim que a instância foi criada, o ip elástico pode ser associado àquela instância;
10. Na seção de IPs elásticos, clique em alocar endereço estático e selecione a mesma região da instância;
11. Com o ip elástico alocado, associe esse ip à instância EC2 ao clicar em ações e em Associar endereço IP elástico;
12. Após a associação do ip elástico, é importante criar um gateway de internet e associá-lo à VPC;
13. Vá no serviço de VPC, clique em gateways da internet e aperte em Criar Gateway da Internet;
14. Ao ser criado o gateway da internet, o associe à VPC utilizada;
15. Vá em tabelas de rotas e clique em criar tabela de rotas. Coloque o nome e a qual VPC será associada;
16. Após isso, vá na seção de grupos de segurança;
17. Edite o grupo de segurança utilizado na criação da instância EC2 e coloque as portas de comunicação para acesso público. São elas: 22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80
/TCP, 443/TCP.
18. Após isso, é apreciável que a instância seja reinicializada antes do login via SSH.
19. Para testar se tudo deu certo, abra o prompt de comando e use o comando:

```
	ssh -i ./Downloads/ChaveUtilizadaNaCriacaoEC2.pem ec2-user@ipDaMaquina

```


Passo a passo no terminal do linux:

1. Primeiro, usando o cd /, crie um diretório:

```
	sudo mkdir diretorio
	
```

2. Depois utilize o comando mount para configurar o NFS que foi entregue:

```

	sudo mount -t nfs enderecoNFS://diretorio

```

3. Após isso, crie um diretório dentro do filesystem do NFS 

```
	sudo mkdir diretorioDoNFS

```


4. Com o NFS configurado, podemos ir para o próximo passo: subir um servidor apache. Primeiramente, iremos instalar o apache e iniciá-lo:

```
	sudo yum install httpd

```

``` 
	sudo systemctl start httpd

```

```
	sudo systemctl enable httpd

```

5. Após isso, o próximo passo é o do Script. Crie uma pasta para os scripts:

```
	sudo mkdir script

```

6. Dentro da pasta script crie o arquivo do script:

```
	sudo nano verificadorApache.sh

```

7. Após fazer o script dentro do arquivo, é preciso aplicar permissão de execução no arquivo verificadorApache.sh
```
	sudo chmod +x verificadorApache.sh
```

8. Agora a pasta de logs de execução deve ser criada:
```
	sudo mkdir /diretorio/diretorioDoNFS/
```

```
	sudo chdmod 775 /diretorio/diretorioDoNFS	
	sudo chmod 775 /diretorio/direotorioDoNFS/*

9. Depois o crontab deve ser utilizado para agendar a execução do script:

```
	sudo crontab -e
```

10. Depois coloque o seguinte comando (note que o 5 foi colocado, mas é de acordo com a minutagem desejada): 

```
	*/5 * * * * /etc/verifica_status_mongodb.sh

```

11. Após isso vá no diretório dentro do filesystem do NFS e verifique a cada cinco minutos se o arquivo está sendo gerado com a informação feita no Script.


## Referências:
* https://www.linkedin.com/pulse/script-de-verifica%C3%A7%C3%A3o-status-do-servi%C3%A7o-mongodb-rodolfo-dos-santos/?trk=pulse-article_more-articles_related-content-card&originalSubdomain=pt


## Feito por Filipe Gomes.
