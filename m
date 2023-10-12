Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B99E7C6F2D
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 15:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378847AbjJLNaW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 09:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378850AbjJLNaS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 09:30:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD52DA
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 06:30:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53e16f076b3so1003181a12.0
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 06:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697117415; x=1697722215; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5M775B5LMX0Cxy8dT/2/cYtP0fadYYir11MjhBexS8=;
        b=bAjYlNPB81pG3YL2NBW8vv1XcUzH1JNs1xt4uxMCV3io7aqEA0vyTkGAv0poOrMKOi
         IOtb+hA0y0FbTUzCJx5Iwc3LgsKW6ZMX1PgtDqYrictszQ+BkYET1kTNuLZZjd/CBZNX
         FGsd8+FdmJIhTeYpm22OaIhTE6dv03bJqxUx2Kkpvl2fVQEPcQCPzj8Er5arDsZR6+W9
         s4hnDLfEI6WkGJNYA9oTWmomwxlONgDtgfxKhxz/bdALpPU7LbI9eLiTMcZthRxs1n1i
         G2CbjTDZuzfL2qaA3wg1J21YB6sWkJIvds9zbKwlGp58Im/Wzz7H5Ac5bZ8fIM5smUwh
         ZrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697117415; x=1697722215;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5M775B5LMX0Cxy8dT/2/cYtP0fadYYir11MjhBexS8=;
        b=kylN5OrI/rrYxGHV4m5bhvDEgfG/PV7d1+xrjNYu2SXZzkg7X8PYMUF8/VY6hAgwmC
         Xqu1EcPdAnD81j9aO0Z0VX3mV5wzDM8DzeMbVs4UcFzOsCm2OonVzXZCk/J+ma3OWrjp
         /rrsCytJFWUKcTAalTvOt3GiUw5krhEjRkVrTiua3CiM8vulJF0IArl9WeLGnCRkA86u
         /ndKnpAWnbXW6Px/Fo6GOQy/zpDc0mWacMlG+FivSFNNO0raKXpwO5QWzq2yweL2l8cf
         WA7ZUngvu5tWSRF0ReJcDDVQTC4425qqhdXVjU4oXCidAxGJ+QX2TrVeVuPrtrUw7RSc
         VzLg==
X-Gm-Message-State: AOJu0YwrvF9mTSk8tWLXhvwaSEtZ0BwlMYLcIgBTYwG5PK21eg9snSUt
        qK4F/8WTfZbchMj6pu+hqUc=
X-Google-Smtp-Source: AGHT+IG2JauVd9Dsd++spftp6nyztD53DPCQ0cU6gxrX7NSDXDCfpa0IRvK0SePnPDy16TaA8QPrwQ==
X-Received: by 2002:aa7:d943:0:b0:533:ccec:552 with SMTP id l3-20020aa7d943000000b00533ccec0552mr17100908eds.9.1697117415097;
        Thu, 12 Oct 2023 06:30:15 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k18-20020a05640212d200b00537fa467ddasm10081866edx.65.2023.10.12.06.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:30:14 -0700 (PDT)
Date:   Thu, 12 Oct 2023 15:30:12 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>, kernel@pengutronix.de
Subject: Re: [PULL] pwm: Changes for v6.7-rc1
Message-ID: <ZSf05DhzLT8qfKjJ@orome.fritz.box>
References: <20230930210758.urhdzkgczpabfsnh@pengutronix.de>
 <20231012084714.sr7t37ptr3qz2wje@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dy3sj0rKw3k158FA"
