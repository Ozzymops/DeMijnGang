using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Serialization;
using System.Xml;
using System.Security.Cryptography.X509Certificates;
using System.Windows.Input;
using Microsoft.Maui.Graphics.Text;

namespace DeMijnGangApp.ViewModel
{
    public partial class MainPageViewModel : ObservableObject
    {
        public ObservableCollection<EventViewModel> Events { get; set; }

        public MainPageViewModel()
        {
            FetchEvents();
        }

        [RelayCommand]
        void FetchEvents()
        {
            XmlSerializer serializer = new XmlSerializer(typeof(Models.Events));

            using (XmlTextReader reader = new XmlTextReader("https://demijngang.nl/appfeed"))
            {
                Models.Events result = (Models.Events)serializer.Deserialize(reader);

                Events = new ObservableCollection<EventViewModel>();
                foreach (Models.Event _event in result.eventList)
                {
                    Events.Add(new EventViewModel { Id = _event.Id,
                                                    Title = _event.Title,
                                                    Description = _event.Description,
                                                    Excerpt = _event.Excerpt,
                                                    Categories = _event.Categories,
                                                    Tags = _event.Tags,
                                                    StartDate = DateTime.Parse(_event.StartDate),
                                                    EndDate = DateTime.Parse(_event.EndDate)
                                                    });
                }
            }
        }
    }
}
