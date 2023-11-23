Return-Path: <linux-pwm+bounces-167-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACA47F5BFA
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 11:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E77B281300
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B5418C04;
	Thu, 23 Nov 2023 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEDD9F
	for <linux-pwm@vger.kernel.org>; Thu, 23 Nov 2023 02:10:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r66f6-0006pw-FM; Thu, 23 Nov 2023 11:10:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r66f4-00B0kL-Pg; Thu, 23 Nov 2023 11:10:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r66f4-006YOP-G5; Thu, 23 Nov 2023 11:10:18 +0100
Date: Thu, 23 Nov 2023 11:10:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Douglas Anderson <dianders@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 101/108] drm/bridge: ti-sn65dsi86: Make use of
 devm_pwmchip_alloc() function
Message-ID: <20231123101018.u6c6nymmkam5ltir@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-102-u.kleine-koenig@pengutronix.de>
 <20231123094652.GH15697@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m7basmppiqka5heb"
Content-Disposition: inline
In-Reply-To: <20231123094652.GH15697@pendragon.ideasonboard.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--m7basmppiqka5heb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Laurent,

On Thu, Nov 23, 2023 at 11:46:52AM +0200, Laurent Pinchart wrote:
> (CC'ing Bartosz)

I'm already in discussion with Bart :-)

> On Tue, Nov 21, 2023 at 02:50:43PM +0100, Uwe Kleine-K=F6nig wrote:
> > This prepares the pwm driver of the ti-sn65dsi86 to further changes of
> > the pwm core outlined in the commit introducing devm_pwmchip_alloc().
> > There is no intended semantical change and the driver should behave as
> > before.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 25 ++++++++++++++++---------
> >  1 file changed, 16 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/br=
idge/ti-sn65dsi86.c
> > index c45c07840f64..cd40530ffd71 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -197,7 +197,7 @@ struct ti_sn65dsi86 {
> >  	DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
> >  #endif
> >  #if defined(CONFIG_PWM)
> > -	struct pwm_chip			pchip;
> > +	struct pwm_chip			*pchip;
>=20
> Dynamic allocation with devm_*() isn't the right solution for lifetime
> issues related to cdev. See my talk at LPC 2022
> (https://www.youtube.com/watch?v=3DkW8LHWlJPTU, slides at
> https://lpc.events/event/16/contributions/1227/attachments/1103/2115/2022=
0914-lpc-devm_kzalloc.pdf),
> and Bartosz's talk at LPC 2023
> (https://lpc.events/event/17/contributions/1627/attachments/1258/2725/Lin=
ux%20Plumbers%20Conference%202023.pdf).

Once the series is completely applied, the pwm_chip isn't allocated
using devm_kzalloc any more. You're only looking at an intermediate
state where I push the broken lifetime tracking from all drivers into a
single function in the core that is then fixed after all drivers are
converted to it.

If you find issues with the complete series applied, please tell me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--m7basmppiqka5heb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVfJQkACgkQj4D7WH0S
/k5UBAf9Hx7Bo4lGarW2XdUD9TsnQJcmEETxGAcjdrs9FKRie0l4wxFjKljLyx1v
nzb81eJFS35tnvRtoNK9/EpZqmBRtyRSjrvZC6yxydcmwQ+IJGE9JRkF54qTGWop
SnbKCVu733TLmcfBdSBQQHeTu3McsQx0tVJEJvQxGn7a1EtoyDQfJrm0VNNb5dMg
FquLZyWJG6Kjy5s9ijmG26NVVaZeu5Mq//+ah4F0g6Pe/hDQWTyh539/rH1Lub1A
bRFWvyAn37q0bVieDUSw0MPaoD67acU7ohBqR7QIuD1aCCHiSquHgJIoIaWVZiVf
vsh19UgImk4ZPtRK0Bpx/9LjXfxjSQ==
=bRsh
-----END PGP SIGNATURE-----

--m7basmppiqka5heb--

