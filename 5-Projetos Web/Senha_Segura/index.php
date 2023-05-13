<!DOCTYPE html
PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<!--
# ----------------------------------------------------------------- #
# Nome do Arquivo :   /Senha_Segura/index.php                       #
# Descrição       :   Testa e Gera Senha Segura                     #
# Site            :   http://intranet.9blog.eb.mil.br               #
# Escrito por     :   1º Sgt L. Matos                               #
# Manutenido por  :   1º Sgt L. Matos                               #
# ----------------------------------------------------------------- #
# Forma de Uso    :   colocar em /var/www/html/Senha_Segura         #
# ----------------------------------------------------------------- #
# Histórico       :   v1.0 25/04/2023, 1º Sgt L. Matos:             #
#                      - Cabeçalho                                  #
# ----------------------------------------------------------------- #
# Agradecimentos :                                                  #
# SecInfor HGeS | TuTI 3ª Cia F Esp | STI PQRMNT12 | STI 9º B Log   #
# ----------------------------------------------------------------- #
-->

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Senha Segura</title>
    <link href="css/default.css" rel="stylesheet" type="text/css" />
    <link rel="icon" href="favicon.ico">
    <link rel="shortcut icon" href="favicon.ico" title="Favicon" />

    <script type="text/javascript" language="javascript" src="js/pwd_meter_min.js"></script>
    <!--[if lt IE 7]>
	<link href="css/ie.css" rel="stylesheet" type="text/css" />
<![endif]-->


    <link href="css_barra/style2.css" rel="stylesheet">
    <link href="css_barra/demo.css" rel="stylesheet">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script>
        window.jQuery || document.write('<script src="js_barra/vendor/jquery-1.9.1.min.js"><\/script>')
    </script>
    <script src="js_barra/jbar.js"></script>
    <style type="text/css">
        body {
            margin-left: 0px;
            margin-top: 0px;
            margin-right: 0px;
            margin-bottom: 0px;
            background-image: url("./images/fundo_Brasil.png");
            background-repeat: no-repeat;
        }

        button_new {
            display: inline-block;
            border-radius: 6px;
            background-color: #32CD32;
            border: none;
            color: #000000;
            text-align: absolute;
            font-size: 22px;
            padding: 16px;
            width: 160px;
            transition: all 0.5s;
            cursor: pointer;
            margin: 5px;
        }

        button_new span {
            cursor: pointer;
            display: inline-block;
            position: relative;
            transition: 0.5s;
        }

        button_new span:after {
            content: '\2207';
            position: right;
            opacity: 0;
            top: 0;
            right: -15px;
            transition: 0.5s;
        }

        button_new:hover span {
            padding-right: 15px;
        }

        button_new:hover span:after {
            opacity: 1;
            right: 0;
        }

        .linha {
            display: flex;
            flex-flow: row-wrap;
        }

        .coluna {
            width: 18%;
        }

        .button-blue {
            background-color: #3CB371;
            box-shadow: #094c66 4px 4px 0px;
            border-radius: 8px;
            transition: transform 200ms, box-shadow 200ms;
        }

        .button-blue:active {
            transform: translateY(4px) translateX(4px);
            box-shadow: #094c66 0px 0px;
        }

        * {
            font-family: Calibri;
            box-sizing: content-box;
            color: #000000;
        }

        .san {
            margin: 40px;
            border: 1px solid #000000;
            width: 365px;
            padding: 16px;
            font-size: 32px;
            font-weight: bold;
        }

        float:left;
    </style>


</head>

