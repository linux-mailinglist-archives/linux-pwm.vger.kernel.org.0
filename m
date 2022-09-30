Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB985F0573
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Sep 2022 09:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiI3HDh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Sep 2022 03:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiI3HDf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Sep 2022 03:03:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C641C612E
        for <linux-pwm@vger.kernel.org>; Fri, 30 Sep 2022 00:03:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeA3R-0004Uk-T0; Fri, 30 Sep 2022 09:03:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeA3Q-003kdS-DB; Fri, 30 Sep 2022 09:03:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeA3N-004XF2-Jz; Fri, 30 Sep 2022 09:03:21 +0200
Date:   Fri, 30 Sep 2022 09:03:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
Message-ID: <20220930070321.5a4tr7tuwc2hecbh@pengutronix.de>
References: <20220921145741.901784-1-biju.das.jz@bp.renesas.com>
 <20220921145741.901784-3-biju.das.jz@bp.renesas.com>
 <OS0PR01MB59223AB5F30A55A0CD54B08886579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220930063429.xlcmimr6m3z3o5wh@pengutronix.de>
 <OS0PR01MB592278A1194D0E8B36123F0E86569@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oifu6hd7byz2cafz"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB592278A1194D0E8B36123F0E86569@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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


--oifu6hd7byz2cafz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2022 at 06:51:12AM +0000, Biju Das wrote:
> Hi Uwe,
>=20
> > Subject: Re: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
> >=20
> > Hello Biju,
> >=20
> > On Thu, Sep 29, 2022 at 05:36:38PM +0000, Biju Das wrote:
> > > > +static u8 rzg2l_calculate_prescale(struct rzg2l_gpt_chip
> > *rzg2l_gpt,
> > > > +				   u64 period_cycles)
> > > > +{
> > > > +	u32 prescaled_period_cycles;
> > > > +	u8 prescale;
> > > > +
> > > > +	prescaled_period_cycles =3D period_cycles >> 32;
> > > > +
> > > > +	if (prescaled_period_cycles >=3D 256)
> > > > +		prescale =3D 5;
> > > > +	else
> > > > +		prescale =3D (roundup_pow_of_two(prescaled_period_cycles + 1)
> > > > + 1) / 2;
> > >
> > >
> > > This algorithm won't give desired result.
> > >
> > > prescaled_period_cycles		Expected result
> > > 0					->0
> > > 1..3					->1
> > > 4..15					->2
> > > 16..63				->3
> > > 64..255				->4
> > > 256 >					->5
> >=20
> > Oh, indeed, it fails for prescaled_period_cycles =E2=88=88 { 0, 3, 15, =
63, 255
> > }.
> >=20
> > The correct formula is:
> >=20
> > 	if (prescaled_period_cycles >=3D 256)
> > 		prescale =3D 5;
> > 	else
> > 		prescale =3D (roundup_pow_of_two(prescaled_period_cycles) +
> > 1) / 2;
> >=20
>=20
> Round_pow_of_two(n) --> n=3D0 is not acceptable=20
>
> Round_pow_of_two(58)--> 64  as per the above formula, it becomes 64 + 1 /=
2 =3D 32
> Which is very high value.

Oh, I translated my (Python) prototype wrongly to Kernel-C, please make
this:

 	if (prescaled_period_cycles >=3D 256)
 		prescale =3D 5;
 	else
 		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;

With fls(58) =3D 6 the result is 3 as intended.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oifu6hd7byz2cafz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM2lLYACgkQwfwUeK3K
7AkeUwf/aOzkKNfHH+VW3cCrXFkCwndk7BtqXALsKX0mcluphN412pZa32jZ10ib
38UNV1V62gNfjo27uiftu1aEsaJLTb3VlKeADrP58lYs3iL90yIMX3NGKtD+0kJR
z4efBiGUQY1YHKKDi8kmFdp7AzXB1UNEMEzxYgEbECGWTphg+jIynrSQi5hj5fuT
qXEPPrsxsAzHp0MQtZGTb6eCMHUT88772Xj9Euj864Vl4JqR72UBk4bj6C5EGq91
yZQ7ZIw8jjZjtjY0RvJm1QDdKmx2hY6wen2p/U3xuY1o4kK5g39eXKBIU7RTWTzQ
x3h37wBghHx3FJYvoI9ilW3vP82h5Q==
=Wl35
-----END PGP SIGNATURE-----

--oifu6hd7byz2cafz--
