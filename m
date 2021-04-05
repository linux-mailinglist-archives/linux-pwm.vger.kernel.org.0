Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363F535476C
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Apr 2021 22:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbhDEUQY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Apr 2021 16:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbhDEUQX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Apr 2021 16:16:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4399CC061756
        for <linux-pwm@vger.kernel.org>; Mon,  5 Apr 2021 13:16:17 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lTVdu-0007f2-NF; Mon, 05 Apr 2021 22:16:14 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lTVdt-0001UJ-E0; Mon, 05 Apr 2021 22:16:13 +0200
Date:   Mon, 5 Apr 2021 22:16:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: lpc18xx-sct: Free resources only after
 pwmchip_remove()
Message-ID: <20210405201610.idbdab3unlwaitjz@pengutronix.de>
References: <20210327212428.136684-1-u.kleine-koenig@pengutronix.de>
 <3797dc74-5f61-826f-307d-221a39f563af@mleia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2e6mvoytwjpdjqez"
Content-Disposition: inline
In-Reply-To: <3797dc74-5f61-826f-307d-221a39f563af@mleia.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2e6mvoytwjpdjqez
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Vladimir,

On Wed, Mar 31, 2021 at 11:37:37PM +0300, Vladimir Zapolskiy wrote:
> On 3/27/21 11:24 PM, Uwe Kleine-K=F6nig wrote:
> > Before pwmchip_remove() returns the PWM is expected to be functional. So
> > remove the pwmchip before disabling the clock.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >   drivers/pwm/pwm-lpc18xx-sct.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sc=
t.c
> > index 3f8e54ec28c6..b643ac61a2e7 100644
> > --- a/drivers/pwm/pwm-lpc18xx-sct.c
> > +++ b/drivers/pwm/pwm-lpc18xx-sct.c
> > @@ -441,13 +441,15 @@ static int lpc18xx_pwm_remove(struct platform_dev=
ice *pdev)
> >   	struct lpc18xx_pwm_chip *lpc18xx_pwm =3D platform_get_drvdata(pdev);
> >   	u32 val;
> > +	pwmchip_remove(&lpc18xx_pwm->chip);
> > +
> >   	val =3D lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_CTRL);
> >   	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL,
> >   			   val | LPC18XX_PWM_CTRL_HALT);
> >   	clk_disable_unprepare(lpc18xx_pwm->pwm_clk);
> > -	return pwmchip_remove(&lpc18xx_pwm->chip);
> > +	return 0;
> >   }
> >   static struct platform_driver lpc18xx_pwm_driver =3D {
>=20
> Acked-by: Vladimir Zapolskiy <vz@mleia.com>

Thanks.
=20
> A horde of PWM drivers does not satisfy the condition, please check
> at least quite popular pwm-rockchip.c, pwm-sti.c, pwm-vt8500.c,
> pwm-bcm2835.c etc., again, it would be preferable to see all the
> drivers fixed in a single series, thank you.

I'm aware that there are more drivers that need fixing and I will come
to them eventually. But I work on this on an on-and-off basis because
PWM driver fixing isn't the only thing I live for. So I send out a patch
whenever I finished one, I don't see a benefit to delay them just to
send them out in a series. If you want to work at fixing all drivers,
tell me, I have several other things to polish on my list.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2e6mvoytwjpdjqez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBrcAcACgkQwfwUeK3K
7Alq+Af/dw3S9a+e8aYUqyDiEYVuJ7QMRN4V37uNyv6ungTQCC4ddC1S8tuKi5xz
NG10W5mRxmEO/ivYbOB4p7uSSeATFonDBOZOYel/8PThwjuwSBdHTTyPYTjQ0cPB
77KyitVoShRfXClwSqDlP/6f7ieDgnKg0LsgpxDjyh8OqpX7AlAjA9r/JrjDn5S/
wh9HhC0rsLmiYDaCSKPmLawZ76cTbskaIyLI4cIKhPm9V0YEbFd53EsTwFcU24oC
m5xuZEU8wbQTRMNgqssrYhSDdtTRQzH2i7NzOH7kqhFvt4gYL3NWcgo5Pp5TVK9o
9fI+np/LqXuCs7vQzwkTJZKxyZv5FA==
=Eya5
-----END PGP SIGNATURE-----

--2e6mvoytwjpdjqez--
