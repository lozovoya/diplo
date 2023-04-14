## проект реализован в 2-х репозиториях:
1. инфраструктура (terraform и ansible) https://github.com/lozovoya/diplo
2. приложение написанное на go, выводит html страницу с приветствием https://github.com/lozovoya/diplo2


## описание деплоя инфраструктуры

для развертывания серверов и сетевой инфраструктуры в яндекс облаке используется terraform, state хранится в облаке. для разделения prod и dev сред используется terraform workspace.

в репозитории настроен workflow отслеживающий изменния инфраструктуры. изменения применяются автоматически, для этого в github actions прокинуты необходимые ключи.

для инсталляции kubernetes используется ansible playbook ansible/setup-cluster.yaml

 playbooks/debian-prepare-server.yaml - общая подготовка серверов
 
 playbooks/install-nodes.yaml - инстал пакетов
 
 playbooks/control-plane.yaml - настройка master ноды
 
 playbooks/node.yaml - настройка worker нод
 
 playbooks/monitoring/kube-prometheus-stack.yaml - установка и настройка kube-prometheus-stack
 
 playbooks/deploy.yaml - деплой приложения с помощью helm. оно лежит архивом во второй репе.


## описание деплоя приложения

 использованы 2 ветки: develop и main, ветка main защищена от прямых merge, изменения только через PR.
 github actions настроены на push/merge для develop ветки и на tag для main ветки
 для хранения образов использован github repository

