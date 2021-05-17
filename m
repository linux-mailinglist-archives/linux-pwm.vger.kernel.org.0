Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582D9383AC7
	for <lists+linux-pwm@lfdr.de>; Mon, 17 May 2021 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbhEQRL5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 May 2021 13:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhEQRL4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 May 2021 13:11:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C646BC061573
        for <linux-pwm@vger.kernel.org>; Mon, 17 May 2021 10:10:39 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1liglF-0008Nn-Lo; Mon, 17 May 2021 19:10:33 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1liglB-0002jh-0K; Mon, 17 May 2021 19:10:29 +0200
Date:   Mon, 17 May 2021 19:10:28 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v5 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20210517171028.qioxg53dpzlq4izu@pengutronix.de>
References: <20210514024845.10531-1-billy_tsai@aspeedtech.com>
 <20210514024845.10531-3-billy_tsai@aspeedtech.com>
 <20210515151827.amiqh6j6brv44jif@pengutronix.de>
 <7A439233-C5FF-4BCA-8A5C-945EB847F487@aspeedtech.com>
 <20210517060615.3hyifoebyrddsrta@pengutronix.de>
 <C451B628-C0CC-47E9-84EF-42DB8518FE1E@aspeedtech.com>
 <20210517063500.toxlb2wbtbqpczwl@pengutronix.de>
 <52C0ED72-65A7-4C39-820F-D4368191878B@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xebupssd5zqcte57"
Content-Disposition: inline
In-Reply-To: <52C0ED72-65A7-4C39-820F-D4368191878B@aspeedtech.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xebupssd5zqcte57
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 17, 2021 at 07:12:53AM +0000, Billy Tsai wrote:
> Hi,
>=20
>     > On 2021/5/17, 2:35 PM,Uwe Kleine-K=F6nigwrote:
>=20
>     >   On Mon, May 17, 2021 at 06:23:06AM +0000, Billy Tsai wrote:
>     >   > Hi,
>     >   > 	On 2021/5/17, 2:06 PM,Uwe Kleine-K=F6nigwrote:
>     >   >=20
>     >   > 	On Mon, May 17, 2021 at 02:53:44AM +0000, Billy Tsai wrote:
>     >   > 	>	> On 2021/5/15, 11:57 PM,Uwe Kleine-K=F6nigwrote:
>     >   > 	>	>=20
>     >   > 	>	> 	>	> +	div_h =3D DIV_ROUND_DOWN_ULL(div_h,
>     >   > 	>	> 	>	> +				   (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1));
>     >   > 	>	> 	>	> +	div_h =3D DIV_ROUND_DOWN_ULL(div_h, NSEC_PER_SEC);
>     >   > 	>	>=20
>     >   > 	>	> 	> As a division is an expensive operation you can better =
first multiply
>     >   > 	>	> 	> NSEC_PER_SEC and FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) +=
 1 and divide by
>     >   > 	>	> 	> the result.
>     >   > 	>	>=20
>     >   > 	>	> When I multiply NSEC_PER_SEC and FIELD_MAX(PWM_ASPEED_CTRL=
_CLK_DIV_L) + 1 the result will overflow
>     >   > 	>	> for 32-bits and the divisor type of do_div is 32-bits so I=
 need to do div twice to avoid the issue.
>     >   > 	>	> Can you give me some suggests?
>     >   >=20
>     >   > 	> Hmm, you're right. There doesn't seem to be a div64_64, I th=
ought there
>     >   > 	> was one. Anyhow, while looking at the various divide functio=
ns I saw
>     >   > 	> that dividing by a constant shouldn't be that expensive, so =
I think the
>     >   > 	> sane way is to keep the two divisions and add a comment desc=
ribing the
>     >   > 	> problem.
>     >   > According to our fixed value, I think that I can use bit shift =
to reduce one divide function:
>     >   >=20
>     >   > rate =3D clk_get_rate(priv->clk);
>     >   > /* Get the smallest value for div_h  */
>     >   > div_h =3D rate * state->period;
>     >   > div_h >>=3D (__fls(PWM_ASPEED_FIXED_PERIOD + 1) +
>     >   > 	   __fls(FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1));
>     >   > div_h =3D DIV_ROUND_DOWN_ULL(div_h, NSEC_PER_SEC);
>=20
>     > Did you check how this is compiled to code? I'd expect that it does=
n't
>     > result in better code than writing it as a division. Given that a
>     > division is easier to understand for a human reader, I'd stick to t=
hat.
>=20
> I found that I can use div64_64 through #include <linux/math64.h> and use=
 "div64_u64":
>=20
> u64 div_h, div_l, divisor;
> u32 index =3D pwm->hwpwm;
>=20
> rate =3D clk_get_rate(priv->clk);
> /* Get the smallest value for div_h  */
> div_h =3D rate * state->period;
> divisor =3D (u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1) *
>                 (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1);
> div_h =3D div64_u64(div_h, divisor);
> div_h =3D order_base_2(div_h);
> if (div_h > 0xf)
>         div_h =3D 0xf;
>=20
> div_l =3D rate * state->period;
> divisor =3D (u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1) *
>                 BIT(div_h);
> div_l =3D div64_u64(div_l, divisor);
>=20
> Can I use this one?

Looks good to me. If you want to improve further you can expand the
comment about div_h to somethink like:

	/*
	 * Pick a small value for div_h so that div_l can be big which
	 * results in a finer resolution near the target period value.
	 */

Another detail I don't like much is that the name div_h is only
justified after the last assignment. I don't have a good suggestion here
though.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xebupssd5zqcte57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCio4IACgkQwfwUeK3K
7Amhpwf/WtOHMRqxyC/ROADLloWz8ncu+TvosU/nXy3m3ZcuxpOqef8jPpFE8kis
NmYnj+N9FqyCCJlsfAXJAzUe8B4j/mBUquCgHH/yeqQNoYyzE58poBXkBKX/4bAO
DUqBPN51DxtLzx3abfrY0hnF8ilLMtz9an8FHyhdY5FqdNXLIBeImYM07kqOgGbw
hLN5ZUi4XCfj0H0+Lm9b4ammvd4K2ovmYubvm3vON8f2hJNoSqjyTMoJPaE6Te8b
5Bz+H8LllZqRSoQ4x13/bCRY+Nf8skLASEK5SCnUE0T5r+kMkvDQrf8TuXIXtvJ0
nveFQR1y3vjvD0EJp7J7xSQSS7EB9A==
=aEYS
-----END PGP SIGNATURE-----

--xebupssd5zqcte57--
