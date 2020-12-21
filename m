Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF112DFA26
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Dec 2020 09:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgLUIvc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Dec 2020 03:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgLUIvc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Dec 2020 03:51:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5CAC0613D3
        for <linux-pwm@vger.kernel.org>; Mon, 21 Dec 2020 00:50:51 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krGu0-0005Hf-8X; Mon, 21 Dec 2020 09:50:48 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krGtz-0003F8-OQ; Mon, 21 Dec 2020 09:50:47 +0100
Date:   Mon, 21 Dec 2020 09:50:47 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Simon South <simon@simonsouth.net>
Cc:     tpiepho@gmail.com, thierry.reding@gmail.com, lee.jones@linaro.org,
        heiko@sntech.de, bbrezillon@kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/3] pwm: rockchip: Eliminate potential race condition
 when probing
Message-ID: <20201221085047.nyl7hacd4imp37qi@pengutronix.de>
References: <cover.1608407584.git.simon@simonsouth.net>
 <fcfb96fd2fd860ae3f08cb563c74eb864cdab41a.1608407584.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="slyuushxrwegpfgo"
Content-Disposition: inline
In-Reply-To: <fcfb96fd2fd860ae3f08cb563c74eb864cdab41a.1608407584.git.simon@simonsouth.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--slyuushxrwegpfgo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Dec 19, 2020 at 03:44:09PM -0500, Simon South wrote:
> Commit 48cf973cae33 ("pwm: rockchip: Avoid glitches on already running
> PWMs") introduced a potential race condition in rockchip_pwm_probe() as t=
he
> function could disable the clock of a PWM device after having registered =
it
> through a call to pwmchip_add().
>=20
> Eliminate this possibility by moving the code that disables the clock of a
> non-enabled PWM ahead of the code that registers the device.

OK, I think I understood the problem. The code in the probe function
looks as follows (simplified):

	pwmchip_add(...);

	if (pwm_is_not_running):
		clk_disable(pc->clk);

The intention is that if probe is called when the PWM is already running
it should not stop (which is good).

However calling pwmchip_add allows for consumers to modify the state and
the check after pwmchip_add then checks the modified state. The result
(if the race happens) is that either the clk is enabled once too much
(if the consumer enabled the PWM) or it disables the clk twice after
enabling only once (if the consumer stopped the running hardware).

So the effect is that either the clk isn't stopped even though it is
unused, or we might hit:

	if (WARN(core->enable_count =3D=3D 0, "%s already disabled\n", core->name))
		return;

in drivers/clk/clk.c, right?

I wonder if the commit log should be more detailed about this, after
reading it I thought the effect of the bug would be that the PWM stops
even though it should oscillate.

> Also refactor the code slightly to eliminate goto targets as the error
> handlers no longer share any recovery steps.

This however makes it hard to review the patch. Maybe this refactoring
can be split out?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--slyuushxrwegpfgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/gYeQACgkQwfwUeK3K
7AlODQgAnTuzBU+rjJx3Vf0xh6TXx1jyo1prcV8hTn50SWpe60Ctv4S4QR8jFbtB
iId0DvGFXIdW0X4AiqVXYe9EXtiaj+Au8oMtbz7F36KPijdREE9Av6MMJbgeLPZr
w9bkyKeVGTQ1GtZRfxTFhBptwQ3ZfId5P8bVEJkfCnUo1wUjejTN2AdEwTXkqKxw
XuonauhbO0QSnfpb6Jvua0hHFZf6LIj+rJ6bjlbFiNfbZcA+sqPSWXpmanWgyt+S
ueaRg/TLARiKDU8sJEcVqSF9OlSOI2kUPSo+r8vjpq5T8a0Hh76LM5lvGjX7zr6F
6RV2feDI5M8xIdFD+iIqP8PqASWx4Q==
=g6CV
-----END PGP SIGNATURE-----

--slyuushxrwegpfgo--
