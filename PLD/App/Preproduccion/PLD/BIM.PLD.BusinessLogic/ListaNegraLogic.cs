using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Transactions;
using BIM.BusinessEntities;
using BIM.DataAccess;

namespace BIM.PLD.BusinessLogic
{
    public class ListaNegraLogic
    {
        #region Constructor de la clase

        private ListaNegraDataAccess ListaNegraDA;

        public ListaNegraLogic()
        {
            ListaNegraDA = new ListaNegraDataAccess ();
        }
        #endregion

        public int InsertarListaNegra(ListaNegra oListaNegra)
        {
            int LISTANEGRAID;
            try
            {
               
                    LISTANEGRAID = ListaNegraDA.InsertarListaNegra(oListaNegra);
                    
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return LISTANEGRAID;
        }

        //public List<ListaNegra> BusquedaListaNegra(int iTipoLista)
        //{
        //    List<ListaNegra> resultado = null;
        //    try
        //    {
        //        resultado = ListaNegraDA.BusquedaListaNegra(iTipoLista);
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //    return resultado;
        //}
        public string CargaListasNegras(int iProveedorId)
        {
            string resultado;
            try
            {
                resultado = ListaNegraDA.CargaListasNegras(iProveedorId);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return resultado;
        }

        public int insertaProveedor(string proveedor)
        {
            int resultado = ListaNegraDA.InsertaProveedor(proveedor);
            return resultado;
        }
        public List<Proveedor> ListarProveedores()
        {
            List<Proveedor> lstResult = new List<Proveedor>();
            try
            {
                lstResult = ListaNegraDA.ListarProveedores();
            }
            catch (Exception e)
            {
                throw e;
            }
            return lstResult;
        }
                
        public List<SistemasPLD> ListarSistemasPLD()
        {
            List<SistemasPLD> resultado = null;
            try
            {
                resultado = ListaNegraDA.ListarSistemasPLD();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return resultado;
        }

        public bool almacenarArchivo(string fuente, string destino, string archivo)
        {
            bool result;
            try
            {
                result = ListaNegraDA.almacenarArchivo(fuente, destino, archivo);
            }
            catch (Exception ex)
            {

                throw ex;
            }
            return result;
        }

    }
}
