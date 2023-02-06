Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876CD68B73B
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Feb 2023 09:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjBFIXs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Feb 2023 03:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjBFIXq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Feb 2023 03:23:46 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7381BAEC
        for <linux-pwm@vger.kernel.org>; Mon,  6 Feb 2023 00:23:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pOwmV-0007UW-RW; Mon, 06 Feb 2023 09:23:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pOwmT-0031E8-JC; Mon, 06 Feb 2023 09:23:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pOwmT-001EgH-SY; Mon, 06 Feb 2023 09:23:17 +0100
Date:   Mon, 6 Feb 2023 09:23:17 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: pwm: Convert Amlogic Meson PWM binding
Message-ID: <20230206082317.ygvixvhjqppz4nmy@pengutronix.de>
References: <8df4ceec-663c-dc68-d775-5caeb02c0cca@gmail.com>
 <5b83767e-c53d-316f-df10-45a39dbd9c88@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gsp2ydktkue72wff"
Content-Disposition: inline
In-Reply-To: <5b83767e-c53d-316f-df10-45a39dbd9c88@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--gsp2ydktkue72wff
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Feb 01, 2023 at 09:00:21PM +0100, Heiner Kallweit wrote:
> Convert Amlogic Meson PWM binding to yaml.
>=20
> Reviewed-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

How is supposed to pick up this patch? Does it go in together with the
other patches in this series via amlogic/arm; or is there an expectation
that it enters via PWM?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gsp2ydktkue72wff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPguPAACgkQwfwUeK3K
7AkOvwf+NG231BHr5/rQggvY7H209Cv+4ixSPdKLxn6pTW6QEl7mcyTgSEBmUTjl
eha7nd681AgnKn7Ixktufs8N3JKd8bMMn1ZRjSOeXSwaskOp7rIP5NEdAi39ZkFx
YO6wvvx12MZ7QYDYNoSU8D+bagEUFlatej/cxXKFWzakoeurShg0DlRLPEUdkD3r
GupQs6x9POxYK9hNDLfhFGKtI7hg0m2yjf/8vJvsYOok2Xb1B3yOUHqYsbkyzbuJ
MeBFozyUzserMGaa0nQZqHEntCYMu9SjjNJ9qkg+8ZIkuf1K/Rq1dgUdShWwg7V2
XqT1fLgAhb8hYJ2mMbHcTLIBjR6aHQ==
=JK05
-----END PGP SIGNATURE-----

--gsp2ydktkue72wff--
