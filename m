Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591421F6D60
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jun 2020 20:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgFKSYi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 11 Jun 2020 14:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgFKSYg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 11 Jun 2020 14:24:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDFBC03E96F;
        Thu, 11 Jun 2020 11:24:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u13so5837960wml.1;
        Thu, 11 Jun 2020 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nAJQCJO3sI3ktluQ6mqJxN6WNOCFp8G6mAcSHO36wgc=;
        b=Rk+ELiNJGvDaygVwcKmN4b9KjPfXU5Q+eTVQU9Jvs2q6VzotRU1p8fhOwBmj446D4t
         miHq/qX8JATF2eGSjU6qjRV+2HTtyFx30Ls8EvKUfNWZrTu0ejYLz/kbBO+o6urAgjzA
         7HXmSOUutrnnRNIYKLmeCVALg+x0iIrctaMheb8wtp6aXE8zyPwmBQ9aCz3YOxO3Ktw4
         C9vKEV8d9kyf2PI4CgWN+t49zk3OBXk1beMsgKATKPRVBTox4VZ0/N+i2KeeQfsuybsq
         dFPULnZle339w1PBtdmaAjMk9BxkVZ+wk1eb5vEma4Lhu9lM7svc7rrqbSCb6BORVaT+
         oUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nAJQCJO3sI3ktluQ6mqJxN6WNOCFp8G6mAcSHO36wgc=;
        b=T1p01Su/t6Z/PTcW6XV6nphoy+c6+FUrBbVXyu2ohtkF9hXXU8v6trwlyttZHlxaLp
         d2LGzSx1X1aBr8z0sgG3ZRsIxjj/N5hpr0zdkeGJU5AMxfnneB3YHl2wKgXo/3Zim4p2
         2sHQ9Gq74zlFOEiaUciznNgXwTYjVYKv3zR7sQrZPRfZv39Krv1N1nSnWswvF9r+Eo9l
         jrjq4HDUDAK1igKZJIauF4TotTqyfZejBf2mI3yPnEE/wqKDm31W57QhVhKGfQaSz4FS
         pYsqtZkIUHzptHmbvoErrEv/O63BosMut9ejUqa8YgcpAc9BzNrG/bjQxUG+JjtG/a+x
         10gg==
X-Gm-Message-State: AOAM531fiGO3XdAVtavPcB6cGIockeD+f6H2jPYoqum+IV2Ty+OMky2n
        noN/X6LU9mi0QZOsT3gjtXo=
X-Google-Smtp-Source: ABdhPJw212c5x0+6odnA8m6cltLpE5W3g9HNinnEyYSJg7guhdrUMjbPbBysV+ZtF2kffAyZEiWvzw==
X-Received: by 2002:a7b:c348:: with SMTP id l8mr10039618wmj.54.1591899874021;
        Thu, 11 Jun 2020 11:24:34 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id u3sm5311663wmg.38.2020.06.11.11.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 11:24:31 -0700 (PDT)
Date:   Thu, 11 Jun 2020 20:24:30 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guru Das Srinagesh <gurus@codeaurora.org>
Cc:     linux-pwm@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v16 00/11] Convert PWM period and duty cycle to u64
Message-ID: <20200611182430.GA2293927@ulmo>
References: <cover.1591136989.git.gurus@codeaurora.org>
 <20200611165505.GA9335@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20200611165505.GA9335@codeaurora.org>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 09:55:05AM -0700, Guru Das Srinagesh wrote:
> On Tue, Jun 02, 2020 at 03:31:04PM -0700, Guru Das Srinagesh wrote:
> > Because period and duty cycle are defined in the PWM framework structs =
as ints
> > with units of nanoseconds, the maximum time duration that can be set is=
 limited
