Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD49F30E0B
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2019 14:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfEaMYg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 May 2019 08:24:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55431 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfEaMYf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 31 May 2019 08:24:35 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id DF2F88031F; Fri, 31 May 2019 14:24:23 +0200 (CEST)
Date:   Fri, 31 May 2019 14:24:34 +0200
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
Subject: Re: [PATCH 2/3] PWM framework: add support referencing PWMs from ACPI
Message-ID: <20190531122434.GC3722@amd>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <254cc03d5467ba7db0f5677646266768e5b24127.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <d4e035b7-7419-cb69-9e22-6103d53d5aaf@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <d4e035b7-7419-cb69-9e22-6103d53d5aaf@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >+struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
> static?
> >+{
> >+	struct fwnode_reference_args args;
> >+	struct pwm_chip *chip;
> >+	struct pwm_device *pwm =3D ERR_PTR(-ENODEV);
> >+	int ret;
> >+
> >+	memset(&args, 0, sizeof(args));
>=20
> args should be zero'd out when initialized on the stack so this is
> necessary.

What?
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzxHQIACgkQMOfwapXb+vKuIQCfW5dIKIOa940BDGi5OVK8pf3K
ByQAnAsMR3DUm4QgoARft8zBHpwJdHyI
=i6ur
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
