Return-Path: <linux-pwm+bounces-260-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2399E7FE900
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 07:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 930B4B20B7E
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 06:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9523E1D688;
	Thu, 30 Nov 2023 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086A7D7F
	for <linux-pwm@vger.kernel.org>; Wed, 29 Nov 2023 22:13:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8aJ8-0003P6-UF; Thu, 30 Nov 2023 07:13:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8aJ8-00CZR9-BR; Thu, 30 Nov 2023 07:13:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8aJ8-00BL3y-0o; Thu, 30 Nov 2023 07:13:54 +0100
Date: Thu, 30 Nov 2023 07:13:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: bcm2835: Fix NPD in suspend/resume
Message-ID: <20231130061353.65nfjd7uwbpiswv2@pengutronix.de>
References: <20231113164632.2439400-1-florian.fainelli@broadcom.com>
 <170119374441.445690.2721498852495955001.b4-ty@gmail.com>
 <20231128205548.hfvknhimerqdunpx@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jjs637ortku6yomh"
Content-Disposition: inline
In-Reply-To: <20231128205548.hfvknhimerqdunpx@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--jjs637ortku6yomh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Tue, Nov 28, 2023 at 09:55:48PM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Nov 28, 2023 at 06:49:22PM +0100, Thierry Reding wrote:
> >=20
> > On Mon, 13 Nov 2023 08:46:32 -0800, Florian Fainelli wrote:
> > > When 119a508c4dc9 ("pwm: bcm2835: Add support for suspend/resume") was
> > > sent out on October 11th,, there was still a call to
> > > platform_set_drvdata() which would ensure that the driver private data
> > > structure could be used in bcm2835_pwm_{suspend,resume}.
> > >=20
> > > A cleanup now merged as commit commit 2ce7b7f6704c ("pwm: bcm2835:
> > > Simplify using devm functions") removed that call which would now cau=
se
> > > a NPD in bcm2835_pwm_{suspend,resume} as a consequence.
> > >=20
> > > [...]
> >=20
> > Applied, thanks!
> >=20
> > [1/1] pwm: bcm2835: Fix NPD in suspend/resume
> >       commit: fba7e9f839d7fcb0888094697da45c5668226455
>=20
> This one should IMHO go into v6.7. Do you intend to send it to Linus
> during the current cycle?

We know since > 2 weeks now that the pwm-bcm2835 driver is broken in
v6.7-rc1 and there is a fix since day 0.

If you continue to be silent about this (here and at
https://lore.kernel.org/linux-pwm/20231121112029.gyv3gqirlycysyr4@pengutron=
ix.de)
I intend to send a PR to Linus with this fix on Friday next week.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jjs637ortku6yomh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVoKCEACgkQj4D7WH0S
/k7HYAf/URew5nIRarRMFGvAgplEOGdIkQVtIXMXacT73bGzqhX3nzbpEVLR5bJm
Nqz40XCT39J4v880D8S6ShVaIGhDu0r2KB7xCEpccSkhR33QIaziOsTNotbh+7eC
8O5QHSISNOrxit2QfAIkylP1uvmKetz5AdANtqm8l1rRW/2advFDRzGzEciBKGN8
KEGwRnkXfSVTkjmUoISHRb8HmuWhi76YyCKUXk8wWyUjZ8Eae4c/q6HUFDwbD4RZ
/L/o3A626T3W7pWMlsiJ+p8q1TkTEpp8sJjFZswB/+4/1Hzl/pkF7TTP9hNhlEsL
aIMNEISJNT7Ck5pAJ/xg4ve9MHlGLg==
=lsbJ
-----END PGP SIGNATURE-----

--jjs637ortku6yomh--

