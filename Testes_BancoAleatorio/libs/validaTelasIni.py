import configparser
import os

class validaTelasIni:

    CAMINHO_TELAS_INI = r"C:\Visual Software\MyCommerce\Telas.ini"

    def valida_telas_ini(self, formulario, campo):
        
        if not os.path.exists(self.CAMINHO_TELAS_INI):
            raise FileNotFoundError(f"Arquivo Telas.ini não encontrado em: {self.CAMINHO_TELAS_INI}")

        config = configparser.ConfigParser()
        config.read(self.CAMINHO_TELAS_INI, encoding='latin-1')

        if not config.has_section(formulario):
            raise KeyError(f"Formulário '[{formulario}]' não encontrado no Telas.ini.")

        if not config.has_option(formulario, campo):
            raise KeyError(f"Campo '{campo}' não encontrado na seção '[{formulario}]' do Telas.ini.")

        valor = config.get(formulario, campo).strip()

        return valor == '1'

    def valida_telas_ini_prefixado(self, formulario, campo):
        """
        Valida campo no Telas.ini cujas chaves possuem prefixo terminal_usuario_.
        Formato esperado da chave: nomeTerminal_nomeUsuario_nomeCampo (ex: CQP-FELIPE-35_Visual_InformaAgrupamento).
        Retorna False quando o arquivo, a seção ou o campo prefixado não forem encontrados,
        ou quando o valor for '0'. Retorna True apenas quando o valor for '1'.
        """
        if not os.path.exists(self.CAMINHO_TELAS_INI):
            return False

        config = configparser.ConfigParser()
        config.read(self.CAMINHO_TELAS_INI, encoding='latin-1')

        if not config.has_section(formulario):
            return False

        # configparser converte chaves para minúsculas por padrão
        sufixo = f"_{campo.lower()}"

        for chave in config.options(formulario):
            if chave.endswith(sufixo):
                valor = config.get(formulario, chave).strip()
                return valor == '1'

        return False

    def valida_telas_ini_padrao_habilitado(self, formulario, campo):
        """
        Valida campo no Telas.ini onde a ausência do arquivo, da seção ou do campo
        significa que o checkbox está HABILITADO (padrão = True).
        Retorna True quando o arquivo, a seção ou o campo não forem encontrados,
        ou quando o valor for '1'. Retorna False apenas quando o valor for '0'.
        Exemplo de uso: chkServico em FrmRelatorioComissao.
        """
        if not os.path.exists(self.CAMINHO_TELAS_INI):
            return True

        config = configparser.ConfigParser()
        config.read(self.CAMINHO_TELAS_INI, encoding='latin-1')

        if not config.has_section(formulario):
            return True

        if not config.has_option(formulario, campo):
            return True

        valor = config.get(formulario, campo).strip()

        return valor != '0'
