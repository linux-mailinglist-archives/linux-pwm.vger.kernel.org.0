Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E78363107
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Apr 2021 17:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhDQPu7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 17 Apr 2021 11:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236612AbhDQPuz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 17 Apr 2021 11:50:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD61AC061574
        for <linux-pwm@vger.kernel.org>; Sat, 17 Apr 2021 08:50:28 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXnD4-0003Jm-2F; Sat, 17 Apr 2021 17:50:14 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXnCz-0006Ka-NM; Sat, 17 Apr 2021 17:50:09 +0200
Date:   Sat, 17 Apr 2021 17:50:09 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
Message-ID: <20210417155009.vnqxx3fn2yjzp3qc@pengutronix.de>
References: <20210409230837.1919744-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210409230837.1919744-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210410135321.oissremqropvrpd3@pengutronix.de>
 <20210412025536.i5chpp6sighunvfx@toshiba.co.jp>
 <20210412070232.6q3cgqvuj53p4cmi@pengutronix.de>
 <20210416080721.oa7xdvu22w2b2rkf@toshiba.co.jp>
 <20210416094426.x4gyw3drp2fcwczs@pengutronix.de>
 <20210416121523.c34trzsrlcjuzirl@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e54mzoygoswyfwbj"
Content-Disposition: inline
In-Reply-To: <20210416121523.c34trzsrlcjuzirl@toshiba.co.jp>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--e54mzoygoswyfwbj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nobuhiro,

On Fri, Apr 16, 2021 at 09:15:23PM +0900, Nobuhiro Iwamatsu wrote:
> > > > For me the critical (and only) difference between "off" and
> > > > "duty cycle =3D 0" is that when a new configuration is to be applie=
d. In
> > > > the "off" state a new period can (and should) start immediately, wh=
ile
> > > > with "duty_cycle =3D 0" the rising edge should be delayed until the
> > > > currently running period is over.[1]
> > > >=20
> > > > So the thing to do here (IMHO) is:
> > > >=20
> > > > Iff with PIPGM_PCSR =3D 0 configuring a new setting (that is finali=
zed
> > > > with writing a non-zero value to PIPGM_PCSR) completes the currently
> > > > running period, then always assume the PWM as enabled.
> > >=20
> > > Yes, this device works that way.
> >=20
> > OK, then please use
> >=20
> > 	state->enabled =3D true
> >=20
> > unconditionally in visconti_pwm_get_state().
>=20
> Please let me check.
> If I unconditionally add 'state->enabled =3D true' to visconti_pwm_get_st=
ate(),
> state->enabled is set to true because visconti_pwm_get_state() is called =
when
> the device is created (this is when I write the device number to the expo=
rt of
> /sys/class/pwm/pwmchip0 ).
> And since PIPGM_PCSR is 0 in this state, the pulse by PWM is not output.

A PWM that is currently configured with .enabled =3D true and .duty_cycle
=3D 0 doesn't have a pulse, so this is fine.

> However, I think this means that the device is working as this driver.

I don't understand this sentence.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--e54mzoygoswyfwbj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB7A64ACgkQwfwUeK3K
7AmAggf/UVi5llHdZdFooQZesJePOcNjWOk5o/uJdNlY1YEsO9FwsFhJ6cAlu4OE
zLkZm5hTMT02CFKXf8Y7r9RZ/6TwsIsOHB8wSYX/gGOFKThhyggm7Er2zhneLkIv
0g+wlaHAqE+kq3NqroH4F3fGTlWnY+WNZ4Q9Ilw6mx+FzALl3GfWsfiDPzz7JI0r
VaGdBDdXCs3eIL+UoDNI3YtjJvsGcyQuBdcTnzNVg0Bi8DU921AhwcAOWmPoSzMa
V9NF0oz+4znqP2jqhvL9fKoQ2Kw95wG7qN0I3Vet0e972u7tvMPBU1m7MEgPf1A8
ZoqjEVvE73KJceyMuQv3nuLxIqvBZQ==
=BgAQ
-----END PGP SIGNATURE-----

--e54mzoygoswyfwbj--
