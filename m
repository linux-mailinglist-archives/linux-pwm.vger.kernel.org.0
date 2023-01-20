Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5CE675A18
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jan 2023 17:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjATQga (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Jan 2023 11:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjATQg3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Jan 2023 11:36:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67963917E9
        for <linux-pwm@vger.kernel.org>; Fri, 20 Jan 2023 08:35:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIuMT-0004Z9-BT; Fri, 20 Jan 2023 17:35:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIuMQ-007PdM-S8; Fri, 20 Jan 2023 17:35:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIuMQ-00ES5w-1c; Fri, 20 Jan 2023 17:35:26 +0100
Date:   Fri, 20 Jan 2023 17:35:25 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/4] pwm: Add support for RZ/V2M PWM driver
Message-ID: <20230120163525.rhtgexzmizotnvrg@pengutronix.de>
References: <20221213185827.2012004-1-biju.das.jz@bp.renesas.com>
 <20221213185827.2012004-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="56qs72c4mf6yg5ye"
Content-Disposition: inline
In-Reply-To: <20221213185827.2012004-3-biju.das.jz@bp.renesas.com>
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


--56qs72c4mf6yg5ye
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

> + * https://www.renesas.com/in/en/document/mah/rzv2m-users-manual-hardwar=
e?language=3Den

I took a look into that now, and there are a few things I noticed.

The PWMCYC register description has:

	To change the setting value of the PWM cycle setting register
	(PWMm_PWMCYC), set the PWME bit of the PWM control register
	(PWMm_PWMCTR) to 0b and stop the counter operation. If it is
	changed during counter operation, PWM output may not be
	performed correctly.

This isn't repected in the driver. Please either fix that or add a
comment why you think this is not necessary. If you choose to adhere to
that, also note it in the Limitations section that I asked you to add.

In .apply() you subtract 1 from the calculated value of PWMCYC. When
looking through section 17.4 Function Details I don't see this
justified. However in 17.3.2.2 the formula is as you quoted in the
driver (i.e. PWMm_PWMCYC =3D (PWM period (ns) / (PWM_CLK period (ns) =C3=97
Division ratio)) =E2=88=92 1). Can you maybe test which of the two is corre=
ct,
maybe adapt the driver code and note in a comment about the difference?

Also comment would be nice about the fact that the native polarity of
the hardware is inverted (i.e. it starts with the low part). I didn't
recheck, maybe the inversion bit handling must be switched?

A 100% duty cycle is only possible (according to Figure 17.4-2) with
PWMLOW > PWMCYC. Assuming this is correct, there is the problem that the
two registers have the same width, so if PWMCYC is 0xffffff a 100% duty
isn't possible. So please stick to only using values < 0xffffff for
PWMCYC.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--56qs72c4mf6yg5ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPKwsoACgkQwfwUeK3K
7AlLCAf+OKlR9sJ1tjp34aw4HwLcNrATLOFtLz1YYfFimIxIK7yjXgvjYmCSUVH5
7gzzYPa8kjLkthEbe6s8/GBbeLHrEyIDT3Z/+58Ij2dV7hKI/V5doXqFXjl5jPAJ
qGftAqkpnXt4lLxwVIvJ/NdL60RGbYuGtVbPLYaykMurmfh7d2SBe+iByWbiNCsp
2Mj16rWwP8YH54zOQ/XXmM1ONKpIAbm7wNLC3yDNYmPhl4hApt6Mzc5CyQzaDDmw
BdATaMznRXrvFBICvtIN6alGJBtSF6nPBhSOtaL73AlTcZacSGdcUVP1s0NxDteK
9dqK8kZrff7o7/yYJWFzztOXpIG6Lw==
=edq4
-----END PGP SIGNATURE-----

--56qs72c4mf6yg5ye--
