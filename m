Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076AF5F69AF
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Oct 2022 16:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiJFOgB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Oct 2022 10:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiJFOf7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Oct 2022 10:35:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446298322D
        for <linux-pwm@vger.kernel.org>; Thu,  6 Oct 2022 07:35:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ogRyb-00065S-Kj; Thu, 06 Oct 2022 16:35:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ogRyX-004ymV-2J; Thu, 06 Oct 2022 16:35:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ogRyU-0061hl-D2; Thu, 06 Oct 2022 16:35:46 +0200
Date:   Thu, 6 Oct 2022 16:35:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH 3/3] pwm: Make capture support optional
Message-ID: <20221006143544.ivhjruazd5m673hf@pengutronix.de>
References: <20220523174502.987113-1-u.kleine-koenig@pengutronix.de>
 <20220523174502.987113-3-u.kleine-koenig@pengutronix.de>
 <YrMdON4uOMfDFN8h@orome>
 <20220622170945.n7eyrnuezs52itt3@pengutronix.de>
 <20220930154355.3uymms4xtmlshgmd@pengutronix.de>
 <Yz7Ttd0WXv7MeKtc@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2cxcz5kpy3g6jkn5"
Content-Disposition: inline
In-Reply-To: <Yz7Ttd0WXv7MeKtc@orome>
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


--2cxcz5kpy3g6jkn5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Oct 06, 2022 at 03:10:13PM +0200, Thierry Reding wrote:
> On Fri, Sep 30, 2022 at 05:43:55PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Wed, Jun 22, 2022 at 07:09:45PM +0200, Uwe Kleine-K=F6nig wrote:
> > > On Wed, Jun 22, 2022 at 03:46:32PM +0200, Thierry Reding wrote:
> > > > On Mon, May 23, 2022 at 07:45:02PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > > The only code making use of the capture functionality is the sysf=
s code
> > > > > in the PWM framework. I suspect there are no real users and would=
 like to
> > > > > deprecate it in favor of the counter framework. So introduce a kc=
onfig
> > > > > symbol to remove the capture support and make the sysfs file a st=
ub.
> > > > >=20
> > > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > > ---
> > > > >  drivers/pwm/Kconfig     | 12 ++++++++++++
> > > > >  drivers/pwm/core.c      |  3 ++-
> > > > >  drivers/pwm/pwm-sti.c   |  4 ++++
> > > > >  drivers/pwm/pwm-stm32.c |  4 ++++
> > > > >  drivers/pwm/sysfs.c     |  4 ++++
> > > > >  include/linux/pwm.h     |  5 +++++
> > > > >  6 files changed, 31 insertions(+), 1 deletion(-)
> > > >=20
> > > > I've applied patches 1-2 for now, but I'm not convinced about this =
yet.
> > > >=20
> > > > The PWM capture is something that's typically useful for applicatio=
ns
> > > > served from userspace, which is why only the sysfs implementation
> > > > exists. So anything that's based on another framework is likely not
> > > > going to have in-kernel users either. Can you specify exactly how t=
his
> > > > alternative implementation would look like and how it would be an
> > > > improvement over the current implementation?
> > >=20
> > > The counter framework would generate a continous stream of events whi=
le
> > > you measure and from the timestamps of the events you can determine
> > > period and duty cycle. So this is even more flexible because pwm-capt=
ure
> > > only supports one-shot mode while with the counter stuff you can stop
> > > to measure whenever you want to. Having said that, I didn't actually =
use
> > > the counter framework for something like that, but that's how I think=
 it
