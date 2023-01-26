Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B58867C4F6
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Jan 2023 08:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjAZHl3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 26 Jan 2023 02:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAZHl1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 26 Jan 2023 02:41:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D9B65F2A
        for <linux-pwm@vger.kernel.org>; Wed, 25 Jan 2023 23:41:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pKwsX-0006uE-DD; Thu, 26 Jan 2023 08:41:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pKwsV-000Vax-LD; Thu, 26 Jan 2023 08:40:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pKwsU-00Fy4h-2i; Thu, 26 Jan 2023 08:40:58 +0100
Date:   Thu, 26 Jan 2023 08:40:55 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 0/8] soc: amlogic: switch bindings to yaml and adjust
 some dtbs's
Message-ID: <20230126074055.7za4nfu6n5kgnqlz@pengutronix.de>
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
 <0e48405a-d4e7-92a8-339f-4be2f4ec1378@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m3isnjrac4mftej2"
Content-Disposition: inline
In-Reply-To: <0e48405a-d4e7-92a8-339f-4be2f4ec1378@linaro.org>
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


--m3isnjrac4mftej2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jan 24, 2023 at 08:16:45AM +0100, Neil Armstrong wrote:
> Le 23/01/2023 =E0 22:22, Heiner Kallweit a =E9crit=A0:
> > At first adjust some existing dtbs's so that they pass dtbs_check
> > after switching bindings to yaml.
>=20
> Thanks for this patchset, but please drop patches 1, 3 & 4, and take
> in account the existing compatible usage in your new bindings like
> I did in my conversion patchset.
>=20
> While we did remove some bad compatibles we introduced a few years ago,
> now the GXBB, GXL & GXM are now stable a aew LTS releases now and
> a few other projects uses them as-is (U-Boot, BSDs, ...) so changing
> the compatibles isn't an option anymore... and we can't know which
> one they use and how the implementation behaves we must document
> the existing usage without breaking any potential users (including linux).

I only looked into patch #1, and I support dropping it for stronger
reasons than not breaking things which maybe started to rely on the
existing contents.

In patch #1 you write:

| amlogic,meson-gx-pwm isn't a valid compatible string, so remove it.
| See drivers/pwm/pwm-meson.c.
|=20
| Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
| ---
|  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 8 ++++----
|  1 file changed, 4 insertions(+), 4 deletions(-)
|=20
| diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/=
dts/amlogic/meson-gx.dtsi
| index a79a35e84..75d35dcfe 100644
| --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
| +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
| @@ -328,14 +328,14 @@ i2c_A: i2c@8500 {
|                         };
|=20
|                         pwm_ab: pwm@8550 {
| -                               compatible =3D "amlogic,meson-gx-pwm", "a=
mlogic,meson-gxbb-pwm";
| +                               compatible =3D "amlogic,meson-gxbb-pwm";

There are two issues:

a) drivers/pwm/pwm-meson.c isn't the reference. The driver doesn't
   justify which compatibles should be used. You should refer to the
   binding document instead.

b) Having the SoC name as an additional compatible (i.e. the status quo
   before your patch) is an advantage. While it doesn't hurt (apart from
   making the dtb a tad bigger) it makes it possible to adapt the driver
   if in the future someone discovers that the PWM component on GX is a
   tad different from the GXBB one. In that case you can add a check in
   the driver =E0 la=20

   	if (of_device_is_compatible(np, amlogic,meson-gx-pwm))
		do_the_special_gx_handling()

   without having to adapt the device trees then (or use some ugly
   code that somehow detects if it's running on GX).

So the driver not handling amlogic,meson-gx-pwm today is fine. I expect
the fix to be: Include that compatible in the binding.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--m3isnjrac4mftej2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPSLoQACgkQwfwUeK3K
7Akkowf/emZNlTr/+ucs/fg+qTCWpgwgyYENdpjTH/m4tDB3rg4W1f0KXHt8JgxS
3CnyjJrJfsBBox0FanIwNYfVHrC8KKaRNpanXiEagq2e1zVGy0xFdJkFMuYeDf0X
8FbIarmwyjwOu1zFoA5j1txfeS1/wRl2SCMsb4tzg5aQDXe24XRc/rHCfl12DbKY
g45YU3VopNpinmd7n4UCCbQkH6g+RxOxHd0oErdPW1Ii6bsrAzR1lYaOBJnC1esi
VgHCOvB8bYAq2Oo3aMYj1l98jPlzfb+rv9ZmA4UbrizTvpequKYECnytV+3cd5gl
8LkL8MWmS6yGUHEdObMCLR5mNuEfqw==
=HveX
-----END PGP SIGNATURE-----

--m3isnjrac4mftej2--
