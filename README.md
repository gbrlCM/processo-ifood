# GitHub Repos - Processo seletivo iFood

![proof](https://github.com/user-attachments/assets/c6c2c2f3-612d-49f7-93da-f4fa195d17ef)


## Como rodar o projeto
Primeiro garanta que tem o XcodeGen instalado no seu Mac, para instruções de como instalar seguir o tutorial desse [link](https://github.com/yonaskolb/XcodeGen?tab=readme-ov-file#installing).

Esse projeto usa Swift 6.0, ou seja é necessário ter o Xcode 16 instalado na máquina.

Com o XcodeGen instalado rode o seguinte comando:
```
xcodegen generate
```

Quando o projeto estiver gerado basta abrir o arquivo e rodar o target `App`

## Dependencias
### Dependencias de Build
 - [XcodeGen:](https://github.com/yonaskolb/XcodeGen)
    Usado para gerar automaticamente o projeto do XCode sem a necessidade do pbxproj ficar guardado no Git reduzindo os conflitos de Git
 - [SwiftGen:](https://github.com/SwiftGen/SwiftGen?tab=readme-ov-file)
    Usado para gerar arquivos de String e Cores para facilitar o uso dos mesmos
    OBS!: Devido a uma limitação do SwiftGen para Swift 6.0 é necessário marcar o `struct Colors` como `Sendable` já que o template atual não faz isso.
### Dependencias do Projeto
 - [SnapKit](https://github.com/SnapKit/SnapKit): Usado para facilitar a descrição de Constraints com ViewCode de forma mais simple
 - [Swinject](https://github.com/Swinject/Swinject): Usado para permitir uma injeção de dependencia entre módulos sem a necessidade de conexão de módulos de implementação
    

## Arquitetura e estrutura
### Arquitetura de Tela

![image](https://github.com/user-attachments/assets/6c56e0e1-05d5-4df4-9fa1-831f8071ef78)

As telas estão organizadas na estrutura VIP (View - Interactor - Presenter) cada um desses elementos tem as seguintes responsabilidades:
- **View**: Descreve o Layout e lida com bindings de ações do usuário com campos de texto, células, botões e etc.
- **Interactor**: Executa as regras de négocio da tela, guarda o estado da tela e se comunica com serviços externos como APIs, DBs entre outros
- **Presenter**: Recebe uma parte do estado enviado pelo `Interactor`, deve adaptá-lo para um modelo de `ViewModel` para que a `View` o consuma e o renderize.

Essa estrutura permite separar bem lógica de négocios (`Interactor`), lógica de exibição (`Presenter`) e componentes visuais (`view`), dessa forma permitindo manter a view apenas com a parte visual e facilitando
a testabilidade dos outros componentes. Cada uma dessas estruturas é separada por protocolos de forma que é muito simples criar `spies` que permitam testar seu comportamento.

### ReducerCore
![image](https://github.com/user-attachments/assets/6f1cf949-b3ef-44c9-83aa-91d682958b0c)
![image](https://github.com/user-attachments/assets/11373916-54dc-49b5-ac0a-231e3be5efc0)

ReducerCore é o módulo criado para criar uma estrutura comum de VIP reativo no APP. O objetivo desse módulo é permitir que as features sejam criadas usando uma estrutura reativa sem nenhum conhecimento de Combine. Usando as classes de `Reducer`, `Presenter` e `StatefulViewController` é possivel emitir uma ação que seja realizada pelo Reducer que
por sua vez irá emitr um novo estado que o Presenter adaptará para uma ViewModel.

Inclusive a `StatefulCollectionViewController` permite que esse padrão seja usada em uma tela que é uma CollectionView com o mesmo padrão reativo.

### Arquitetura de Módulos

![image](https://github.com/user-attachments/assets/658c8f57-de43-4344-b9a7-ed44a83dc8a3)

O Projeto está estruturado em pequenos módulos dentro do mesmo repósitorio (estrutura MonoRepo), cada módulo é um Pacote de [SPM](https://www.swift.org/documentation/package-manager/) linkado localmente via `XcodeGen` e a própria estrutura dos pacotes.

O App depende apenas do módulo de `RouterImplementation` que é responsável por retornar a view correta para determinada rota, esse módulo depende dos módulos das telas e do módulo de interface do `RouterImplementation`, esse módulo existe para que as telas consigam se comunicar com o Router sem depender dele diretamente, através de um módulo que contém apenas protocolos definindo o contrato de acesso ao Router.

As telas não tem nenhuma dependência entre elas, já que a navegação é feita pelo `RouterInterface` e delegado para o módulo de `Router`, e por fim os módulos de Model, DesignSystem e Network são módulos Core com classes reutilizadas pelos outros módulos.

## Pontos a melhorar
- CI/CD com Fastlane
- Testes de Snapshot com [SnapshotTesting](https://github.com/pointfreeco/swift-snapshot-testing) para ViewControllers e Views
- Tokenização de Assets de imagens
