Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D1E20309A
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jun 2020 09:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgFVH0Q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Jun 2020 03:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731354AbgFVH0Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Jun 2020 03:26:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DCBC061794
        for <linux-pwm@vger.kernel.org>; Mon, 22 Jun 2020 00:26:16 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jnGq3-0007TP-4w; Mon, 22 Jun 2020 09:25:55 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jnGq2-00011S-8g; Mon, 22 Jun 2020 09:25:54 +0200
Date:   Mon, 22 Jun 2020 09:25:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 03/15] pwm: lpss: Fix off by one error in base_unit
 math in pwm_lpss_prepare()
Message-ID: <20200622072554.qkuvf25xmy3vyjd2@taurus.defre.kleine-koenig.org>
References: <20200620121758.14836-1-hdegoede@redhat.com>
 <20200620121758.14836-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s33yr6daqbbyscr3"
Content-Disposition: inline
In-Reply-To: <20200620121758.14836-4-hdegoede@redhat.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--s33yr6daqbbyscr3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2020 at 02:17:46PM +0200, Hans de Goede wrote:
> According to the data-sheet the way the PWM controller works is that
> each input clock-cycle the base_unit gets added to a N bit counter and
> that counter overflowing determines the PWM output frequency.
>=20
> So assuming e.g. a 16 bit counter this means that if base_unit is set to =
1,
> after 65535 input clock-cycles the counter has been increased from 0 to
> 65535 and it will overflow on the next cycle, so it will overflow after
> every 65536 clock cycles and thus the calculations done in
> pwm_lpss_prepare() should use 65536 and not 65535.
>=20
> This commit fixes this. Note this also aligns the calculations in
> pwm_lpss_prepare() with those in pwm_lpss_get_state().
>=20
> Note this effectively reverts commit 684309e5043e ("pwm: lpss: Avoid
> potential overflow of base_unit"). The next patch in this series really
> fixes the potential overflow of the base_unit value.
>=20
> Fixes: 684309e5043e ("pwm: lpss: Avoid potential overflow of base_unit")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Add Fixes tag
> - Add Reviewed-by: Andy Shevchenko tag
> ---
>  drivers/pwm/pwm-lpss.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index 9d965ffe66d1..43b1fc634af1 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -93,7 +93,7 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm=
, struct pwm_device *pwm,
>  	 * The equation is:
>  	 * base_unit =3D round(base_unit_range * freq / c)
>  	 */
> -	base_unit_range =3D BIT(lpwm->info->base_unit_bits) - 1;
> +	base_unit_range =3D BIT(lpwm->info->base_unit_bits);
>  	freq *=3D base_unit_range;
> =20
>  	base_unit =3D DIV_ROUND_CLOSEST_ULL(freq, c);
> @@ -104,8 +104,8 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lp=
wm, struct pwm_device *pwm,
> =20
>  	orig_ctrl =3D ctrl =3D pwm_lpss_read(pwm);
>  	ctrl &=3D ~PWM_ON_TIME_DIV_MASK;
> -	ctrl &=3D ~(base_unit_range << PWM_BASE_UNIT_SHIFT);
> -	base_unit &=3D base_unit_range;
> +	ctrl &=3D ~((base_unit_range - 1) << PWM_BASE_UNIT_SHIFT);
> +	base_unit &=3D (base_unit_range - 1);
>  	ctrl |=3D (u32) base_unit << PWM_BASE_UNIT_SHIFT;
>  	ctrl |=3D on_time_div;

I willing to believe your change is right, what I don't like is that the
calculation is really hard to follow. But that's nothing I want to
burden on you to improve. (If however you are motivated, adding some
comments about the hardware would probably help.)

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s33yr6daqbbyscr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7wXP8ACgkQwfwUeK3K
7AnlQggAnmb/EK9bchCisGMTtET3A8MmMvsLrGaMsQG0BI4fWzS2SnYifvpSTs57
BrrYG0y72GKb6hx7rxvlkTHRHIq9x0jMvcEan6ZFjVjdrX7cqKo3/yd399PmE0VB
ewOY+xd2xKIT/NXtUdcsoU6jfNA9+NxVMZpNBuA9sPS+Bn3pXbeBWrl0w7gAefhs
S08mgy7B9a+njGYt5wF1n3hhyrDZ7kJIUdS4jCczjgC8zQ6QciVRRoSw+cyWU58o
AkvPSA/e99kHzkKTns/j2BTx7fKqyelpqTFy0+Sc4LEqr7H2N+1mToBYGiDgb87Q
4uD50mRhYHbfRtzms/sOWvjRfPvsGQ==
=qThH
-----END PGP SIGNATURE-----

--s33yr6daqbbyscr3--
