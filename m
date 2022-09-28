Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392D15EDE21
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Sep 2022 15:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiI1Nur (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Sep 2022 09:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiI1Num (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Sep 2022 09:50:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF6C30549;
        Wed, 28 Sep 2022 06:50:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l14so27269059eja.7;
        Wed, 28 Sep 2022 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=GXvCKqJ66V+LOd8p3aFdV+eHd75M+diYRnJfiYMAw2E=;
        b=fRbRUCyexvIMRfFFJYq4fLLe5Z+8f3Ca/XNmax47HJq5JOTOt1gi01eWiklH3pnIfr
         EDQdAPddLBQm5khYQYACfXWzgm236snx8wIFrQn+lUkZcXssWLEClYevfA2WSa+wC9Z7
         vi7dfw3FL064wjjm2bxFe9LQ13L6rFnGul8oT9vgDrTYQUnC3NhF+hXfe/SJbhG9fs8F
         z6/qw1ZvCdMvy5jEjhgUZ/vIe/Ay+CfnaDU4RmjbRFkx6+2WcrB+5k7ZRjuQu9BnplAp
         YDFmfutylkYZXU/psXXy1t3kZwvCWedgv/wsr+QH1R42N//PzswUCf2MA8swAq/SztTE
         O1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GXvCKqJ66V+LOd8p3aFdV+eHd75M+diYRnJfiYMAw2E=;
        b=Un9DBMGZHw+PEUq+4tQvxelNTAllYeYLFBjjh9AgLTfFptILUrLGF5VHM28O2DwtoI
         MVMY71OnEnk2AeZ7aZPcYvrppDi0AyVW7a8ev0XrAST6IPr5nii+rA/cyBkEzOmiDyyT
         Vgz8gXUJusX0mYjMdFzT2VL8Y1qhU5DFgGEAsFy+48kxvzeVYux/8ioVkbMjMpSAIk/u
         ZUN/fPX6cmP2ghi12X0k9plQOavZDZSClGnG4pRvG73b6G4KNCmZtGfClsg5PVm8h5yG
         j9d8KgvZB3JkIbxkTD6EyRDEdbEQE5yVQDYCOvM1i4NFMCfQr+qHhy8WNQSP8XvMvLEw
         EXKw==
X-Gm-Message-State: ACrzQf1hpDMwgN0HkboWRcoUuuYe53mjQt8dgG68/ryjMAfmzYdd0ls5
        dI+R2VDX+dsOlSgEMWZWHrg=
X-Google-Smtp-Source: AMsMyM79kDlYy6VI8EGstC/YYdvl1zukJnlafqjmOZuvs0505WgxbBQM0yHO22wQpInI6eHjVen7ug==
X-Received: by 2002:a17:907:6088:b0:782:e1a:42d6 with SMTP id ht8-20020a170907608800b007820e1a42d6mr27863706ejc.586.1664373032656;
        Wed, 28 Sep 2022 06:50:32 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f7-20020a17090631c700b007803083a36asm2390762ejf.115.2022.09.28.06.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 06:50:30 -0700 (PDT)
Date:   Wed, 28 Sep 2022 15:50:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
Message-ID: <YzRRJD/VTbgesoEI@orome>
References: <20220921145741.901784-1-biju.das.jz@bp.renesas.com>
 <20220921145741.901784-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JixGLmsvkKpAjhZK"
Content-Disposition: inline
In-Reply-To: <20220921145741.901784-3-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--JixGLmsvkKpAjhZK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2022 at 03:57:41PM +0100, Biju Das wrote:
> RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer
> (GPT32E). It supports the following functions
>  * 32 bits =C3=97 8 channels
>  * Up-counting or down-counting (saw waves) or up/down-counting
>    (triangle waves) for each counter.
>  * Clock sources independently selectable for each channel
>  * Two I/O pins per channel
>  * Two output compare/input capture registers per channel
>  * For the two output compare/input capture registers of each channel,
>    four registers are provided as buffer registers and are capable of
>    operating as comparison registers when buffering is not in use.
>  * In output compare operation, buffer switching can be at crests or
>    troughs, enabling the generation of laterally asymmetric PWM waveforms.
>  * Registers for setting up frame cycles in each channel (with capability
>    for generating interrupts at overflow or underflow)
>  * Generation of dead times in PWM operation
>  * Synchronous starting, stopping and clearing counters for arbitrary
>    channels
>  * Starting, stopping, clearing and up/down counters in response to input
>    level comparison
>  * Starting, clearing, stopping and up/down counters in response to a
>    maximum of four external triggers
>  * Output pin disable function by dead time error and detected
>    short-circuits between output pins
>  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
>  * Enables the noise filter for input capture and external trigger
>    operation
>=20
> This patch adds basic pwm support for RZ/G2L GPT driver by creating
> separate logical channels for each IOs.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v6->v7:
>  * Added the comment for cacheing rzg2l_gpt->state_period.
>  * Fixed boundary values for pv and dc.
>  * Added comment for modifying mode, prescaler, timer counter and buffer =
enable
>    registers.
>  * Fixed buffer overflow in get_state()
>  * Removed unnecessary assignment of state->period value in get_state().
>  * Fixed state->duty_cycle value in get_state().
>  * Added a limitation for disabling the channels, when both channels used.
> v5->v6:
>  * Updated macros RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH and
>    RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH with computation
>    involving FIELD_PREP macro.
>  * Removed struct rzg2l_gpt_phase and started using RZG2L_GTCCR macro
>    for duty_offset.
>  * replaced misnomer real_period->state_period.
>  * Added handling for values >=3D (1024 << 32) for both period
>    and duty cycle.
>  * Added comments for pwm {en,dis}abled by bootloader during probe.
> v4->v5:
>  * Added Hardware manual details
>  * Replaced the comment GTCNT->Counter
>  * Removed the macros RZG2L_GPT_IO_PER_CHANNEL and chip.npwm directly
>    used in probe.
>  * Removed the unsed macro RZG2L_GTPR_MAX_VALUE
>  * Added driver prefix for the type name and the variable.
>  * Initialization of per_channel data moved from request->probe.
>  * Updated clr parameter for rzg2l_gpt_modify for Start count.
>  * Started using mutex and usage_count for handling shared
>    period and prescalar for the 2 channels.
>  * Updated the comment cycle->period.
>  * Removed clk_disable from rzg2l_gpt_reset_assert_pm_disable()
>  * Replaced pc->rzg2l_gpt.
>  * Updated prescale calculation.
>  * Moved pm_runtime_{get_sync,put} from {request,free}->{enable,disable}
>  * Removed platform_set_drvdata as it is unused
>  * Removed the variable pwm_enabled_by_bootloader=20
>  * Added dev_err_probe in various error paths in probe.
>  * Added an error message, if devm_pwmchip_add() fails.
> v3->v4:
>  * Changed the local variable type i from u16->u8 and prescaled_period_
>    cycles from u64->u32 in calculate_prescale().
>  * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div()
>  * Dropped the comma after the sentinel.
>  * Add a variable to track pwm enabled by bootloader and added comments
>    in probe().
>  * Removed unnecessary rzg2l_gpt_reset_assert_pm_disable() from probe.
>  * Replaced devm_clk_get()->devm_clk_get_prepared()
>  * Removed devm_clk_get_optional_enabled()
> v2->v3:
>  * Updated limitation section
>  * Added prefix "RZG2L_" for all macros
>  * Modified prescale calculation
>  * Removed pwm_set_chip_data
>  * Updated comment related to modifying Mode and Prescaler
>  * Updated setting of prescale value in rzg2l_gpt_config()
>  * Removed else branch from rzg2l_gpt_get_state()
>  * removed the err label from rzg2l_gpt_apply()
>  * Added devm_clk_get_optional_enabled() to retain clk on status,
>    in case bootloader turns on the clk of pwm.
>  * Replaced devm_reset_control_get_exclusive->devm_reset_control_get_shar=
ed
>    as single reset shared between 8 channels.
> v1->v2:
>  * Added Limitations section
>  * dropped "_MASK" from the define names.
>  * used named initializer for struct phase
>  * Added gpt_pwm_device into a flexible array member in rzg2l_gpt_chip
>  * Revised the logic for prescale
>  * Added .get_state callback
>  * Improved error handling in rzg2l_gpt_apply
>  * Removed .remove callback
>  * Tested driver with PWM_DEBUG enabled
> RFC->V1:
>  * Updated macros
>  * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
>  * Added rzg2l_gpt_read()
> ---
>  drivers/pwm/Kconfig         |  11 +
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-rzg2l-gpt.c | 423 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 435 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 60d13a949bc5..2723a3e9ff65 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -481,6 +481,17 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
> =20
> +config PWM_RZG2L_GPT
> +	tristate "Renesas RZ/G2L General PWM Timer support"
> +	depends on ARCH_RENESAS || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver exposes the General PWM Timer controller found in Renesas
> +	  RZ/G2L like chips through the PWM API.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-rzg2l-gpt.
> +
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 7bf1a29f02b8..cac39b18d1ee 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-=
poe.o
>  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> new file mode 100644
> index 000000000000..c4e011f2a843
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
[...]
> +static void rzg2l_gpt_write(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, u=
32 data)
> +{
> +	iowrite32(data, rzg2l_gpt->mmio + reg);
> +}
> +
> +static u32 rzg2l_gpt_read(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg)
> +{
> +	return ioread32(rzg2l_gpt->mmio + reg);
> +}

Do you really need to support PCI I/O space in this driver? If not, make
this writel() and readl() instead.

[...]
> +static int rzg2l_gpt_probe(struct platform_device *pdev)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt;
> +	int ret;
> +
> +	rzg2l_gpt =3D devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt), GFP_KERNEL);
> +	if (!rzg2l_gpt)
> +		return -ENOMEM;
> +
> +	rzg2l_gpt->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rzg2l_gpt->mmio))
> +		return PTR_ERR(rzg2l_gpt->mmio);
> +
> +	rzg2l_gpt->rstc =3D devm_reset_control_get_shared(&pdev->dev, NULL);
> +	if (IS_ERR(rzg2l_gpt->rstc))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> +				     "get reset failed\n");
> +
> +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "cannot deassert reset control\n");
> +
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       rzg2l_gpt_reset_assert_pm_disable,
> +				       rzg2l_gpt);
> +	if (ret < 0)
> +		return ret;
> +
> +	rzg2l_gpt->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(rzg2l_gpt->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> +				     "cannot get clock\n");
> +
> +	rzg2l_gpt->rate =3D clk_get_rate(rzg2l_gpt->clk);
> +	/*
> +	 *  We need to keep the clock on, in case the bootloader has enabled the
> +	 *  PWM and is running during probe(). A variable pwm_enabled_by_
> +	 *  bootloader is set to true in that case and during first
> +	 *  pwm_disable(), it is set to false and release the clock resource.
> +	 *
> +	 *  In case the pwm is not enabled by the bootloader, devm_clk_put
> +	 *  disables the clk and holding a reference on the clk isn't needed
> +	 *  because runtime-pm handles the needed enabling.
> +	 */

