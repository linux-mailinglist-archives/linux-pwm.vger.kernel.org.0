Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AE968B7C5
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Feb 2023 09:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjBFIzG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Feb 2023 03:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjBFIzF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Feb 2023 03:55:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394C512857
        for <linux-pwm@vger.kernel.org>; Mon,  6 Feb 2023 00:55:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pOxGz-00035S-1S; Mon, 06 Feb 2023 09:54:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pOxGw-0031Jx-N4; Mon, 06 Feb 2023 09:54:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pOxGw-001Exq-V6; Mon, 06 Feb 2023 09:54:46 +0100
Date:   Mon, 6 Feb 2023 09:54:46 +0100
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
Message-ID: <20230206085446.rf3rqgaoktwrnr2e@pengutronix.de>
References: <8df4ceec-663c-dc68-d775-5caeb02c0cca@gmail.com>
 <5b83767e-c53d-316f-df10-45a39dbd9c88@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pqcbke23quziawtk"
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


--pqcbke23quziawtk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Feb 01, 2023 at 09:00:21PM +0100, Heiner Kallweit wrote:
> Convert Amlogic Meson PWM binding to yaml.
>=20
> Reviewed-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
this is effectively v4 of

	https://lore.kernel.org/linux-pwm/c92b9e51-bb69-0712-0b29-3db3c9a29f8b@gma=
il.com

and the ony change compared to v3 is that you dropped "items:" (and
reindented). I'll mark above v3 as superseeded in our patchwork, please
scream if I got that wrong.

Other than that:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pqcbke23quziawtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPgwFQACgkQwfwUeK3K
7Ak7Twf/Yk3+SICeBOjvdNeJZ8KDEJlLmf7bUz16JZE5bEIgjYM2SxDI1+n/g6ap
orITRLE+vI0KaUcZYOpx/aTQ3Hh3Tzn9i1odaVCUTs11GFJcP/9unu6KlibqEjYi
fbt6ZuLYVepmhn6RZexmWCHzOZdepljJZwZfpP3VgyYs1rwBbBZzEx27L1P+UcHb
Kbt9XQjSoQoddq+jdTk0ldnAxNeXKTCKRym5mtObYgY3oUUAHpuVQzgbmN2n7RSr
vbDUpRmlnIlbcjenWnlknjg7Cqb4YgBygkgX/ihptNAhgPCnUk7JevJ2HkoHDKmd
j4Ji4gCm71X+k02/efApnitsOkajBw==
=WWKj
-----END PGP SIGNATURE-----

--pqcbke23quziawtk--
