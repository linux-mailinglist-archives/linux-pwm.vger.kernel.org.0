Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA32B6E54BA
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Apr 2023 00:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDQWlw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Apr 2023 18:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDQWlv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Apr 2023 18:41:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F994211
        for <linux-pwm@vger.kernel.org>; Mon, 17 Apr 2023 15:41:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1poXXX-0002Ej-Um; Tue, 18 Apr 2023 00:41:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1poXXT-00ByRY-SC; Tue, 18 Apr 2023 00:41:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1poXXT-00E2bJ-0n; Tue, 18 Apr 2023 00:41:35 +0200
Date:   Tue, 18 Apr 2023 00:41:34 +0200
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
Message-ID: <20230417224134.splsu7ipupttuila@pengutronix.de>
References: <20230330111632.169434-1-biju.das.jz@bp.renesas.com>
 <20230330111632.169434-7-biju.das.jz@bp.renesas.com>
 <20230414062641.76no7jz7uluixwdg@pengutronix.de>
 <OS0PR01MB5922824F09E1BC9FB9CECC9586999@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230414165540.bfquriyo6crnxj5q@pengutronix.de>
 <OS0PR01MB592260E8E4F583704C2844B0869C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j4wbqnt37pvj2xry"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB592260E8E4F583704C2844B0869C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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


--j4wbqnt37pvj2xry
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Biju,

On Mon, Apr 17, 2023 at 11:06:59AM +0000, Biju Das wrote:
> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH v15 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
> >=20
> > Hello,
> >=20
> > On Fri, Apr 14, 2023 at 09:53:09AM +0000, Biju Das wrote:
> > > > On Thu, Mar 30, 2023 at 12:16:32PM +0100, Biju Das wrote:
> > > > > +	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;
> > > > > +	if (priv->map->channel =3D=3D pwm->hwpwm) {
> > > > > +		rz_mtu3_8bit_ch_write(priv->mtu, RZ_MTU3_TCR,
> > > > > +				      RZ_MTU3_TCR_CCLR_TGRA | val);
> > > >
> > > > If the sibling PWM on the same channel is on, you're overwriting its
> > > > prescale value here, are you not?
> > >
> > > Yes, you are correct. Will cache prescale and add the below code in
> > > rz_mtu3_pwm_config(). Is it ok?
> > >
> > > +        * Prescalar is shared by multiple channels, so prescale can
> > > +        * NOT be modified when there are multiple channels in use wi=
th
> > > +        * different settings.
> > > +        */
> > > +       if (prescale !=3D rz_mtu3_pwm->prescale[ch] && rz_mtu3_pwm-
> > >user_count[ch] > 1)
> > > +               return -EBUSY;
> >=20
> > If the other PWM is off, you can (and should) change the prescale value.
> > Also if the current prescale value is less than the one you want to set=
, you
> > can handle that.
> >=20
>=20
> You mean like below??
>=20
> static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *p=
wm,
> 			      const struct pwm_state *state)
> {
> 	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> 	struct rz_mtu3_pwm_channel *priv;
> 	u64 period_cycles;
> 	u64 duty_cycles;
> 	u8 prescale;
> 	u16 pv, dc;
> 	u8 val;
> 	u32 ch;
>=20
> 	priv =3D rz_mtu3_get_channel(rz_mtu3_pwm, pwm->hwpwm);
> 	ch =3D priv - rz_mtu3_pwm->channel_data;
>=20
> 	period_cycles =3D mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
> 					NSEC_PER_SEC);
> 	prescale =3D rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm, period_cycles);
>=20
> 	/*
> 	 * Prescalar is shared by multiple channels, so prescale can
> 	 * NOT be modified when there are multiple channels in use with
> 	 * different settings. Modify prescalar if other PWM is off or current
> 	 * prescale value is less than the one we want to set.
> 	 */
> 	if (rz_mtu3_pwm->enable_count[ch] > 1 &&
> 	    rz_mtu3_pwm->prescale[ch] > prescale)
> 		return -EBUSY;
>=20
> 	pv =3D rz_mtu3_pwm_calculate_pv_or_dc(period_cycles, prescale);

Here it starts to get wrong. If rz_mtu3_pwm->enable_count[ch] > 1 you
have to use rz_mtu3_pwm->prescale[ch] instead of prescale.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--j4wbqnt37pvj2xry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ9yx4ACgkQj4D7WH0S
/k4XDwf/S715S5brYmhTzHIMGg7x8lxKADJCboq4ecRmTf4I6Up7A/Zd9311UafS
EZ0+FUMJuHSP1VeGpyS2vzy9vLDypMOrdBlkm0gBZtn+DmDFKWxcUu6Hmd0uXWqC
Ll1RnczZOtpkJfasVI2l84hv7ZwMfboKKY+WCRkqTkY05cJnaX0mrNRz3U6SoMdX
HDjzv0b0LaVBJVCrTWv4Ry6125gtGNWB3DENwap0jc9OqQC4z95ZX7riOVcXIhdU
/JvBUGPaUkT9bBTjkb/CXqOIPlXa/QNLHdv95rsN2DtlU/VH5JCGggSi++yQQgbo
Yr7fTaq+BziRDEGoaZMirwtTKtjBMA==
=wSEI
-----END PGP SIGNATURE-----

--j4wbqnt37pvj2xry--
