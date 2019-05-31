Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5BE30E04
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2019 14:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEaMXX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 May 2019 08:23:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55413 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfEaMXW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 May 2019 08:23:22 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C0169802F5; Fri, 31 May 2019 14:23:10 +0200 (CEST)
Date:   Fri, 31 May 2019 14:23:21 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/3] ACPI: Resolve objects on host-directed table loads
Message-ID: <20190531122320.GB3722@amd>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <8704391ae3004a6b4dd17975dbcc9e88bd28cf4b.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <2944848d-d004-6750-b95d-825b1758ff22@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <2944848d-d004-6750-b95d-825b1758ff22@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >diff --git a/drivers/acpi/acpica/tbxfload.c b/drivers/acpi/acpica/tbxflo=
ad.c
> >index 4f30f06a6f78..61f2d46e52ba 100644
> >--- a/drivers/acpi/acpica/tbxfload.c
> >+++ b/drivers/acpi/acpica/tbxfload.c
> >@@ -297,6 +297,17 @@ acpi_status acpi_load_table(struct acpi_table_heade=
r *table)
> >  	status =3D acpi_tb_install_and_load_table(ACPI_PTR_TO_PHYSADDR(table),
> >  						ACPI_TABLE_ORIGIN_EXTERNAL_VIRTUAL,
> >  						FALSE, &table_index);
> >+
> >+	if (!ACPI_FAILURE(status)) {
> Checkpatch should complain about putting brackets around single statement
> if's.

With multiline statement like that and including comment -- I'd say
keep {'s. It is cleaner this way.
									Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzxHLgACgkQMOfwapXb+vLSVwCgvkY1xHITo54fK5GMzNokK4g7
zJQAoJM8WPcbSTGlKCz03eSbtVaS66m4
=DJMy
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
