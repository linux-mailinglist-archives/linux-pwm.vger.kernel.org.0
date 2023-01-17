Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1D670C35
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jan 2023 23:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjAQWz2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Jan 2023 17:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjAQWyw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Jan 2023 17:54:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6E34A1C2
        for <linux-pwm@vger.kernel.org>; Tue, 17 Jan 2023 13:39:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHtg0-0003Ts-5Q; Tue, 17 Jan 2023 22:39:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHtfv-006lgx-TT; Tue, 17 Jan 2023 22:39:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHtfv-00DhU5-7L; Tue, 17 Jan 2023 22:39:23 +0100
Date:   Tue, 17 Jan 2023 22:39:19 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        thierry.reding@gmail.com, krzysztof.kozlowski+dt@linaro.org
Cc:     robh+dt@kernel.org, matthias.bgg@gmail.com, john@phrozen.org,
        sean.wang@mediatek.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 1/2] arm64: dts: mediatek: mt7622: Add missing
 pwm-cells to pwm node
Message-ID: <20230117213919.56cl74ffxzdpdcgp@pengutronix.de>
References: <20221128112028.58021-1-angelogioacchino.delregno@collabora.com>
 <20221128112028.58021-2-angelogioacchino.delregno@collabora.com>
 <20221202180932.5k3vymrwds5ssivq@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="reopnm6bu5cdz26m"
Content-Disposition: inline
In-Reply-To: <20221202180932.5k3vymrwds5ssivq@pengutronix.de>
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


--reopnm6bu5cdz26m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Dec 02, 2022 at 07:09:32PM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Nov 28, 2022 at 12:20:27PM +0100, AngeloGioacchino Del Regno wrot=
e:
> > Specify #pwm-cells on pwm@11006000 to make it actually usable.
> >=20
> > Fixes: ae457b7679c4 ("arm64: dts: mt7622: add SoC and peripheral relate=
d device nodes")
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot=
/dts/mediatek/mt7622.dtsi
> > index 146e18b5b1f4..f321c6d0fd7c 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> > @@ -435,6 +435,7 @@ uart3: serial@11005000 {
> >  	pwm: pwm@11006000 {
> >  		compatible =3D "mediatek,mt7622-pwm";
> >  		reg =3D <0 0x11006000 0 0x1000>;
> > +		#pwm-cells =3D <2>;
>=20
> 3 should be possible, too. The driver does only support one
> polarity, so it's not really needed, but would be nice for consistency?
>=20
> Thierry, what's your take here?
>=20
> Other than that: Who would pick this up, I assume it to go via an ARM
> tree together with the 2nd patch in this series?

The questions here are still open and both patches unapplied. :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--reopnm6bu5cdz26m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPHFYQACgkQwfwUeK3K
7Akv5gf/SJFYiqZQ3e3k7+kMNq/B+6Dm6vLLOrHhY7dXMcF3Xl9CD/eMuHJ3f23K
J99iGKEB0DLxV5P33FS7xbJKdCUc9LuZSdVJyn0O38dbk3r0JkWRuVyU03KbQ1F5
bklzciXjRNjn0GjeZVVNKt77U27aQvYCH6sTf3pwm3Daswr2sZLczSApMP/Hxmo4
4JUU7HoWFUyFekbH1Sdc/b2eFi8gTgSMsfQ2tCjmwsIDYuvEKJag7VKn91D3SZhL
/YZD5rSW+enlPaLQPqgl3LblyW7eyaaCnjwdY8VTNKzKqEHdxfDywhkD0uNMNzR5
L/3BJO7uE2sGE+y9hMx8I6jtMiCRzw==
=m6Kf
-----END PGP SIGNATURE-----

--reopnm6bu5cdz26m--
