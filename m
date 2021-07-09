Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5843C1F20
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Jul 2021 07:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhGIF4i (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Jul 2021 01:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhGIF4h (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Jul 2021 01:56:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B9CC061574
        for <linux-pwm@vger.kernel.org>; Thu,  8 Jul 2021 22:53:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1jSI-0007lA-QR; Fri, 09 Jul 2021 07:53:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1jSE-0003cR-5b; Fri, 09 Jul 2021 07:53:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1jSE-0000zp-38; Fri, 09 Jul 2021 07:53:38 +0200
Date:   Fri, 9 Jul 2021 07:53:25 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v8 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20210709055325.4y4ufjvoiwo2pcvi@pengutronix.de>
References: <20210608064658.14262-1-billy_tsai@aspeedtech.com>
 <20210608064658.14262-3-billy_tsai@aspeedtech.com>
 <20210702143147.6a7psfup4tlidq2x@pengutronix.de>
 <FC122EAB-46A9-4B6F-B75C-271B4E17F057@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qqbiwvrhqx7yu7h3"
Content-Disposition: inline
In-Reply-To: <FC122EAB-46A9-4B6F-B75C-271B4E17F057@aspeedtech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qqbiwvrhqx7yu7h3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Billy,

On Fri, Jul 09, 2021 at 05:40:45AM +0000, Billy Tsai wrote:
> On 2021/7/2, 10:32 PM, "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.=
de> wrote:
>     > The multiplication can be up to:
>=20
>     >	100000000 * (1 << 31) * (31 + 1) * (255 + 1)
>=20
>     > right? This needs 71 bits and so might overflow a u64.
>=20
> No, the multiplication can be up to:
>=20
> Max(div_h) =3D 15
> Max(div_l) =3D 255
> Max(clk_period) =3D 255
> 1000000000 * (1 << 15) * (255 + 1) * (255 + 1) < 2^64 - 1
> it doesn't overflow a u64.

Ah, you're right. Please note this in a comment (not that you were
right, but that it doesn't overflow :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qqbiwvrhqx7yu7h3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDn5FAACgkQwfwUeK3K
7AkCLgf/Wqw5mfuphqGF4+uRZjb+BVpbgi6TY8lgmZQS9hR+16ML35aNawrAo0J/
c/2e0I8SQtbevb552QGX2eSStU0i/jPIWBpXRzYBxYNy4+tYOdpL59GEA5qZJeH7
R83lXsYsQEOGoSufHH3MsHWZfPXNms1rxZAmQ1Zlp6AqRVwVNE+cLdC3ByC9qxxl
Um2TbbOwVHvQfhXgfGLwlC1rmBeDU0I0rrdWNBnw3ifWKCCHuwytg/mJ0c/MXKzo
44gxD+YqV0J1gy9vKLtNWEOFY8RBXV5UjPQLgH2bk5vD9xLOATF11c5wc2e58s6P
aCwg6rvWFB+hrS+UP6aXQlO4CKM5uQ==
=i2jo
-----END PGP SIGNATURE-----

--qqbiwvrhqx7yu7h3--
