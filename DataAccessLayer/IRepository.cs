using System;
using System.Collections.Generic;

namespace DataAccessLayer
{
    public interface IRepository<T>
        where T : class
    {
        void Add(T entity);
        T? GetById(Guid id);
        void Update(T entity);
        void Delete(Guid id);
    }
}
