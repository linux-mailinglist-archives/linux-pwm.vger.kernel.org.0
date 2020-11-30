Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185562C8705
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Nov 2020 15:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgK3On5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Nov 2020 09:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgK3On5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Nov 2020 09:43:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F8FC0613CF
        for <linux-pwm@vger.kernel.org>; Mon, 30 Nov 2020 06:43:16 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kjkOT-0003Ye-PB; Mon, 30 Nov 2020 15:43:09 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kjkOP-00074L-3P; Mon, 30 Nov 2020 15:43:05 +0100
Date:   Mon, 30 Nov 2020 15:43:03 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] gpio: mvebu: fix potential user-after-free on probe
Message-ID: <20201130144303.pe2iqr5lzj43jevt@pengutronix.de>
References: <c27a61d66a9ec4e52e0d1820ce9528ffa18ca539.1606743203.git.baruch@tkos.co.il>
 <20201130135130.rynozhii4yfxtmdh@pengutronix.de>
 <87blffdk4v.fsf@tarshish>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="43qxzxiwep2fmzrm"
Content-Disposition: inline
In-Reply-To: <87blffdk4v.fsf@tarshish>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--43qxzxiwep2fmzrm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Baruch,

On Mon, Nov 30, 2020 at 03:55:28PM +0200, Baruch Siach wrote:
> On Mon, Nov 30 2020, Uwe Kleine-K=F6nig wrote:
> > On Mon, Nov 30, 2020 at 03:33:23PM +0200, Baruch Siach wrote:
> >> When mvebu_pwm_probe() fails IRQ domain is not released. Move
> >> mvebu_pwm_probe() before IRQ domain registration.
> >
> > And now if something with IRQ domain registration fails the pwm stuff
> > isn't freed?
>=20
> As far as I can see mvebu_pwm_probe() uses devres exclusively to
> allocate resources.

there is no devm magic in pwmchip_add().

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--43qxzxiwep2fmzrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/FBPQACgkQwfwUeK3K
7Amx2gf9GKCQ86q3UuLBWIwiRROK2bAgRstzlnjOwHtPTkcyUqvwYxn64+M2wpNq
x1cNVsKPFOLul3RHAYxYMyoT7VAWWjvCU70qSCcyOYIaUJbZisg4/iVa093rOQ/m
OwRlfFxsxnGkwdEqiOqrFmg4qQANUXYoDotTgoVEkGDvTMTvnWcrYk4nFUeBxPDz
yRHxZEgmlCh6Wa/Fuq4Ih/4N9Y1RGMIXC9tZpM56kiB8tXRDiCYnmrZY7UB8Oyhh
yz+iKditBILRGE8j0udn35bn26bflBrTRikXHGh1/H8Zvy8TDqszJkyMqnOhT7rC
9RhVcUPaYXlrt4SL9EF5RLVmx0afLA==
=ylWq
-----END PGP SIGNATURE-----

--43qxzxiwep2fmzrm--
