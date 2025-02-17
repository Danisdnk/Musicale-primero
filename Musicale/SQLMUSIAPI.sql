USE [master]
GO
/****** Object:  Database [MusicApi]    Script Date: 30/7/2019 18:24:06 ******/
CREATE DATABASE [MusicApi]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MusicApi', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\MusicApi.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MusicApi_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\MusicApi_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [MusicApi] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MusicApi].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MusicApi] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MusicApi] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MusicApi] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MusicApi] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MusicApi] SET ARITHABORT OFF 
GO
ALTER DATABASE [MusicApi] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MusicApi] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MusicApi] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MusicApi] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MusicApi] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MusicApi] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MusicApi] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MusicApi] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MusicApi] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MusicApi] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MusicApi] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MusicApi] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MusicApi] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MusicApi] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MusicApi] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MusicApi] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MusicApi] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MusicApi] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MusicApi] SET  MULTI_USER 
GO
ALTER DATABASE [MusicApi] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MusicApi] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MusicApi] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MusicApi] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MusicApi] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MusicApi] SET QUERY_STORE = OFF
GO
USE [MusicApi]
GO
/****** Object:  Table [dbo].[Album]    Script Date: 30/7/2019 18:24:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Album](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[anio] [varchar](4) NULL,
	[generoID] [int] NOT NULL,
	[portada] [nvarchar](max) NULL,
	[ArtistaID] [int] NULL,
 CONSTRAINT [PK__Album__3214EC27F286D423] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Artist]    Script Date: 30/7/2019 18:24:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Artist](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[descripcion] [varchar](max) NULL,
	[foto] [nvarchar](max) NULL,
 CONSTRAINT [PK__Artist__3214EC27085A7326] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 30/7/2019 18:24:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[genero] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Song]    Script Date: 30/7/2019 18:24:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Song](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[audio] [nvarchar](max) NULL,
	[AlbumID] [int] NULL,
 CONSTRAINT [PK__Song__3214EC2798DA93B3] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Album] ON 

INSERT [dbo].[Album] ([ID], [nombre], [anio], [generoID], [portada], [ArtistaID]) VALUES (66, N'Fuerte', N'2018', 5, N'/Content/Images/Miranda_-Fuerte-Frontal19162044.jpg', 20)
INSERT [dbo].[Album] ([ID], [nombre], [anio], [generoID], [portada], [ArtistaID]) VALUES (67, N'Equilibrio', N'2014', 7, N'/Content/Images/Porta19170213.jpg', 18)
INSERT [dbo].[Album] ([ID], [nombre], [anio], [generoID], [portada], [ArtistaID]) VALUES (68, N'Templo del Pop', N'2011', 5, N'/Content/Images/Miranda_-El_Templo_Del_Pop_(Edicion_Especial)-Frontal19173708.jpg', 20)
INSERT [dbo].[Album] ([ID], [nombre], [anio], [generoID], [portada], [ArtistaID]) VALUES (69, N'Guau!', N'2004', 5, N'/Content/Images/miranda-86637m19232925.jpg', 20)
INSERT [dbo].[Album] ([ID], [nombre], [anio], [generoID], [portada], [ArtistaID]) VALUES (70, N'Raro', N'2006', 5, N'/Content/Images/Swedish_House_Mafia-Until_Now-Frontal19235115.jpg', 20)
INSERT [dbo].[Album] ([ID], [nombre], [anio], [generoID], [portada], [ArtistaID]) VALUES (71, N'Obsesionario', N'2013', 4, N'/Content/Images/Obsesionario19155915.jpg', 22)
INSERT [dbo].[Album] ([ID], [nombre], [anio], [generoID], [portada], [ArtistaID]) VALUES (72, N'Cuestión de edad', N'2009', 7, N'/Content/Images/cuestion de19174703.jpg', 18)
INSERT [dbo].[Album] ([ID], [nombre], [anio], [generoID], [portada], [ArtistaID]) VALUES (73, N'Porfiado', N'2012', 4, N'/Content/Images/porfiado19041109.png', 23)
INSERT [dbo].[Album] ([ID], [nombre], [anio], [generoID], [portada], [ArtistaID]) VALUES (74, N'Guau!', N'2006', 4, N'/Content/Images/guau19114009.jpg', 22)
SET IDENTITY_INSERT [dbo].[Album] OFF
SET IDENTITY_INSERT [dbo].[Artist] ON 

INSERT [dbo].[Artist] ([ID], [nombre], [descripcion], [foto]) VALUES (17, N'Cafe Tacuba', N'Café Tacvba (antes Café Tacuba) es una banda de rock alternativo, originaria de Ciudad Satélite del Área Metropolitana de la Ciudad de México. El grupo se conformó en 1989.4? Además del éxito comercial y de crítica que han logrado, el grupo es reconocido por su proyecto cultural vanguardista el cual mezcla el rock y sus temas habituales con letras, historias y sonidos extraídos de la cultura popular mexicana', N'/Content/Images/tacuba19062784.jpg')
INSERT [dbo].[Artist] ([ID], [nombre], [descripcion], [foto]) VALUES (18, N'Porta', N'Óscar de la Torre, más conocido por su nombre artístico «Ambkor» es un MC barcelonés, exmiembro del grupo Malafama Squad, junto a Zaisé, T-Key y, anteriormente, Triple H. Posteriormente, el grupo se disuelve y cada artista siguió con su carrera en solitario. En enero de 2019 tuvo a su primer hijo, Ignacio.', N'/Content/Images/el-porta19090514.jpg')
INSERT [dbo].[Artist] ([ID], [nombre], [descripcion], [foto]) VALUES (19, N'Soda Estereo', N'Soda Stereo fue una banda de rock argentina formada en Buenos Aires en 1982 por Gustavo Cerati, Héctor «Zeta» Bosio y Carlos Alberto Ficicchia «Charly Alberti», considerada una de las más influyentes e importantes bandas iberoamericanas de todos los tiempos y una leyenda de la música latina. contemporanea', N'/Content/Images/estejpg19111384.jpg')
INSERT [dbo].[Artist] ([ID], [nombre], [descripcion], [foto]) VALUES (20, N'Miranda!', N'Antes de Miranda!, Alejandro Sergi y Juliana Gattas formaron un dúo llamado «Lirio», donde él cumplía papel de programador, reversionando temas de jazz en estilo electrónico y ella cantaba. Para sus presentaciones, que se realizaban en Cemento (lugar que vio nacer y crecer a la banda), Alejandro Sergi decide componer un tema propio llamado «Imán», ', N'/Content/Images/miranda-86637m19142295.jpg')
INSERT [dbo].[Artist] ([ID], [nombre], [descripcion], [foto]) VALUES (21, N'Ambkor', N'Óscar de la Torre, más conocido por su nombre artístico «Ambkor» es un MC barcelonés, exmiembro del grupo Malafama Squad, junto a Zaisé, T-Key y, anteriormente, Triple H. Posteriormente, el grupo se disuelve y cada artista siguió con su carrera en solitario. En enero de 2019 tuvo a su primer hijo, Ignacio. Wikipedia', N'/Content/Images/Lobonegro19154859.jpg')
INSERT [dbo].[Artist] ([ID], [nombre], [descripcion], [foto]) VALUES (22, N'Arbol', N'Óscar de la Torre, más conocido por su nombre artístico «Ambkor» es un MC barcelonés, exmiembro del grupo Malafama Squad, junto a Zaisé, T-Key y, anteriormente, Triple H. Posteriormente, el grupo se disuelve y cada artista siguió con su carrera en solitario. En enero de 2019 tuvo a su primer hijo, Ignacio', N'/Content/Images/Arbol-2919581083.jpg')
INSERT [dbo].[Artist] ([ID], [nombre], [descripcion], [foto]) VALUES (23, N'Cuarteto de nos', N'Óscar de la Torre, más conocido por su nombre artístico «Ambkor» es un MC barcelonés, exmiembro del grupo Malafama Squad, junto a Zaisé, T-Key y, anteriormente, Triple H. Posteriormente, el grupo se disuelve y cada artista siguió con su carrera en solitario. En enero de 2019 tuvo a su primer hijo, Ignacio', N'/Content/Images/cuarteto19562983.jpg')
SET IDENTITY_INSERT [dbo].[Artist] OFF
SET IDENTITY_INSERT [dbo].[Gender] ON 

INSERT [dbo].[Gender] ([ID], [genero]) VALUES (4, N'rock')
INSERT [dbo].[Gender] ([ID], [genero]) VALUES (5, N'pop')
INSERT [dbo].[Gender] ([ID], [genero]) VALUES (6, N'reggaeton')
INSERT [dbo].[Gender] ([ID], [genero]) VALUES (7, N'rap')
INSERT [dbo].[Gender] ([ID], [genero]) VALUES (8, N'techno')
INSERT [dbo].[Gender] ([ID], [genero]) VALUES (9, N'blues')
SET IDENTITY_INSERT [dbo].[Gender] OFF
SET IDENTITY_INSERT [dbo].[Song] ON 

INSERT [dbo].[Song] ([ID], [nombre], [audio], [AlbumID]) VALUES (21, N'David Bowie', N'/Content/AudioFiles/Sample.mp3', 67)
INSERT [dbo].[Song] ([ID], [nombre], [audio], [AlbumID]) VALUES (22, N'vestido azul', N'/Content/AudioFiles/La oreja de Van Gogh - Vestido azul19345197.mp3', 66)
INSERT [dbo].[Song] ([ID], [nombre], [audio], [AlbumID]) VALUES (23, N'Tu y yo', N'/Content/AudioFiles/Sample.mp3', 66)
INSERT [dbo].[Song] ([ID], [nombre], [audio], [AlbumID]) VALUES (24, N'y yo', N'/Content/AudioFiles/La oreja de Van Gogh - Tú y yo19130423.mp3', 66)
INSERT [dbo].[Song] ([ID], [nombre], [audio], [AlbumID]) VALUES (25, N'Esperanza', N'/Content/AudioFiles/La oreja de Van Gogh - La esperanza debida19132602.mp3', 68)
INSERT [dbo].[Song] ([ID], [nombre], [audio], [AlbumID]) VALUES (26, N'Adiós', N'/Content/AudioFiles/La oreja de Van Gogh - Adiós19134067.mp3', 68)
INSERT [dbo].[Song] ([ID], [nombre], [audio], [AlbumID]) VALUES (27, N'Perdoname', N'/Content/AudioFiles/La oreja de Van Gogh - Perdóname19135529.mp3', 66)
INSERT [dbo].[Song] ([ID], [nombre], [audio], [AlbumID]) VALUES (28, N'Algo mejor', N'/Content/AudioFiles/Sample.mp3', 73)
INSERT [dbo].[Song] ([ID], [nombre], [audio], [AlbumID]) VALUES (29, N'Insaciable', N'/Content/AudioFiles/11 Insaciable19054500.mp3', 73)
SET IDENTITY_INSERT [dbo].[Song] OFF
ALTER TABLE [dbo].[Album]  WITH CHECK ADD  CONSTRAINT [FK_Album_Artist] FOREIGN KEY([ArtistaID])
REFERENCES [dbo].[Artist] ([ID])
GO
ALTER TABLE [dbo].[Album] CHECK CONSTRAINT [FK_Album_Artist]
GO
ALTER TABLE [dbo].[Album]  WITH CHECK ADD  CONSTRAINT [FK_Album_Gender] FOREIGN KEY([generoID])
REFERENCES [dbo].[Gender] ([ID])
GO
ALTER TABLE [dbo].[Album] CHECK CONSTRAINT [FK_Album_Gender]
GO
ALTER TABLE [dbo].[Song]  WITH CHECK ADD  CONSTRAINT [FK_Song_Album] FOREIGN KEY([AlbumID])
REFERENCES [dbo].[Album] ([ID])
GO
ALTER TABLE [dbo].[Song] CHECK CONSTRAINT [FK_Song_Album]
GO
USE [master]
GO
ALTER DATABASE [MusicApi] SET  READ_WRITE 
GO