Content-Disposition: inline
In-Reply-To: <20231012084714.sr7t37ptr3qz2wje@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--dy3sj0rKw3k158FA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 10:47:14AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Sat, Sep 30, 2023 at 11:07:58PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > I started picking patches from the mailing list that I consider ready to
> > go in. I was unsure if I should include my big series fixing the
> > lifetime issues I identified. However deciding that was simple as it
> > depends on patch "drm/ssd130x: Print the PWM's label instead of its
> > number" which currently waits as 84f54d4966f4 in drm-misc/next and I
> > neither wanted to duplicate this patch nor merge in drm-misc/next
> > (including the needed coordination). I'll rebase after the next merge
> > window.
> >=20
> > In the hope this effort is helpful for you and I didn't pick a patch
> > that you would have refused, you can find my patch stack based on
> > commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> >=20
> >   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> >=20
> > in the Git repository at:
> >=20
> >   https://git.pengutronix.de/git/ukl/linux tags/pwm/for-thierry-6.7-rc1
> >=20
> > for you to fetch up to a8b048b7fd94376ec66ec760f034e04c7e38384c:
> >=20
> >   pwm: cros-ec: Simplify using devm_pwmchip_add() and dev_err_probe() (=
2023-09-30 22:02:44 +0200)
> >=20
> > to be added to your for-next branch.
> >=20
> > Thanks to Ben Dooks, Conor Dooley, Fabio Estevam and Ruan Jinjie for
> > their contributions.
>=20
> I see you ignored this effort and now pushed out a few patches you
> picked yourself.
>=20
> This is really frustrating, there are often long periods of silence from
> your side and then around -rc6 you shortly appear, pick some patches and
> then disappear again.
>=20
> Are you already done for this cycle? What about the patches included
> in this PR that you didn't apply and didn't give any feedback? (These are:

I'm not done yet, but I've got a bunch of other things that need my
attention, so things are moving a bit slowly. And sorry that I didn't
see this before.

Maybe next time you can mark these as "delegated" to you in patchwork,
which would give me an additional indication?

> 	pwm: cros-ec: Simplify using devm_pwmchip_add() and dev_err_probe()
> 	pwm: samsung: Consistently use the same name for driver data
> 	pwm: vt8500: Simplify using devm functions
> 	pwm: sprd: Simplify using devm_pwmchip_add() and dev_err_probe()
> 	pwm: sprd: Provide a helper to cast a chip to driver data
> 	pwm: spear: Simplify using devm functions
> 	pwm: mtk-disp: Simplify using devm_pwmchip_add()
> 	pwm: imx-tpm: Simplify using devm functions
> 	pwm: brcmstb: Simplify using devm functions
> 	pwm: bcm2835: Simplify using devm functions
> 	pwm: bcm-iproc: Simplify using devm functions
> 	pwm: dwc: add PWM bit unset in get_state call
> 	pwm: dwc: make timer clock configurable
> 	pwm: dwc: split pci out of core driver
> 	pwm: berlin: Simplify using devm functions
> 	pwm: Drop pwm_[sg]et_chip_data()
> 	pwm: cros-ec: Put per-channel data into driver data
> 	pwm: sti: Reduce number of allocations and drop usage of chip_data
> 	pwm: renesas: Drop usage of pwm_[gs]et_chip_data()
> 	pwm: lp3943: Drop usage of pwm_[gs]et_chip_data()
> 	pwm: jz4740: Put per-channel clk into driver data
> 	pwm: samsung: Put per-channel data into driver data
> 	pwm: berlin: Put per-channel config into driver data
> 	pwm: crc: Allow compilation as module and with COMPILE_TEST
> 	pwm: Manage owner assignment implicitly for drivers
> 	pwm: jz4740: Consistently name driver data "jz"
>=20
> (The patch "pwm: Adapt sysfs API documentation to reality" was already
> applied by corbet.))
>=20
> Since I created this PR a few more patches hit the list that IMHO can go
> in. (Florian's PM patches for brcmstb and bcm2835, Rob's DT include
> patch and my USE_DEFINE_SIMPLE_DEV_PM_OPS series.)
>=20
> IMHO they are all good and easy enough that "needs more time for review"
> is hardly an argument.

I'll go over the rest of patchwork over the next couple of days and pick
up what's ready to go.

Thierry

--dy3sj0rKw3k158FA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUn9OQACgkQ3SOs138+
s6FCsBAAvBog+Ts6h0DS/f5/aoSv7g5bz947LNLGfkP2fWpZh8f4oFlE962b+ate
pfkxyPKnaMdmiPQwz92+754WEy+UqyAtje7ZarN4EydAmSdIftq2p5NFJrdXD7qL
SwcMIhGD5mLzGDcpWf8KpWeXN2a2JEdK0kdBB5wrfdqWbixyNhZVvZjFU6tMi1EL
DRvTa5LcvCWlr+9HsE60wLgCU57ZuFbqYkJtvJk9FcOjeL7MIAJ9od1ZRYU92aAT
/p+z5ae8YBO84+SBTlZ0ltLHJaud1ckQGD9f3W4hyrWbOf2tkjS8nwO/LA1/N6sp
PEQoODxwLLsRPh7j5iInw3NRlaIzfEq8Bo9ZlhYsHto0R9pZQIfI6znlvYHLSbqb
EOPRML1TCTyN1SYwvU5CuDXV6gZcT3/XzPH6UxTHiBRpg1TeOnhUWILgm8yP2O95
G305vHSew7iwotwKc10srQXAabtAJg4i8uqqxv3XmUXNb5ROd49q7H+WCYv1KiAd
S00Lx1mSDjenVZXsZLnR7xmm3d+QM9PZCt0lLt+5qGrDGmYlfRbw8zKSKj/ihMeK
83ZhGaxgQVQPxAYfl2b7ccMCTy72LpCFmgQBOpftfkGpo+qpuIqiQiXvB7hmAwE3
p1I/lWlOxqgVR1M2krEYiYzgmLfcN5NRLOCc7ytC4a71SaA+ndA=
=4JO7
-----END PGP SIGNATURE-----

--dy3sj0rKw3k158FA--
