# inlaze 1 parte DISEÑO INFRAESTRUCTURA


![terraform](https://github.com/user-attachments/assets/6421dbcb-b73b-4cc8-bc1c-cfd75ac25705)




### Este repo contiene archivos terraform para creacion de infraestructura
Aca hacemos el deploy de una infraestructura completa con terraform en aws, todo via cli, en elpdf de
la arquitectura se puede evidenciar otra vpc auxiliar, en la cual tambien se podria habilitar otra instancia de bd
para aun mas disponibilidad, estas bases de datos son seguras, ya q se encuentran dentro de una subnet privada
y solo seria accesible por medio del nodo como tal.

----------------------------------------------------------------------------------------------------------------

# Descripcion archivos

## variables.tf

### contiene las variables que van a ser usadas en el codigo

-----------------------------------------------------------------------------------------------------------------

## terraform.tfvars

### contiene valor variables que van a ser usadas, y que tambien estan relacionadas con variables.tf

------------------------------------------------------------------------------------------------------------------

##  terraform.tfstate  y  terraform.tfstate.backup

### archivos creados directamente por terraform al iniciar codigo

------------------------------------------------------------------------------------------------------------------

## rds.tf

### archvo configuracion de un bd aurora en aws con multizona
Esta base de datos es de alta disponibilidad, multizona, lo que garantiza una replica inmediata x si falla
-------------------------------------------------------------------------------------------------------------------

## providers.tf

###  En Terraform, los "providers" son plugins que permiten a Terraform interactuar con diferentes plataformas,
servicios y APIs. Básicamente, son los que le dan a Terraform la capacidad de crear, modificar y eliminar recursos en 
diferentes entornos.

---------------------------------------------------------------------------------------------------------------------

##  nginx-deployment.yaml

### este es un .yaml que ejecuta un deployment de  servidor nginx en el cluster aws, es una forma de hacerlo manual,
ahora mismo esta haciendo el deploy automaticamente con terraform, el cual baja un docker nginx, tambien se puede hacer
el deploy con el archivo yaml propuesto, de manera manual una vez este el kluster listo
----------------------------------------------------------------------------------------------------------------------

## network.tf

### contiene configuracion de vpc y suredes

----------------------------------------------------------------------------------------------------------------------

## eks.tf

### contiene todo lo relacionado con la configuracion del cluster en aws

-----------------------------------------------------------------------------------------------------------------------

#                                                     MODO USO

## clonar el repositorio, debes tener instalado terraform, tener una cuenta en aws y tenerla configurda en tu cli, verificar 
que tu usuario,tenga todos los permisos necesarios para ejecutar el codigo, y poder manipular recursos creados en aws.

## COMANDOS TERRAFORM

## terraform init

### El comando terraform init es el primer comando que debes ejecutar en un directorio que contiene archivos de configuración 
de Terraform. Esencialmente, prepara tu directorio de trabajo para que puedas usar Terraform para crear, modificar y gestionar
tu infraestructura.

---------------------------------------------------------------------------------------------------------------------------

## terraform fmt

### El comando terraform fmt formatea tu código Terraform para que siga las convenciones de estilo estándar. Esto ayuda a mantener 
la consistencia y la legibilidad en tus archivos de configuración.

-----------------------------------------------------------------------------------------------------------------------------------

## terraform validate

### El comando terraform validate en Terraform se utiliza para verificar la validez de tus archivos de configuración. Realiza una 
serie de comprobaciones para asegurarse de que tu código esté escrito correctamente y sea internamente consistente, sin llegar a 
conectarse a ningún servicio externo o aplicar cambios reales.

------------------------------------------------------------------------------------------------------------------------------------

## terraform plan

### El comando terraform plan en Terraform es esencial para comprender qué cambios se realizarán en tu infraestructura antes de 
aplicarlos realmente. Crea un plan de ejecución que detalla las acciones que Terraform tomará para que tu infraestructura coincida con 
tu configuración 
actual.

----------------------------------------------------------------------------------------------------------------------------------------

## terraform apply

### El comando terraform apply es uno de los comandos más importantes en Terraform. Se utiliza para aplicar los cambios que has definido 
en tu configuración y crear, modificar o eliminar recursos en tu infraestructura.

# inlaze 2  IMPLEMENTAR PIPELINE

# Desafío: Implementación de Argo CD en Minikube

## Descripción del Proyecto
Este repositorio contiene los archivos necesarios para la segunda parte del desafío técnico. En esta etapa, configuramos un servidor **Argo CD** para realizar el despliegue y la sincronización automática de una aplicación utilizando **Minikube**.

Minikube es una herramienta que facilita la ejecución de un clúster local de Kubernetes, ideal para pruebas y desarrollo. En este proyecto, Argo CD fue implementado localmente en Minikube y configurado para sincronizar automáticamente los cambios del repositorio con el clúster.

---

## Archivos Subidos

### `argo.yaml`
Este archivo contiene la configuración principal del servidor de **Argo CD**.
- Define cómo se conecta el servidor Argo CD al repositorio.
- Apunta al archivo de manifiesto del repositorio para realizar despliegues o sincronizar la aplicación.
- Está configurado para la sincronización automática y la eliminación de recursos obsoletos.

### `repomanifiesto.yaml`
Este archivo es el manifiesto que describe los recursos de Kubernetes necesarios para la aplicación, como Pods, Servicios o ConfigMaps.
- Se encuentra dentro del repositorio que se clonó en este proyecto.
- Es utilizado por Argo CD para gestionar y desplegar los recursos en el clúster local de Kubernetes.

### `githubactionfile.yaml`
Este archivo configura un pipeline de **GitHub Actions** que automatiza la sincronización de los cambios en el repositorio con Argo CD.
- Se activa mediante un evento `push` en el repositorio.
- Refleja automáticamente los cambios en el servidor Argo CD, actualizando el clúster local.

## Descripción Breve del Pipeline

Este pipeline está diseñado para automatizar el flujo de trabajo cuando un desarrollador realiza un cambio en el repositorio local en cualquier rama en la que esté trabajando. 

1. **Detección del Cambio**: Un webhook monitorea el repositorio y detecta cualquier cambio en un evento `push`.
2. **Comunicación con Argo CD**: Al notar un cambio, el webhook se comunica automáticamente con el servidor Argo CD.
3. **Sincronización y Despliegue**: Argo CD, gracias a su configuración, utiliza el archivo `argo.yaml` que apunta al manifiesto del repositorio. Esto permite sincronizar los cambios y realizar el despliegue actualizado en el clúster de Kubernetes.

De esta forma, los cambios en el código fuente se reflejan rápidamente en el entorno de despliegue, manteniendo una integración y entrega continua.


