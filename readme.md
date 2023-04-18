# Checklist

## Создание облачной инфраструктуры
Ожидаемые результаты:

1. Terraform сконфигурирован и создание инфраструктуры посредством Terraform возможно без дополнительных ручных действий.
https://github.com/lozovoya/diplo/blob/main/deploy/tf/main.tf

## Создание Kubernetes кластера

Ожидаемый результат:

Работоспособный Kubernetes кластер.
В файле ~/.kube/config находятся данные для доступа к кластеру. 
Команда kubectl get pods --all-namespaces отрабатывает без ошибок.


доступ к кластеру реализован через ssh
https://github.com/lozovoya/diplo/blob/main/deploy/ansible/setup-cluster.yaml

## Создание тестового приложения

Ожидаемый результат:

Git репозиторий с тестовым приложением и Dockerfile. https://github.com/lozovoya/diplo2/blob/main/main.go
Регистр с собранным docker image. В качестве регистра может быть DockerHub или Yandex Container Registry, созданный также с помощью terraform (использован github registry)


## проект реализован в 2-х репозиториях:
1. инфраструктура (terraform и ansible) https://github.com/lozovoya/diplo
2. приложение написанное на go, выводит html страницу с приветствием https://github.com/lozovoya/diplo2


## Подготовка cистемы мониторинга и деплой приложения

Ожидаемый результат:

Git репозиторий с конфигурационными файлами для настройки Kubernetes. https://github.com/lozovoya/diplo/blob/main/deploy/ansible/playbooks/monitoring/kube-prometheus-stack.yaml
Http доступ к web интерфейсу grafana.
Дашборды в grafana отображающие состояние Kubernetes кластера.
Http доступ к тестовому приложению.

## Установка и настройка CI/CD

Ожидаемый результат:

Интерфейс ci/cd сервиса доступен по http.
При любом коммите в репозиторие с тестовым приложением происходит сборка и отправка в регистр Docker образа. https://github.com/lozovoya/diplo2/blob/main/.github/workflows/diplo-app-develop.yaml
При создании тега (например, v1.0.0) происходит сборка и отправка с соответствующим label в регистр, а также деплой соответствующего Docker образа в кластер Kubernetes. https://github.com/lozovoya/diplo2/blob/main/.github/workflows/diplo-app-main.yaml

# описание деплоя инфраструктуры

для развертывания серверов и сетевой инфраструктуры в яндекс облаке используется terraform, state хранится в облаке. для разделения prod и dev сред используется terraform workspace.

в репозитории настроен workflow отслеживающий изменния инфраструктуры. изменения применяются автоматически, для этого в github actions прокинуты необходимые ключи.

для инсталляции kubernetes используется ansible playbook ansible/setup-cluster.yaml

 playbooks/debian-prepare-server.yaml - общая подготовка серверов
 playbooks/install-nodes.yaml - инстал пакетов
 playbooks/control-plane.yaml - настройка master ноды
 playbooks/node.yaml - настройка worker нод
 playbooks/monitoring/kube-prometheus-stack.yaml - установка и настройка kube-prometheus-stack
 playbooks/deploy.yaml - деплой приложения с помощью helm. оно лежит архивом во второй репе.


# описание деплоя приложения

 использованы 2 ветки: develop и main, ветка main защищена от прямых merge, изменения только через PR.
 github actions настроены на push/merge для develop ветки и на tag для main ветки
 для хранения образов использован github repository

