Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC584BEB12
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Feb 2022 20:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiBUS1l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Feb 2022 13:27:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiBUS0N (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Feb 2022 13:26:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464B15F9E
        for <linux-pwm@vger.kernel.org>; Mon, 21 Feb 2022 10:22:18 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nMDKB-0002CQ-Pi; Mon, 21 Feb 2022 19:22:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nMDKB-000Ta4-PH; Mon, 21 Feb 2022 19:22:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nMDKA-004ejb-8u; Mon, 21 Feb 2022 19:22:14 +0100
Date:   Mon, 21 Feb 2022 19:22:13 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] pwm: rcar: Simplify multiplication/shift logic
Message-ID: <20220221182213.wjh3lrnaoquinlxg@pengutronix.de>
References: <4ddca410da1f52a8e2049e0f51f14196cc797200.1645460845.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6zxoayu3tu5xgteu"
Content-Disposition: inline
In-Reply-To: <4ddca410da1f52a8e2049e0f51f14196cc797200.1645460845.git.geert+renesas@glider.be>
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


--6zxoayu3tu5xgteu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 21, 2022 at 05:28:16PM +0100, Geert Uytterhoeven wrote:
>   - Remove the superfluous cast; the multiplication will yield a 64-bit
>     result due to the "100ULL" anyway,
>   - "a * (1 << b)" =3D=3D "a << b".
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6zxoayu3tu5xgteu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIT2FIACgkQwfwUeK3K
7Am27gf/Wz2EWI1e3N2Ei6rtPkAcuxnWK0C3aOdr7KChh7X+ooecBCaLP0QUu7Rm
7sN16y2czAkETCBoLlBQUcLeOkm2hg831ifr/gn9Jw1CbUeyhmfArU/qRvalth6A
cK7cKzjWLbrsRmSgFF+lGMfastFNMhh81ZgQ70mAHmNEq52Pe/cw48ywwdwWXpdw
cb0tLdKovGgBL+peKLG62zw2fORHYB1I0N96Ho2KFLyF3U7lI/2Iyve8JfyyGdvu
f5Ds4uanz+9MyqFb5wLNHM0fzmWO8VZlPFeifOpbJ7+w7HLVORWj3X7Fb2bqMP/C
4GuRj5S8gU7exn7lxxQZpx6a7GNNuQ==
=6X5h
-----END PGP SIGNATURE-----

--6zxoayu3tu5xgteu--
