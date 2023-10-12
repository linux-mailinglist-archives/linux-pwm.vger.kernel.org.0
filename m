Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FD37C6890
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 10:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbjJLIrW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 04:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjJLIrV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 04:47:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8B190
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 01:47:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqrLi-0005yn-HI; Thu, 12 Oct 2023 10:47:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqrLf-0016aX-6p; Thu, 12 Oct 2023 10:47:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqrLe-00ElWv-Td; Thu, 12 Oct 2023 10:47:14 +0200
Date:   Thu, 12 Oct 2023 10:47:14 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>, kernel@pengutronix.de
Subject: Re: [PULL] pwm: Changes for v6.7-rc1
Message-ID: <20231012084714.sr7t37ptr3qz2wje@pengutronix.de>
References: <20230930210758.urhdzkgczpabfsnh@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ddfa5ipluxii5g6e"
Content-Disposition: inline
In-Reply-To: <20230930210758.urhdzkgczpabfsnh@pengutronix.de>
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


--ddfa5ipluxii5g6e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Sat, Sep 30, 2023 at 11:07:58PM +0200, Uwe Kleine-K=F6nig wrote:
> I started picking patches from the mailing list that I consider ready to
> go in. I was unsure if I should include my big series fixing the
> lifetime issues I identified. However deciding that was simple as it
> depends on patch "drm/ssd130x: Print the PWM's label instead of its
> number" which currently waits as 84f54d4966f4 in drm-misc/next and I
> neither wanted to duplicate this patch nor merge in drm-misc/next
> (including the needed coordination). I'll rebase after the next merge
> window.
>=20
> In the hope this effort is helpful for you and I didn't pick a patch
> that you would have refused, you can find my patch stack based on
> commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
>=20
>   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
>=20
> in the Git repository at:
>=20
>   https://git.pengutronix.de/git/ukl/linux tags/pwm/for-thierry-6.7-rc1
>=20
> for you to fetch up to a8b048b7fd94376ec66ec760f034e04c7e38384c:
>=20
>   pwm: cros-ec: Simplify using devm_pwmchip_add() and dev_err_probe() (20=
23-09-30 22:02:44 +0200)
>=20
> to be added to your for-next branch.
>=20
> Thanks to Ben Dooks, Conor Dooley, Fabio Estevam and Ruan Jinjie for
> their contributions.

I see you ignored this effort and now pushed out a few patches you
picked yourself.

This is really frustrating, there are often long periods of silence from
your side and then around -rc6 you shortly appear, pick some patches and
then disappear again.

Are you already done for this cycle? What about the patches included
in this PR that you didn't apply and didn't give any feedback? (These are:

	pwm: cros-ec: Simplify using devm_pwmchip_add() and dev_err_probe()
	pwm: samsung: Consistently use the same name for driver data
	pwm: vt8500: Simplify using devm functions
	pwm: sprd: Simplify using devm_pwmchip_add() and dev_err_probe()
	pwm: sprd: Provide a helper to cast a chip to driver data
	pwm: spear: Simplify using devm functions
	pwm: mtk-disp: Simplify using devm_pwmchip_add()
	pwm: imx-tpm: Simplify using devm functions
	pwm: brcmstb: Simplify using devm functions
	pwm: bcm2835: Simplify using devm functions
	pwm: bcm-iproc: Simplify using devm functions
	pwm: dwc: add PWM bit unset in get_state call
	pwm: dwc: make timer clock configurable
	pwm: dwc: split pci out of core driver
	pwm: berlin: Simplify using devm functions
	pwm: Drop pwm_[sg]et_chip_data()
	pwm: cros-ec: Put per-channel data into driver data
	pwm: sti: Reduce number of allocations and drop usage of chip_data
	pwm: renesas: Drop usage of pwm_[gs]et_chip_data()
	pwm: lp3943: Drop usage of pwm_[gs]et_chip_data()
	pwm: jz4740: Put per-channel clk into driver data
	pwm: samsung: Put per-channel data into driver data
	pwm: berlin: Put per-channel config into driver data
	pwm: crc: Allow compilation as module and with COMPILE_TEST
	pwm: Manage owner assignment implicitly for drivers
	pwm: jz4740: Consistently name driver data "jz"

(The patch "pwm: Adapt sysfs API documentation to reality" was already
applied by corbet.))

Since I created this PR a few more patches hit the list that IMHO can go
in. (Florian's PM patches for brcmstb and bcm2835, Rob's DT include
patch and my USE_DEFINE_SIMPLE_DEV_PM_OPS series.)

IMHO they are all good and easy enough that "needs more time for review"
is hardly an argument.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ddfa5ipluxii5g6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUnspIACgkQj4D7WH0S
/k6M2wgApVfhBvZWMy+GPeVfZBIfhcqHNLOYcTKnm2eon2ZXDipx1zERtk3LPHBj
1b+aUWloZtCDo5bj/eKruMiRmt0yEiF6WCqc+TtoLCSyfoHGErQdQdYl8BRBKrGb
zN4c7soFW8HuffS6vS9c3Ab09+8Ja4R8xyiZr7afnqTu8tjyg83dJCwm3HVjE9xp
uFLPaGNb3/SnnW+6eu3TQkVyy8qli7xBs5bjZOAPHBnXHY34SHL2ASIl0I5nZClm
TND/KouB0+JlT4T9UBNkB1uhHMq3z+zMSrwTotM8gTEbjzY4uIxWWZMGC9YArvkN
y44hwsbDcQMXl+rrAnp7g1n/wg4Inw==
=vrOL
-----END PGP SIGNATURE-----

--ddfa5ipluxii5g6e--
