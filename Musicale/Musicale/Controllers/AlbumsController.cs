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
    public class AlbumsController : Controller
    {
        private MusicApiEntities db = new MusicApiEntities();

        // GET: Albums
        public ActionResult Index(Album album,string busquedaAlbum)
        {
            //MusicApiEntities db = new MusicApiEntities();

            if (album.portada == null)
            {
                album.portada = "~/Content/Images/not-image.jpg";
            }


            var ColAlbum = db.Albums.Include(a => a.Artist).Include(a => a.Gender);

            if (busquedaAlbum != null)
            {
                ColAlbum = db.Albums.Where(b => b.nombre.Contains(busquedaAlbum));
            }

            return View(ColAlbum.ToList());




            //var albums = db.Albums.Include(a => a.Artist).Include(a => a.Gender);
            //return View(albums.ToList());
        }



        // GET: Albums/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Album album = db.Albums.Find(id);


            if (album == null)
            {
                return HttpNotFound();
            }

            if (album.portada == null)
            {
                album.portada = "/Content/Images/not-image.jpg";
            }

            return View(album);
        }

        

     

            // GET: Albums/Create
            public ActionResult Create(int? id)
        {
            var portada = db.Albums.Find(id);
            ViewBag.ArtistaID = new SelectList(db.Artists, "ID", "nombre");
            ViewBag.generoID = new SelectList(db.Genders, "ID", "genero");
            return View();
        }

        // POST: Albums/Create
         [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Album album)
        {
            ViewBag.ArtistaID = new SelectList(db.Artists, "ID", "nombre", album.ArtistaID);
            ViewBag.generoID = new SelectList(db.Genders, "ID", "genero", album.generoID);

            if (album.UserImageFile != null)
            {
               
                string fileName = Path.GetFileNameWithoutExtension(album.UserImageFile.FileName);
                string extension = Path.GetExtension(album.UserImageFile.FileName);
                fileName = fileName + DateTime.Now.ToString("yymmssff") + extension;
                album.portada = "/Content/Images/" + fileName;
                fileName = Path.Combine(Server.MapPath("/Content/Images/"), fileName);
                album.UserImageFile.SaveAs(fileName);

            }



            //if (album.portada == "/Content/Images/not-image.jpg")
            // {
            //album.portada = null;
            // }


            if (album.portada == null)
            {
                album.portada = "/Content/Images/not-image.jpg";
            }


            if (ModelState.IsValid)
            {

                db.Albums.Add(album);
                db.SaveChanges();
                return RedirectToAction("Index");

            }



            return View(album);

        }

        // GET: Albums/Edit/5
        public ActionResult Edit(int? id)
        {



            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Album album = db.Albums.Find(id);
            if (album == null)
            {
                return HttpNotFound();
            }
            ViewBag.ArtistaID = new SelectList(db.Artists, "ID", "nombre", album.ArtistaID);
            ViewBag.generoID = new SelectList(db.Genders, "ID", "genero", album.generoID);
            return View(album);
        }

        // POST: Albums/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit( Album album)
        {
            if (album.UserImageFile != null)
            {

                string fileName = Path.GetFileNameWithoutExtension(album.UserImageFile.FileName);
                string extension = Path.GetExtension(album.UserImageFile.FileName);
                fileName = fileName + DateTime.Now.ToString("yymmssff") + extension;
                album.portada = "/Content/Images/" + fileName;
                fileName = Path.Combine(Server.MapPath("/Content/Images/"), fileName);
                album.UserImageFile.SaveAs(fileName);

            }

            if (album.portada == null)
            {
                album.portada = "/Content/Images/not-image.jpg";
            }



            ViewBag.ArtistaID = new SelectList(db.Artists, "ID", "nombre", album.ArtistaID);
            ViewBag.generoID = new SelectList(db.Genders, "ID", "genero", album.generoID);

 if (ModelState.IsValid)
            {
                db.Entry(album).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
        
 return View(album);
            
        }

        // GET: Albums/Delete/5
        public ActionResult Delete(int? id)
        {
            Album album = db.Albums.Find(id);


            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
         
            if (album == null)
            {
                return HttpNotFound();
            }


            return View(album);
        }


        // POST: Albums/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Album album = db.Albums.Find(id);


//si existe artista o cancion relacionada que no permita borrar
           var condicion = album.ArtistaID != null || album.Songs != null;


            if (condicion == true)
            {


                ViewBag.MyErrorMessage = "este Album no se puede borrar porque tiene canciones y/o artistas relacionados";


                return View("Delete");


            }


            if (ModelState.IsValid)
            {
                db.Albums.Remove(album);
                db.SaveChanges();
                return RedirectToAction("Index");
            }



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
