import xml.etree.ElementTree as ET
from datetime import datetime
import pytz
import os

# Define o fuso horário de São Paulo para consistência
tz_sp = pytz.timezone('America/Sao_Paulo')

def update_readme():
    try:
        # Pega a URL do repositório a partir das variáveis de ambiente do GitHub Actions
        repo_url = os.getenv('GITHUB_SERVER_URL', 'https://github.com') + '/' + os.getenv('GITHUB_REPOSITORY', 'PeeeDrummm/cinema-challenge-tests')
        actions_url = f"{repo_url}/actions"

        output_xml_path = 'cinema-automation/logs/output.xml'
        tree = ET.parse(output_xml_path)
        root = tree.getroot()

        stats = root.find('.//statistics/total/stat')
        passed = int(stats.attrib.get('pass', 0))
        failed = int(stats.attrib.get('fail', 0))
        total = passed + failed

        status = "PASSOU" if failed == 0 else "FALHOU"
        status_color = "green" if status == "PASSOU" else "red"
        now_sp = datetime.now(tz_sp)
        last_run_date = now_sp.strftime('%d/%m/%Y às %H:%M:%S (%Z)')

        detailed_results = []
        for test_case in root.findall('.//test'):
            test_name = test_case.get('name')
            test_status_element = test_case.find('status')
            test_status = test_status_element.get('status')
            emoji = "✅" if test_status == "PASS" else "❌"
            detailed_results.append(f"| {test_name} | {emoji} {test_status} |")
        
        detailed_results_markdown = "\n".join(detailed_results)

        with open('README_TEMPLATE.md', 'r', encoding='utf-8') as f:
            template_content = f.read()

        readme_content = template_content.replace('{{total_tests}}', str(total))
        readme_content = readme_content.replace('{{passed_tests}}', str(passed))
        readme_content = readme_content.replace('{{failed_tests}}', str(failed))
        readme_content = readme_content.replace('{{status}}', status)
        readme_content = readme_content.replace('{{status_color}}', status_color)
        readme_content = readme_content.replace('{{last_run_date}}', last_run_date)
        readme_content = readme_content.replace('{{actions_url}}', actions_url)
        readme_content = readme_content.replace('{{detailed_results}}', detailed_results_markdown)

        with open('README.md', 'w', encoding='utf-8') as f:
            f.write(readme_content)

        print("✅ README.md atualizado com sucesso!")

    except Exception as e:
        print(f"❌ Um erro inesperado ocorreu: {e}")
        exit(1)

if __name__ == "__main__":
    update_readme()
