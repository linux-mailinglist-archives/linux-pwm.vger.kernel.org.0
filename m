Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E25C65700C
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Dec 2022 22:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiL0VjH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 27 Dec 2022 16:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiL0VjG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Dec 2022 16:39:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036E3E44
        for <linux-pwm@vger.kernel.org>; Tue, 27 Dec 2022 13:39:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pAHf0-0004Tq-Ho; Tue, 27 Dec 2022 22:38:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pAHez-0029Qd-2P; Tue, 27 Dec 2022 22:38:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pAHey-008Nlb-93; Tue, 27 Dec 2022 22:38:56 +0100
Date:   Tue, 27 Dec 2022 22:38:37 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] pwm: iqs620a: Replace one remaining instance of
 regmap_update_bits()
Message-ID: <20221227213837.phoyx3z6c6ubisse@pengutronix.de>
References: <Y6r7jSs3dFw0KZOP@nixie71>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xortgp2g5ewbwxae"
Content-Disposition: inline
In-Reply-To: <Y6r7jSs3dFw0KZOP@nixie71>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xortgp2g5ewbwxae
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 27, 2022 at 08:05:01AM -0600, Jeff LaBundy wrote:
> The call to regmap_update_bits() which was responsible for clearing
> the PWM output enable register bit was recently dropped in favor of
> a call to regmap_clear_bits(), thereby simplifying the code.
>=20
> Similarly, the call to regmap_update_bits() which sets the same bit
> can be simplified with a call to regmap_set_bits().
>=20
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xortgp2g5ewbwxae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOrZdsACgkQwfwUeK3K
7AlrHwf+InzHYv4V80xBiYMWeHBqG8IAHkBqSli6Tddd9lBR81NMBgcTWvxGEMWl
rQcQsUzyzsCUa67LWOS0ELNkfy9psIV/BxLe92N7aOABIslDcIAlymqxDRrMA/Mb
kiLaeNqesNYrnJp08X8bYsgcYZweOB2YqJksU8BuXve9gnr0FJM90uOdRA3QjQ4M
Eysji0rAqgWd77rNpQBl++S4zNxzgB8NLFvMp7GMwxGo8niYDFVjzmUkrc2fDwl3
mC434zsDrs4FpptwzEHlzEjeNza4KAHBp4UxxF/dgp2sZPyeRLV0HTRglbEkNGpI
L17RzbR7XABt5DQoX6/k6jmvrERx5A==
=7stA
-----END PGP SIGNATURE-----

--xortgp2g5ewbwxae--
