import 'package:ami_projecto/models/modelprincipal.dart';
import 'package:ami_projecto/pages/detalhesauxiliar.dart';
import 'package:flutter/material.dart';

class Auxiliarlist extends StatelessWidget {
  final List<ModelPrincipal> items;

  Auxiliarlist({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero, // Remove padding extra
      shrinkWrap: true, // Permite o widget adaptar o tamanho
      physics: NeverScrollableScrollPhysics(), // Evita conflitos de scroll
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: Image.network(
            item.imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: Icon(Icons.broken_image, color: Colors.grey[700]),
              );
            },
          ),
          title: Text(
            item.Titulo,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Text(
            item.Descricao,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetalhesAuxiliar(item: item),
              ),
            );
          },
        );
      },
    );
  }
}
