import 'package:ami_projecto/models/modelsobre.dart';
import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  final ModelSobre sobre;

  SobrePage({required this.sobre});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          // Exibição das informações
          SectionWidget(
            titulo: "História",
            conteudo: sobre.historia,
            icon: Icons.history,
          ),
          const SizedBox(height: 16),
          SectionWidget(
            titulo: "Fundador(es)",
            conteudo: sobre.fundadores,
            icon: Icons.people,
          ),
          const SizedBox(height: 16),
          SectionWidget(
            titulo: "Data de Fundação",
            conteudo:
                "${sobre.dataFundacao.day}/${sobre.dataFundacao.month}/${sobre.dataFundacao.year}",
            icon: Icons.calendar_today,
          ),
          const SizedBox(height: 16),
          SectionWidget(
            titulo: "Missão",
            conteudo: sobre.missao,
            icon: Icons.lightbulb,
          ),
        ],
      ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String titulo;
  final String conteudo;
  final IconData icon;

  const SectionWidget({
    required this.titulo,
    required this.conteudo,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  conteudo,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
