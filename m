Return-Path: <linux-pwm+bounces-419-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CED807246
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 15:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4337B20E3A
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 14:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920023DBBB;
	Wed,  6 Dec 2023 14:23:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F811BD
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 06:23:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAso7-00055u-4j; Wed, 06 Dec 2023 15:23:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAso5-00Dyyj-9z; Wed, 06 Dec 2023 15:23:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAso5-00FWd8-0W; Wed, 06 Dec 2023 15:23:21 +0100
Date: Wed, 6 Dec 2023 15:23:02 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Robert Foss <rfoss@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Douglas Anderson <dianders@chromium.org>,
	dri-devel@lists.freedesktop.org,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 101/108] drm/bridge: ti-sn65dsi86: Make use of
 devm_pwmchip_alloc() function
Message-ID: <20231206142302.veoybwpvt77rskd6@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-102-u.kleine-koenig@pengutronix.de>
 <20231123094652.GH15697@pendragon.ideasonboard.com>
 <20231123101018.u6c6nymmkam5ltir@pengutronix.de>
 <20231206120611.GI22607@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zs6l5avnfu4nmnmv"
Content-Disposition: inline
In-Reply-To: <20231206120611.GI22607@pendragon.ideasonboard.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--zs6l5avnfu4nmnmv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 02:06:11PM +0200, Laurent Pinchart wrote:
> On Thu, Nov 23, 2023 at 11:10:18AM +0100, Uwe Kleine-K=F6nig wrote:
> > Once the series is completely applied, the pwm_chip isn't allocated
> > using devm_kzalloc any more. You're only looking at an intermediate
> > state where I push the broken lifetime tracking from all drivers into a
> > single function in the core that is then fixed after all drivers are
> > converted to it.
>=20
> Indeed, I missed that devm_pwm_alloc() got changed later in the series
> to not call devm_kzalloc(). The naming is quite unfortunate, a
> devm_*_alloc() function really gives a strong hint that the
> corresponding cleanup at device remove time will be a free(), not a
> put() :-S That's pretty confusing for the readers.

Note there is a v4 in the meantime. My suggestion to rename
pwmchip_alloc() to pwmchip_get_new() could address this concern. Would
you like that? I didn't get any feedback about it when I suggested it
somewhere in the v3 thread. (I'm not sure I like it, given that
foo_alloc() is quite usual for other subsystems.)

> > If you find issues with the complete series applied, please tell me.
>=20
> One thing I still dislike is forcing drivers to dynamically allocate the
> pwm_chip series.

A struct pwm_chip must be allocated dynamically as it's reference
counted by a struct device. Given that nearly all drivers allocate their
driver data dynamically, too, this isn't a big issue IMO.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zs6l5avnfu4nmnmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVwg8UACgkQj4D7WH0S
/k6RXQf9GpPx1PyMC+wRqQElqp1h9M+WmZC5EuUi6xZIAp2iIlJGQ+uxsTsL9pg5
zEppRD5r/7aFOeHZjMNmSkEmIIDXAwPmDrOovlJDQyoFDKdUnW9UBwkUgYucaP9v
0tZ4QqiTXEjLEzA2Pd12xx9JPwSNDp6T69bqtpedUeqlUclzPKPs1SqKw8b8JibE
kZBYTunkkti0pt2TZrilPMQVeZqY8O5f4senU7cY5iARzbaYzLWRxlRylSnTxE5J
Mwm5H4TH7E17wQ9709Qd2EvxGFWR8afdMCJwILu3zDvyw5FwjbcB9JrOzjdwOhUN
EaH2KQqLWC/eMf7jH7xJsqwj61zhpw==
=ql0j
-----END PGP SIGNATURE-----

--zs6l5avnfu4nmnmv--

