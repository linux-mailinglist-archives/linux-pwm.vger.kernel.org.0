Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211277B81F7
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Oct 2023 16:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242858AbjJDOPd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Oct 2023 10:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242860AbjJDOPd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Oct 2023 10:15:33 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B723AD
        for <linux-pwm@vger.kernel.org>; Wed,  4 Oct 2023 07:15:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo2ep-0001OW-FX; Wed, 04 Oct 2023 16:15:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo2en-00B3Kc-Nb; Wed, 04 Oct 2023 16:15:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo2en-0091KZ-EJ; Wed, 04 Oct 2023 16:15:21 +0200
Date:   Wed, 4 Oct 2023 16:15:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] pwm: Add support for RZ/V2M PWM driver
Message-ID: <20231004141521.rgm74pepirnvzrwm@pengutronix.de>
References: <20230630114003.320641-1-biju.das.jz@bp.renesas.com>
 <20230630114003.320641-3-biju.das.jz@bp.renesas.com>
 <20230916153248.27k7erg7i7ruf76w@pengutronix.de>
 <TYWPR01MB8775150932FD1F0A346029B7C2C4A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jujoux4pgvgy3jaq"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB8775150932FD1F0A346029B7C2C4A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jujoux4pgvgy3jaq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Fabrizio,

On Tue, Oct 03, 2023 at 09:19:41PM +0000, Fabrizio Castro wrote:
> > > +	if (period)
> > > +		period +=3D 1;
> >=20
> > This looks bogus, why don't you add 1 if RZV2M_PWMCYC is 0?
>=20
> Agreed. We should always add 1.
>=20
> > Also it suggests that the hardware cannot do a 100% relative duty
> > cycle?
>=20
> It does support 100% duty cycle.
> PWMCYC =3D 0 actually means 1 clock cycle, that's why the faff with
> increment and decrement operations, and that's why the confusion.

So it doesn't support a 0% relative duty cycle?

> > If I didn't miss anything here, please add that to the list of
> > Limitations above.
>=20
> Thankfully not a limitation.
>=20
> >=20
> > > +	state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)period << (4
> > * prescale),
> > > +					 rzv2m_pwm->rate);
> >=20
> > The multiplication can overflow. I see no easy way to prevent this
> > without introducing a mul_u64_u64_div_roundup helper. Maybe I miss
> > something?
>=20
> It does overflow, good catch!
> I think we could split this in three operations for now, and maybe
> improve it later on:
> period =3D NSEC_PER_SEC * (cyc + 1);
> period =3D DIV64_U64_ROUND_UP(period, rzv2m_pwm->rate);
> period <<=3D rzv2m_pwm_prescale_to_shift(prescale);

You're loosing precision here though. With /^ =3D div_round_up:

	1000000000 * 5 /^ 3 << 2 =3D=3D 6666666668
	1000000000 * 5 << 2 /^ 3 =3D=3D 6666666667

So I correct my statement to: I see no easy and exact way to prevent an
overflow without introducing a mul_u64_u64_div_roundup helper. :-)

> with rzv2m_pwm_prescale_to_shift as below:
> static inline int rzv2m_pwm_prescale_to_shift(u8 prescale)
> {
>     return prescale =3D=3D 3 ? 11 : prescale * 4;
> }
>=20
> As it turns out "<< (4 * prescale)" and ">> (4 * prescale)" are not
> correct for prescale =3D=3D 3.
> As per manual: PWMPS =3D 3 means a frequency division by 2048, and not
> 4096.

funny hardware.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jujoux4pgvgy3jaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUdc3gACgkQj4D7WH0S
/k6rZAf+JMX4TC3zDeH0JWBCNDpdoUHeCmlqAXd9pJW276oxPTa5bZW1lw/0Eyk5
HE0Lss9N9NNXO/ug+VKkhfM13uaYKZ+DmREfBptoM1IL4lKH6+cMmIUJiNwBccJT
Dd6+HZiT2MAANuZH+w8qgu3ZGpK7YOHfeHrIGmAzPJETlNTXOt9RgUFMLSXtmS+S
5uzgl+gH+bIPYHtAhg5NFJtq6hWzWmCVETQITxRci8rnTTGHoUmJyVDfaLb05rJt
v6xqM++eGtOkz7KPn0f0zPMZjExgmQKdlZ8I1cPV7nUX70p5lJyHY3eFMsTi+IMG
i2Sr/f5YpJQAJyj3/rBJb3RowbQimw==
=dqCX
-----END PGP SIGNATURE-----

--jujoux4pgvgy3jaq--