Where does this happen? I'm not aware of any code that would
automatically enable clocks for runtime PM. Typically you would need to
implement driver-specific callbacks for that to happen.

> +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> +		rzg2l_gpt->pwm_enabled_by_bootloader =3D true;
> +	else
> +		devm_clk_put(&pdev->dev, rzg2l_gpt->clk);

So in either case I would expect you to want to hold on to the clock
pointer here and use that in the runtime PM callbacks.

This whole business of keeping a separate variable to track this also
seems a bit fishy to me because it only partially reflects in the
software state what's really going on. So I think what you really want
here is to call pm_runtime_set_active() before pm_runtime_enable() to
make sure that your device is marked as such.

I wonder if that alone wouldn't already solve this problem. IIRC, the
runtime PM infrastructure will consider a device to be runtime suspended
after ->probe() by default. And if the clock is indeed managed by
runtime PM somehow, then that might just cause it to get disabled.
Again, it'd be great to know how exactly runtime PM knows how to manage
the clock if you don't tell it here. Is the clock perhaps shared between
multiple IPs? Perhaps a parent device that managed it in runtime PM?

> +
> +	mutex_init(&rzg2l_gpt->lock);
> +
> +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> +	rzg2l_gpt->chip.npwm =3D 2;

The changelog above mentions that you use a shared reset because the
reset is shared between 8 channels, but here you only expose 2. What's
going on there?

