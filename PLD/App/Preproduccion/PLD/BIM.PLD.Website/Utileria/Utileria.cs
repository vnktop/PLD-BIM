using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.UI;
using System.Web.UI.WebControls;

using AjaxControlToolkit;

namespace BIM.PLD.Website.Utileria
{
    public static class Utileria
    {
        /// <summary>
        /// Control DDL: configura DDL para asignar el valor y el texto
        /// </summary>
        /// <param name="_dll">Control DDL</param>
        /// <param name="_valor">texto, valor del id</param>
        /// <param name="_texto">texto, valor para mostrar</param>
        #region control DropDownList
        
        public static void _ddlAsignarValorTexto(DropDownList _dll, string _valor, string _texto)
        {
            _dll.DataValueField = _valor;
            _dll.DataTextField = _texto;
            _dll.DataBind();
        }

        /// <summary>
        /// Agrega valor inicial [Seleccionar una opcion...], en la posición 0
        /// </summary>
        /// <param name="_ddl">Control DDL</param>
        public static void _ddlAgregarValorInicial(DropDownList _ddl, string _txtMostrarOpcion)
        {
            _ddl.Items.Insert(0, new ListItem(_txtMostrarOpcion, "0", true));
        }

        /// <summary>
        /// Agrega tooltipo en control, evento load,
        /// </summary>
        /// <param name="_ddl">Control DDL</param>
        public static void _ddlAgregarToolTip(DropDownList _ddl)
        {
            foreach (ListItem item in _ddl.Items)
            {
                item.Attributes.Add("title", item.Text);
            }
        }

        /// <summary>
        /// Asigna ID a control DDL cuando la lista del Id no empieza en 1
        /// </summary>
        /// <param name="_ddl">Control DDL</param>
        /// <param name="_valor">Id que se busca</param>
        public static int _ddlAsignarIdMayorAUno(DropDownList _ddl, int _valor)
        {            
            for (int i = 0; i < _ddl.Items.Count -1; i++)
			{
                int _id = int.Parse(_ddl.Items[i].Value);
                    if (_id == _valor)
	                {
                        return i;
	                }
			}
            return 0;
        }

        /// <summary>
        /// Asigna ID a control DDL por texto
        /// </summary>
        /// <param name="_ddl">Control DDL</param>
        /// <param name="_valor">Id que se busca</param>
        public static int _ddlAsignarIdPorTexto(DropDownList _ddl, string _text)
        {
            for (int i = 0; i <= _ddl.Items.Count - 1; i++)
            {
                string _txt = _ddl.Items[i].Text;
                if (_txt == _text)
                {
                    return i;
                }
            }
            return 0;
        }
        
        #endregion
    }
}