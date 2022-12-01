Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3313C63F47A
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Dec 2022 16:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiLAPsc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Dec 2022 10:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiLAPsb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Dec 2022 10:48:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A482398026
        for <linux-pwm@vger.kernel.org>; Thu,  1 Dec 2022 07:48:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0lnW-0003Yb-1w; Thu, 01 Dec 2022 16:48:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0lnT-001c1s-6G; Thu, 01 Dec 2022 16:48:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p0lnS-001pRK-QQ; Thu, 01 Dec 2022 16:48:22 +0100
Date:   Thu, 1 Dec 2022 16:48:22 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] pwm: sun4i: Propagate errors in .get_state() to the
 caller
Message-ID: <20221201154822.mx7jafj3tyxes5ab@pengutronix.de>
References: <20221201152223.3133-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pvzzkh5g6gs7wysj"
Content-Disposition: inline
In-Reply-To: <20221201152223.3133-1-andre.przywara@arm.com>
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


--pvzzkh5g6gs7wysj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2022 at 03:22:23PM +0000, Andre Przywara wrote:
> .get_state() can return an error indication now. Make use of it to
> propagate an impossible prescaler encoding, should that have sneaked in
> somehow.
> Also check the return value of clk_get_rate(). That's unlikely to fail,
> but we use that in two divide operations down in the code, so let's
> avoid a divide-by-zero condition on the way.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
>=20
> this goes on top of Uwe's series to introduce and observe .get_state
> failures: https://lore.kernel.org/linux-pwm/20221130152148.2769768-12-u.k=
leine-koenig@pengutronix.de/T/#m9af39aa03bbd9bb7b31b3600f110c65ee0e8e70b
> Actually it only relies on patch 01/11 from that.

I recommend to put this info in machine-readable form into your patch.
If you applied my patch #1 on v6.1-rc1 and this on top, you'd do

	git format-patch -1 --base v6.1-rc1

This results in two additional lines that the build bots can evaluate,
to find the right setup to test your patch.

Apart from that:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

and thanks to pick up on this topic,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pvzzkh5g6gs7wysj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOIzMMACgkQwfwUeK3K
7AmPYQf/VRLlVm87HsOU2kfflZl+lqtTUd7MlJ7BwKXnoZsV/+jaa0fyh5Qpj7uR
ajDzWrjYS22y5ec6BtJLSaVRSqrwXaW95RIJa4TUL9SH2vbSMNxqjFvhhRY85Ej3
kwXqmAPojkmpjIjgEsu7MMQLla1idHqZu1ltfLS5WMPZ6fLgtXWq1S4Ba27ebiZo
ymH89B/4P+3wEjUYnZggZmWW4H6jtoE3FfJUzKpeUt7+Ol8gFFSRj55bDmf490uS
UcHRYaLkK+dNfGRhhr+A2QGNDOaE131UOVutxbUAnR7xvD2I+eYgUo/22f+pvwHR
fe3ytW37idP6SAae/HZsPz3yfE8Jlw==
=ZiZt
-----END PGP SIGNATURE-----

--pvzzkh5g6gs7wysj--
