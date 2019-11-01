class Script{
  //tabela localização
  static final String TABLE_LOCALIZACAO = "tb_localizacao";
  static final String COLUMN_ID_LOC = "id_localizacao";
  static final String COLUMN_LAT = "lat";
  static final String COLUMN_LOG = "long";
  static final String COLUMN_NOME = "nome";
  static final String COLUMN_COR = "cor";
  static final String COLUMN_NUMERO = "numero";

  static final String SQL = 'CREATE TABLE '+ TABLE_LOCALIZACAO 
  + '('+ COLUMN_ID_LOC +' INTEGER PRIMARY KEY, '+ COLUMN_LAT + ' TEXT, ' 
  + COLUMN_LOG + ' TEXT, ' + COLUMN_NOME + ' TEXT, ' + COLUMN_COR 
  + ' TEXT, '+ COLUMN_NUMERO +' TEXT)';
}