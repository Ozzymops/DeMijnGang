using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FacebookRipper.Models
{
    public class Group
    {
        public string Name { get; set; }
        public string Id { get; set; }

        public Group(string name, string id)
        {
            Name = name;
            Id = id;
        }
    }
}