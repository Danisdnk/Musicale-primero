using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Musicale.Models;

namespace Musicale.Controllers
{
    public class SongsController : Controller
    {
        private MusicApiEntities db = new MusicApiEntities();

        // GET: Songs
        public ActionResult Index(Song song, string busquedaCancion)
        {

            //var songs = db.Songs.Include(s => s.Album);


            
            if (song.audio == null)
            {
                song.audio = "/Content/AudioFiles/Sample.mp3";
            }



            var ColCancion = db.Songs.Include(a => a.Album);

      

            if (busquedaCancion != null)
            {
                ColCancion = db.Songs
                             .Where(b => b.nombre.Contains(busquedaCancion))
                             .OrderBy(c=>c.nombre);
               
            }




            return View(ColCancion.ToList());


        }

        // GET: Songs/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Song song = db.Songs.Find(id);
            if (song == null)
            {
                return HttpNotFound();
            }
            return View(song);
        }

      
        
        
        
        
        
        
        
        // GET: Songs/Create
        public ActionResult Create()
        {
            ViewBag.AlbumID = new SelectList(db.Albums, "ID", "nombre");
            return View();
        }

        // POST: Songs/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Song song)
        {
         ViewBag.AlbumID = new SelectList(db.Albums, "ID", "nombre", song.AlbumID);



            if (song.UserAudioFile != null)
            {

                string fileName = Path.GetFileNameWithoutExtension(song.UserAudioFile.FileName);
                string extension = Path.GetExtension(song.UserAudioFile.FileName);
                fileName = fileName + DateTime.Now.ToString("yymmssff") + extension;
                song.audio = "/Content/AudioFiles/" + fileName;
                fileName = Path.Combine(Server.MapPath("/Content/AudioFiles/"), fileName);
                song.UserAudioFile.SaveAs(fileName);

            }



            if (song.audio == null)
            {
                song.audio = "/Content/AudioFiles/Sample.mp3";
            }


            if (ModelState.IsValid)
            {
                db.Songs.Add(song);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(song);
        }

        // GET: Songs/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Song song = db.Songs.Find(id);
            if (song == null)
            {
                return HttpNotFound();
            }
            ViewBag.AlbumID = new SelectList(db.Albums, "ID", "nombre", song.AlbumID);
            return View(song);
        }

        // POST: Songs/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Song song)
        {

            if (song.UserAudioFile != null)
            {

                string fileName = Path.GetFileNameWithoutExtension(song.UserAudioFile.FileName);
                string extension = Path.GetExtension(song.UserAudioFile.FileName);
                fileName = fileName + DateTime.Now.ToString("yymmssff") + extension;
                song.audio = "/Content/AudioFiles/" + fileName;
                fileName = Path.Combine(Server.MapPath("/Content/AudioFiles/"), fileName);
                song.UserAudioFile.SaveAs(fileName);

            }


            if (song.audio == null)
            {
                song.audio = "/Content/AudioFiles/Sample.mp3";
            }


            if (ModelState.IsValid)
            {
                db.Entry(song).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.AlbumID = new SelectList(db.Albums, "ID", "nombre", song.AlbumID);
            return View(song);
        }

        // GET: Songs/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Song song = db.Songs.Find(id);
            if (song == null)
            {
                return HttpNotFound();
            }
            return View(song);
        }

        // POST: Songs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Song song = db.Songs.Find(id);
            db.Songs.Remove(song);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
