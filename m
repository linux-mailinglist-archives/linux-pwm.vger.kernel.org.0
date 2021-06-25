Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51A83B4841
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 19:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFYRfs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Jun 2021 13:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhFYRfr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Jun 2021 13:35:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5251C061574
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jun 2021 10:33:26 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwphf-0004IA-M0; Fri, 25 Jun 2021 19:33:19 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwphd-0005va-3n; Fri, 25 Jun 2021 19:33:17 +0200
Date:   Fri, 25 Jun 2021 19:33:16 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc:     Zou Wei <zou_wei@huawei.com>, thierry.reding@gmail.com,
        lee.jones@linaro.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] pwm: img: Fix PM reference leak in img_pwm_enable()
Message-ID: <20210625173316.pfsk7rvlplv4bzef@pengutronix.de>
References: <1620791837-16138-1-git-send-email-zou_wei@huawei.com>
 <20210512045222.2yjm6yxikznohlmn@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nw3jy26dwfiaqji6"
Content-Disposition: inline
In-Reply-To: <20210512045222.2yjm6yxikznohlmn@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--nw3jy26dwfiaqji6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rafael, Kevin and Ulf,

On Wed, May 12, 2021 at 06:52:22AM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Wed, May 12, 2021 at 11:57:17AM +0800, Zou Wei wrote:
> > pm_runtime_get_sync will increment pm usage counter even it failed.
> > Forgetting to putting operation will result in reference leak here.
> > Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> > counter balanced.
> >=20
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Zou Wei <zou_wei@huawei.com>
> > ---
> >  drivers/pwm/pwm-img.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> > index cc37054..11b16ec 100644
> > --- a/drivers/pwm/pwm-img.c
> > +++ b/drivers/pwm/pwm-img.c
> > @@ -156,7 +156,7 @@ static int img_pwm_enable(struct pwm_chip *chip, st=
ruct pwm_device *pwm)
> >  	struct img_pwm_chip *pwm_chip =3D to_img_pwm_chip(chip);
> >  	int ret;
> > =20
> > -	ret =3D pm_runtime_get_sync(chip->dev);
> > +	ret =3D pm_runtime_resume_and_get(chip->dev);
> >  	if (ret < 0)
> >  		return ret;
>=20
> This patch looks right with my limited understanding of pm_runtime. A
> similar issue in this driver was fixed in commit
>=20
> 	ca162ce98110 ("pwm: img: Call pm_runtime_put() in pm_runtime_get_sync() =
failed case")
>=20
> where (even though the commit log talks about pm_runtime_put()) a call
> to pm_runtime_put_autosuspend() was added in the error path.
>=20
> I added the PM guys to Cc, maybe they can advise about the right thing
> to do here. Does it make sense to use the same idiom in both
> img_pwm_enable() and img_pwm_config()?

Can you give some feedback here?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nw3jy26dwfiaqji6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDWE1kACgkQwfwUeK3K
7AlMHAf/Seh27QiCuoDAcLlJ+osf/17c6RGJV3u5TfaG84noBRtpFr5rz8bKOQMT
UJ/ElYO8+dIcwhxvnp6ZUuHl3x7faYThWxvQxGn4qSUN5qw2N6gpjoQ3r6HEaPU0
vk/DdsxgXGv1g3LT3jkPM6t5lkGS9b6wQZhUxzO9ybsJNzYnK+1h8wqWr9Wz723P
tVfFGiEiGvHpCY7B3f93AKiAQmJKIHsbg9w/p5GVeNOs/ipgqAGzvRra9uw941mY
ItQSWvCloxcuCDpYFJLlQPzH41O3YgruK3QP4YD+raLoberxAmzQIGmTAjqWC4UG
YbSq8uAkzioI+BT3Rd3UYjXdWBd3SA==
=Jgez
-----END PGP SIGNATURE-----

--nw3jy26dwfiaqji6--
