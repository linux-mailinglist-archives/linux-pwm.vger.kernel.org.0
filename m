Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E25C5F0F28
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Sep 2022 17:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiI3PoC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Sep 2022 11:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiI3PoB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Sep 2022 11:44:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6191A6E8F
        for <linux-pwm@vger.kernel.org>; Fri, 30 Sep 2022 08:44:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeIBC-0000Da-Bw; Fri, 30 Sep 2022 17:43:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeIBC-003pOA-3b; Fri, 30 Sep 2022 17:43:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oeIB9-004hYf-Li; Fri, 30 Sep 2022 17:43:55 +0200
Date:   Fri, 30 Sep 2022 17:43:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH 3/3] pwm: Make capture support optional
Message-ID: <20220930154355.3uymms4xtmlshgmd@pengutronix.de>
References: <20220523174502.987113-1-u.kleine-koenig@pengutronix.de>
 <20220523174502.987113-3-u.kleine-koenig@pengutronix.de>
 <YrMdON4uOMfDFN8h@orome>
 <20220622170945.n7eyrnuezs52itt3@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xz3snnod57a25jr2"
Content-Disposition: inline
In-Reply-To: <20220622170945.n7eyrnuezs52itt3@pengutronix.de>
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


--xz3snnod57a25jr2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Wed, Jun 22, 2022 at 07:09:45PM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, Jun 22, 2022 at 03:46:32PM +0200, Thierry Reding wrote:
> > On Mon, May 23, 2022 at 07:45:02PM +0200, Uwe Kleine-K=F6nig wrote:
> > > The only code making use of the capture functionality is the sysfs co=
de
> > > in the PWM framework. I suspect there are no real users and would lik=
e to
> > > deprecate it in favor of the counter framework. So introduce a kconfig
> > > symbol to remove the capture support and make the sysfs file a stub.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/Kconfig     | 12 ++++++++++++
> > >  drivers/pwm/core.c      |  3 ++-
> > >  drivers/pwm/pwm-sti.c   |  4 ++++
> > >  drivers/pwm/pwm-stm32.c |  4 ++++
> > >  drivers/pwm/sysfs.c     |  4 ++++
> > >  include/linux/pwm.h     |  5 +++++
> > >  6 files changed, 31 insertions(+), 1 deletion(-)
> >=20
> > I've applied patches 1-2 for now, but I'm not convinced about this yet.
> >=20
> > The PWM capture is something that's typically useful for applications
> > served from userspace, which is why only the sysfs implementation
> > exists. So anything that's based on another framework is likely not
> > going to have in-kernel users either. Can you specify exactly how this
> > alternative implementation would look like and how it would be an
> > improvement over the current implementation?
>=20
> The counter framework would generate a continous stream of events while
> you measure and from the timestamps of the events you can determine
> period and duty cycle. So this is even more flexible because pwm-capture
> only supports one-shot mode while with the counter stuff you can stop
> to measure whenever you want to. Having said that, I didn't actually use
> the counter framework for something like that, but that's how I think it
> works and the framework has users.
>=20
> Other than that I have no better reasoning than the commit log. It's
> some time ago something happend in pwm that concerns the capture
> functionality[1] and the 13 new drivers since then all didn't implement
> capture support. Also the capture stuff was done by an ST employee for
> an ST driver, so that might not even be an active user but just a
> developer fulfilling a management roadmap such that the marketing
> department can advertise capture support. (Added Fabrice Gasnier to Cc:,
> maybe he will comment.)
>=20
> I don't know of any user of this, but of course I cannot rule out there
> are users I just don't know of. So the suggestion here looks reasonable
> to me: There is a Kconfig item now, people who don't use capture can
> disable it and the ones who rely on it set it =3Dy. I expect that when
> this switch hits the distribution kernels it will initially be off. Then
> either people will wail to enable it. Or they don't and in a few years
> we can be even more convinced there are no active users.

You discarded this patch as "rejected" without any feedback to my
explanation :-\

Do you think that capture support is such a vital part of the pwm
framework that everyone who makes use of a PWM should also have the
capture stuff even though only two drivers implement the needed callback
and all drivers that were added in the last five years don't?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xz3snnod57a25jr2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM3DrUACgkQwfwUeK3K
7AkLWQgAivMr1q1hCh1wNqSk6PLL3z2tKdS0aSX8KW102d8lyXkDHLeJuF3rfh86
2X0HQfSvEh+qFnZGck04Prgqs5NfPIlW3W5LI0ruDOomYEosxCOrokBsJ2b/nlsj
UxAfWm1013CaOy2bEoWATmA+ho1llfybbAI41ftA90ZkC3FirDy1mgEG3tsthggh
3XsbJeYAT2YSDAT8ZSQtMs29BZTAFf67c+As7TbGRRTuGnVmveOLthKrEKDdht4b
h31a6ULnJC+8NTUhALqML2T+c45Vd07T4y2Op1uAdfytHU9LmLAlCJNW5o7w4q3j
ntJe8ikmUXzKscuSoXFBnXk/keb3iA==
=kB0W
-----END PGP SIGNATURE-----

--xz3snnod57a25jr2--
