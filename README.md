# Repositorio plantilla para la creación de nuevos módulos de Terraform
Este repositorio tiene como finalidad, guiar en el proceso de creación de un nuevo módulo de Terraform, brindando indicaciones así como la estructura de archivos y carpetas que se deben contener para una correcta conexión y funcionalidad.

## Uso e instalación
Para la instalación deberá conectarse el repositorio con el registro privado de la organización de Terraform Cloud. Para ello deberá tenerse las siguientes consideraciones:
* Usar esta plantilla para la estructura de archivos
  * El repositorio en si mismo es el módulo.
  * En caso emplee submódulos, estos ebdeberán cargarse en la carpeta submodules y cada uno contará con sus respectivos ejemplos.
* Eliminar toda la información de guía desde la línea separadora hacia arriba, lo podrá identificar con el comentario "INICIO DE PLANTILLA DE DOCUMENTACIÓN" en el contenido del archivo Markdown.
* El repositorio deberá tener la siguiente estructura en el nombre:
  * terraform-_proveedor_-_nombre que se le dará al módulo sin guiones_
* Para que sea funcional, deberá generar un nuevo _release_ usando _tags_ en Github
  * Use [versiones de tipo semántica](https://semver.org/), por ejemplo: v1.0.0
  * Para ello, ir a la página de _releases_ del repositorio ubicado en "/releases/new" y crear un nuevo _tag_
    * Para nuevas versiones, siga la secuencia lógica de las versiones, por ejemplo: v1.0.0 > v1.0.1
    * En el campo de título, el nombre del tag, por ejemplo: v1.0.0
    * En el campo de descripción, indique los detalles de la nueva versión y los cambios efectuados.

<!-- INICIO DE PLANTILLA DE DOCUMENTACIÓN -->

# _Insertar el nombre del módulo_
Agregar breve descripción del módulo y los recursos que creará.

## Usage

```hcl
Agregar el uso del módulo
```

## Examples

- [Ejemplo 01](https://github.com/orion-global/terraform-module-template/tree/prod/examples/example-001): Este es un primer ejemplo

## Requirements

| Name      | Version  |
| --------- | -------- |
| terraform | >= X.X.X |

## Providers

| Name | Version  |
| ---- | -------- |
| aws  | >= X.X.X |

## Modules

| Name   | Source                           | Version |
| ------ | -------------------------------- | ------- |
| modulo | ./modules/eks-managed-node-group | n/a     |

## License

MIT Licensed. See [LICENSE](https://github.com/orion-global/terraform-module-template/tree/prod/LICENSE) for full details.