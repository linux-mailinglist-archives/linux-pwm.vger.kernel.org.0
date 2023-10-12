Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8361A7C70A6
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378013AbjJLOsQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 10:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379031AbjJLOsP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 10:48:15 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB2FB8
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 07:48:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqwyy-0007C4-Dk; Thu, 12 Oct 2023 16:48:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqwyv-001AuK-Ps; Thu, 12 Oct 2023 16:48:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqwyv-00F0i8-GV; Thu, 12 Oct 2023 16:48:09 +0200
Date:   Thu, 12 Oct 2023 16:48:09 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>, kernel@pengutronix.de
Subject: Re: [PULL] pwm: Changes for v6.7-rc1
Message-ID: <20231012144809.qxlpx6jysj5gploi@pengutronix.de>
References: <20230930210758.urhdzkgczpabfsnh@pengutronix.de>
 <20231012084714.sr7t37ptr3qz2wje@pengutronix.de>
 <ZSf05DhzLT8qfKjJ@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qcvvpiwighyoxksb"
Content-Disposition: inline
In-Reply-To: <ZSf05DhzLT8qfKjJ@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--qcvvpiwighyoxksb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Oct 12, 2023 at 03:30:12PM +0200, Thierry Reding wrote:
> On Thu, Oct 12, 2023 at 10:47:14AM +0200, Uwe Kleine-K=F6nig wrote:
> > Are you already done for this cycle? What about the patches included
> > in this PR that you didn't apply and didn't give any feedback? (These a=
re:
>=20
> I'm not done yet, but I've got a bunch of other things that need my
> attention, so things are moving a bit slowly. And sorry that I didn't
> see this before.

I expected that this PR also appears in patchwork, but it didn't. I
mentioned that in #linux-pwm on Oct 2. Is this a suitable channel to
communicate such things for you?
=20
> Maybe next time you can mark these as "delegated" to you in patchwork,
> which would give me an additional indication?

Good idea. I assume that means that you consider my effort to collect
patches a well spend support.
=20
> > 	pwm: cros-ec: Simplify using devm_pwmchip_add() and dev_err_probe()
> > 	pwm: samsung: Consistently use the same name for driver data
> > 	pwm: vt8500: Simplify using devm functions
> > 	pwm: sprd: Simplify using devm_pwmchip_add() and dev_err_probe()
> > 	pwm: sprd: Provide a helper to cast a chip to driver data
> > 	pwm: spear: Simplify using devm functions
> > 	pwm: mtk-disp: Simplify using devm_pwmchip_add()
> > 	pwm: imx-tpm: Simplify using devm functions
> > 	pwm: brcmstb: Simplify using devm functions
> > 	pwm: bcm2835: Simplify using devm functions
> > 	pwm: bcm-iproc: Simplify using devm functions
> > 	pwm: dwc: add PWM bit unset in get_state call
> > 	pwm: dwc: make timer clock configurable
> > 	pwm: dwc: split pci out of core driver
> > 	pwm: berlin: Simplify using devm functions
> > 	pwm: Drop pwm_[sg]et_chip_data()
> > 	pwm: cros-ec: Put per-channel data into driver data
> > 	pwm: sti: Reduce number of allocations and drop usage of chip_data
> > 	pwm: renesas: Drop usage of pwm_[gs]et_chip_data()
> > 	pwm: lp3943: Drop usage of pwm_[gs]et_chip_data()
> > 	pwm: jz4740: Put per-channel clk into driver data
> > 	pwm: samsung: Put per-channel data into driver data
> > 	pwm: berlin: Put per-channel config into driver data
> > 	pwm: crc: Allow compilation as module and with COMPILE_TEST
> > 	pwm: Manage owner assignment implicitly for drivers
> > 	pwm: jz4740: Consistently name driver data "jz"
> >=20
> > (The patch "pwm: Adapt sysfs API documentation to reality" was already
> > applied by corbet.))
> >=20
> > Since I created this PR a few more patches hit the list that IMHO can go
> > in. (Florian's PM patches for brcmstb and bcm2835, Rob's DT include
> > patch and my USE_DEFINE_SIMPLE_DEV_PM_OPS series.)
> >=20
> > IMHO they are all good and easy enough that "needs more time for review"
> > is hardly an argument.
>=20
> I'll go over the rest of patchwork over the next couple of days and pick
> up what's ready to go.

Great, thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qcvvpiwighyoxksb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUoBygACgkQj4D7WH0S
/k4mMAgArh1kbtgqAHptM4cwRKfOI0r3lT9GljAIUXKk2ny7vSL7oy8M4UoraZnK
7ZwdOmzfACSgEqIGK2AwJB2M+n6tjLg7RP4pJqop/JD9nj4Z8NMBJxYGC7VxayYT
GPzamUcUV2CpggfpEFF3V2ENfgkepQfzsOlAso3gR4lB36GQkcZpxwO25VoMWofx
CtglWDnlphY2J28eFU3z5VuXefqDRRZA3cKh3eEJR0cI3JtpX7QIt/Ev+ziSJJ+k
7esdrxtEMyWN2re5co+t5qVhOl0pTGbGXa7GV+pEXxv+c2pfBnFCAbrZ3yyBNHKN
/TKWXvtJ8u1RX6auK8i2IutY1XToHQ==
=/LdM
-----END PGP SIGNATURE-----

--qcvvpiwighyoxksb--