> > > works and the framework has users.
> > >=20
> > > Other than that I have no better reasoning than the commit log. It's
> > > some time ago something happend in pwm that concerns the capture
> > > functionality[1] and the 13 new drivers since then all didn't impleme=
nt
> > > capture support. Also the capture stuff was done by an ST employee for
> > > an ST driver, so that might not even be an active user but just a
> > > developer fulfilling a management roadmap such that the marketing
> > > department can advertise capture support. (Added Fabrice Gasnier to C=
c:,
> > > maybe he will comment.)
> > >=20
> > > I don't know of any user of this, but of course I cannot rule out the=
re
> > > are users I just don't know of. So the suggestion here looks reasonab=
le
> > > to me: There is a Kconfig item now, people who don't use capture can
> > > disable it and the ones who rely on it set it =3Dy. I expect that when
> > > this switch hits the distribution kernels it will initially be off. T=
hen
> > > either people will wail to enable it. Or they don't and in a few years
> > > we can be even more convinced there are no active users.
> >=20
> > You discarded this patch as "rejected" without any feedback to my
> > explanation :-\
>=20
> Sorry, I hadn't realized that there was outstanding feedback on this.
>=20
> > Do you think that capture support is such a vital part of the pwm
> > framework that everyone who makes use of a PWM should also have the
> > capture stuff even though only two drivers implement the needed callback
> > and all drivers that were added in the last five years don't?
>=20
> Just because only two drivers support a feature doesn't automatically
> make it useless or non-vital.

Ack, but two drivers also don't automatically make it useful or vital. I
never used it even tough I already used PWMs a lot. Did you ever use it?

> This feature was added because somebody
> needed it and I haven't received feedback that this is unused, so I

So you expect people to tell you which part of the PWM framework they
stopped using (or never used)? <sarcasm>Has anybody ever told you that
they don't use CONFIG_PWM? Maybe we should compile it in
unconditionally.</sarcasm>

> see no reason why this should be removed.

I don't want to remove it---at least for now. Just make it possible to
disable this code for users who don't need it. (To pick up your line of
reasoning: I haven't received feedback that it is used.) I'm happy about
every unused feature I can disable, even if it only affects a single
sysfs property. Code that is compiled out cannot trash cache lines or
bring in runtime overhead or security problems without any gain. Yeah,
this affects only very little code, but flipping a Kconfig switch is
still easier than even to consider to review the capture stuff for
unwanted effects. Given that more than 90% (99% ?) don't use capture, I
do see some benefit.

> The overhead for drivers that
> don't use this is negligible. There's exactly one function pointer that
> would always be NULL for those. Then there's one sysfs attribute with
> associated code and one core function that's just a teeny tiny wrapper
> around the function pointer.

Agreed, the overhead is small. Still code that is hardly used, not even
by the maintainers of the framework is a bad thing in my eyes. So being
able to disable it (and ship kernels with that item disabled in distros)
is a good way to find users who care, should they really exist. Either
outcome is a win. Either we can get rid of an unused feature at some
point in time, or we actually know there are users and we know their
email address.

> On the other side of this we have an additional PWM_CAPTURE Kconfig
> symbol that introduces another combination that needs to be compile-
> tested for along with the potential to confuse users when they don't
> get capture support, etc. And that's just not worth it.

My (subjective) judgement is obviously different. IMHO compile testing
isn't a big issue. There are enough auto builders around to catch this
and should really someone get it wrong, it's easy and trivial to fix.
And if we had done this change 5 years ago, exactly zero patches since
then would have had to care about this Kconfig symbol.

> If you really think that the counters framework is a better fit, the
> right way to deprecate this is to add support for equivalent capture
> functionality to that framework and get everyone to transition to that.

I claim everyone already transitioned. I cannot prove it as you cannot
prove the opposite. Until we make it harder for people to use it.

> Once that's done we can deprecate (and eventually perhaps even remove)
> the PWM capture stuff.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2cxcz5kpy3g6jkn5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM+570ACgkQwfwUeK3K
7AmMfAf8Du1oVmGhifijBfhjuqdJzMJtFztJjYoW6YNylA3Zsw/73JPhz1JIstuV
c+NdtRQnbzLyEsX5F+IJZEma04MarvY5ALnlwEw59tld/VXeE8j5FdfCekaepxCN
lwy07NhSEZ0T10WkHHVQbmbE852JMxiWdmWUxkI2EgRv8VtunS1jLH4C6pZHQGL/
oSm45OcERmnsKq40Qbv6AdMPl8tE7ITiYlslSNNXzEx50x+lFY3lnrzccZyVlggG
IGHXysx+AOTlTOrDng6ouH23J0wT+umrKvMKQI4T5itYQ9EANgzLlHSD/hTlTLdy
nKRjY+60jn+3QD5/jaAIO4pqVAPqtQ==
=L6jl
-----END PGP SIGNATURE-----

--2cxcz5kpy3g6jkn5--
