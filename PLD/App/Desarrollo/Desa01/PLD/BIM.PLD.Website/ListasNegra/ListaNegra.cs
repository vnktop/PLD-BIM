using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BIM.PLD.Website.ListasNegra
{
    public class ListaNegra
    {//utp akin  //StreamReader //

        public string VCHTIPOLISTA;
        public string VCHIDQEQ;
        public string VCHNOMBRE;
        public string VCHAPPATERNO;
        public string VCHAPMATERNO;
        public string VCHCURP;
        public string VCHRFC;
        public string VCHFECHANAC;
        public string VCHESTATUS;
        public string VCHDEPENDENCIA;
        public string VCHPUESTO;
        public int? INTIDDISPO;
        public bool? BITCURPOK;
        public string VCHIDREL;
        public string VCHPARENTESCO;
        public string VCHRAZONSOCIAL;
        public string VCHRFCMORAL;
        public string VCHISSSTE; 
        public string VCHIMSS;
        public string VCHINGRESOS;
        public string VCHNOMCOMPLETO;
        public string VCHAPELLIDOS;
        public string VCHENTIDAD;
        public string VCHGENERO;
        public string AUDUSUARIO;
        public DateTime? SDATFECHAINS;

        #region Cod anterior
        //public int INTLISTANEGRAID {get; set;}
        //public string VCHTIPOLISTA;
        //public string? VCHIDQEQ { get; set; }
        //public string? VCHNOMBRE { get; set; }
        //public string? VCHAPPATERNO { get; set; }
        //public string? VCHAPMATERNO { get; set; }
        //public string? VCHCURP { get; set; }
        //public string? VCHRFC { get; set; }
        //public string? VCHFECHANAC { get; set; }
        //public string? VCHESTATUS { get; set; }
        //public string? VCHDEPENDENCIA { get; set; }
        //public string? VCHPUESTO { get; set; }
        //public int? INTIDDISPO { get; set; }
        //public bool? BITCURPOK { get; set; }
        //public string? VCHIDREL { get; set; }
        //public string? VCHPARENTESCO { get; set; }
        //public string? VCHRAZONSOCIAL { get; set; }
        //public string? VCHRFCMORAL { get; set; }
        //public string? VCHISSSTE { get; set; }
        //public string? VCHIMSS { get; set; }
        //public string? VCHINGRESOS { get; set; }
        //public string? VCHNOMCOMPLETO { get; set; }
        //public string? VCHAPELLIDOS { get; set; }
        //public string? VCHENTIDAD { get; set; }
        //public string? VCHGENERO { get; set; }
        //public string? AUDUSUARIO { get; set; }
        //public DateTime? SDATFECHAINS { get; set; }


        //public ListaNegra(string VCHTIPOLISTA, string VCHIDQEQ, string VCHNOMBRE, string VCHAPPATERNO, string VCHAPMATERNO, string VCHCURP, string VCHRFC, string VCHFECHANAC, string VCHESTATUS,
        //    string VCHDEPENDENCIA, string VCHPUESTO, int INTIDDISPO, bool BITCURPOK, string VCHIDREL, string VCHPARENTESCO, string VCHRAZONSOCIAL, string VCHRFCMORAL, string VCHISSSTE, string VCHIMSS,
        //    string VCHINGRESOS, string VCHNOMCOMPLETO, string VCHAPELLIDOS, string VCHENTIDAD, string VCHGENERO, string AUDUSUARIO, DateTime SDATFECHAINS)
        //{ }
        #endregion
    }

    public class Proveedor
    {
        public int iProveedorId;
        public string strNombre;
        public int iEstatus;
    }
}