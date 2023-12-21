Return-Path: <linux-pwm+bounces-597-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D118A81B4BC
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Dec 2023 12:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632EFB223B1
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Dec 2023 11:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF226ABB3;
	Thu, 21 Dec 2023 11:17:39 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9386AB9F
	for <linux-pwm@vger.kernel.org>; Thu, 21 Dec 2023 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGH3U-00059L-Jp; Thu, 21 Dec 2023 12:17:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGH3S-000Vit-Sp; Thu, 21 Dec 2023 12:17:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGH3T-001POd-MZ; Thu, 21 Dec 2023 12:17:31 +0100
Date: Thu, 21 Dec 2023 12:17:31 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-pwm@vger.kernel.org, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Kevin Hilman <khilman@baylibre.com>, kernel@pengutronix.de, 
	linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] MAINTAINERS: pwm: Thierry steps down, Uwe takes over
Message-ID: <bgydjom2y32ahs7y5o5xel67ybpifydmeokc7ew7ocm66gway2@v76vqgxrw3ho>
References: <20231206214817.1783227-2-u.kleine-koenig@pengutronix.de>
 <ZXM72QYBbb32Q_aL@orome.fritz.box>
 <20231208190620.5qobgtyii2wt7tfa@pengutronix.de>
 <ZXbsDRslZNKCeJF9@orome.fritz.box>
 <20231211141900.x6tpyctch5fv3uqf@pengutronix.de>
 <ZXcpswXxb1oQldp5@orome.fritz.box>
 <20231212203352.wl3rzob75fct4lov@pengutronix.de>
 <ZYMPc50eBi6oBClu@orome.fritz.box>
 <6nj7rmq36hj5m26b7yhlbmpfps5wuxkx4zwyvttg4cpgocimj7@xtqm4qleo3s6>
 <ZYQMA-tM-zl5IJyC@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i3hpii6aoqhh5mej"
Content-Disposition: inline
In-Reply-To: <ZYQMA-tM-zl5IJyC@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--i3hpii6aoqhh5mej
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Dec 21, 2023 at 10:57:23AM +0100, Thierry Reding wrote:
> Looks all good to me. I'll keep things going until the next merge window
> and will then send out my last PWM pull request and let Linus know to
> expect future requests to come from you.

Sounds good.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--i3hpii6aoqhh5mej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWEHsoACgkQj4D7WH0S
/k6XeggAolfcwyJ6/eHa78Mwclwm/k8z28O6swoIpBNWbgoSO0Zr97YOtHDzmRrn
DE2m1Wu4CbQDVE03wRkDcTP0zbgqzj8f9MzFoONQLczlFf/jIgsR7DhyIV8IyxuR
WJ0tvVWBsrWG2dYDEgyuD84d8xLcMWOIHRL3P5KDsuy5p0Oae0CER58u4wnlHP9P
iBk5Vp8tDsBZp2EL6TE2ggc7pQLwbusyvC/0bgd3mWmGslmpYjWl6GkW/PgxhQKi
4Zj2aW+eXeBen1ZvVBhr+k/+t+ZapWLcYiymaEKw2I0mD4OlKOkV6/BMz2PW7yCc
hU/SnqoH0eJ+V0+WBLG1bDx5Oyq8TA==
=0/BY
-----END PGP SIGNATURE-----

--i3hpii6aoqhh5mej--

