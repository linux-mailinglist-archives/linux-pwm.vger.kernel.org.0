Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D6C7666BE
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 10:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjG1IS1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 04:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbjG1ISH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 04:18:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0463F10E
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 01:18:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPIfl-0005yV-Ba; Fri, 28 Jul 2023 10:18:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPIfj-002fOF-T5; Fri, 28 Jul 2023 10:18:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPIfj-008S77-7A; Fri, 28 Jul 2023 10:18:03 +0200
Date:   Fri, 28 Jul 2023 10:18:03 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/2] pwm: stmpe: Don't issue error messages for problems
 in .apply_state()
Message-ID: <20230728081803.aswbz4slvrqqi5hc@pengutronix.de>
References: <20230714214519.2503468-1-u.kleine-koenig@pengutronix.de>
 <20230714214519.2503468-2-u.kleine-koenig@pengutronix.de>
 <ZMN2DtpxEpHcseTi@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wtwb2wwbm2l6qz3u"
Content-Disposition: inline
In-Reply-To: <ZMN2DtpxEpHcseTi@orome>
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


--wtwb2wwbm2l6qz3u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 10:02:22AM +0200, Thierry Reding wrote:
> On Fri, Jul 14, 2023 at 11:45:19PM +0200, Uwe Kleine-K=F6nig wrote:
> > pwm drivers are supposed to be silent for failures in .apply_state()
> > because a problem is likely to be persistent and so it can easily flood
> > the kernel log. So remove all error messages from .apply_state() and the
> > functions that are (only) called by that callback.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-stmpe.c | 35 ++++++-----------------------------
> >  1 file changed, 6 insertions(+), 29 deletions(-)
>=20
> I don't necessarily agree with that claim. Given that some of the
> implementations can be quite complex, the error messages may be useful
> to diagnose what exactly is going wrong. It's also quite rare for any
> consumers to call pwm_apply_state() in quick succession, so I don't
> think "flooding" is really a problem.
>=20
> Is this an actual problem anywhere?

The real motivation for this change was to stop the driver making use of
struct pwm_chip::dev as I'm changing that one in my effort to track a
pwm_chip's lifetime using a struct device preparing character device
support for PWMs. So each usage that is gone doesn't need to be touched
later together with the pwm_chip restructurings.

While I think that the error messages are hardly useful I also never
were in a situation where they triggered, so maybe my judgement isn't
well-founded.

> On the other hand, the stmpe_reg_read() and stmpe_reg_write() produce
> error messages of their own, so the ones in this driver mainly serve as
> adding context. Perhaps rather than removing these, turning them into
> dev_dbg() would be a good compromise?

I will consider that. It would still use chip->dev, but I can cope with
that. :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wtwb2wwbm2l6qz3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTDeboACgkQj4D7WH0S
/k53ogf+OMjGXX6GAMEIDDzu8FYz5WjbCFY40R4pbnRPuh1aL5SAuGD9dkankZW6
2MvpsY4+0ORZ97SNrayEc+EMajuMlBpuiJjgyzBbJJ6or5ZeK4q0DejcyMS87bMS
9UkdR5eKmpofWEm5BfFuRnDJ3aE6ZewAPS8w6qgtyXXmocZKgMnzFdF/JZt1HJdL
DtHoYDgTJQoX2u1wA5lqljag6vVFXI5Jz819z+GfW/IRvePxwBaLvO9wJT2tUq3B
bBvcr5YZ0yZ/G1pZ1su1RdXGhuQZ9KGtlBpwjXGL+9/FLaJjdeCSfewyluptbS39
rYvRhHRUaXsddTGhjNEJklm6EhcGRg==
=8D0T
-----END PGP SIGNATURE-----

--wtwb2wwbm2l6qz3u--
