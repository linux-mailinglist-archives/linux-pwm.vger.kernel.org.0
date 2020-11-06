Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9AB2A92D1
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Nov 2020 10:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgKFJem (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Nov 2020 04:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFJel (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Nov 2020 04:34:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC81C0613CF
        for <linux-pwm@vger.kernel.org>; Fri,  6 Nov 2020 01:34:41 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kay8k-0006Pm-62; Fri, 06 Nov 2020 10:34:38 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kay8i-0007It-Qi; Fri, 06 Nov 2020 10:34:36 +0100
Date:   Fri, 6 Nov 2020 10:34:35 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Ajit Pal Singh <ajitpal.singh@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] pwm: sti: fix error handling
Message-ID: <20201106093435.4mlr6ujivvkzkd5z@pengutronix.de>
References: <20201013081531.661528-1-uwe@kleine-koenig.org>
 <20201106082914.GX4488@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7rosrj6sn3fj4hcg"
Content-Disposition: inline
In-Reply-To: <20201106082914.GX4488@dell>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7rosrj6sn3fj4hcg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Lee,

On Fri, Nov 06, 2020 at 08:29:14AM +0000, Lee Jones wrote:
> On Tue, 13 Oct 2020, Uwe Kleine-K=F6nig wrote:
>=20
> > This commit fixes several faults:
> >=20
> >  - Iff a clk was returned by of_clk_get_by_name() it must be dereferenc=
ed
> >    by calling clk_put().
> >  - A clk that was prepared must be unprepared.
> >  - The .remove callback isn't supposed to call pwm_disable().
> >  - The necessary resources needed by the PWM must not be freed before
> >    pwmchip_remove() was called.
> >=20
> > Fixes: 378fe115d19d ("pwm: sti: Add new driver for ST's PWM IP")
> > Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> > ---
> >  drivers/pwm/pwm-sti.c | 49 ++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 37 insertions(+), 12 deletions(-)
>=20
> Sorry for the delay, this ended up in spam.
>=20
> > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> > index 1508616d794c..f89f8cbdfdfc 100644
> > --- a/drivers/pwm/pwm-sti.c
> > +++ b/drivers/pwm/pwm-sti.c
> > @@ -605,7 +605,7 @@ static int sti_pwm_probe(struct platform_device *pd=
ev)
> >  	ret =3D clk_prepare(pc->pwm_clk);
> >  	if (ret) {
> >  		dev_err(dev, "failed to prepare clock\n");
> > -		return ret;
> > +		goto err_pwm_clk_prepare;
>=20
> I would prefer these to indicate the intention, rather than were they
> were called from.  So err_put_cpt_clk for this one, etc.

This might be subjective, but I like it better the way I did it. My
pattern is:

	ret =3D get_resource_A();
	if (ret)
		goto err_A;

	ret =3D get_resource_B();
	if (ret)
		goto err_B;

	...

	put_resource_B();
err_B:
=09
	put_resource_A();
err_A:

	return ret;

This way just looking at on get_resource_$X block it is obvious that the
picked label is right and in the error handling blocks that's obvious,
too.

However with the (admittedly more common) style you prefer it is:

	ret =3D get_resource_A();
	if (ret)
		goto return_ret; // or just: return ret

	ret =3D get_resource_B();
	if (ret)
		goto put_A;

	...

put_B:
	put_resource_B();

put_A:
	put_resource_A();

return_ret:
	return ret;

You have to check the previous block to see that put_A is right for
the error path of get_resource_B(). In this trivial example you have to
look back 6 instead of 2 lines. For more complex stuff it tends to be
3 lines for my approach (one more for the error message, and so still in
the same logical block) but might be considerably bigger for the common
approach. The usual amount of context in patches is 3 lines. And if you
add another resource allocation between A and B you have to adapt the
error path in B which is somewhat unrelated. So a patch adding A2 looks
for my approach:

@@ ...
 	if (ret)
 		goto err_A;
=20
+	ret =3D get_resource_A2();
+	if (ret)
+		goto err_A2;
+
 	ret =3D get_resource_B();
 	if (ret)
 		goto err_B;
@@ ...
 	put_resource_B();
 err_B:
 =09
+	put_resource_A2();
+err_A2:
+
 	put_resource_A()
 err_A:
=20
Here you see that the right error label is used in the new error path
and that it is placed correctly between err_B and err_A.

For your preferred approach the patch looks as follows:

@@ ...
 	if (ret)
 		goto return_ret;
=20
+	ret =3D get_resource_A2();
+	if (ret)
+		goto put_A;
+
 	ret =3D get_resource_B();
 	if (ret)
-		goto put_A;
+		goto put_A2;
=20
 	...
@@ ...
 put_B:=20
 	put_resource_B();
=20
+put_A2:
+	put_resource_A2;
+
 put_A:
 	put_resource_A();
=20
Note you cannot see by just looking at the patch that goto put_A is
right. (Well, if you assume that the old code is correct see that just
before put_A B is freed which matches what just happens after your new
get_resource_A2, but that's considerably more complicated.) Also you
have to modify the goto for B.

This is in my eyes ugly enough to justify my preference.

> > +err_pwmchip_add:
> > +
> > +	if (cdata->cpt_num_devs) {
>=20
> No need for the evaluations, clk_*() calls are NULL safe.

Yes, I added that to match the allocation pattern. I don't feel strong
here. (But as a side note: I don't like the gotos in .probe. They are
not used to do (plain) error handling and so they complicate following
the code flow.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7rosrj6sn3fj4hcg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+lGKgACgkQwfwUeK3K
7AnQzQgAnG/0G2MjZVcs5kMo0xuYelz8KHC390PU5ZSYXkXZTUYG2gpN77ZUYkqZ
GfxLWl6zqYa0EytbvisW5sbfqNMMzXxSGpAwcCnIHbuwd/LHe4zFRFfkOcth9+G1
SBmI5mEM1tZ61DOLdGAraICiaLu8AJXTKRjFrKLSlal3xeVOSclGrx3PsB+zEjk9
fW302BoBMD4X3ab4qOyhsTwd+hhRCZuDBxAEXdq387PcnH9yOk6IuRDzh8LgSrLU
12N3eDnTsOasaofn/znYgstsMKbStoynas2ScR76TSk//3L8VvpCV8gUg/yU+zjA
VRSjJdgOvWOm4qWwR69vr0CvPCwAUQ==
=ITp8
-----END PGP SIGNATURE-----

--7rosrj6sn3fj4hcg--
