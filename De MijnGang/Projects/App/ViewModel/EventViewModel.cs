using CommunityToolkit.Mvvm.Input;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using System.Xml.Serialization;

namespace DeMijnGangApp.ViewModel
{
    public class EventViewModel : INotifyPropertyChanged
    {
        #region XML Elements
        public int Id { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Excerpt { get; set; }
        public string Categories { get; set; }
        public string Tags { get; set; }
        public Location Location { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        #endregion

        public ICommand Expand { get; set; }

        private bool _isExpanded;
        public Models.Event EventObject;

        public bool IsExpanded
        {
            get => _isExpanded;
            set
            {
                _isExpanded = value;
                OnPropertyChanged();
            }
        }

        public EventViewModel()
        {
            Expand = new RelayCommand(ExpandEvent);
        }

        public event PropertyChangedEventHandler PropertyChanged;
        protected void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        private void ExpandEvent()
        {
            IsExpanded = !IsExpanded;
        }
    }
}
