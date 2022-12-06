Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D378C6449EA
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Dec 2022 18:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiLFRG2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Dec 2022 12:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbiLFRGK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Dec 2022 12:06:10 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4B71134
        for <linux-pwm@vger.kernel.org>; Tue,  6 Dec 2022 09:06:08 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q7so24418568wrr.8
        for <linux-pwm@vger.kernel.org>; Tue, 06 Dec 2022 09:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6M7e/S92ILa/eR6YDG0IPwQRk6DwRDkQxOGoYIQCY4=;
        b=Hrl+MzsshnLgGnyl2nZ/IQj4ymOv6W0AiJYOU36CgUb/SsuVwU7tvtTptgvb4dPyDQ
         WqkkrFx/eg+GnD1pqr/aIgG63/ZDq2RuZHMvVJrvX0uFBvIzTBu2BZOgTRpU+uWPVkRu
         Zgji9lOmeEu1xEKYVLIAEIQrvwuRSTJSacq3rMsoVJfcNC6f95G4/rtriBKsWIR2N3Kz
         1zDXX+ve5WKJdG9Z+fL7ygIMm7cHPilW94YPk2Qrc7aiMKO3AtzhNjr8i8+ZfFw2yDet
         qJXbSZ7tynw4XibBG+lR1FxSU0uokUlp0ZvzhfRT/yOzl+RjNaLbGkkezUrUg/dxmyOq
         nm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6M7e/S92ILa/eR6YDG0IPwQRk6DwRDkQxOGoYIQCY4=;
        b=WPkXzfWTR9Gu7Wq/hXjJDEn0t14Qx1gzYAJKyhz5i7CkSqGsOB/wo8vcfXhtBVUrHC
         Wf4n/CHVN8arxqEt82dThyElQbePEQGkFWDehgf56ENktM+EiA82PanEMGFRZ5Nivco7
         S4vZNoRShK9Hn8T9N1hvKxR23eF8BrTsJ2+sroWFIZyQ17pclK03xyT4lC8vwOg8xrrj
         lgydrke66ZHoFwtv00B0exS6RPL0RMoQm68XpjEvKAYziZgMDt/lMl4Gwv3SOzSmsFZ1
         Y+liup8dhLq+8VmfE55UK1P+u4xJDkrpF1lfy0xutNEhUxwpL7EX5hrneDt6rakiPKLa
         sOWQ==
X-Gm-Message-State: ANoB5pmR0iE6X8ufS9SimriG4gwJ6ksf5Vwsh/suRb69V59rw3N2bFsB
        qRpUOaKlp5DcJyY77S99GtmVnGbnMuk=
X-Google-Smtp-Source: AA0mqf6RsL+pGgOPBohfxZpz+s66bIgebVMVS2gDVqw4JdBeCJo/B/gsjShKiH9/JCj6ddmR/smzEw==
X-Received: by 2002:a5d:440b:0:b0:241:f901:a7e3 with SMTP id z11-20020a5d440b000000b00241f901a7e3mr36641993wrq.511.1670346367372;
        Tue, 06 Dec 2022 09:06:07 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n186-20020a1ca4c3000000b003d1cf67460esm6803938wme.40.2022.12.06.09.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:06:06 -0800 (PST)
