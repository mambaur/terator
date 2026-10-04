import 'package:flutter/material.dart';
import 'package:terator/core/styles.dart';
import 'package:terator/data/kop_surat_designs.dart';
import 'package:terator/models/kop_surat_model.dart';
import 'package:terator/persentations/kop_surat/widgets/kop_design_preview.dart';
import 'package:terator/repositories/kop_surat_repository.dart';
import 'package:terator/utils/custom_snackbar.dart';

/// Picks the default kop design. Previews use [kop] (including unsaved edits
/// from `KopSuratScreen`); only the chosen design id is persisted here.
/// Pops with the selected design id.
class KopDesignScreen extends StatefulWidget {
  final KopSuratModel kop;
  const KopDesignScreen({super.key, required this.kop});

  @override
  State<KopDesignScreen> createState() => _KopDesignScreenState();
}

class _KopDesignScreenState extends State<KopDesignScreen> {
  final KopSuratRepository _kopRepo = KopSuratRepository();
  late String _designId = KopSuratDesigns.byId(widget.kop.designId).id;

  Future<void> _save() async {
    final saved = await _kopRepo.get();
    await _kopRepo.save(saved.copyWith(designId: _designId));
    if (!mounted) return;
    CustomSnackbar.show(context,
        type: SnackbarType.success, message: 'Desain kop surat disimpan');
    Navigator.pop(context, _designId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSurface,
      appBar: AppTheme.modernAppBar(
        title: 'Desain Kop Surat',
        showBack: true,
        context: context,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        children: [
          const Text(
            'Pilih desain yang akan dipakai sebagai default. Kotak abu-abu '
            'menunjukkan posisi logo yang belum diunggah.',
            style: TextStyle(fontSize: 13, color: kTextSecondary),
          ),
          const SizedBox(height: 12),
          ...KopSuratDesigns.all.map(_buildDesignCard),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: AppTheme.gradientButton(
            label: 'Simpan Desain',
            icon: Icons.check_rounded,
            onTap: _save,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildDesignCard(KopSuratDesign design) {
    final bool selected = _designId == design.id;
    return GestureDetector(
      onTap: () => setState(() => _designId = design.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: kCardWhite,
          borderRadius: BorderRadius.circular(kRadiusLg),
          border: Border.all(
            color: selected ? kPrimary : Colors.grey.shade200,
            width: selected ? 2 : 1,
          ),
          boxShadow: kShadowSm,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: KopDesignPreview(
                kop: widget.kop,
                designId: design.id,
                showBothLogos: true,
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          design.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: kTextPrimary,
                          ),
                        ),
                        Text(
                          design.description,
                          style: const TextStyle(
                              fontSize: 11, color: kTextSecondary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  selected
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            gradient:
                                const LinearGradient(colors: kGradientPrimary),
                            borderRadius: BorderRadius.circular(kRadiusSm),
                          ),
                          child: const Text(
                            'Default',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      : const Icon(Icons.radio_button_unchecked_rounded,
                          color: kTextMuted, size: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
