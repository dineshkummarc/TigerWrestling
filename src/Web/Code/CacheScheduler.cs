using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace Web.Code
{
    public class CacheScheduler
    {
        #region Helper Classes...

        private class CacheItem
        {
            public string Name;
            public Callback Callback;
            public Cache Cache;
            public DateTime LastRun;
        }

        private static int Interval { get; set; }

        #endregion

        #region Methods...

        public delegate void Callback();

        public CacheScheduler Every(int interval)
        {
            Interval = interval;

            return this;
        }

        public CacheScheduler Run(string cacheItemName, Callback callbackMethod)
        {
            CacheItem cache = new CacheItem();

            cache.Name = cacheItemName;
            cache.Callback = callbackMethod;
            cache.Cache = HttpRuntime.Cache;
            cache.LastRun = DateTime.Now;

            AddCacheObject(cache);

            return this;
        }

        private void AddCacheObject(CacheItem cacheItem)
        {
            var cacheExpirationInterval = Interval; // In minutes

            // ** If the specified cache interval is 0 minutes, do nothing, effectively disabling the timer
            if (cacheExpirationInterval == 0) { return; }

            if (Equals(cacheItem.Cache[cacheItem.Name], null))
            {
                cacheItem.Cache.Add(cacheItem.Name,
                                    cacheItem,
                                    null,
                                    DateTime.Now.AddMinutes(cacheExpirationInterval),
                                    Cache.NoSlidingExpiration,
                                    CacheItemPriority.NotRemovable,
                                    CacheCallback);
            }
        }

        private void CacheCallback(string key,
                                   object value,
                                   CacheItemRemovedReason reason)
        {
            CacheItem obj_cache = (CacheItem)value;

            if (obj_cache.LastRun < DateTime.Now)
            {
                if (obj_cache.Callback != null) { obj_cache.Callback.Invoke(); }

                obj_cache.LastRun = DateTime.Now;
            }

            // ** Re-add the item back to the cache to continue the "timer" mechanism
            AddCacheObject(obj_cache);
        }

        #endregion
    }
}
