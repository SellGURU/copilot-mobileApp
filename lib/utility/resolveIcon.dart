String resolveAnalyseIcon(String name) {
  switch (name) {
    case 'Blood Health':
    case 'Blood':
      return 'assets/biomarkers/red-blood-cells.svg';
    case 'Diabetes & Glucose':
      return 'assets/biomarkers/donor.svg';
    case 'Inflammatory health':
      return 'assets/biomarkers/medicine.svg';
    case 'Total Body Mass':
    case 'Metabolic Health':
    case 'Major Essential Minerals':
      return 'assets/biomarkers/Abdominal.svg';
    case 'Urine Test Parameters':
      return 'assets/biomarkers/eye medicine.svg';
    case 'Cardiovascular Risk':
    case 'Cardiovascular Health':
      return 'assets/biomarkers/heart.svg';
    case 'Immune health':
      return 'assets/biomarkers/egg.svg';
    case 'Kidney Function':
    case 'Kidney Health':
      return 'assets/biomarkers/kidney.svg';
    case 'Vitamins':
    case 'Vitamins & Minerals':
      return 'assets/biomarkers/vitamins.svg';
    case 'Tumor health':
      return 'assets/biomarkers/dna (1).svg';
    case 'Genetics/DNA':
      return 'assets/biomarkers/DNA.svg';
    case 'Arterial Stiffness':
      return 'assets/biomarkers/inject.svg';
    case 'Bone and Mineral Health':
    case 'Bone Biomarkers':
      return 'assets/biomarkers/bones.svg';
    case 'Liver Function':
      return 'assets/biomarkers/monitor.svg';
    case 'Trace Essential Minerals':
      return 'assets/biomarkers/Urine.svg'; // This replaces duplicate entry
    case 'Essential Minerals':
      return 'assets/biomarkers/minerals.svg';
    case 'Thyroid Function':
      return 'assets/biomarkers/thyroid.svg';
    case 'Arterial Thickness':
      return 'assets/biomarkers/temperature (1).svg';
    case 'Metabolism and Energy':
      return 'assets/biomarkers/metabolism.svg';
    case 'Inflammation & Coagulation':
      return 'assets/biomarkers/inflammation.svg';
    case 'Immune System Health':
      return 'assets/biomarkers/Cells.svg';
    case 'Sex Hormones':
      return 'assets/biomarkers/sex-hormone.svg';
    case 'Muscle and Fat':
      return 'assets/biomarkers/muscle.svg';
    case 'Gut Health':
      return 'assets/biomarkers/Gut.svg';
    default:
      return 'assets/biomarkers/red-blood-cells.svg';
  }
}
