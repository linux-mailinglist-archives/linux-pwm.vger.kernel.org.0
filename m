Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911C936E9F1
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Apr 2021 14:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhD2MFO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Apr 2021 08:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2MFO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Apr 2021 08:05:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F76C06138B
        for <linux-pwm@vger.kernel.org>; Thu, 29 Apr 2021 05:04:28 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lc5P3-00041E-RU; Thu, 29 Apr 2021 14:04:21 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lc5Oy-0007Gb-EW; Thu, 29 Apr 2021 14:04:16 +0200
Date:   Thu, 29 Apr 2021 14:04:16 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Roman =?utf-8?Q?Ber=C3=A1nek?= <roman.beranek@prusa3d.cz>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-sunxi@googlegroups.com,
        Roman Beranek <roman.beranek@prusa3d.com>
Subject: Re: [PATCH] pwm: sun4i: Round delay time up to a nearest jiffy
Message-ID: <20210429120416.5ba7rq5fvhcfebzz@pengutronix.de>
References: <20210428001946.1059426-1-roman.beranek@prusa3d.com>
 <20210428061357.725m72aikc52n4gg@pengutronix.de>
 <CAL8eAtpuAQUiesC-gxSQENDXrw44qQQvp5UqEjdfz1hX5CLHnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lnlp25nt3uc2ep5f"
Content-Disposition: inline
In-Reply-To: <CAL8eAtpuAQUiesC-gxSQENDXrw44qQQvp5UqEjdfz1hX5CLHnQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lnlp25nt3uc2ep5f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Roman,

On Wed, Apr 28, 2021 at 02:14:31PM +0200, Roman Ber=E1nek wrote:
> Correct, the output may stay in an active state. I only discovered this
> bug as I investigated a report of unreliable screen timeout. The period
> we use the PWM with is 50 us.

What I don't like here is that the delay is quite coarse and might still
be too short. (Maybe I miss something, but consider the current period
is quite long, then you configure a short one and then disable. In this
case the inital long setting might still be active.)

> The PWMx_RDY bit stays 0 well after the last period ends, so if the bit
> has any function at all, this one is certainly not it.

OK.

A way out could be to not disable the clock on .enable =3D 0. This might
(or might not) have an impact on power consumption, but it improves
correctness and simplifies the driver as the delay just goes away. So
you might consider it a good trade-off, too. Maybe there is also a nice
solution with runtime-PM?!

> Note: my apologies for the previous HTML message

I didn't notice (because the message also contained a txt part). Another
thing to improve is to reply inline instead of top posting :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lnlp25nt3uc2ep5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCKoL0ACgkQwfwUeK3K
7AlB+wf/XxvVAdfUNVgszWiH5GTPUdXgB/0ijkwoFig7vQfZ0/rHQaXnyLSAu3t/
FKj8TV8xEhRWksrUTUpHyywsyt3seS5YJiqSTe8myzKiqcodHkV7AqLrHOx+xACP
WbtMKD0djHpS5ARAkv0IfyqCeAZeEMhDN8dOKVZ+//xYVZEpB3AaYV/IzwnR/VdK
QsJyQ4TDKMJIT+iJbGFP9I1Dgh9jpPpZGS8Pd00//nke0RrRwqLvBE8Q82hyaJc+
RUviVqPUDjHG5JnTaLTY81z+oLWpE94dvrCn3EYq7UPQE8vFvACIjfcn2cRWLyE4
aKmcYMY+huBUfi45fR95ex46yurjkw==
=yBRL
-----END PGP SIGNATURE-----

--lnlp25nt3uc2ep5f--
