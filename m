Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289A17EB884
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 22:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjKNVUS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 16:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjKNVUR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 16:20:17 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CB9CB
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 13:20:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r30pP-0006ix-N2; Tue, 14 Nov 2023 22:20:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r30pO-00952I-B8; Tue, 14 Nov 2023 22:20:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r30pO-001XcQ-1h; Tue, 14 Nov 2023 22:20:10 +0100
Date:   Tue, 14 Nov 2023 22:20:09 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] pwm: stm32: Fix enable count for clk in .probe()
Message-ID: <20231114212009.44r742f3xqosswod@pengutronix.de>
References: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
 <20231019200658.1754190-12-u.kleine-koenig@pengutronix.de>
 <c2da3f60-595c-4938-809a-c5640388c13c@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r6ihegeeobhhwcex"
Content-Disposition: inline
In-Reply-To: <c2da3f60-595c-4938-809a-c5640388c13c@foss.st.com>
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


--r6ihegeeobhhwcex
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 02:35:19PM +0100, Fabrice Gasnier wrote:
> On 10/19/23 22:07, Uwe Kleine-K=F6nig wrote:
> > From: Philipp Zabel <p.zabel@pengutronix.de>
> >=20
> > Make the driver take over hardware state without disabling in .probe()
> > and enable the clock for each enabled channel.
> >=20
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > [ukleinek: split off from a patch that also implemented .get_state()]
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-stm32.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
>=20
> Hi Uwe,
>=20
> I'd only have a suggestion on the commit title:
> pwm: stm32: Fix enable count for clk in .probe()
>             ^
> On first sight, the "Fix" may suggest that this fixes something older in
> the tree. This would suggest a Fixes tag which isn't the case in this
> series, as this is a split of the .get_state() patch.
> Is it possible to rephrase ?

IMHO it is a fix, the hw state wasn't properly taken over before.
If you want a Fixes line, that's:

Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")

> something like: set clk enable count when probing channels ?
>=20
> Apart from that, you can add my:
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>=20
> ---
> I've additional questions, unrelated to this patch. I had a look at
> pwm-stm32-lp.c, the clock enabling is done directly in the .get_state()
> routine. I think this should be moved to the .probe() routine as done
> here. There's likely a risk, that clk enable count gets increased
> artificially, at least since commit cfc4c189bc70 "pwm: Read initial
> hardware state at request time".
> Shall I send a patch for pwm-stm32-lp.c, similar as this patch ? Or has
> it been spotted already ?

I'm not aware of someone working on stm32-lp, so feel free to prepare a
patch!

Best regards and thanks for your review,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r6ihegeeobhhwcex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmVT5IkACgkQj4D7WH0S
/k4Z3Qf/Vr6JnoMYrONs6bAbOBdMIAZ8oN2F/CpUkGvejr9MGcC1kyaHZ2hUbDNx
jOtmumD86vMrNjFBH3DGqOKMbM6JMwKq3l9Tlt8155/jgsZ1+nsXmd7I9l1VcVoo
D1JbcZtrNIW8ocfuN8Dr42ZLhHNI7W2tkn1CdsM7aLKJpiFNSICfLzHoT47Ep5oJ
4nWkjny0dnHvExs6bLjXg4f7giMAFfTmSV9OCMP006AnmrnDfhpeEl9E6zIEoye9
j7OnOGgVrjHO/Rp62qAOtreuks+vsXD8EAU4lXqGZm99nFiXfVUd+QXT9Qfjhqrv
6RRcFi3mpnXTbNN6a6sfyXjFUIM7gA==
=PEx/
-----END PGP SIGNATURE-----

--r6ihegeeobhhwcex--
