Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9A735ADD8
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Apr 2021 15:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhDJN51 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 10 Apr 2021 09:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbhDJN51 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 10 Apr 2021 09:57:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF1FC06138B
        for <linux-pwm@vger.kernel.org>; Sat, 10 Apr 2021 06:57:12 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVE6c-0008GH-JZ; Sat, 10 Apr 2021 15:56:58 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVE6c-0007Dp-7b; Sat, 10 Apr 2021 15:56:58 +0200
Date:   Sat, 10 Apr 2021 15:56:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
Message-ID: <20210410135658.pf7eg5x5bdhndxkg@pengutronix.de>
References: <20210409090709.1918021-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210409090709.1918021-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <YHBUjPjEpLYF/915@orome.fritz.box>
 <20210409213455.6f25m4jyttqn75hf@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yuj53qadwvlrvifp"
Content-Disposition: inline
In-Reply-To: <20210409213455.6f25m4jyttqn75hf@toshiba.co.jp>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yuj53qadwvlrvifp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Apr 10, 2021 at 06:34:55AM +0900, Nobuhiro Iwamatsu wrote:
> > > +static int visconti_pwm_remove(struct platform_device *pdev)
> > > +{
> > > +	struct visconti_pwm_chip *priv =3D platform_get_drvdata(pdev);
> > > +
> > > +	return pwmchip_remove(&priv->chip);
> >=20
> > I think Uwe would prefer this to be done separately because he's working
> > towards removing the return value from pwmchip_remove() and if we start
> > ignoring it in new drivers that will make life easier going forward.
> >=20
> > So this should just be:
> >=20
> > 	pwmchip_remove(&priv->chip);
> >=20
> > 	return 0;
>=20
> I understand your suggestion.
> However, it looks like the pwmchip_remove() hasn't been updated yet.
> I will wait for the update of pwmchip_remove.

pwmchip_remove will always return 0 since b2c200e3f2fd which is in v5.3.
So Thierry's suggestion is safe and indeed welcome.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yuj53qadwvlrvifp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBxrqcACgkQwfwUeK3K
7An+hQgAj2qaimHxOZxUmLVDVonb3IXjlqjNIUaxsPEkWqsxkVe0Qft4EEJuw0zr
XXHF54BLbK163akwKdlIiRbXBWr2wa8weVst/QyhjvLZC3SK1aarrxetSCt+ySFU
Ujq0EerNvC8JR9Npxq2p3wwo5FgOMCzuPAfCVqH2YT7hpdEAj3IxtJS516rFeUFr
L3mVCtN6IHxhsYbx74xaQ5aARALCw3CTOwNTFIXY3ash9u3Rq2MhiWMjTnpiwcge
UsGOKlJkhauN6uUy7M2lBL0ccL2d/JZKVv1iKcBGdx8v4eH7HAWz5utoH60h+EEL
XZa5gLu0WNXUnCi37W8DUQGL4xIzFQ==
=3NT8
-----END PGP SIGNATURE-----

--yuj53qadwvlrvifp--
