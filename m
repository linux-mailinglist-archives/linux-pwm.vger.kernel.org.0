Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E800D5E8D2B
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Sep 2022 15:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiIXNnD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 24 Sep 2022 09:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiIXNnD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 24 Sep 2022 09:43:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA458481E6
        for <linux-pwm@vger.kernel.org>; Sat, 24 Sep 2022 06:43:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc5Qi-000493-3H; Sat, 24 Sep 2022 15:42:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc5Qf-002evp-Q5; Sat, 24 Sep 2022 15:42:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oc5Qd-003Dyv-Kk; Sat, 24 Sep 2022 15:42:47 +0200
Date:   Sat, 24 Sep 2022 15:42:33 +0200
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
Message-ID: <20220924134233.m7uyvwyulbmo3mrv@pengutronix.de>
References: <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
 <OS0PR01MB5922B87D4A05973F88B427A7864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220920155306.dvcz4324zvg72udm@pengutronix.de>
 <OS0PR01MB5922A9B3314F2F2B32F6B0DE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922289B89061F6B3DF4819F864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220921133542.3glfgeddnlhrebkz@pengutronix.de>
 <OS0PR01MB592258F2341BEDA1A5A7301C864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220922053605.qivxzwon52orbdgz@pengutronix.de>
 <OS0PR01MB59220ECD0B2D42DF5012B6C7864E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <TYCPR01MB59336AAF4DD1D304FA53451286509@TYCPR01MB5933.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ehgdgnokkrf4zgm"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB59336AAF4DD1D304FA53451286509@TYCPR01MB5933.jpnprd01.prod.outlook.com>
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


--6ehgdgnokkrf4zgm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Biju,

On Sat, Sep 24, 2022 at 10:53:30AM +0000, Biju Das wrote:
> > Subject: RE: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
> >=20
> > Thanks for the feedback.
> >=20
> > > Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
> > >
> > > Hello,
> > >
> > > On Wed, Sep 21, 2022 at 01:46:54PM +0000, Biju Das wrote:
> > > > > Actually it's worse:
> > > > >
> > > > > - When both channels are used, setting the duty-cycle on one
> > > aborts the
> > > > >   currently running period on the other and starts it anew.
> > > > >
> > > > > (Did I get this correctly?)
> > > >
> > > > I think, I have fixed that issue with the below logic Which allows
> > > to
> > > > update duty cycle on the fly.
> > > >
> > > > Now the only limitation is w.r.to disabling channels as we need to
> > > > disable together as stopping the counter affects both.
> > > >
> > > >       /*
> > > > 	 * Counter must be stopped before modifying mode, prescaler,
> > > timer
> > > > 	 * counter and buffer enable registers. These registers are
> > > shared
> > > > 	 * between both channels. So allow updating these registers only
> > > for the
> > > > 	 * first enabled channel.
> > > > 	 */
> > > > 	if (rzg2l_gpt->user_count <=3D 1)
> > > > 		rzg2l_gpt_disable(rzg2l_gpt);
> > > >
> > > > 	is_counter_running =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) &
> > > RZG2L_GTCR_CST;
> > > > 	if (!is_counter_running)
> > > > 		/* GPT set operating mode (saw-wave up-counting) */
> > > > 		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_MD,
> > > > 				 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> > >
> > > So if the PWM is already running (e.g. from the bootloader) and the
> > > mode is wrong, this isn't fixed? Similar problems in the if blocks
> > > below.
>=20
> What is your thought on caching the registers that needs counter to be st=
opped
> for updating values. Basically, we don't stop the counter if the values a=
re same?

I don't see a very relevant difference between caching and reading the
registers. Whatever is fine for you.

> This allows updating period/duty cycle on the fly without stopping the co=
unter
> even for the single channel use case.

I didn't get the relevant difference, but the result sounds good.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6ehgdgnokkrf4zgm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMvCUcACgkQwfwUeK3K
7AnakAgAlxBpFtEBrJDLRLaLwMkZxXapgRA6U4DRpMcQXanMl4vXNr8PQzcKYqp9
vvOPQox9ecJ4QOs+5PNbhXJENbYdqK6qnvvjJmOu+Lvpcy9Y15y+Kuxf5RydbRV6
iRpIfdV0HL5Cx7GPkCGl1HRKRzd4Bt6wSnKQRTrCNxpsc8Y623/hpTgTx1oDLlx9
fxUD8t2hYEfAoNDaz8u5FO/0Kwyrzl1tbpcxhm3MrmZpVb8081tgIWFfDfu9OfsX
dyK8QXBWtINgx0+bVcoGlatQ7QS2guVCJpNyiOoCTzvxqBcVnFvyPgetnCCFhvDI
MGhjl8aUlzSxVF42BsNlk7XnlgWCog==
=7/kV
-----END PGP SIGNATURE-----

--6ehgdgnokkrf4zgm--
