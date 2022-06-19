Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6DF550CDF
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jun 2022 22:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiFSUHO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jun 2022 16:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiFSUHM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jun 2022 16:07:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7B5A1A2
        for <linux-pwm@vger.kernel.org>; Sun, 19 Jun 2022 13:07:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o31CP-0000Cx-6B; Sun, 19 Jun 2022 22:07:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o31CN-001Vnz-3D; Sun, 19 Jun 2022 22:07:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o31CN-00HRXq-Sn; Sun, 19 Jun 2022 22:07:07 +0200
Date:   Sun, 19 Jun 2022 22:07:05 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Drop support for legacy drivers
Message-ID: <20220619200705.oqbs3qk457vgkecb@pengutronix.de>
References: <20220521110203.790597-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="htyvm2ajnjaqqctm"
Content-Disposition: inline
In-Reply-To: <20220521110203.790597-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--htyvm2ajnjaqqctm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Sat, May 21, 2022 at 01:02:03PM +0200, Uwe Kleine-K=F6nig wrote:
> There are no drivers left providing the legacy callbacks. So drop
> support for these.
>=20
> If this commit breaks your out-of-tree pwm driver, look at e.g. commit
> ec00cd5e63f0 ("pwm: renesas-tpu: Implement .apply() callback") for an
> example of the needed conversion for your driver.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> on top of current Thierry's for-next branch this compiles just fine
> an allmodconfig on arm64, m68k, powerpc, riscv, s390, sparc64 and x86_64
> after cherry-picking 357ad4d89828 ("sound/oss/dmasound: fix
> 'dmasound_setup' defined but not used") to fix an unrelated problem.

FTR said commit is in 5.18-rc4. So no problem assuming the next for-next
will start on something later. (But even if not, not a big deal ...)

> Still I think it would be nice to have this cooking in next for some
> time after the next merge window closes.

Ping! Would be great to get this change into next soon such that it can
cook a while before going to Linus. (All assuming you also like this
patch of course.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--htyvm2ajnjaqqctm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKvgeYACgkQwfwUeK3K
7Ami0Af9H8QxHq1Y9pfsbpfnwQ2y9IM1Bdw2A+FzVcJ1dir+Qx68tXjv1phYUaVL
3TLzJPGAPspDlkHj2dtnEnyhdOKy+zqT4MNC/PC+MRf8MUC8So61W7sjJyyITIOV
qHbigrBssGaplyk7LwfaCj3J8X8Uiz1fSl6elF3fokXGGec+MHLRXExzhVyTdoq8
X7BJMqQr31iT14bk0qSQfeOOdayTovzbID/dEkfs3Kd2Mxma326sMorr7+szf09W
lI1ll8UQpmyPg03oPxmxzqPZMI3cb4b+5LKKHTNM9wl0cJUYG19Bee1Bfpi05QAn
644peG4Yy7v+gIMLCs7kn9WqkzL93A==
=p2s6
-----END PGP SIGNATURE-----

--htyvm2ajnjaqqctm--
