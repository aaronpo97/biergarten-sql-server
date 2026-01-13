using System;
using System.Collections.Generic;

namespace BusinessLayer.Services
{
    public interface IService<T>
        where T : class
    {
        IEnumerable<T> GetAll(int? limit, int? offset);
        T? GetById(Guid id);
        void Add(T entity);
        void Update(T entity);
        void Delete(Guid id);
    }
}
