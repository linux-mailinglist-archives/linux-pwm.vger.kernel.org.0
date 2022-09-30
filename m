Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4E35F04DA
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Sep 2022 08:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiI3Gep (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Sep 2022 02:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiI3Geo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Sep 2022 02:34:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5BBDB9
        for <linux-pwm@vger.kernel.org>; Thu, 29 Sep 2022 23:34:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oe9bU-000182-Mo; Fri, 30 Sep 2022 08:34:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oe9bT-003kaO-Ok; Fri, 30 Sep 2022 08:34:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oe9bR-004Wil-Nh; Fri, 30 Sep 2022 08:34:29 +0200
Date:   Fri, 30 Sep 2022 08:34:29 +0200
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
Message-ID: <20220930063429.xlcmimr6m3z3o5wh@pengutronix.de>
References: <20220921145741.901784-1-biju.das.jz@bp.renesas.com>
 <20220921145741.901784-3-biju.das.jz@bp.renesas.com>
 <OS0PR01MB59223AB5F30A55A0CD54B08886579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdyhefq2yqhsoxhi"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59223AB5F30A55A0CD54B08886579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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


--sdyhefq2yqhsoxhi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Biju,

On Thu, Sep 29, 2022 at 05:36:38PM +0000, Biju Das wrote:
> > +static u8 rzg2l_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
> > +				   u64 period_cycles)
> > +{
> > +	u32 prescaled_period_cycles;
> > +	u8 prescale;
> > +
> > +	prescaled_period_cycles =3D period_cycles >> 32;
> > +
> > +	if (prescaled_period_cycles >=3D 256)
> > +		prescale =3D 5;
> > +	else
> > +		prescale =3D (roundup_pow_of_two(prescaled_period_cycles + 1)
> > + 1) / 2;
>=20
>=20
> This algorithm won't give desired result.
>=20
> prescaled_period_cycles		Expected result
> 0					->0
> 1..3					->1
> 4..15					->2
> 16..63				->3
> 64..255				->4
> 256 >					->5

Oh, indeed, it fails for prescaled_period_cycles =E2=88=88 { 0, 3, 15, 63, =
255 }.

The correct formula is:

	if (prescaled_period_cycles >=3D 256)
		prescale =3D 5;
	else
		prescale =3D (roundup_pow_of_two(prescaled_period_cycles) + 1) / 2;

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sdyhefq2yqhsoxhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM2jfIACgkQwfwUeK3K
7AlF3gf/Uva+cNUs67ES7uWGnNW0SoE635tKzalhp3EojFV2QIEKt7CVZSFM05VU
v8pBiBNfHJMODTUFs5xrpWksV1D7GLyHH5LUjdPoZuM8YSYODMDUJ37y+wQ6WsPG
elX1sFhzwVT5u77TUGj4GdVWn3evtfymdcyWvElYyPf3e2Hp7LtqbWde6X9xv+ME
Z9+rhgGYfX7zC3cJY0XRtj/+t+C3zjIiAOisC0eAr3LqGlg99nM1QUM1sW+4cZ+Y
yRQ+sxgVTpRpvkEfejLTD8UBQ0cRMQeIk0s7rKX4QUZiXSXbhbAl33GNdnfW+ut+
eU7NcAVzYmnHDDpZ47gH+a+zif/mow==
=ZOVF
-----END PGP SIGNATURE-----

--sdyhefq2yqhsoxhi--
