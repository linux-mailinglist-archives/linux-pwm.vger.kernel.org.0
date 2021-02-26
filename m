Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3C3260C6
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Feb 2021 11:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhBZKBi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 Feb 2021 05:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhBZKAb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Feb 2021 05:00:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE50C061793
        for <linux-pwm@vger.kernel.org>; Fri, 26 Feb 2021 01:59:40 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lFZuL-0001Ht-Kb; Fri, 26 Feb 2021 10:59:37 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lFZuK-0002E2-UZ; Fri, 26 Feb 2021 10:59:36 +0100
Date:   Fri, 26 Feb 2021 10:59:36 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org
Subject: Re: [GIT PULL] pwm: Changes for v5.12-rc1
Message-ID: <20210226095936.sc27f3un5vnc5o62@pengutronix.de>
References: <20210225193426.3679817-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xack6k32avcpvrfx"
Content-Disposition: inline
In-Reply-To: <20210225193426.3679817-1-thierry.reding@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xack6k32avcpvrfx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Feb 25, 2021 at 08:34:26PM +0100, Thierry Reding wrote:
> ----------------------------------------------------------------
> pwm: Changes for v5.12-rc1
>=20
> The ZTE ZX platform is being removed, so the PWM driver is no longer
> needed and removed as well. Other than that this contains a small set of
> fixes and cleanups across a couple of drivers.

patches I'd have liked to be seen additionally in this pull request are:

  pwm: bcm2835: Improve period and duty cycle calculation
   https://patchwork.ozlabs.org/project/linux-pwm/patch/20210114204804.1438=
92-1-u.kleine-koenig@pengutronix.de/
  pwm: get rid of pwmchip_add_with_polarity()
   https://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D219012
  pwm: add a config symbol for legacy drivers
   https://patchwork.ozlabs.org/project/linux-pwm/patch/20200613155742.3152=
8-1-uwe@kleine-koenig.org/

Can you please consider these for your next pull request or provide
feedback in the respective mailing list threads.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xack6k32avcpvrfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmA4xoUACgkQwfwUeK3K
7AknlQf/d9D/OnrV2hKKt/TxRXG6F928fZ6NzQZvX1HqENn2ZzlCXVrNk1/43hCC
VKj+0B2FmFe5N/yB/QQ6xW9d74ytSw84IA3aAulEfZ8JTkkupB8pZ38qdwyK5g2B
TEq/tJ3TRPUh9E5ZWn+RBvh7wCbDqlQPJ2y39oxnWxf5F9zEdee5T/HYZRoIuZ2z
loyunqIqMbwI+Vo5068hcpzMG04a/huTsOc05o/HkW90GXcbv/wWIwQANDSPpNc5
6YSgaBPXfFrr05WrmtYR1TWtriM4lpMeB4jL0/jVwFsdNK9Wnf9U/AyKbTNY9XR9
gJsNj3aZ5wujQ78y1CFpkzgJqQYYfw==
=lAzj
-----END PGP SIGNATURE-----

--xack6k32avcpvrfx--
