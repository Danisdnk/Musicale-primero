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
    public class ArtistsController : Controller
    {
        private MusicApiEntities db = new MusicApiEntities();

        // GET: Artists
        public ActionResult Index(Artist artist, string busquedaArtista)
        {

            //ArtistImageFile

            if (artist.foto == null)
            {
                artist.foto = "~/Content/Images/not-image.jpg";
            }

            var ColArtist = db.Artists.Include(a => a.Albums.Select(d => d.Gender));
              

            if (busquedaArtista != null)
            {
                ColArtist = db.Artists
                    .Where(b => b.nombre
                    .Contains(busquedaArtista))
                    .OrderBy(c=>c.nombre);

               //ColArtist = db.Artists.Where(b => b.Albums.Select(d => d.Gender.genero).Contains(busquedaArtista)); 
            }

            return View(ColArtist.ToList());

            //return View(db.Artists.ToList());



        }

        // GET: Artists/Details/5
        public ActionResult Details(int? id)
        {
            Artist artist = db.Artists.Find(id);

            //Artist albumSongs = (from a in db.Artists where a.ID == id select a).FirstOrDefault();

            //db.Artists.Include(a => a.Albums.Select(d => d.Songs));

          
            //y aca es donde me encantaria haber podido devolver la 'coleccion' a mi vista
            //pero no llegue a hacerlo y accedi atraves de album 
            //¿Cómo devolver colecciones <ienumerables>/<yqueriables> AsEnumerable?

            var coleccion = db.Artists
                           .Include(co =>
                            co.Albums.Select(d => d.Songs))
                           .ToList();
                           //.FirstOrDefault(co => co.ID == id);

            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
          
            if (artist == null)
            {
                return HttpNotFound();
            }

            if (artist.foto == null)
            {
                artist.foto = "/Content/Images/not-image.jpg";
            }

            return View(artist);
        }

        // GET: Artists/Create
        public ActionResult Create()
        {

            return View();
        }

        // POST: Artists/Create
       
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Artist artist)
        {


            if (artist.ArtistImageFile != null)
            {

                string fileName = Path.GetFileNameWithoutExtension(artist.ArtistImageFile.FileName);
                string extension = Path.GetExtension(artist.ArtistImageFile.FileName);
                fileName = fileName + DateTime.Now.ToString("yymmssff") + extension;
                artist.foto = "/Content/Images/" + fileName;
                fileName = Path.Combine(Server.MapPath("/Content/Images/"), fileName);
                artist.ArtistImageFile.SaveAs(fileName);

            }



            if (artist.foto == null)
            {
                artist.foto = "/Content/Images/not-image.jpg";
            }

            if (ModelState.IsValid)
            {
                db.Artists.Add(artist);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(artist);
        }

        // GET: Artists/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Artist artist = db.Artists.Find(id);
            if (artist == null)
            {
                return HttpNotFound();
            }
            return View(artist);
        }

        // POST: Artists/Edit/5
      [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit( Artist artist)
        {

            if (artist.ArtistImageFile != null)
            {

                string fileName = Path.GetFileNameWithoutExtension(artist.ArtistImageFile.FileName);
                string extension = Path.GetExtension(artist.ArtistImageFile.FileName);
                fileName = fileName + DateTime.Now.ToString("yymmssff") + extension;
                artist.foto = "/Content/Images/" + fileName;
                fileName = Path.Combine(Server.MapPath("/Content/Images/"), fileName);
                artist.ArtistImageFile.SaveAs(fileName);

            }



            if (artist.foto == null)
            {
                artist.foto = "/Content/Images/not-image.jpg";
            }


            if (ModelState.IsValid)
            {
                db.Entry(artist).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(artist);
        }

        // GET: Artists/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Artist artist = db.Artists.Find(id);
            if (artist == null)
            {
                return HttpNotFound();
            }
            return View(artist);
        }

        // POST: Artists/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Artist artist = db.Artists.Find(id);



         var condicion = artist.Albums.FirstOrDefault().ArtistaID !=null ;


            if (condicion == true)
            {


                ViewBag.MyErrorMessage = "este Album no se puede borrar porque tiene canciones y/o artistas relacionados";


                return View("Delete");


            }




            db.Artists.Remove(artist);
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