> > to ~2.147 seconds. Consequently, applications desiring to set greater t=
ime
> > periods via the PWM framework are not be able to do so - like, for inst=
ance,
> > causing an LED to blink at an interval of 5 seconds.
> >=20
> > Redefining the period and duty cycle struct members in the core PWM fra=
mework
> > structs as u64 values will enable larger time durations to be set and s=
olve
> > this problem. Such a change to the framework mandates that drivers usin=
g these
> > struct members (and corresponding helper functions) also be modified co=
rrectly
> > in order to prevent compilation errors.
> >=20
> > This patch series introduces the changes to all the drivers first, foll=
owed by
> > the framework change at the very end so that when the latter is applied=
, all
> > the drivers are in good shape and there are no compilation errors.
> >=20
> > Changes from v15:
> >   -  Rebased to tip of for-next.
> >=20
> > Changes from v14:
> >   - Collected Uwe's Acked-by for the pwm core patch.
> >   - Addressed comments in pwm-clps711x.c.
> >=20
> > Changes from v13:
> >   - Pruned cc-list and added same (reduced) set of reviewers to all pat=
ches.
> >   - Added Lee Jones' Acked-by to the pwm_bl.c patch.
> >   - Added Jani Nikula's Acked-by to intel-panel.c patch.
> >   - Added Stephen Boyd's Acked-by to pwm-clk.c patch.
> >   - Addressed Geert's review comments in clps711x.c patch.
> >=20
> > Changes from v12:
> >   - Rebased to tip of for-next
> >   - Collected Acked-by for sun4i
> >   - Reworked patch for intel-panel.c due to rebase, dropped Jani's Acke=
d-by as
> >     a result
> >=20
> > Changes from v11:
> >   - Rebased to tip of for-next.
> >   - Collected "Acked-by:" for v7 (unchanged) of pwm: sifive: [4]
> >   - Squished stm32-lp.c change with final patch in series
> >   - sun4i: Used nsecs_to_jiffies()
> >   - imx27: Added overflow handling logic
> >   - clps711x: Corrected the if condition for skipping the division
> >   - clk: pwm: Reverted to v8 version, added check to prevent division-b=
y-zero
> >=20
> > Changes from v10:
> >   - Carefully added back all the "Reviewed-by: " and "Acked-by: " tags =
received
> >     so far that had gotten missed in v9. No other changes.
> >=20
> > Changes from v9:
> >   - Gathered the received "Reviewed-by: " tag
> >   - Added back the clk-pwm.c patch because kbuild test robot complained=
 [3]
