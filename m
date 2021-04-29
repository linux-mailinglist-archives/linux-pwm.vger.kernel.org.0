Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247E136E523
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Apr 2021 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbhD2GxJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Apr 2021 02:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbhD2GxI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Apr 2021 02:53:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3241C06138B
        for <linux-pwm@vger.kernel.org>; Wed, 28 Apr 2021 23:52:22 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lc0X0-0002j9-JE; Thu, 29 Apr 2021 08:52:14 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lc0Wz-0002AX-Ul; Thu, 29 Apr 2021 08:52:13 +0200
Date:   Thu, 29 Apr 2021 08:52:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        subbaram@codeaurora.org, collinsd@codeaurora.org,
        aghayal@codeaurora.org
Subject: Re: [PATCH 2/2] pwm: pwm-qcom: add driver for PWM modules in QCOM
 PMICs
Message-ID: <20210429065213.inajpznvfxa2xsld@pengutronix.de>
References: <20210427102247.822-1-fenglinw@codeaurora.org>
 <20210427102247.822-3-fenglinw@codeaurora.org>
 <20210427170748.wglupc6zwrndalxs@pengutronix.de>
 <YImfkM/ll1nCmopq@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y4s53szfi6y5jve3"
Content-Disposition: inline
In-Reply-To: <YImfkM/ll1nCmopq@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--y4s53szfi6y5jve3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Apr 28, 2021 at 07:46:56PM +0200, Thierry Reding wrote:
> On Tue, Apr 27, 2021 at 07:07:48PM +0200, Uwe Kleine-K=F6nig wrote:
> > I would like to see the register definition to use a common prefix (like
> > QCOM_PWM_) and that the names of bit fields include the register name.
> > So something like:
> >=20
> > 	#define QCOM_PWM_PWM_SIZE_CLK		0x41
> > 	#define QCOM_PWM_PWM_SIZE_CLK_FREQ_SEL 		GENMASK(1, 0)
> >=20
> > even if the names are quite long, its usage is less error prone. Maybe
> > it makes sense to drop the duplicated PWM (but only if all or no
> > register contains PWM in its name according to the reference manual).
> > Also maybe QCOM_PWM_PWMSIZECLK_FREQSEL might be a good choice. I let you
> > judge about the details.
>=20
> Please stop requesting this. A common prefix is good for namespacing
> symbols, but these defines are used only within this file, so there's no
> need to namespace them.

I do consider it important. The goal of my review comments is to improve
the drivers according to what I consider sensible even if that might not
fit your metrics.=20

Consistent name(space)ing is sensible because the names of static
functions are used in backtraces. It is sensible because tools like
ctags, etags and cscope work better when names are unique. It is
sensible because it's harder than necessary to spot the error in

	writel(PWM_EN_GLITCH_REMOVAL_MASK, base + REG_ENABLE_CONTROL);

=2E It is sensible because the rule "Use namespacing for all symbols" is
easier than "Use namespacing for symbols that might conflict with
(present or future) names in the core or that might appear in user
visible messages like backtraces or KASAN reports". It's sensible
because then it's obvious when reading a code line that the symbol is
driver specific. It is useful to have a common prefix for driver
functions because that makes it easier to select them for tracing.

> Forcing everyone to use a specific prefix is just going to add a bunch
> of characters but doesn't actually add any value.

That's your opinion and I disagree. I do see a value and the "burden" of
these additional characters is quite worth its costs. In my bubble most
people also see this value. This includes the coworkers I talked to,
several other maintainers also insist on common prefixes[1] and it
matches what my software engineering professor taught me during my
studies. I also agree that longer names are more annoying than short
ones, but that doesn't outweigh the advantages in my eyes and a good
editor helps here.
=20
Best regards
Uwe

[1] A few posts that I found quickly:
    https://lore.kernel.org/lkml/YH2k5xnD%2F+CKnMBQ@hovoldconsulting.com/
    https://lore.kernel.org/lkml/CAPDyKFpg1qJD0r54sBC3hCoFey_+gwAL1n2o-aGwn=
AzAan5p7w@mail.gmail.com/
    https://lore.kernel.org/lkml/CAMpxmJW770v6JLdveEe1hkgNEJByVyArhorSyUZBY=
OyFiVyOeg@mail.gmail.com/
    https://lore.kernel.org/linux-can/fe0a8a9b-35c6-8f23-5968-0b14abb6078d@=
pengutronix.de/
    https://lore.kernel.org/netdev/20190327084422.4209-16-maxime.chevallier=
@bootlin.com/

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--y4s53szfi6y5jve3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCKV5kACgkQwfwUeK3K
7AlmwQf/epeEtpmrZMHYRnU75vEFtSLuwbRwEWsSadMmTTP8gE82juELjPfqMZff
aUHOX2IiZkMlBEsPUIUWQZIqY0tMnlpnrwg6ndugFlhACZXn1G7eIl0ojyeoTnB8
tSjHCQOzL4S8+PWHyxshxFzG3eQJuEbK5LkcvZiENPM0LrIrh0OOHvCVVQedMeg4
zrmAQ2jJgB4QQ4taTQ/n9HyJ07GZUZxEkU9c5SGVfYcwc2BXLLnTHg39K2FNVUW+
qiqMTgLyXFUVv6pfOxUU0uGY87XOzG+pIUIm/2eO6eKnx45ewxaur5k9PSaNF9+3
bYo8WAxns5T8PEg+r4UjeWlIwYj9yw==
=sHLp
-----END PGP SIGNATURE-----

--y4s53szfi6y5jve3--
