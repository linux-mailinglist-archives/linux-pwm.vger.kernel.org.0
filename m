Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BAC622737
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Nov 2022 10:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiKIJjZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Nov 2022 04:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiKIJjT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Nov 2022 04:39:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D727CE8
        for <linux-pwm@vger.kernel.org>; Wed,  9 Nov 2022 01:39:18 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oshY8-0007Av-F3; Wed, 09 Nov 2022 10:39:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oshY6-003Dxy-70; Wed, 09 Nov 2022 10:39:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oshY6-00FOB4-2q; Wed, 09 Nov 2022 10:39:10 +0100
Date:   Wed, 9 Nov 2022 10:39:09 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: renesas,pwm-rcar: Add r8a779g0 support
Message-ID: <20221109093909.wjcv3remlloureii@pengutronix.de>
References: <7785f163a5a798574c68495de8b0ca7a02e35f07.1665156318.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7zl37ugebwzhjs7d"
Content-Disposition: inline
In-Reply-To: <7785f163a5a798574c68495de8b0ca7a02e35f07.1665156318.git.geert+renesas@glider.be>
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


--7zl37ugebwzhjs7d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Oct 07, 2022 at 05:25:56PM +0200, Geert Uytterhoeven wrote:
> Document support for the PWM timers in the Renesas R-Car V4H (R8A779G0)
> SoC.
>=20
> Based on a patch in the BSP by CongDang.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Who will pick this patch up? Looking at the git history, patches were
committed by Thierry and Rob in the past. Who volunteers? (Assuming no
objections are brought forward of course.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7zl37ugebwzhjs7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNrdToACgkQwfwUeK3K
7AlX3wf+MFosI9wpD+cOP9XVMKRzomSOTUutRjFGyssy8uU2/agmY7rUnGej38l0
4nHZ2Tj13AEqNBcaBo1sLs5ByWM5MzffrHupchQSZVtYEnrQWVlzaJs5daR3XzwA
VQ19Sy3R3MqGyTICCEqm4ql3hhU+2CebjWW3BEvs5CJNpZeT9xsjeSK91njTvZbu
L6Lgi67L2V0Bws8oATQC+x0xmL+Oo+ggwKYorXwf+I1c3enq/xK98jXsur/d9ei1
H1Q9o7HcBy1ojuEI61V686SrZnHimSlVjjVehqxj+AGotqBwTpqwLejt+wwxZGxF
Z7zzgrPVPjKmxl5g2X1yMV4C7m8s5g==
=0ZGv
-----END PGP SIGNATURE-----

--7zl37ugebwzhjs7d--
