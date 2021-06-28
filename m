Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D1A3B5934
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jun 2021 08:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhF1GlM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Jun 2021 02:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhF1GlL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Jun 2021 02:41:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9371C061574
        for <linux-pwm@vger.kernel.org>; Sun, 27 Jun 2021 23:38:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lxkum-0002SH-IT; Mon, 28 Jun 2021 08:38:40 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lxkul-0003IP-RG; Mon, 28 Jun 2021 08:38:39 +0200
Date:   Mon, 28 Jun 2021 08:38:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH -next] pwm: img: Fix PM reference leak in img_pwm_enable()
Message-ID: <20210628063839.5oeh5fvvoy3fk2gw@pengutronix.de>
References: <1620791837-16138-1-git-send-email-zou_wei@huawei.com>
 <20210512045222.2yjm6yxikznohlmn@pengutronix.de>
 <CAJZ5v0huz6Ek1FTvdMs0hPOoMn+ZHiNJeDp6-ujg-1WwpCsELQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ouqyesh2gt3a22qr"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0huz6Ek1FTvdMs0hPOoMn+ZHiNJeDp6-ujg-1WwpCsELQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ouqyesh2gt3a22qr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Zou,

On Fri, Jun 25, 2021 at 07:45:14PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 12, 2021 at 6:52 AM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, May 12, 2021 at 11:57:17AM +0800, Zou Wei wrote:
> > > pm_runtime_get_sync will increment pm usage counter even it failed.
> > > Forgetting to putting operation will result in reference leak here.
> > > Fix it by replacing it with pm_runtime_resume_and_get to keep usage
> > > counter balanced.
> > >
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: Zou Wei <zou_wei@huawei.com>
> > > ---
> > >  drivers/pwm/pwm-img.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> > > index cc37054..11b16ec 100644
> > > --- a/drivers/pwm/pwm-img.c
> > > +++ b/drivers/pwm/pwm-img.c
> > > @@ -156,7 +156,7 @@ static int img_pwm_enable(struct pwm_chip *chip, =
struct pwm_device *pwm)
> > >       struct img_pwm_chip *pwm_chip =3D to_img_pwm_chip(chip);
> > >       int ret;
> > >
> > > -     ret =3D pm_runtime_get_sync(chip->dev);
> > > +     ret =3D pm_runtime_resume_and_get(chip->dev);
> > >       if (ret < 0)
> > >               return ret;
> >
> > This patch looks right with my limited understanding of pm_runtime. A
> > similar issue in this driver was fixed in commit
> >
> >         ca162ce98110 ("pwm: img: Call pm_runtime_put() in pm_runtime_ge=
t_sync() failed case")
> >
> > where (even though the commit log talks about pm_runtime_put()) a call
> > to pm_runtime_put_autosuspend() was added in the error path.
> >
> > I added the PM guys to Cc, maybe they can advise about the right thing
> > to do here. Does it make sense to use the same idiom in both
> > img_pwm_enable() and img_pwm_config()?
>=20
> I think so.
>=20
> And calling pm_runtime_put_autosuspend() in the img_pwm_enable() error
> path would work too.

Do you care to clean this up accordingly and send a new patch?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ouqyesh2gt3a22qr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDZbmwACgkQwfwUeK3K
7AkHdAgAh/F2qNIQATDK1b+ShrXomsXhrDHW8/TMxpw+VRjRRGpnIPzv5NMXxNNt
v9ABxSjUBms6N1vP5ax3Jv52IJWWetn53OAOGTI99PsvESh+1yW2J6LlNAO7yyLw
y/2Ify+L7Ppoj3vbgGYFCdgiJf/3g0f/q4xTzA3zhSPDD1Ku6enUW6+upjkYuKbs
GAFcraEYEBSGBI186HRWB2zOB645APQXm/YZlz6dTDHwhBUBgtjkjxfy8lmW8jpc
RZs9l8fbMWzKlk8SQPgbRUpsJnzO/+lwMnSskJQMfm1U8lL+had5PW9kTD7L39sE
kPMOWYwIjGbKBIvVF9KnlFLHZMYt1Q==
=p3Fy
-----END PGP SIGNATURE-----

--ouqyesh2gt3a22qr--
