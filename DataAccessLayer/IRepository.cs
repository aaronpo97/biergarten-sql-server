using System;
using System.Collections.Generic;

namespace DataAccessLayer
{
    public interface IRepository<T>
        where T : class
    {
        void Add(T entity);

        IEnumerable<T> GetAll(int? limit, int? offset);

        T? GetById(Guid id);
        void Update(T entity);
        void Delete(Guid id);
    }
}