Date:   Tue, 6 Dec 2022 18:06:05 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PULL] pwm changes for 6.2 for Thierry
Message-ID: <Y492fQi3oSgr39O7@orome>
References: <20221202183504.rhz5meomd4a4t7am@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wVPgfoWgF052pWLL"
Content-Disposition: inline
In-Reply-To: <20221202183504.rhz5meomd4a4t7am@pengutronix.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wVPgfoWgF052pWLL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2022 at 07:35:04PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> there are quite some patches still marked as "new" in our patchwork and
> a bit part of them is ready in my eyes on top of your for-next branch.
> Given that Linus Torvalds indicated to want the pull requests for 6.2
> ready early[1] I thought I collect the patches I consider good for
> application.
>=20
> Feel free to do whatever you want with this pull request. If you find
> the time to pick up patches yourself that's just fine for me. And in
> case Linus doesn't to a -rc8 but cuts 6.1 this weekend, we have at least
> a tree with non-faked timestamps older than the v6.1 tag. :-)
>=20
> One thing I considered was pulling in Andy's PR[2], just to have it.
> But I didn't as you signalled it to be not necessary. (And it merges
> just fine into the changes from this PR.)
>=20
> Best regards and a nice week-end
> Uwe
>=20
> [1] https://lore.kernel.org/lkml/CAHk-=3DwgUZwX8Sbb8Zvm7FxWVfX6CGuE7x+E16=
VKoqL7Ok9vv7g@mail.gmail.com/
> [2] https://lore.kernel.org/linux-pwm/Y30YOvHpqvte9otX@black.fi.intel.com
>=20
> The following changes since commit 50315945d178eebec4e8e2c50c265767ddb926=
eb:
>=20
>   dt-bindings: pwm: renesas,tpu: Add r8a779g0 support (2022-11-23 12:22:3=
5 +0100)
>=20
> are available in the Git repository at:
>=20
>   https://git.pengutronix.de/git/ukl/linux pwm-6.2
>=20
> for you to fetch changes up to 145e5425eb85fc833d4b5d983cffa9ef1acd6c16:
>=20
>   pwm: pca9685: Convert to i2c's .probe_new() (2022-12-02 19:16:30 +0100)
>=20
> ----------------------------------------------------------------
> Andre Przywara (1):
>       pwm: sun4i: Propagate errors in .get_state() to the caller
>=20
> Andy Shevchenko (1):
>       pwm: core: Remove S_IFREG from debugfs_create_file()
>=20
> Daniel Golle (2):
>       pwm: mediatek: always use bus clock for PWM on MT7622
>       pwm: mediatek: Add support for MT7986
>=20
> Doug Brown (6):
>       pwm: pxa: Remove pxa_pwm_enable/disable
>       pwm: pxa: Set duty cycle to 0 when disabling PWM
>       pwm: pxa: Remove clk enable/disable from pxa_pwm_config
>       pwm: pxa: Use abrupt shutdown mode
>       pwm: pxa: Add reference manual link and limitations
>       pwm: pxa: Enable for MMP platform
>=20
> Fabrice Gasnier (1):
>       pwm: stm32-lp: fix the check on arr and cmp registers update
>=20
> Uwe Kleine-K=C3=B6nig (23):
>       pwm: sifive: Call pwm_sifive_update_clock() while mutex is held
>       pwm: lpc18xx-sct: Fix a comment to match code
>       pwm: Document variables protected by pwm_lock
>       pwm: Reduce time the pwm_lock mutex is held in pwmchip_add()
>       pwm: Mark free pwm IDs as used in alloc_pwms()
>       pwm: Don't initialize list head before calling list_add()
>       pwm: fsl-ftm: Use regmap_clear_bits and regmap_set_bits where appli=
cable
>       pwm: img: Use regmap_clear_bits and regmap_set_bits where applicable
>       pwm: iqs620a: Use regmap_clear_bits and regmap_set_bits where appli=
cable
>       pwm: stm32-lp: Use regmap_clear_bits and regmap_set_bits where appl=
icable
>       pwm: stm32: Use regmap_clear_bits and regmap_set_bits where applica=
ble
>       pwm: Make .get_state() callback return an error code
>       pwm/tracing: Also record trace events for failed API calls
>       drm/bridge: ti-sn65dsi86: Propagate errors in .get_state() to the c=
aller
>       leds: qcom-lpg: Propagate errors in .get_state() to the caller
>       pwm: crc: Propagate errors in .get_state() to the caller
>       pwm: cros-ec: Propagate errors in .get_state() to the caller
>       pwm: imx27: Propagate errors in .get_state() to the caller
>       pwm: mtk-disp: Propagate errors in .get_state() to the caller
>       pwm: rockchip: Propagate errors in .get_state() to the caller
>       pwm: sprd: Propagate errors in .get_state() to the caller
>       pwm: Handle .get_state() failures
>       pwm: pca9685: Convert to i2c's .probe_new()
>=20
> xinlei lee (1):
>       pwm: mtk-disp: Fix the parameters calculated by the enabled flag of=
 disp_pwm
