Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE21C56D6CA
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jul 2022 09:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiGKH3M (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jul 2022 03:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGKH3M (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jul 2022 03:29:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6C665EE
        for <linux-pwm@vger.kernel.org>; Mon, 11 Jul 2022 00:29:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oAnqi-0006ib-SU; Mon, 11 Jul 2022 09:28:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oAnqh-000GRm-QP; Mon, 11 Jul 2022 09:28:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oAnqh-004TFL-4x; Mon, 11 Jul 2022 09:28:55 +0200
Date:   Mon, 11 Jul 2022 09:28:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v8 2/2] pwm: Add clock based PWM output driver
Message-ID: <20220711072841.vtdgjbtefzphhtb7@pengutronix.de>
References: <20220711062330.4923-1-nikita@trvn.ru>
 <20220711062330.4923-3-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikxnmvrhzqbsjtde"
Content-Disposition: inline
In-Reply-To: <20220711062330.4923-3-nikita@trvn.ru>
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


--ikxnmvrhzqbsjtde
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 11, 2022 at 11:23:30AM +0500, Nikita Travkin wrote:
> Some systems have clocks exposed to external devices. If the clock
> controller supports duty-cycle configuration, such clocks can be used as
> pwm outputs. In fact PWM and CLK subsystems are interfaced with in a
> similar way and an "opposite" driver already exists (clk-pwm). Add a
> driver that would enable pwm devices to be used via clk subsystem.
>=20
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ikxnmvrhzqbsjtde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLL0SEACgkQwfwUeK3K
7AkFAQf7B2/hjKRRsYekNT1WInfl0CTPzvlXJpWLpi3R1D8Lh2O6Ks12TczXBfoA
cykJs7PBZ5DzhGwGQSqSvVhaBEar5V8RVdeNLblYMXmMKTPRH3aHd7NieOfllQBd
ApOisebie2PUTJBt0bWeobVuO02dQtfi66F34GuzoMj4j7qNG9MRbTgiIaw7dAqs
bqFvdOKQEX+/voGjeRDwACPyqtUYyvcIyR1eCCOkyuIK87w0kNa0OPJc9Qxg280v
4NhE4Vktqp+ZImRgL6Fy1JDIY5Z8XHTT9NkTqAzozyZC1Zp/R5Tls0NUbYh+QzRJ
XqNihElDHcts0eX4GLqwITFr27+rFw==
=Gkns
-----END PGP SIGNATURE-----

--ikxnmvrhzqbsjtde--
