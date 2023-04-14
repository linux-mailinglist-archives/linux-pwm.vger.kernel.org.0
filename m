Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476776E28C6
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Apr 2023 18:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjDNQ4A (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Apr 2023 12:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjDNQz7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Apr 2023 12:55:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7818A53
        for <linux-pwm@vger.kernel.org>; Fri, 14 Apr 2023 09:55:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnMi7-0001Cw-E4; Fri, 14 Apr 2023 18:55:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnMi5-00BEyN-7z; Fri, 14 Apr 2023 18:55:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pnMi4-00DDJC-Ex; Fri, 14 Apr 2023 18:55:40 +0200
Date:   Fri, 14 Apr 2023 18:55:40 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Lee Jones <lee@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        William Breathitt Gray <william.gray@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v15 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Message-ID: <20230414165540.bfquriyo6crnxj5q@pengutronix.de>
References: <20230330111632.169434-1-biju.das.jz@bp.renesas.com>
 <20230330111632.169434-7-biju.das.jz@bp.renesas.com>
 <20230414062641.76no7jz7uluixwdg@pengutronix.de>
 <OS0PR01MB5922824F09E1BC9FB9CECC9586999@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bwyqhkojzq4skp7g"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922824F09E1BC9FB9CECC9586999@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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


--bwyqhkojzq4skp7g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Apr 14, 2023 at 09:53:09AM +0000, Biju Das wrote:
> > On Thu, Mar 30, 2023 at 12:16:32PM +0100, Biju Das wrote:
> > > +	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;
> > > +	if (priv->map->channel =3D=3D pwm->hwpwm) {
> > > +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
> > > +				      RZ_MTU3_TCR_CCLR_TGRA | val);
> >=20
> > If the sibling PWM on the same channel is on, you're overwriting its
> > prescale value here, are you not?
>=20
> Yes, you are correct. Will cache prescale and add the below code
> in rz_mtu3_pwm_config(). Is it ok?
>=20
> +        * Prescalar is shared by multiple channels, so prescale can
> +        * NOT be modified when there are multiple channels in use with
> +        * different settings.
> +        */
> +       if (prescale !=3D rz_mtu3_pwm->prescale[ch] && rz_mtu3_pwm->user_=
count[ch] > 1)
> +               return -EBUSY;

If the other PWM is off, you can (and should) change the prescale value.
Also if the current prescale value is less than the one you want to set,
you can handle that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bwyqhkojzq4skp7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ5hYsACgkQj4D7WH0S
/k63lwgAnMkRgs4KfBktS8lhuRwD6okp5dy+PNAPNfYzcYU6u5CXM5zrFEmeDLTn
wRBAUiiP+fryGo7N3THwiTyw39Ati5jLHJJ/7zi3LJkoVI8GRNMoUZCcbIrwPdL2
R10Ifh/UlaBPpcCfKiR31ZhWuyG/GdiCKKHLm1zYqkXh1x3E2xDwztEYRT/Go9f7
puKCgyGyxwQUjBor1DyuWdeKkqjReAmZgQknXcGGtlkOkf2DfBhA13DAnhyrDLgu
vgFE/QgrmfBL9fYTi2D078bj7eck77Bd/T2HA4JnxmrH80AwXeFTKa8j+PkFsadC
LcCY8VCX8npPYG0BXYa0j0432qwVmw==
=yKDO
-----END PGP SIGNATURE-----

--bwyqhkojzq4skp7g--