>=20
>  drivers/gpio/gpio-mvebu.c             |  9 ++++++---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 14 ++++++++------
>  drivers/leds/rgb/leds-qcom-lpg.c      | 14 ++++++++------
>  drivers/pwm/Kconfig                   |  2 +-
>  drivers/pwm/core.c                    | 68 +++++++++++++++++++++++++++++=
+++++++++------------------------------
>  drivers/pwm/pwm-atmel.c               |  6 ++++--
>  drivers/pwm/pwm-bcm-iproc.c           |  8 +++++---
>  drivers/pwm/pwm-crc.c                 | 10 ++++++----
>  drivers/pwm/pwm-cros-ec.c             |  8 +++++---
>  drivers/pwm/pwm-dwc.c                 |  6 ++++--
>  drivers/pwm/pwm-fsl-ftm.c             | 18 +++++++-----------
>  drivers/pwm/pwm-hibvt.c               |  6 ++++--
>  drivers/pwm/pwm-img.c                 | 15 +++++++--------
>  drivers/pwm/pwm-imx-tpm.c             |  8 +++++---
>  drivers/pwm/pwm-imx27.c               |  8 +++++---
>  drivers/pwm/pwm-intel-lgm.c           |  6 ++++--
>  drivers/pwm/pwm-iqs620a.c             | 10 ++++++----
>  drivers/pwm/pwm-keembay.c             |  6 ++++--
>  drivers/pwm/pwm-lpc18xx-sct.c         |  2 +-
>  drivers/pwm/pwm-lpss.c                |  6 ++++--
>  drivers/pwm/pwm-mediatek.c            |  9 ++++++++-
>  drivers/pwm/pwm-meson.c               |  8 +++++---
>  drivers/pwm/pwm-mtk-disp.c            | 17 ++++++++++-------
>  drivers/pwm/pwm-pca9685.c             | 13 +++++++------
>  drivers/pwm/pwm-pxa.c                 | 58 +++++++++++++++++++++++++----=
-----------------------------
>  drivers/pwm/pwm-raspberrypi-poe.c     |  8 +++++---
>  drivers/pwm/pwm-rockchip.c            | 12 +++++++-----
>  drivers/pwm/pwm-sifive.c              | 11 ++++++++---
>  drivers/pwm/pwm-sl28cpld.c            |  8 +++++---
>  drivers/pwm/pwm-sprd.c                |  8 +++++---
>  drivers/pwm/pwm-stm32-lp.c            | 15 ++++++++-------
>  drivers/pwm/pwm-stm32.c               | 34 ++++++++++++++++-------------=
-----
>  drivers/pwm/pwm-sun4i.c               | 14 +++++++++-----
>  drivers/pwm/pwm-sunplus.c             |  6 ++++--
>  drivers/pwm/pwm-visconti.c            |  6 ++++--
>  drivers/pwm/pwm-xilinx.c              |  8 +++++---
>  include/linux/pwm.h                   |  4 ++--
>  include/trace/events/pwm.h            | 20 ++++++++++----------
>  38 files changed, 275 insertions(+), 214 deletions(-)

I had gotten partially through this set and b4 wasn't happy letting me
pull this directly since the commit in the pull request didn't match the
commit in the remote, so I ended up grabbing the patches based on this
list and that seems to have worked. Build tests all check out (modulo
some egrep vs. grep -E warnings on MIPS) so I've pushed these out.

The branch also contains a few more that I had already applied before
taking the above patches.

Thanks,
Thierry

--wVPgfoWgF052pWLL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmOPdn0ACgkQ3SOs138+
s6G4kg/+Oy7/63EpcLr7jTkNw1yTVV1dqPe/GDXTsGCKRbnD9BZ4VXRamck9fqCR
1+koE8swym42BG/Sx5ON6778G37vTZ5DzDdNXwx/MalmIyx+8L11xdvW5CxotDFk
wEAz9cW7wL3O8K86mo4g0NZQ6Pf7UFx8qOxFf5wCadgVK1ftO71za2uA37RxCVp2
WPiEJKLk9mEpfN0n3NNDc/3/rnJZliPfbmAlsT4vrAqkoYipcE7LuN8kfbGOF6M/
Rc0y6U4Lx1/nFc2D9OPiZuWTLCKusl5qBNkFwLl/54P+NRtb7Nobv9twInAjQmg7
I29FxhKUvi5nXJTJ+kJxvvGhNWHeLqw7J8hMAoSJfF5RXSnM8M7MWgpfELGN8gof
Q0Tga5FJTMchO84yqqxN4hzLDGmzB/OIQmtNvR+teIYRaF1WL+RM7fjeCnMg0XLb
ZbarIgDt+bREwp1zIZ1VXstx8XcTNEmRKjYVUyVVvXhttLDlWzMznGiWeB1xg35P
S99XBYmarY0VLkGWYCBMleSuY01WO/BSQ7RDtCJtUmGBO1kBgQ0gLwCFZxfwPOfp
AhHSHwrqtzsXd2UmTIVHyfJBK+27Azc4CO7h2WFlagn9RyBuwdfonw4ggpKqzlf1
VHI9wVt4tnQ1R7EDyCVM7HgHuIQrYIPW0ku+D6IV+K2vujfzJ8w=
=IJEV
-----END PGP SIGNATURE-----

--wVPgfoWgF052pWLL--