> >     and addressed received review comments.
> >   - clps711x: Addressed review comments.
> >=20
> > Changes from v8:
> >   - Gathered all received "Acked-by: " and "Reviewed-by: " tags
> >   - Dropped patch to clk-pwm.c for reasons mentiond in [2]
> >   - Expanded audience of unreviewed patches
> >=20
> > Changes from v7:
> >   - Changed commit messages of all patches to be brief and to the point.
> >   - Added explanation of change in cover letter.
> >   - Dropped change to pwm-sti.c as upon review it was unnecessary as st=
ruct
> >     pwm_capture is not being modified in the PWM core.
> >=20
> > Changes from v6:
> >   - Split out the driver changes out into separate patches, one patch p=
er file
> >     for ease of reviewing.
> >=20
> > Changes from v5:
> >   - Dropped the conversion of struct pwm_capture to u64 for reasons men=
tioned
> >     in https://www.spinics.net/lists/linux-pwm/msg11541.html
> >=20
> > Changes from v4:
> >   - Split the patch into two: one for changes to the drivers, and the a=
ctual
> >     switch to u64 for ease of reverting should the need arise.
> >   - Re-examined the patch and made the following corrections:
> >       * intel_panel.c:
> > 	DIV64_U64_ROUND_UP -> DIV_ROUND_UP_ULL (as only the numerator would be
> > 	64-bit in this case).
> >       * pwm-sti.c:
> > 	do_div -> div_u64 (do_div is optimized only for x86 architectures, and
> > 	div_u64's comment block suggests to use this as much as possible).
> >=20
> > Changes from v3:
> >   - Rebased to current tip of for-next.
> >=20
> > Changes from v2:
> >   - Fixed %u -> %llu in a dev_dbg in pwm-stm32-lp.c, thanks to kbuild t=
est robot
> >   - Added a couple of fixes to pwm-imx-tpm.c and pwm-sifive.c
> >=20
> > Changes from v1:
> >   - Fixed compilation errors seen when compiling for different archs.
> >=20
> > v1:
> >   - Reworked the change pushed upstream earlier [1] so as to not add an
> >     extension to an obsolete API. With this change, pwm_ops->apply() ca=
n be
> >     used to set pwm_state parameters as usual.
> >=20
> > [1] https://lore.kernel.org/lkml/20190916140048.GB7488@ulmo/
> > [2] https://lore.kernel.org/lkml/20200312190859.GA19605@xxxxxxxxxxxxxx/
> > [3] https://www.spinics.net/lists/linux-pwm/msg11906.html
> > [4] https://www.spinics.net/lists/linux-pwm/msg11986.html
> >=20
> > Guru Das Srinagesh (11):
> >   drm/i915: Use 64-bit division macro
> >   hwmon: pwm-fan: Use 64-bit division macro
> >   ir-rx51: Use 64-bit division macro
> >   pwm: clps711x: Use 64-bit division macro
> >   pwm: pwm-imx-tpm: Use 64-bit division macro
> >   pwm: imx27: Use 64-bit division macro and function
> >   pwm: sifive: Use 64-bit division macro
> >   pwm: sun4i: Use nsecs_to_jiffies to avoid a division
> >   backlight: pwm_bl: Use 64-bit division function
> >   clk: pwm: Use 64-bit division function
> >   pwm: core: Convert period and duty cycle to u64
> >=20
> >  drivers/clk/clk-pwm.c                      |  7 ++++-
> >  drivers/gpu/drm/i915/display/intel_panel.c |  2 +-
> >  drivers/hwmon/pwm-fan.c                    |  2 +-
> >  drivers/media/rc/ir-rx51.c                 |  3 +-
> >  drivers/pwm/core.c                         | 14 ++++-----
> >  drivers/pwm/pwm-clps711x.c                 |  2 +-
> >  drivers/pwm/pwm-imx-tpm.c                  |  2 +-
> >  drivers/pwm/pwm-imx27.c                    | 48 ++++++++++++++++++++++=
++++----
> >  drivers/pwm/pwm-sifive.c                   |  2 +-
> >  drivers/pwm/pwm-stm32-lp.c                 |  2 +-
> >  drivers/pwm/pwm-sun4i.c                    |  2 +-
> >  drivers/pwm/sysfs.c                        |  8 ++---
> >  drivers/video/backlight/pwm_bl.c           |  3 +-
> >  include/linux/pwm.h                        | 12 ++++----
> >  14 files changed, 77 insertions(+), 32 deletions(-)
> >=20
> > --=20
>=20
> Hello Thierry, Uwe, Lee,
>=20
> Gentle reminder for this patch series :) Earlier discussions on next
> steps were as per [1] and [2].

Hi Guru,

I ended up deciding against queueing this for v5.8-rc1 because I want
this to soak for a bit in linux-next. I'll apply them early next week
after v5.8-rc1 is out.

Thierry

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7idt4ACgkQ3SOs138+
s6GNsg//VAMZ3a0gqYkSM99mCdQx0o0+Y1Y14Vf/zK/D/VQKmfyVOZro8AFvqp4n
I0wFixIFWxhc1RROOdsCLrwBPWCYgArtYHsXnKwasYbkCJtQBtOSlX0UA5vBAvoT
1aDCy2dKwRT4NHVj1qa1FdTp1YwX+89l/dpu5dE+BluYN6LDR/8doMYVQ6r9YT0+
k7bNRotaoM2/TXn8y5CLXunnpHytD9SB3oRMSVLjESYUvgy9jWcfj9yiIknoTPb7
jslp9FLKhBbEMx2FLW4drGpoWml+RRt8fqIEeucqoDf3e/ZtwrPfhzG3TeDU75+U
ATfpQn033j5RMK4RYbeUPMN29hDiKBr1uVA2rq3xYDblgbbFegCYhtgeoFf3iLl+
bUvp0ZBHf9tVsO9O378xNBnYn3P+BqEqwek0/1HHHs1iGxe0rvRcf+QN91sGOyKd
hdVWm/MYs7wRDqRQgxV3xNammYCapCCizApSYfnNb3Om3QY30Y+WI5rmExcIUPzP
1rgdBJmpzdfuxgWoaBO5lKlHyTzFOM6Md3AO1E20pfUp6DsJ+l8LDdYgVT4Z88Fg
H+7GkvC9OtLtdKls3fAzjE9HGafCtxT8fvnFScA01FDsHUf0CaitNAodnNgJMtNy
vQ3Yer+0/+jwUI3Wy9h1qRj6rJ2ADF71w1CtSvjN1VG5Kvagddk=
=xxlE
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
