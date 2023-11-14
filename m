Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9447EAE48
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 11:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjKNKrJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 05:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKNKrI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 05:47:08 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61C6187
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 02:47:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2qwi-0004tq-B5; Tue, 14 Nov 2023 11:47:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2qwh-008yKI-Sl; Tue, 14 Nov 2023 11:47:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2qwh-001JQ4-JY; Tue, 14 Nov 2023 11:47:03 +0100
Date:   Tue, 14 Nov 2023 11:47:03 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee@kernel.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH 0/2] pwm: Use an idr to assign pwm_chip IDs
Message-ID: <20231114104703.dcwn4bscivfe45sf@pengutronix.de>
References: <20230808165250.942396-1-u.kleine-koenig@pengutronix.de>
 <20231114072859.ffikahqfjufgw3j6@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bablsqzajkoodr7a"
Content-Disposition: inline
In-Reply-To: <20231114072859.ffikahqfjufgw3j6@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bablsqzajkoodr7a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 08:28:59AM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> On Tue, Aug 08, 2023 at 06:52:48PM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > this series depend on patch "leds: qcom-lpg: Drop assignment to struct
> > pwmchip::base" which Lee already claimed to have applied in
> > https://lore.kernel.org/linux-leds/169054337847.351209.7864098481511406=
737.b4-ty@kernel.org/,
> > but it didn't made it into next yet.
>=20
> The led patch is in v6.6-rc1 already, so this series could go in, too.
>=20
> Applying it to v6.7-rc1 yields an easy merge conflict. Please tell me if
> I should resend.

Never mind, this also depends on
https://lore.kernel.org/linux-pwm/20230728145824.616687-1-u.kleine-koenig@p=
engutronix.de/
where patch 3/3 can go in now. I'll resend these together.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bablsqzajkoodr7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVTUCYACgkQj4D7WH0S
/k70tQgAomSWWHJtG/u2m8UezFG59x6nnE8EmRgOh8cuu6SM8uN2F87nQi8B6cW7
EqpJNTEzdwPdKw1cEX0O6oO5AnK9RQF6JcNiC+G7uHxPVXse3ielFh3X0bCF5a5q
8v11cTObbbCvjUPKexm+Eh/zHj86lLpk874rwbgLLZg7TvPNpSbSbYKeLCwcRBuc
VHgc3a3EdmhJTPr5XypefsUHN6qNkPpueVevopBUme9kdqrc16ZGu8pXqHfbZR+d
/GT+n1TxV5kp2df41Q8wKHxy/o2LPInSBuns9hhHo/ei6MPjNANSnGD7EiRkq/Z4
XvGRsFMtComshXMD6PAKPeafmaIoqQ==
=/rpw
-----END PGP SIGNATURE-----

--bablsqzajkoodr7a--
