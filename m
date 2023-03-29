Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C94A6CF4D6
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Mar 2023 22:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjC2Uwj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Mar 2023 16:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjC2Uw2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Mar 2023 16:52:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9B66EBD
        for <linux-pwm@vger.kernel.org>; Wed, 29 Mar 2023 13:52:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1phclu-0001zE-G2; Wed, 29 Mar 2023 22:51:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phcls-007cAt-7M; Wed, 29 Mar 2023 22:51:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phclr-0091Ek-A4; Wed, 29 Mar 2023 22:51:51 +0200
Date:   Wed, 29 Mar 2023 22:51:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lee Jones <lee@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v14 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Message-ID: <20230329205150.a4tdosjlojppigc6@pengutronix.de>
References: <20230310170654.268047-1-biju.das.jz@bp.renesas.com>
 <20230310170654.268047-7-biju.das.jz@bp.renesas.com>
 <20230327204000.x67sybfbp34udwfg@pengutronix.de>
 <OS0PR01MB5922B1D75AF03CA851572AB586899@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6z6brxp2giiq35mf"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922B1D75AF03CA851572AB586899@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6z6brxp2giiq35mf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Biju,

On Wed, Mar 29, 2023 at 05:40:17PM +0000, Biju Das wrote:
> [...]

IMHO it's easier to send a v15 instead of discussing what you made of my
suggestions in prosa.

> > .probe() enables rz_mtu3_pwm->clk, but there is no .remove() that cares
> > about disabling it again.
>=20
> I believe it is ok. I have added WARN_ON for double checking.
> Please correct me, if it is wrong.

I might have missed some details in the runtime pm stuff. I'll happily
recheck if you resend with the other things we agreed on fixed.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6z6brxp2giiq35mf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQkpOUACgkQj4D7WH0S
/k7PHwf3Up6s6QHp3k7DgWe8QdKCFjJVWpf97pwB60EzM4cym+vDAtT+znVGsg1A
IINmRwmCADerl0nDeLQWQGV+zegneCi3H4dTPO1162hk619NbAbYf3znoA0h+2yB
d2bBYda9JuIx4t4fzn3tYMdEliecCcaXX2zmwV24+m7MRhs2mxFhKRwzHO50ELEJ
cfZSsJVqZ1DA4SyJXjh2LdwkCmFpEe5ykveyn0wXFEJ0ruw5TplMbyF6tD+569Ui
coJc3SxHjADL6Al/vKE79f9HwHmLygJk39Dq/E1OGNN+Vkuop99dk83bgyHfTDwQ
s3VprgasWoIpUBSnN5OfhDTKIpG+
=uR9f
-----END PGP SIGNATURE-----

--6z6brxp2giiq35mf--
