Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041317EE82A
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Nov 2023 21:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjKPUND (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Nov 2023 15:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjKPUNC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Nov 2023 15:13:02 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCFA131
        for <linux-pwm@vger.kernel.org>; Thu, 16 Nov 2023 12:12:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3ijP-0004KN-Vh; Thu, 16 Nov 2023 21:12:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3ijO-009Wit-UN; Thu, 16 Nov 2023 21:12:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r3ijO-002oam-L5; Thu, 16 Nov 2023 21:12:54 +0100
Date:   Thu, 16 Nov 2023 21:12:54 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v16 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <20231116201254.kszjhv5u7qplxgoh@pengutronix.de>
References: <20231004111451.126195-1-biju.das.jz@bp.renesas.com>
 <20231004111451.126195-4-biju.das.jz@bp.renesas.com>
 <TYCPR01MB112699BBDA620567EA36AE2AC86B0A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q4xafe72bv6gxzuv"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB112699BBDA620567EA36AE2AC86B0A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--q4xafe72bv6gxzuv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 07:00:00PM +0000, Biju Das wrote:
> Hello Uwe,
>=20
> The clock rate for RZ/G2L family SoCs is 100 MHz.
>=20
> With this, maximum possible period in nsec =3D  2^32 * 10 nsecs * 1024 (p=
rescale) =3D 43,980,465,111,040 nsec which is well below than
> 2^64.
>=20
> So I am planning to reject the PWM Period  > 43,980,465,111,040 nsecs in =
apply on next version.
>=20
> Please correct me, if It is wrong.

It's wrong. A request for a period > 43,980,465,111,040 ns should
configure 43,980,465,111,040 then.

(Rationale: If your HW could do 43,980,465,111,040 and 50,000,000,000,000
(and nothing in between) and you request 44,000,000,000,000 you get
43,980,465,111,040, right? That your hardware cannot do
50,000,000,000,000 is totally irrelevant for this request and the
resulting configuration. So go with 43,980,465,111,040 even if you
cannot do 50,000,000,000,000.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--q4xafe72bv6gxzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVWd8UACgkQj4D7WH0S
/k7QCQgAo0zhKmAPhDiGTgHRzSMfQ3LWkvYy8CDYLS1SSEVY5V9X5R5scZrhH/ca
LORD74kqJVOQasFlrcXJDrzpg6A/YLgkmh/RFTnc8j7wHlj+4zO4AH7QH7Gc9/Y9
J14z6b+ULlYvKvssQ3VTowHVYJTzsHBdvCFp1L8AmrrZ1+3WkJNmT3bO1vxE1w0Q
r3XeV0m/qunXFDR0oj3w+WqV478mwp8JOxlczk+SkXXFrC4RcyH0EVJKabUXWTTt
mcCi8iTnQPfMxPeXrnPFJVaj4wEd1TarZtSnURvPZNVqc0eQgjP41/jcC2STyHqw
2yNixPKTymM2EOPvHfKt4polo8huIw==
=0ZFW
-----END PGP SIGNATURE-----

--q4xafe72bv6gxzuv--
