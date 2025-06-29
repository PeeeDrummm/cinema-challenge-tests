import xml.etree.ElementTree as ET
from datetime import datetime
import pytz

# Define o fuso horário de São Paulo para consistência
tz_sp = pytz.timezone('America/Sao_Paulo')

def update_readme():
    """
    Lê o output.xml do Robot, extrai estatísticas gerais e detalhadas,
    e atualiza o README.md a partir de um template.
    """
    try:
        # Caminho para o ficheiro de resultados do Robot
        output_xml_path = 'cinema-automation/logs/output.xml'
        tree = ET.parse(output_xml_path)
        root = tree.getroot()

        # --- Extração das Estatísticas Gerais ---
        stats = root.find('.//statistics/total/stat')
        passed = int(stats.attrib.get('pass', 0))
        failed = int(stats.attrib.get('fail', 0))
        total = passed + failed

        status = "PASSOU" if failed == 0 else "FALHOU"
        status_color = "green" if status == "PASSOU" else "red"
        now_sp = datetime.now(tz_sp)
        last_run_date = now_sp.strftime('%d/%m/%Y às %H:%M:%S (%Z)')

        # --- Extração dos Resultados Detalhados ---
        detailed_results = []
        # Procura por todos os testes dentro de todas as suítes
        for test_case in root.findall('.//test'):
            test_name = test_case.get('name')
            test_status_element = test_case.find('status')
            test_status = test_status_element.get('status')
            
            emoji = "✅" if test_status == "PASS" else "❌"
            # Cria uma linha da tabela em Markdown
            detailed_results.append(f"| {test_name} | {emoji} {test_status} |")
        
        # Junta todas as linhas da tabela
        detailed_results_markdown = "\n".join(detailed_results)

        # --- Atualização do README ---
        with open('README_TEMPLATE.md', 'r', encoding='utf-8') as f:
            template_content = f.read()

        readme_content = template_content.replace('{{total_tests}}', str(total))
        readme_content = readme_content.replace('{{passed_tests}}', str(passed))
        readme_content = readme_content.replace('{{failed_tests}}', str(failed))
        readme_content = readme_content.replace('{{status}}', status)
        readme_content = readme_content.replace('{{status_color}}', status_color)
        readme_content = readme_content.replace('{{last_run_date}}', last_run_date)
        readme_content = readme_content.replace('{{detailed_results}}', detailed_results_markdown)

        with open('README.md', 'w', encoding='utf-8') as f:
            f.write(readme_content)

        print("✅ README.md atualizado com sucesso com resultados detalhados!")

    except FileNotFoundError:
        print(f"❌ Erro Crítico: O ficheiro de resultados dos testes '{output_xml_path}' não foi encontrado.")
        print("Isso geralmente acontece se os testes não foram executados ou falharam antes da geração do log.")
        exit(1)
    except Exception as e:
        print(f"❌ Um erro inesperado ocorreu ao atualizar o README: {e}")
        exit(1)

if __name__ == "__main__":
    update_readme()
