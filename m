Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA366B4FDF
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Mar 2023 19:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjCJSLs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Mar 2023 13:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCJSLr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Mar 2023 13:11:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972B31241CA
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 10:11:46 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pahDP-00049d-29; Fri, 10 Mar 2023 19:11:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pahDO-003EVe-9j; Fri, 10 Mar 2023 19:11:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pahDM-003rYE-Vr; Fri, 10 Mar 2023 19:11:36 +0100
Date:   Fri, 10 Mar 2023 19:11:35 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RESEND v4] dt-bindings: pwm: Convert Amlogic Meson PWM
 binding
Message-ID: <20230310181135.kiajexld3v655tph@pengutronix.de>
References: <3edc5ba6-bf3d-e45b-377a-9e7ece7642a7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nvgxxjq7kdxf6a65"
Content-Disposition: inline
In-Reply-To: <3edc5ba6-bf3d-e45b-377a-9e7ece7642a7@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--nvgxxjq7kdxf6a65
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2023 at 10:19:30PM +0100, Heiner Kallweit wrote:
> Convert Amlogic Meson PWM binding to yaml.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> Seems patch got lost over the question who takes it.
> Please apply through the pwm tree.

Hmm, I found
https://lore.kernel.org/linux-pwm/aaa73903-1837-d9c8-8c45-54b4473fd548@gmai=
l.com
which had no Reviewed-by tag where Krzysztof Kozlowski replied writing:
"You got here a tag and my comment was about minor issue, so please keep
that tag." I didn't find a thread where such a tag was given, though. I
only found a review reply on v3 where Krzysztof requested a change (and
didn't provide a tag).

The Reviewed-by tag for Rob probably originates from
https://lore.kernel.org/linux-pwm/20230130212121.GA3468100-robh@kernel.org/.

And there is another variant where this patch was part of a series at
https://lore.kernel.org/linux-pwm/5b83767e-c53d-316f-df10-45a39dbd9c88@gmai=
l.com
where it got an ack from me which wasn't included here.

To fix this:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

but please note that you can save some scarce maintainer time if you're
more careful here.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nvgxxjq7kdxf6a65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQLctQACgkQwfwUeK3K
7AmWQQf+LoTwr1YY8aMCovUzX36/LqmoETYJ8knDwpvMibZ13lvsR0BLmB1kH0U8
YwkK5Ept9Ak+Y7+slFZDZ7L1gMSwcFl2n0HgX6JDv3pWfN80pbb2gyrztTo42msd
wN1tmMRCdKwoRAu+YBMily+Ab3WB0jS3KMGQkIGsgddlrE7OPJxoaCHTUJ7SPeei
9V/6ltHCpqgGoyeZG33+8gVps2OYPxWZILNJM50YRe/dFbWig4/KWCCNFa29YmRc
bjigzHSAbC2Ptu2JyaPsdxL0R/89FsYeTzeL6QFBnk4Lqzz9gLS51/0zaYeAmxB2
tM4nlB5zH4rDe4wLoTMEdFzn77mYDA==
=JzhO
-----END PGP SIGNATURE-----

--nvgxxjq7kdxf6a65--