<body>
    <div align="center"><img src="./images/STI.png"></div>

    <div id="header">
        <br>
        <br>
        <h1><b>Verifique se a sua senha realmente é segura! Uma boa senha deve conter no mínimo 8 caracteres, </b><br>
        <b>misturando letras, números e símbolos. </b><br></h1>

    </div>

    <div id="content">
        <form id="formPassword" name="formPassword">
            <table id="tablePwdCheck" cellpadding="5" cellspacing="1" border="0">
                <tr>
                    <th colspan="2" class="txtCenter">Teste de Senha</th>
                    <th class="txtCenter">Requerimentos Mínimos</th>
                </tr>
                <tr>
                    <th>Senha:</th>
                    <td>
                        <input type="password" id="passwordPwd" name="passwordPwd" maxlength="16" autocomplete="off"
                            onkeyup="chkPass(this.value);" />
                        <input type="text" id="passwordTxt" name="passwordTxt" maxlength="16" autocomplete="off"
                            onkeyup="chkPass(this.value);" class="hide" />
                    </td>
                    <td rowspan="4">
                        <ul>
                            <li>Mínimo de 8 caracteres</li>
                            <li>Conter ao menos 3/4 dos seguintes itens:<br />
                                - Letras maiúsculas<br />
                                - Letras minúsculas<br />
                                - Números<br />
                                - Símbolos<br />
                            </li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <th>Esconder:</th>
                    <td><input type="checkbox" id="mask" name="mask" value="1" checked="checked"
                            onclick="togPwdMask();" /></td>
                </tr>
                <tr>
                    <th>Pontuação:</th>
                    <td>
                        <div id="scorebarBorder">
                            <div id="score">0%</div>
                            <div id="scorebar"> </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>Complexidade:</th>
                    <td>
                        <div id="complexity">Muito curta</div>
                    </td>
                </tr>

            </table>
            <table id="tablePwdStatus" cellpadding="5" cellspacing="1" border="0">
                <tr>
                    <th colspan="2">Adições</th>
                    <th class="txtCenter">Tipo</th>
                    <th class="txtCenter">Fórmula</th>
                    <th class="txtCenter">Contagem</th>
                    <th class="txtCenter">Bônus</th>
                </tr>
                <tr>
                    <td width="1%">
                        <div id="div_nLength" class="fail"> </div>
                    </td>
                    <td width="94%">Número de caracteres</td>
                    <td width="1%" class="txtCenter">Flat</td>
                    <td width="1%" class="txtCenter italic">+(n*4)</td>
                    <td width="1%">
                        <div id="nLength" class="box"> </div>
                    </td>
                    <td width="1%">
                        <div id="nLengthBonus" class="boxPlus"> </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="div_nAlphaUC" class="fail"> </div>
                    </td>
                    <td>Letras maiúsculas</td>
                    <td class="txtCenter">Cond/Incr</td>
                    <td nowrap="nowrap" class="txtCenter italic">+((len-n)*2)</td>
                    <td>
                        <div id="nAlphaUC" class="box"> </div>
                    </td>
                    <td>
                        <div id="nAlphaUCBonus" class="boxPlus"> </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="div_nAlphaLC" class="fail"> </div>
                    </td>
                    <td>Letras minúsculas</td>
                    <td class="txtCenter">Cond/Incr</td>
                    <td class="txtCenter italic">+((len-n)*2)</td>
                    <td>
                        <div id="nAlphaLC" class="box"> </div>
                    </td>
                    <td>
                        <div id="nAlphaLCBonus" class="boxPlus"> </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="div_nNumber" class="fail"> </div>
                    </td>
                    <td>Números</td>
                    <td class="txtCenter">Cond</td>
                    <td class="txtCenter italic">+(n*4)</td>
                    <td>
                        <div id="nNumber" class="box"> </div>
                    </td>
                    <td>
                        <div id="nNumberBonus" class="boxPlus"> </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="div_nSymbol" class="fail"> </div>
                    </td>
                    <td>Símbolos</td>
                    <td class="txtCenter">Flat</td>
                    <td class="txtCenter italic">+(n*6)</td>
                    <td>
                        <div id="nSymbol" class="box"> </div>
                    </td>
                    <td>
                        <div id="nSymbolBonus" class="boxPlus"> </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="div_nMidChar" class="fail"> </div>
                    </td>
                    <td>Números ou símbolos no meio</td>
                    <td class="txtCenter">Flat</td>
                    <td class="txtCenter italic">+(n*2)</td>
                    <td>
                        <div id="nMidChar" class="box"> </div>
                    </td>
                    <td>
                        <div id="nMidCharBonus" class="boxPlus"> </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="div_nRequirements" class="fail"> </div>
                    </td>
                    <td>Requerimentos</td>
                    <td class="txtCenter">Flat</td>
                    <td class="txtCenter italic">+(n*2)</td>
                    <td>
                        <div id="nRequirements" class="box"> </div>
                    </td>
                    <td>
                        <div id="nRequirementsBonus" class="boxPlus"> </div>
                    </td>
                </tr>
                <tr>
                    <th colspan="6">Deduções</th>
                </tr>
                <tr>
                    <td width="1%">
                        <div id="div_nAlphasOnly" class="pass"> </div>
                    </td>
                    <td width="94%">Somente letras</td>
                    <td width="1%" class="txtCenter">Flat</td>
                    <td width="1%" class="txtCenter italic">-n</td>
                    <td width="1%">
                        <div id="nAlphasOnly" class="box"> </div>
                    </td>
                    <td width="1%">
                        <div id="nAlphasOnlyBonus" class="boxMinus"> </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="div_nNumbersOnly" class="pass"> </div>
                    </td>
                    <td>Somente números</td>
                    <td class="txtCenter">Flat</td>
                    <td class="txtCenter italic">-n</td>
                    <td>
                        <div id="nNumbersOnly" class="box"> </div>
                    </td>
                    <td>
                        <div id="nNumbersOnlyBonus" class="boxMinus"> </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="div_nRepChar" class="pass"> </div>
                    </td>
                    <td>Caracteres repetidos</td>
                    <td class="txtCenter">Incr</td>
                    <td nowrap="nowrap" class="txtCenter italic">-(n(n-1))</td>
                    <td>
                        <div id="nRepChar" class="box"> </div>
                    </td>
                    <td>
                        <div id="nRepCharBonus" class="boxMinus"> </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="div_nConsecAlphaUC" class="pass"> </div>
                    </td>
                    <td>Letras maiúsculas consecutivas</td>
                    <td class="txtCenter">Flat</td>
                    <td class="txtCenter italic">-(n*2)</td>
                    <td>
                        <div id="nConsecAlphaUC" class="box"> </div>
                    </td>
                    <td>
                        <div id="nConsecAlphaUCBonus" class="boxMinus"> </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="div_nConsecAlphaLC" class="pass"> </div>
                    </td>
                    <td>Letras minúsculas consecutivas</td>
                    <td class="txtCenter">Flat</td>
                    <td class="txtCenter italic">-(n*2)</td>
                    <td>
                        <div id="nConsecAlphaLC" class="box"> </div>
                    </td>
                    <td>
                        <div id="nConsecAlphaLCBonus" class="boxMinus"> </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="div_nConsecNumber" class="pass"> </div>
                    </td>
                    <td>Números consecutivos</td>
                    <td class="txtCenter">Flat</td>
                    <td class="txtCenter italic">-(n*2)</td>
                    <td>
                        <div id="nConsecNumber" class="box"> </div>
                    </td>
                    <td>
                        <div id="nConsecNumberBonus" class="boxMinus"> </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="div_nSeqAlpha" class="pass"> </div>
                    </td>
                    <td>Sequência de letras (3+)</td>
                    <td class="txtCenter">Flat</td>
                    <td class="txtCenter italic">-(n*3)</td>
                    <td>
                        <div id="nSeqAlpha" class="box"> </div>
                    </td>
                    <td>
                        <div id="nSeqAlphaBonus" class="boxMinus"> </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="div_nSeqNumber" class="pass"> </div>
                    </td>
                    <td>Sequência de números (3+)</td>
                    <td class="txtCenter">Flat</td>
                    <td class="txtCenter italic">-(n*3)</td>
                    <td>
                        <div id="nSeqNumber" class="box"> </div>
                    </td>
                    <td>
                        <div id="nSeqNumberBonus" class="boxMinus"> </div>
                    </td>
                </tr>
                <tr>
                    <th colspan="6">Legenda</th>
                </tr>
                <tr>
                    <td colspan="6">
                        <ul id="listLegend">
                            <li>
                                <div class="exceed imgLegend"> </div> <span class="bold">Excepcional:</span> Excede os
                                padrões mínimos. Bônus aplicados.
                            </li>
                            <li>
                                <div class="pass imgLegend"> </div> <span class="bold">Suficiente:</span> Atinge o
                                mínimo aconselhado. Bônus aplicados.
                            </li>
                            <li>
                                <div class="warn imgLegend"> </div> <span class="bold">Aviso:</span> Melhore a sua
                                senha. Pontuação reduzida.
                            </li>
                            <li>
                                <div class="fail imgLegend"> </div> <span class="bold">Falha:</span> Senha muito fraca.
                                Pontuação reduzida.
                            </li>
                        </ul>
                    </td>
                </tr>
            </table>
            <table id="tablePwdNotes" cellpadding="5" cellspacing="1" border="0">


                <tr>
                    <th>AVISO</th>
                </tr>
                <tr>
                    <td>
                        <p><b>Esta aplicação foi projetada para avaliar a complexidade de uma senha. A avaliação deste
                                sistema pode ajudar ao usuário a melhorar a complexidade da senha, alertando sobre
                                hábitos ruins ou falhas na escolha e formulação de senhas. A avaliação da complexidade
                                da senha é calculada através de método próprio, sem utilizar fórmulas ou instruções de
                                organizações, RFCs e similares. Esta aplicação não é perfeita e deve ser utilizada
                                apenas como um guia para melhorar a complexidade de senhas.
                        </b></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div align="center"><b><h1>Gerar Senha Aleatória</h1></b></div><br>
                        <?php
                        /**
                        * Summary of random_password_generate
                        * @param mixed $length
                        * @return string
                        */
                        function random_password_generate($length) 
                        {
                        $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-=+?";
                        $password = substr(str_shuffle( $chars ),0, $length );
                        return $password;
                        }
                        $password = random_password_generate(10);?>
                        <h2 style="float:left; margin:40px;  padding: 21px 0px;"> Senha Segura: </h2> &nbsp;

                        <div class="san">
                            <?php echo $password;?>
                        </div>

                        <input type="button" class="button-blue button-blue-active btn-success btn-lg btn-block"
                            value="Atualizar Senha" onClick="window.location.reload()"
                            style="float:left; margin:49px 40px;  padding: 15px;">

                        <a type="button" class="button-blue button-blue-active btn-success btn-lg btn-block"
                            target="_blank" style="float:left; margin:49px 40px;  padding: 15px;"
                            href="https://senhasegura.remontti.com.br/" rel="nofollow noreferrer noopener external">
                            <center>Testar Senha</center>
                        </a>

                    </td>
                </tr>
            </table>
        </form>
        <div class="xtend"> </div>
    </div>
    <br>
    <div id="footer">
        <div class="txtRight txtSmall noPad">)</div>
        <p class="txtCenter txtSmall"><h3><b>Site Adapdato pela STI do 9º B Log de acordo com a licença</b> <a
                href="http://www.gnu.org/licenses/gpl-3.0.txt" target="_blank">GNU General Public License (GPL)</a>.</p></h3>
    </div>
</body>

</html>
