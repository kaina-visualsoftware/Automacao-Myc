import mysql.connector
import leituraConfig as config

ROBOT_LIBRARY_SCOPE = 'TEST SUITE'

dbname = config.config.Database
porta = config.config.Porta
ipservidor = config.config.IpServidor


class validaPermissoesUsuario:

    ROBOT_LIBRARY_SCOPE = 'TEST SUITE'

    def __init__(self):
        self.connection = mysql.connector.connect(
            host=ipservidor,
            user='root',
            password='vssql',
            database=dbname,
            port=porta
        )
        self.cursor = self.connection.cursor()
        self._usuario_logado = None

    def obter_usuario_logado(self):
        
        if self._usuario_logado is not None:
            return self._usuario_logado

        query = (
            "SELECT u.Codigo "
            "FROM usuario_acesso ua "
            "INNER JOIN usuarios u ON u.UserName = ua.ua_usuario_mycommerce "
            "WHERE ua.ua_data = CURDATE() "
            "ORDER BY ua.ua_id DESC, u.Codigo ASC "
            "LIMIT 1"
        )

        self.cursor.execute(query)
        resultado = self.cursor.fetchone()

        if not resultado:
            raise Exception("Nenhum usuário logado encontrado na tabela usuario_acesso.")

        self._usuario_logado = resultado[0]
        return self._usuario_logado

    def carregar_permissoes(self, tabela, colunas, usuario, join=""):

        colunas_sql = ", ".join(colunas)

        query = (
            f"SELECT {colunas_sql} "
            f"FROM {tabela} "
            f"{join} "
            f"WHERE u.Codigo = %s"
        )

        self.cursor.execute(query, (usuario,))
        linha = self.cursor.fetchone()

        if not linha:
            return []

        return [coluna for i, coluna in enumerate(colunas) if linha[i] == 1]

    def valida_permissoes_usuario(self):

        usuario = self.obter_usuario_logado()

        colunas = [
            "MenuInicializacao",
            "Avisos_menu",
            "AvisoChequeCompensar",
            "AvisoChequesCompensarVencidos",
            "ContaAvisoTodas",
            "AvisoCortes",
            "Crm_Notify",
            "prod_EstAviso",
            "AvisoNcmCest",
            "Entrega_Aviso",
            "AvisoVendaAberta",
            "AvisoProdutosLoteValidade",
            "AvisoAniversariantes",
            "AvisoClienteSemCompra",
            "ContaAviso",
            "AvisoNFCPendente",
        ]

        return self.carregar_permissoes(
            tabela="usuarios u",
            colunas=colunas,
            usuario=usuario,
        )

    def valida_permissoes_usuario_auxiliar(self):

        usuario = self.obter_usuario_logado()

        colunas = [
            "uau_avisa_ferias",
            "Uau_Cons_Avisos_Manutencoes_Inicializar",
            "Uau_Cons_Avisos_TransfRecusadas_Inicializar",
            "Uau_Avisos_Cotacao_Moeda",
            "Uau_Importa_Produtos",
            "uau_BloqDev_ComValorNegativo",
            "uau_PreVenda_BotaoConferencia",
            "uau_PreVenda_Conferencia_AoFinalizar",
        ]

        return self.carregar_permissoes(
            tabela="usuarios_auxiliar uax",
            colunas=colunas,
            usuario=usuario,
            join="INNER JOIN usuarios u ON u.Codigo = uax.uau_codigo_usuario",
        )

    def carregar_permissoes_usuario(self):

        permissoes = []
        permissoes.extend(self.valida_permissoes_usuario())
        permissoes.extend(self.valida_permissoes_usuario_auxiliar())

        return permissoes
