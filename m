Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB6A2CED77
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Dec 2020 12:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgLDLtI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 06:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730100AbgLDLtH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 06:49:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD06CC0613D1
        for <linux-pwm@vger.kernel.org>; Fri,  4 Dec 2020 03:48:27 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kl9ZZ-0001sU-ST; Fri, 04 Dec 2020 12:48:25 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kl9ZY-0005FI-VR; Fri, 04 Dec 2020 12:48:24 +0100
Date:   Fri, 4 Dec 2020 12:48:24 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Johannes Pointner <h4nn35.work@gmail.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: pwm: imx27: pwm-backlight strange behavior
Message-ID: <20201204114824.u7mxu6alcsjqry5y@pengutronix.de>
References: <CAHvQdo1CEQfD4gUG7gVFMqaohXAq-dZiz84VY1ZrVN6DdnRBkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="akxxxlmvotgctxlz"
Content-Disposition: inline
In-Reply-To: <CAHvQdo1CEQfD4gUG7gVFMqaohXAq-dZiz84VY1ZrVN6DdnRBkQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--akxxxlmvotgctxlz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Johannes,

On Thu, Dec 03, 2020 at 01:00:56PM +0100, Johannes Pointner wrote:
> I just tested 5.10-rc6 with a imx6dl-board and found an issue
> regarding the pwm-backlight.
> Using 5.10 at about level 67 I got a new maximum and with level 68
> it's restarting at about level 1.
> This was working properly for me with kernel 5.4.

Reverting only the last hunk helps already I assume? I starred at the
patch for some time now and don't see a relevant change.

Can you please enable PWM_DEBUG and TRACING in the kernel configuration
and then do:

	echo 1 > /sys/kernel/debug/tracing/events/pwm/enable

reproduce a wrong setting (the less you do other than that the easier it
will be to analyse the trace) and then send me the contents of

	/sys/kernel/debug/tracing/trace

? Also please lookup the frequency of the per clk (grep for "pwm" in
/sys/kernel/debug/clk/clk_summary).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--akxxxlmvotgctxlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/KIgUACgkQwfwUeK3K
7AlRhQf/ThBUSs6hWjklAYA1OMgeFEGbCL6C8eHtep7ccVMDwD+nmLsCfS4u74LN
TZFah4VP30USfPnrrHybgdCBgbVF7rfXuG3w/tAOQ9uyuJQArrUrNt1EYM1dE5a6
+JXoky4bYkUoEfID6Af8jnLwj7GdB83zMZRbPZZtGO2RN2RQgkJ1/MJJcc9hdMpb
I1SSw/LGxokOjA066xNZGOPZt7cbQujGGOgdq+F7HMCfGL3UsCbgOdpjTskUgpF6
oX/Gezuh5o3zx6DvMG3VkiZEQonuC8lOXa2IBnNh/mTChgdH1eKsDAwqts4P5YU3
txPGVynJpFFargndZoKUy5U1GcJNjQ==
=bs1s
-----END PGP SIGNATURE-----

--akxxxlmvotgctxlz--
