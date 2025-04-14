import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/todolisticon_icons.dart';

class TodoListField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final IconButton? suffixIconButton;
  final ValueNotifier<bool> isObscureTextValueNotifier;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  // O ValueNotifier é uma classe que notifica os ouvintes quando o valor muda.
  // Ele é usado para gerenciar o estado de forma reativa.
  // Isso significa que, quando o valor muda, os widgets que estão ouvindo essa mudança podem ser atualizados automaticamente.
  // Isso é útil para campos de senha, onde você pode querer alternar entre mostrar e ocultar o texto.
  // O ValueNotifier é uma maneira eficiente de gerenciar o estado em Flutter,
  // especialmente quando você precisa de uma notificação de mudança de estado.
  // O ValueNotifier é uma classe que estende ChangeNotifier, o que significa que ele pode ser usado com o Provider para gerenciar o estado.
  // O ValueNotifier é uma maneira eficiente de gerenciar o estado em Flutter,
  // especialmente quando você precisa de uma notificação de mudança de estado.
  // O ValueNotifier é uma classe que estende ChangeNotifier, o que significa que ele pode ser usado com o Provider para gerenciar o estado.
  // O ValueNotifier é uma classe que notifica os ouvintes quando o valor muda.
  // Ele é usado para gerenciar o estado de forma reativa.

  TodoListField({
    Key? key,
    required this.label,
    this.obscureText = false,
    this.suffixIconButton,
    this.controller,
    this.validator,
    this.focusNode,
  })  : assert(obscureText == true ? suffixIconButton == null : true,
            'obscureText não pode ser enviado em conjunto com o suffixIconButton'),
        isObscureTextValueNotifier = ValueNotifier(obscureText),
        super(key: key);

  // O construtor da classe TodoListField recebe os seguintes parâmetros:
  // - label: O texto que será exibido como rótulo do campo de entrada.
  // - obscureText: Um booleano que indica se o texto deve ser oculto (usado para senhas).
  // - suffixIconButton: Um botão de ícone opcional que pode ser exibido no final do campo de entrada.
  // O construtor também verifica se obscureText e suffixIconButton estão sendo usados juntos, o que não é permitido.
  // Se obscureText for verdadeiro, suffixIconButton deve ser nulo, e vice-versa.
  // O construtor usa assert para garantir que essa condição seja atendida. Se não for, uma exceção será lançada em tempo de execução.
  // Isso ajuda a evitar erros de configuração do widget.
  // O assert é uma verificação de depuração que só é executada em modo de depuração.
  // Em produção, o código dentro do assert é ignorado.
  // Isso significa que o assert não afetará o desempenho do aplicativo em produção.
  // O assert é útil para garantir que os desenvolvedores não cometam erros ao usar o widget.
  // Se obscureText for verdadeiro, o campo de entrada será exibido como um campo de senha, ocultando o texto digitado.

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isObscureTextValueNotifier,
      builder: (_, isObscureTextValue, child) {
        return TextFormField(
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.red),
            ),
            isDense: true,
            suffixIcon: suffixIconButton ??
                (obscureText == true
                    ? IconButton(
                        onPressed: () {
                          isObscureTextValueNotifier.value =
                              !isObscureTextValue;
                          // Alterna o valor de isObscureTextValueNotifier entre verdadeiro e falso
                          // quando o botão de ícone é pressionado.
                          // Isso altera o estado do campo de entrada para mostrar ou ocultar o texto.          
                        },
                        icon: Icon(
                          !isObscureTextValue
                              ? Todolisticon.eye_slash
                              : Todolisticon.eye,
                          size: 15,
                        ),
                      )
                    : null),
          ),
          obscureText: isObscureTextValue,
        );
      },
    );
  }
}
