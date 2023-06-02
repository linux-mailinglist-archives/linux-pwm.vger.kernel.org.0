Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6084671FC09
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Jun 2023 10:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjFBI1q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Jun 2023 04:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjFBI1K (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Jun 2023 04:27:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C3E1707
        for <linux-pwm@vger.kernel.org>; Fri,  2 Jun 2023 01:26:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q5076-0007g1-OA; Fri, 02 Jun 2023 10:26:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q5075-004Xlj-60; Fri, 02 Jun 2023 10:26:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q5074-00APUw-AD; Fri, 02 Jun 2023 10:26:22 +0200
Date:   Fri, 2 Jun 2023 10:26:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v17] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Message-ID: <20230602082622.vs3boxqgek4jmb7b@pengutronix.de>
References: <20230522171449.688814-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nf4fj3vubftysrlc"
Content-Disposition: inline
In-Reply-To: <20230522171449.688814-1-biju.das.jz@bp.renesas.com>
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


--nf4fj3vubftysrlc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, May 22, 2023 at 06:14:49PM +0100, Biju Das wrote:
> base-commit: 9f258af06b6268be8e960f63c3f66e88bdbbbdb0
> prerequisite-patch-id: 7d5c55db908971d16a58eb46b25d42dfb0f680ec
> prerequisite-patch-id: 6c15d33bb612750523d14af87a5cf9e6ff142540
> prerequisite-patch-id: e5e4d86a0a012a59f585b84ce7ae0d3f047787dc
> prerequisite-patch-id: d62b4e1326f1518fd30eb98a37bfb4998573979a
> prerequisite-patch-id: 15bf63b610cab275387a2bbee7ab2a0a48414f75

My working copy doesn't contain
9f258af06b6268be8e960f63c3f66e88bdbbbdb0, so I wonder what is the base
you used here. Also the other prerequisite patches are unclear to me and
I didn't find them[1]. I assume it's stuff around

	654c293e1687 mfd: Add Renesas RZ/G2L MTU3a core driver

(which is in v6.4-rc1)? I recommend duplicating this information in
human readable form in the cover letter (or below the --- if it's only a
single patch).

So this patch was probably not tested by the build bots.

Otherwise I think this is good enough to go in now, so:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

[1] git log -p v6.2..next/master | git patch-id | grep 6c15d33bb612750523d1=
4af87a5cf9e6ff142540

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nf4fj3vubftysrlc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR5p60ACgkQj4D7WH0S
/k4fewgArLtkF/a7qmldtJ3eVJUdAH04DG9lgeDDZWeyXgIJj577f94aYfeXn5Ls
6i4cOubitXFiGlLm7w6pujol60azn6B7qibm24clYqWOgTSlNaq8i30Uq3zjEkD2
GdNRunTgtHjNTs3qKjAg+VUdw9YnhXAHVBJJM8DocRvXnGPgcO9J0ZmMKibg501a
ndTADGgBnO0sCEGBDNolpYTmG0upRErooPv6e0xRCzp7tbR5O6ChnCMwuQQtLuVI
giTDu+5QY1P1EZNNQ2k2ewjQ1V+39NKR1uTbXT7zHOeM/stKZtgL+FjtCFpsofXn
i66MD2rXoUljqzFkB7f0+NqfCi8QbQ==
=pbdN
-----END PGP SIGNATURE-----

--nf4fj3vubftysrlc--
