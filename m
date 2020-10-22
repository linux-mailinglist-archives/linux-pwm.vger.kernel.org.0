Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F601296533
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Oct 2020 21:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370063AbgJVTW5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Oct 2020 15:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370064AbgJVTW5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Oct 2020 15:22:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5CAC0613CE
        for <linux-pwm@vger.kernel.org>; Thu, 22 Oct 2020 12:22:57 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kVgAp-0004WC-MU; Thu, 22 Oct 2020 21:22:55 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kVgAo-00036w-Nb; Thu, 22 Oct 2020 21:22:54 +0200
Date:   Thu, 22 Oct 2020 21:22:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: ab8500: Add error message if pwmchip_add() fails
Message-ID: <20201022192253.5c2c2jmxtsji2fnh@pengutronix.de>
References: <20200812075214.499-1-u.kleine-koenig@pengutronix.de>
 <20200812081139.GC4354@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lflftbotac6x3su3"
Content-Disposition: inline
In-Reply-To: <20200812081139.GC4354@dell>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lflftbotac6x3su3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2020 at 09:11:39AM +0100, Lee Jones wrote:
> On Wed, 12 Aug 2020, Uwe Kleine-K=F6nig wrote:
>=20
> > pwmchip_add() doesn't emit an error message, so add one in the driver.
>=20
> Maybe placing one there would be a good idea.
>=20
> It would certainly cut down on a lot of superfluous strings.

Hmm, I'm not convinced. Do you want to work on that? If not I suggest to
still apply the patch as currently it is justified.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lflftbotac6x3su3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+R3AoACgkQwfwUeK3K
7AniaAgAgDGaDt7Wkga6a4zvu+qYMPrxpPrrz3MCAlX0Nn+5MDRjLNacKL4giUGp
rR4INp06iB8T6GsnHwZhKXPGcjtJuzGY/aOH3uSbOSJquTIjK/bMcesKCHul91UL
25xS97Q5uoMfTm7RzDC0O5VLqX80HpkbhjjiPuzHU2a4lw0exw9w+s0ozTs+751P
CgJf9clGv0cPwW6V5hZBm/FwR9MYSuW7pAQOrFbrUwnoVWHyze//YzioNWqZ2Wo9
t6JRU4LG39MiBN0bpXLfqLbHyAAgHyCREZFrsBRQAUeO4RNrptXuqhOpZs/x1uaC
eL4Rn/6m6IIwlyTdPLCGbDX3Ljv/IA==
=AiqE
-----END PGP SIGNATURE-----

--lflftbotac6x3su3--
