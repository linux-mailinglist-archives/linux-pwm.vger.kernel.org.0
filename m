Return-Path: <linux-pwm+bounces-159-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA1E7F550B
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 00:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4262813C9
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 23:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3F8219EC;
	Wed, 22 Nov 2023 23:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3261B6
	for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 15:52:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5x16-0007J3-Lt; Thu, 23 Nov 2023 00:52:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5x16-00Auvb-2i; Thu, 23 Nov 2023 00:52:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5x15-0066Zq-Pw; Thu, 23 Nov 2023 00:52:23 +0100
Date: Thu, 23 Nov 2023 00:52:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 104/108] pwm: Ensure that pwm_chips are allocated
 using pwmchip_alloc()
Message-ID: <20231122235223.jsksp43mfdbwls7i@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-105-u.kleine-koenig@pengutronix.de>
 <ZV44H9ZQDuEA217B@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qm3gzwbktco7ksv6"
Content-Disposition: inline
In-Reply-To: <ZV44H9ZQDuEA217B@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--qm3gzwbktco7ksv6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Wed, Nov 22, 2023 at 06:19:27PM +0100, Thierry Reding wrote:
> On Tue, Nov 21, 2023 at 02:50:46PM +0100, Uwe Kleine-K=F6nig wrote:
> > Memory holding a struct device must not be freed before the reference
> > count drops to zero. So a struct pwm_chip must not live in memory
> > freed by a driver on unbind. All in-tree drivers were fixed accordingly,
> > but as out-of-tree drivers, that were not adapted, still compile fine,
> > catch these in pwmchip_add().
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/core.c  | 10 ++++++++++
> >  include/linux/pwm.h |  1 +
> >  2 files changed, 11 insertions(+)
>=20
> We don't usually care about out of tree drivers.

I'm open to drop this patch if you insist. But I think it's nice to
out-of-tree driver maintainers (not sure how much there really are?) to
not silently break their drivers.

> But this also indicates to me that we're doing something wrong here.
> If we cared about out of tree drivers we should be implementing this
> in a way that doesn't break things immediately.

Given that drivers need adaption -- see the main amount of the patches
in this series -- not breaking out-of-tree drivers isn't possible.

> If we don't care, we might as well make sure that compilation breaks
> for any drivers that haven't been adapted.

This could be done. The most straight forward way to do that is to
invent a new name for struct pwmchip or pwmchip_register() or change the
latter's arguments. However I like the outcome and wouldn't change the
implementation just to break out-of-tree driver's compilation. That's
why I chose to implement this patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qm3gzwbktco7ksv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVelDYACgkQj4D7WH0S
/k7Ctwf/QbFRWiVcINOwiP9KLJNr5wtN1r9xAYYBFO2iHD4GaQW14LdIwdcD1JD5
CGzOXtUvoX2SeESxIz06nNjjM17palWKA4BFkGmHONYQuytucCv+L7ROhCMr8OlQ
CuOh9tgb4ALXtISQ2hXWBB4Jm12yTer6XqGvqj/bc0aG1tV9CuTj3fqaazYlUWlo
frusScNkKiNqmJwMjFyOg4co1fJyiZFvs0mm2f+OvfqcmjDNcUrgdfj+5eATRGjk
OhRTYTACq9ac+ddzBa/MyQ473GtDuu9BRQJw10lAPkythXRSs4NBL2TRRAaombWE
KuYEfiusr1Za3rypRbIkPpsC9pdUvg==
=MWwq
-----END PGP SIGNATURE-----

--qm3gzwbktco7ksv6--

