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
using DeMijnGangApp.Models;
using System.Xml;

namespace DeMijnGangApp.ViewModel
{
    public partial class MainPageViewModel : ObservableObject
    {
        public MainPageViewModel()
        {
            Events = new ObservableCollection<Event>();
            Fetch();
        }

        [ObservableProperty]
        ObservableCollection<Event> events;

        [RelayCommand]
        void Fetch()
        {
            XmlSerializer serializer = new XmlSerializer(typeof(Events));

            using (XmlTextReader reader = new XmlTextReader("https://demijngang.nl/appfeed"))
            {
                Events result = (Events)serializer.Deserialize(reader);
                events = new ObservableCollection<Event>(result.eventList as List<Event>);
            }
        }
    }
}
