Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3984043FF53
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Oct 2021 17:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJ2PVF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Oct 2021 11:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2PVE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Oct 2021 11:21:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093A4C061570
        for <linux-pwm@vger.kernel.org>; Fri, 29 Oct 2021 08:18:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgTe9-0005Hf-Pj; Fri, 29 Oct 2021 17:18:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgTe6-00063Y-Gs; Fri, 29 Oct 2021 17:18:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgTe6-0003Rp-Fd; Fri, 29 Oct 2021 17:18:18 +0200
Date:   Fri, 29 Oct 2021 17:18:15 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Cc:     Sean Young <sean@mess.org>, kernel test robot <lkp@intel.com>,
        mchehab@kernel.org, thierry.reding@gmail.com,
        Lee Jones <lee.jones@linaro.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4] media: rc: pwm-ir-tx: Switch to atomic PWM API
Message-ID: <20211029151815.kn4ya7sk2bsrcrwo@pengutronix.de>
References: <YXlxhpZWf2mxJaMi@fedora>
 <20211028064513.guziv6uaivzlk6ki@pengutronix.de>
 <20211028091442.GA16514@gofer.mess.org>
 <20211028111535.x7xgz7domx2lpyfh@pengutronix.de>
 <20211028122610.GA18767@gofer.mess.org>
 <20211028180516.t2tpfbzztm7s6cqm@pengutronix.de>
 <20211029071608.GA28997@gofer.mess.org>
 <20211029110602.uugnbm5vtfpghiwh@pengutronix.de>
 <20211029115412.GA32383@gofer.mess.org>
 <CAH7FV3njgZ7sOnZZF88KZ2C4UwqxoodpUuLsnucvBxYXmaZo1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="whsgya2kubn3yddj"
Content-Disposition: inline
In-Reply-To: <CAH7FV3njgZ7sOnZZF88KZ2C4UwqxoodpUuLsnucvBxYXmaZo1Q@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--whsgya2kubn3yddj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Oct 29, 2021 at 09:08:29AM -0300, Ma=EDra Canal wrote:
> I would like to thank you guys for the attention and this interesting
> discussion. I'm looking for some work in the kernel and I would like
> to know if you guys have any suggestions for beginner tasks in this
> subsystem. I have solid knowledge in C programming, but I started in
> the kernel a couple of weeks ago. Anyway, thank you for all the
> feedback.

If you want something mathematically demanding, you can pick up the
patch I pointed out to Sean, I think I won't find the time in the near
future to work on this.

The background is that PWM drivers have to round most requests and there
is no uniformity among drivers and so if a consumer (e.g. the pwm-ir
driver) requests say 20000 ns, it will get 18000 from some drivers and
maybe 25000 from others. So the idea is to have a function
pwm_round_state that has fixed rounding rules such that a consumer can
pick the best setting for their use-case.

Something more mechanic in the PWM area is to convert drivers that still
implement .config/.enable/.disable to .apply. See
http://patchwork.ozlabs.org/project/linux-pwm/patch/20211029105617.210178-1=
-u.kleine-koenig@pengutronix.de/
for an example. The well-known good template is pwm_apply_legacy() after
applying
http://patchwork.ozlabs.org/project/linux-pwm/list/?series=3D251456 .

If you want something more global: The prototype of the remove callbacks
for platform devices returns an int:

	https://elixir.bootlin.com/linux/v5.15-rc7/source/include/linux/platform_d=
evice.h#L206

However the returned value is (nearly) ignored by the driver core:

	https://elixir.bootlin.com/linux/v5.15-rc7/source/drivers/base/platform.c#=
L1433

The longterm goal is to change the prototype of .remove to return void.
As a first step making all functions return 0 is a worthwile project.

The same problem exists for several other buses, one patch I sent to
work on this goal for i2c is:

	https://lore.kernel.org/r/20211021105657.72572-1-u.kleine-koenig@pengutron=
ix.de

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--whsgya2kubn3yddj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF8ELQACgkQwfwUeK3K
7AlCMQf/RVnL1UcvsIreO+vijfPhlLHR119QMz4m3LCKpkYMdv1MxstUHqJnRFRm
Q0dN7kOeSnKJgi2jckQQOneVYABnB4vGHMuygSUFZSTXnrizUxRc94rMfk+wvGR4
LbTqhpdi/3Tm/EPKKEZxyAqphA0iTETnLWmeNz34KozaK0IZ3NTlJWdyZh2axb3f
r8+f2p33sPTCrzwOl0DkWfZ+EW4JCrLlGHcxDqZg61WMkwD1ujYd0meVBxsLA8aI
xSLXYL3iHlyY7INCMFcKMQmYDBv6zbkChV6oUO906IbsHZ8/0a1yrWCelAD3Zjmv
KKOC1V8M7kUBtHX0Aqk87HRaFSRBKQ==
=0Is5
-----END PGP SIGNATURE-----

--whsgya2kubn3yddj--
