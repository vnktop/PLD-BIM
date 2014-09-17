using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel;

using BIM.PLD.Services;

namespace BIM.PLD.TestHost
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                Console.WriteLine("*************************BIM.PLD.Services Versión 0.1.0****************************");
                Console.WriteLine("Iniciando servicios...");
                Console.WriteLine();

                using (ServiceHost host1 = new ServiceHost(typeof(CatalogoServices)))
                {
                    host1.Open();
                    Console.WriteLine("CatalogoServices Iniciado!");
                    Console.WriteLine();

                    using (ServiceHost host2 = new ServiceHost(typeof(ListaNegraServices)))
                    {
                        host2.Open();
                        Console.WriteLine("ListaNegraServices Iniciado!");
                        Console.WriteLine();

                        using (ServiceHost host3 = new ServiceHost(typeof(VerificadorPLDServices)))
                        {
                            host3.Open();
                            Console.WriteLine("VerificadorPLDServices Iniciado!");
                            Console.WriteLine();

                            using (ServiceHost host4 = new ServiceHost(typeof(ConfiguracionPLDServices)))
                            {
                                host4.Open();
                                Console.WriteLine("ConfiguracionPLDServices Iniciado!");
                                Console.WriteLine();

                                using (ServiceHost host5 = new ServiceHost(typeof(ServiceVerificardorPLD)))
                                {
                                    host5.Open();
                                    Console.WriteLine("ServiceVerificardorPLD Iniciado!");
                                    Console.WriteLine();

                                    using (ServiceHost host6 = new ServiceHost(typeof(BitacoraPLDServices)))
                                    {
                                        host6.Open();
                                        Console.WriteLine("BitacoraPLDServices Iniciado!");
                                        Console.WriteLine();

                                        using (ServiceHost host7 = new ServiceHost(typeof(TipoListaNegraServices)))
                                        {
                                            host7.Open();
                                            Console.WriteLine("TipoListaNegraServices Iniciado!");
                                            Console.WriteLine();

                                            using (ServiceHost host8 = new ServiceHost(typeof(TipoCambioServices)))
                                            {
                                                host8.Open();
                                                Console.WriteLine("TipoCambioServices Iniciado!");
                                                Console.WriteLine();

                                                Console.ReadKey();
                                                host1.Close();
                                                host2.Close();
                                                host3.Close();
                                                host4.Close();
                                                host5.Close();
                                                host6.Close();
                                                host7.Close();
                                                host8.Close();
                                            }
                                        }
                                    }
                                }

                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al iniciar servicios:");
                Console.WriteLine(ex.Message);
                Console.WriteLine("*****************************************************************");
                Console.WriteLine();
                Console.WriteLine("Presione cualquier tecla para terminar...");
                Console.ReadKey();
            }
        }
    }
}
