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
