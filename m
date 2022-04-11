Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858C84FB830
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Apr 2022 11:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344749AbiDKJvv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Apr 2022 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344795AbiDKJvW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Apr 2022 05:51:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF33427C1
        for <linux-pwm@vger.kernel.org>; Mon, 11 Apr 2022 02:48:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ndqew-0007Wn-LH; Mon, 11 Apr 2022 11:48:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ndqew-002MOW-Rx; Mon, 11 Apr 2022 11:48:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ndqeu-002ZP9-Dx; Mon, 11 Apr 2022 11:48:32 +0200
Date:   Mon, 11 Apr 2022 11:48:28 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Johan Hovold <johan@kernel.org>
Cc:     Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Drop assignment to struct
 pwm_chip::base
Message-ID: <20220411094828.p3bjyioocuzhvqs7@pengutronix.de>
References: <20220411083118.200663-1-u.kleine-koenig@pengutronix.de>
 <YlPxIWfaFoQxW63Z@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ghzdgkbdd4wniguk"
Content-Disposition: inline
In-Reply-To: <YlPxIWfaFoQxW63Z@hovoldconsulting.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ghzdgkbdd4wniguk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2022 at 11:13:05AM +0200, Johan Hovold wrote:
> On Mon, Apr 11, 2022 at 10:31:18AM +0200, Uwe Kleine-K=F6nig wrote:
> > Since commit f9a8ee8c8bcd ("pwm: Always allocate PWM chip base ID
> > dynamically") the value held in base isn't used any more in the PWM
> > framework. All PMWs get assigned a dynamic ID, so the assignment is
> > redundant and can be dropped.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/staging/greybus/pwm.c | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pw=
m.c
> > index ad20ec24031e..3fda172239d2 100644
> > --- a/drivers/staging/greybus/pwm.c
> > +++ b/drivers/staging/greybus/pwm.c
> > @@ -297,7 +297,6 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_=
dev,
> > =20
> >  	pwm->dev =3D &gbphy_dev->dev;
> >  	pwm->ops =3D &gb_pwm_ops;
> > -	pwm->base =3D -1;			/* Allocate base dynamically */
> >  	pwm->npwm =3D pwmc->pwm_max + 1;
> > =20
> >  	ret =3D pwmchip_add(pwm);
> >=20
> > base-commit: 3123109284176b1532874591f7c81f3837bbdc17
>=20
> I'd prefer if you added a "pwm: " module prefix to the summary (even if
> the previous patch to this driver didn't have that).
>=20
> Looks good to me otherwise:
>=20
> Reviewed-by: Johan Hovold <johan@kernel.org>

Am I supposed to resend with the changed subject? Who will pick this up?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ghzdgkbdd4wniguk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJT+WkACgkQwfwUeK3K
7AnKYwgAnW/zOynyHe8zLts2pqMiWAedcxs30iTv3pXkbNu2QwlSv9KYaFSeKxRs
csjh8i7+ZryfUBLCL+racxiEuS9a27s2GmvtfqDms87qExdk9z4bkeYE9f1xdEAk
ONnqLdn/ua5uZ/MPPhdOIf+JewiYTlIivB5JlFo9eaftBjK/7H36Doolp2vC33TS
FOIf44BCP9+D8+ztfhnAUk04zGl8PeOETxPrNNtN30qlE7k/b8fEabReamxvTFP+
V71PPzhHg1sAh2/rrUpelo3dgtGfWH2yHkg351yydjFCLdQFc3Tx8x3ChSegX7Es
Z7WGWO8nmQmNIddyW9TJaLc841hXvw==
=b02P
-----END PGP SIGNATURE-----

--ghzdgkbdd4wniguk--
