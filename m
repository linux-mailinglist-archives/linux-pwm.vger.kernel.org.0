Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B602F94B5
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Jan 2021 19:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbhAQSqs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 Jan 2021 13:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbhAQSqo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 Jan 2021 13:46:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BCEC061574
        for <linux-pwm@vger.kernel.org>; Sun, 17 Jan 2021 10:46:03 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l1D3m-0006sz-4E; Sun, 17 Jan 2021 19:45:58 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l1D3l-000844-2R; Sun, 17 Jan 2021 19:45:57 +0100
Date:   Sun, 17 Jan 2021 19:45:56 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicola Di Lieto <nicola.dilieto@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pwm: pwm-gpio: New driver
Message-ID: <20210117184556.7huqlkxykjwionok@pengutronix.de>
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
 <20201211170432.6113-1-nicola.dilieto@gmail.com>
 <20201211170432.6113-2-nicola.dilieto@gmail.com>
 <20210117130434.663qpp6noujptdyt@pengutronix.de>
 <20210117135803.gt2zgta5pv7o6t6t@einstein.dilieto.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ja7r6p7sxf5p6ir6"
Content-Disposition: inline
In-Reply-To: <20210117135803.gt2zgta5pv7o6t6t@einstein.dilieto.eu>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ja7r6p7sxf5p6ir6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nicola,

On Sun, Jan 17, 2021 at 02:58:03PM +0100, Nicola Di Lieto wrote:
> On Sun, Jan 17, 2021 at 02:04:34PM +0100, Uwe Kleine-K=F6nig wrote:
> > > +	if (!atomic_read(&pwm_gpio->enabled))
> > > +		return HRTIMER_NORESTART;
> > > +
> > > +	if (pwm_gpio->state) {
> > > +		ns =3D pwm_gpio->cur.toff_ns;
> > > +		pwm_gpio->state =3D false;
> > > +	} else {
> > > +		if (spin_trylock(&pwm_gpio->lock)) {
> > > +			pwm_gpio->cur =3D pwm_gpio->new;
> > > +			spin_unlock(&pwm_gpio->lock);
> > > +		}
> > > +		ns =3D pwm_gpio->cur.ton_ns;
> > > +		pwm_gpio->state =3D true;
> > > +	}
> > > +	pwm_gpio->output =3D pwm_gpio->state ^ pwm_gpio->cur.invert;
> > > +
> > > +	schedule_work(&pwm_gpio->work);
> > > +	hrtimer_forward(handle, hrtimer_get_expires(handle), ns_to_ktime(ns=
));
> >=20
> > This is hard to understand. I think we need more comments explaining
> > (e.g.) the semantic of the members of struct pwm_gpio.
>=20
> Would it be OK if I added the following comment in the code?
>=20
> pwm_gpio_apply writes the new settings to pwm_gpio->new, synchronized by =
the
> spinlock. At the beginning of every PWM cycle pwm_gpio->new is copied into
> pwm_gpio->cur, but only if the spinlock can be locked immediately (meaning
> the settings aren't being applied concurrently to the beginning of the
> period).  By not waiting for the spinlock, no extra jitter in the PWM per=
iod
> is introduced.

So far I understood also only comment. What wasn't obvious immediately
is the state member.

> > Does it make sense to use the workqueue only if the GPIO is a sleeping
> > one and for fast GPIOs call gpiod_set_value directly?
>=20
> I thought about this but didn't implement it as it seemed overkill to me.
> The workqueue is needed anyway to cope with sleeping GPIOs, and it can de=
al
> with fast GPIOs with insignificant degradation compared to a direct
> implementation.

OK. If later the need arises this can be added then.

> > > +static const struct pwm_ops pwm_gpio_ops =3D {
> > > +	.free =3D pwm_gpio_free,
> >=20
> > A free without request seems wrong. The callback stops the PWM, this is
> > wrong, the PWM should continue to toggle.
> >=20
>=20
> Would it be OK to remove the pwm_gpio_free callback altogether and move t=
he
> cancel_work_sync() call to pwm_gpio_remove?

Yes, that sounds right.

> Would it be ok to cancel the timer first and then "return
> pwmchip_remove(...)"?

No. The PWM must stay functional until pwmchip_remove() returns.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ja7r6p7sxf5p6ir6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAEhd8ACgkQwfwUeK3K
7Amhjwf/U8PDuJmRPLLsaT5FO2SgvaDJq06R0Yk2eJmuIuK0BaPnzqqrXRhnPt4o
tx5S0sSDmUK5bn4Qpsb84UbLvEhlDVNYrmNjISp30HEqa5YtZu6c++6z5RYdVGyM
0rpTXa3kX8nwun5Ml8LsQnvwwD0Rab3pPXyY3fheqRCb6yZj4ntckZf/3k1ZWL9r
jhe1y8AEMw2Z6OdgZvNdMYoTHPbHJx6wBvjCTpdSQZDHc4HgvXdxvdUPYLpb+jAC
DNg68Dz/yVlW9qFuT+xyVLoxVvLMuyOfqU521GqzV0+TGr/C2J5lmaMDUzKXAQTG
zwz0ed2YOg/8UE0Ihn/MK6Ok2jYAog==
=Y6IA
-----END PGP SIGNATURE-----

--ja7r6p7sxf5p6ir6--
