Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426545220A4
	for <lists+linux-pwm@lfdr.de>; Tue, 10 May 2022 18:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347027AbiEJQJE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 May 2022 12:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348445AbiEJQIO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 May 2022 12:08:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675074C794
        for <linux-pwm@vger.kernel.org>; Tue, 10 May 2022 09:01:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1noSI6-0004bX-A3; Tue, 10 May 2022 18:00:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1noSI6-001W9r-2j; Tue, 10 May 2022 18:00:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1noSI4-008q4u-4j; Tue, 10 May 2022 18:00:48 +0200
Date:   Tue, 10 May 2022 18:00:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [RFC 0/8] Add RZ/G2L POEG support
Message-ID: <20220510160045.4d3pgvjlbea2jwy5@pengutronix.de>
References: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tjk46zng4p3czgo2"
Content-Disposition: inline
In-Reply-To: <20220510151112.16249-1-biju.das.jz@bp.renesas.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tjk46zng4p3czgo2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 10, 2022 at 04:11:04PM +0100, Biju Das wrote:
> The output pins of the general PWM timer (GPT) can be disabled by using
> the port output enabling function for the GPT (POEG). Specifically,
> either of the following ways can be used.
>   * Input level detection of the GTETRGA to GTETRGD pins.
>   * Output-disable request from the GPT.
>   * Register settings.
>=20
> Added RZ/G2L POEG support under driver/soc/renesas, as currently I am not=
 sure about
> the framework to be used for POEG.
>=20
> This patch series add support for controlling output disable function usi=
ng sysfs.
>=20
> For output disable operation, POEG group needs to be linked with
> GPT. So introduced renesas,poeg-group property in pwm for linking both GP=
T and
> POEG devices.
>=20
> Please share your valuable comments.
>=20
> patch#3 and #4 depend upon [1]
> [1] https://lore.kernel.org/linux-renesas-soc/20220510144259.9908-1-biju.=
das.jz@bp.renesas.com/T/#t

I suggest to use the --base switch to git-format-patch for the next
submission round. This way the built robots can parse this information,
too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tjk46zng4p3czgo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJ6jCoACgkQwfwUeK3K
7AnJtgf/X2Qug9zfJKeDXJOUlIhTIoaDddPmGFP5jtb+zLMXec3ZPmkSedfiQaKu
Hgt2zSAeYZfSTu6/rnRnJqnA3/zVBc5mND3z1XkAPxsVhRydLMGHhVEQNU1iFzce
BEDp3lDrsDF45MlTMiZQg4j0R3e8xkKqB26+0be63h6Ro8zdZhOkyRJD8+wEThpu
ifVnm/AzVgzaXLyNhqfaJwp6eMjnYTEBiId5QUfZmvpotSrnUjChjdnUuta7/RQ/
fgh4OZIa12b2UPtmbFuStTATb1n07AkjT9nXeGQRqeFuZo0ixLhHEBThoKe3qZ6B
MIW6NooQ8r9f5nmne2dD6lNi2U7VOg==
=4n1b
-----END PGP SIGNATURE-----

--tjk46zng4p3czgo2--