Thierry

--JixGLmsvkKpAjhZK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0USIACgkQ3SOs138+
s6F4ZhAAoHnPMVGMMmSiH9E+DH7v01K75BXklCjYjaAOPai1xWgtZYaWGq9dv2PJ
sKOL4veJdcEB4zgWwSfZQyRG7sZnwgLk6+skZMIl+tG69fNPyaoMEMujioz4W00e
iShKRPUX2CaMIvbg7TPqn42oU+3Lku2S5ETtS6s9O1LOEC+jclVtIRl+sF4RnZ6g
JzNhvYpyJpTISNHazAAzkVInPBSM+LnetNQoScuL+IYwovtobWUOphDviVq/Km4D
zQ/CCg7gyhyjKpOHI3qQRZKd7ttUsK3Jx5N2bl5jZn32Q/L36qiChtf0/ODKbbDh
opDkMhdWaIN7Cf5iFv4DxB9UamgjRRpdY7M/gPGTVDWOFPuR/tAw2Ll1nMl3y3pd
LxI28jqllZR0YInzLKF87nTcC5JTZ8fQafuxSkFAnMdzTIk4ZLwBi0DKhVV+Abh8
PPkpp4fpTtnDAnccTFo3syKNkUM0CaD7Z/9auuqqk+b3HZZfzTdV96NJNikZpYvV
CBCJKhpxwOI+pJioSfKnaH1WgFCvnuw/D70R7DMEC6Gf9M/1T2YQLB5Z29WDD8Zy
m4kKT1zqL0m/TGV58DjXfAkAHkP3Zvg7ZWazQBYuCbsqPnBoO5klWaTgSJEYDcYO
WjiWIZSQwUR0D79pR9CrGtCPy0fhxUa53PEz5v0bPQeSbDRyQ60=
=gtHS
-----END PGP SIGNATURE-----

--JixGLmsvkKpAjhZK--
