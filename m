Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAD6640E29
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Dec 2022 20:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiLBTDO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Dec 2022 14:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbiLBTDO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Dec 2022 14:03:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2FDE0752
        for <linux-pwm@vger.kernel.org>; Fri,  2 Dec 2022 11:03:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p1BJX-0003Rb-QF; Fri, 02 Dec 2022 20:03:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p1BJW-001rSO-3H; Fri, 02 Dec 2022 20:03:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p1BJW-0026cl-2c; Fri, 02 Dec 2022 20:03:10 +0100
Date:   Fri, 2 Dec 2022 20:03:06 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PULL] pwm changes for 6.2 for Thierry
Message-ID: <20221202190306.rqzfpkgitgexxyg7@pengutronix.de>
References: <20221202183504.rhz5meomd4a4t7am@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="znefqdyqgi5fk3bx"
Content-Disposition: inline
In-Reply-To: <20221202183504.rhz5meomd4a4t7am@pengutronix.de>
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


--znefqdyqgi5fk3bx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2022 at 07:35:04PM +0100, Uwe Kleine-K=F6nig wrote:
>       drm/bridge: ti-sn65dsi86: Propagate errors in .get_state() to the c=
aller
>       leds: qcom-lpg: Propagate errors in .get_state() to the caller

One thing I forgot to point out: I wasn't sure if I should include these
two patches. They could just be dropped without harm. I kept them
because I already touched these drivers anyhow in the change "pwm: Make
=2Eget_state() callback return an error code".

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--znefqdyqgi5fk3bx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOKS+cACgkQwfwUeK3K
7AmkJAf/el6C6EYPRBLpYg4b9TyJw+ZrPHonfDU5pO20H7VA5lgaO7P+RYfXDboF
r7lAcPl/xxcFOh5ripE8DN8FJCtt4rYP9M1VYbtT3mBiVv1ARuRG6APs4DrptCav
ZMhqky7+a8mM5SR0iBS3yYawPH/0D8dAU4zCrDJ3/aG2J9l7LIJGCPJ4s7N8lNV6
RLYhrBDvDzn1hQm3mBT7GDKj78ZkSJ1lC3vDkOGs45fyIzH7HeBdXsRPNyu7aFcO
y9Ws0unvOEXVF7kYml4TuUkxVnVcZEbLcoEiWzuEF8jYtUVG0U/sh2NYKhKGvxlT
vVl/j4s7x+L37GP+sLFzeD/WypXXlg==
=7bm8
-----END PGP SIGNATURE-----

--znefqdyqgi5fk3bx--
