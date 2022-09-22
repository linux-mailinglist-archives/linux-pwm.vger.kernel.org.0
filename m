Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C695E5AC8
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Sep 2022 07:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIVFg2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Sep 2022 01:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIVFgX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Sep 2022 01:36:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BC9B2DB5
        for <linux-pwm@vger.kernel.org>; Wed, 21 Sep 2022 22:36:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1obEsf-0006CV-8L; Thu, 22 Sep 2022 07:36:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1obEse-002C7T-NT; Thu, 22 Sep 2022 07:36:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1obEsc-002dxZ-KW; Thu, 22 Sep 2022 07:36:10 +0200
Date:   Thu, 22 Sep 2022 07:36:05 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
Message-ID: <20220922053605.qivxzwon52orbdgz@pengutronix.de>
References: <20220905171328.991367-1-biju.das.jz@bp.renesas.com>
 <20220905171328.991367-3-biju.das.jz@bp.renesas.com>
 <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
 <OS0PR01MB5922B87D4A05973F88B427A7864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220920155306.dvcz4324zvg72udm@pengutronix.de>
 <OS0PR01MB5922A9B3314F2F2B32F6B0DE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922289B89061F6B3DF4819F864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220921133542.3glfgeddnlhrebkz@pengutronix.de>
 <OS0PR01MB592258F2341BEDA1A5A7301C864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rqdh27d43dsak7ix"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB592258F2341BEDA1A5A7301C864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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


--rqdh27d43dsak7ix
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Sep 21, 2022 at 01:46:54PM +0000, Biju Das wrote:
> > Actually it's worse:
> >=20
> > - When both channels are used, setting the duty-cycle on one aborts the
> >   currently running period on the other and starts it anew.
> >=20
> > (Did I get this correctly?)
>=20
> I think, I have fixed that issue with the below logic
> Which allows to update duty cycle on the fly.
>=20
> Now the only limitation is w.r.to disabling channels
> as we need to disable together as stopping the counter
> affects both.
>=20
>       /*
> 	 * Counter must be stopped before modifying mode, prescaler, timer
> 	 * counter and buffer enable registers. These registers are shared
> 	 * between both channels. So allow updating these registers only for the
> 	 * first enabled channel.
> 	 */
> 	if (rzg2l_gpt->user_count <=3D 1)
> 		rzg2l_gpt_disable(rzg2l_gpt);
>=20
> 	is_counter_running =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTC=
R_CST;
> 	if (!is_counter_running)
> 		/* GPT set operating mode (saw-wave up-counting) */
> 		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_MD,
> 				 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);

So if the PWM is already running (e.g. from the bootloader) and the mode
is wrong, this isn't fixed? Similar problems in the if blocks below.

> 	/* Set count direction */
> 	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC, RZG2L_UP_COUNTING);
>=20
> 	if (!is_counter_running)
> 		/* Select count clock */
> 		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_TPCS,
> 				 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
>=20
> 	/* Set period */
> 	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR, pv);
>=20
> 	/* Set duty cycle */
> 	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(pwm->hwpwm), dc);
>=20
> 	if (!is_counter_running) {
> 		/* Set initial value for counter */
> 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCNT, 0);
>=20
> 		/* Set no buffer operation */
> 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER, 0);
> 	}

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rqdh27d43dsak7ix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMr9DQACgkQwfwUeK3K
7AnruAf9HKlu/vjbl8bIrI+YJm+1AqUMJM0sv2P4ScGYx3KRmzF1Iv4MkgSS0JVL
xu+fBbHQdqpLfV6mAmRsE4w6STZdCY1hcK3Id9IDqEKYH1sSxXkYDjTDthk4LaaC
hxR/Dlmv5c6cgeH1Fo0UAo2+4tiTEvyS+WHL6VG1U9tt/BPOm+OLmfxTxURuWriT
Jg4tbd7aaTIDm+J/WzqjmYLTf2C1RtxLfhSMzb3S2A6T1Rnj26ChtB86ONgez7Qr
05NZoucw3UPc3k1U8m/OGVyzS/azW/ISaOhoG4xKnBWfQu28WjjUyoHBdcNQ6pL0
8rV3Ockfe6yfJJcGusCsyahTnQvM4g==
=HBFT
-----END PGP SIGNATURE-----

--rqdh27d43dsak7ix--
