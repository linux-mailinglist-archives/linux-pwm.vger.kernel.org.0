Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A875EF2A7
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Sep 2022 11:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiI2JuE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Sep 2022 05:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiI2Jtl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Sep 2022 05:49:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD8A399DA;
        Thu, 29 Sep 2022 02:48:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x92so1197517ede.9;
        Thu, 29 Sep 2022 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=KeZrQs/Iy31iWg7zGQHJJGX25Wr/15LyXqPJOL3nKO0=;
        b=k1VgeC2T1nzN8oIlnHo/rnqY0EZvbp6SyQ94maN1tQRrNm3duJrCtChEVFVfn4Sx/b
         9tHvIffILugdtG0Mk6OmrCouZV1T0EryLtrZMxQ1KLHGBJw+RIlJqvJQKJkUk0FbNhyf
         zKut8Z3+5+CeXMJn6cKqjAH5qrx8aCvlJGf6EWADRB58mrQpXnROyOSJQdSuqrTN+6+J
         XGPjtY4BkLaO3LfQjeStNF6TxVD6I+yeWH2SasSJkEZRVn72HC9h+bKgLw60YQyzG+p/
         2B0jhzhAdP0T4uCfntT1UDQn/CxrJYiOJzWXak/bURyY5thpr54hDIPoJdQdwd57To9y
         j0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KeZrQs/Iy31iWg7zGQHJJGX25Wr/15LyXqPJOL3nKO0=;
        b=y1K1MGb+TNDb/jdbUYQUjwanRt+IBwVBYEEOHZKpEam0sILKMskNujJ8VY9fFO0LhC
         gacUXPQb1JVsjoFR4HVJHYbl7MNfs0B4+Q1KbWg6b5qEagJaCYuboW8bMFAjR5is+qx+
         eViVTNYDxu34RZ9+QfnDzae9yozQtAKix4UTyPHp/PilhE7pfRd1FQq4ScIPbYV9Ozd6
         adEesXahTzjKzkIW+KnGwJzbaNXsBoWlKQqkFX9Hhu4cgjCWhibN8yBsltkI1lob4YUH
         jpc62mB6jwqIf4NiC6LB/cP3fW8dNAhEcp5IZM3eQxl1zSB8PCj2OA0ZGgeu9+5xGmPZ
         Nq+g==
X-Gm-Message-State: ACrzQf2S7Qrq2HQ4aCboAIs/fpAKM0NM4hsuYngXJEh/jL9ugMPL775+
        x1U2uErad3/0A6cF8orf2+8=
X-Google-Smtp-Source: AMsMyM6kDMli0r71UsmC0zlzDABuXmoKJuaip53MoJDsCrRf3MDNjHUcCiE65uVbPf8qblZqMy9Tlg==
X-Received: by 2002:aa7:c9cf:0:b0:452:e416:644d with SMTP id i15-20020aa7c9cf000000b00452e416644dmr2373583edt.163.1664444889842;
        Thu, 29 Sep 2022 02:48:09 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709063d2a00b0076f0ab9591esm3611273ejf.125.2022.09.29.02.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 02:48:08 -0700 (PDT)
Date:   Thu, 29 Sep 2022 11:48:06 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
Message-ID: <YzVp1t7fMRBv9ISK@orome>
References: <20220921145741.901784-1-biju.das.jz@bp.renesas.com>
 <20220921145741.901784-3-biju.das.jz@bp.renesas.com>
 <YzRRJD/VTbgesoEI@orome>
 <OS0PR01MB5922D60C59A5BACC580030A986549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WeGM5742Gwhpfqob"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922D60C59A5BACC580030A986549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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


--WeGM5742Gwhpfqob
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 05:34:49PM +0000, Biju Das wrote:
> Hi Thierry Reding,
>=20
> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH v7 2/2] pwm: Add support for RZ/G2L GPT
> >=20
> > On Wed, Sep 21, 2022 at 03:57:41PM +0100, Biju Das wrote:
> > > RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit
> > > timer (GPT32E). It supports the following functions
> > >  * 32 bits =C3=97 8 channels
> > >  * Up-counting or down-counting (saw waves) or up/down-counting
> > >    (triangle waves) for each counter.
> > >  * Clock sources independently selectable for each channel
> > >  * Two I/O pins per channel
> > >  * Two output compare/input capture registers per channel
> > >  * For the two output compare/input capture registers of each
> > channel,
> > >    four registers are provided as buffer registers and are capable
> > of
> > >    operating as comparison registers when buffering is not in use.
> > >  * In output compare operation, buffer switching can be at crests or
> > >    troughs, enabling the generation of laterally asymmetric PWM
> > waveforms.
> > >  * Registers for setting up frame cycles in each channel (with
> > capability
> > >    for generating interrupts at overflow or underflow)
> > >  * Generation of dead times in PWM operation
> > >  * Synchronous starting, stopping and clearing counters for
> > arbitrary
> > >    channels
> > >  * Starting, stopping, clearing and up/down counters in response to
> > input
> > >    level comparison
> > >  * Starting, clearing, stopping and up/down counters in response to
> > a
> > >    maximum of four external triggers
> > >  * Output pin disable function by dead time error and detected
> > >    short-circuits between output pins
> > >  * A/D converter start triggers can be generated (GPT32E0 to
> > GPT32E3)
> > >  * Enables the noise filter for input capture and external trigger
> > >    operation
> > >
> > > This patch adds basic pwm support for RZ/G2L GPT driver by creating
> > > separate logical channels for each IOs.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > v6->v7:
> > >  * Added the comment for cacheing rzg2l_gpt->state_period.
> > >  * Fixed boundary values for pv and dc.
> > >  * Added comment for modifying mode, prescaler, timer counter and
> > buffer enable
> > >    registers.
> > >  * Fixed buffer overflow in get_state()
> > >  * Removed unnecessary assignment of state->period value in
> > get_state().
> > >  * Fixed state->duty_cycle value in get_state().
> > >  * Added a limitation for disabling the channels, when both channels
> > used.
> > > v5->v6:
> > >  * Updated macros RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH and
> > >    RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH with computation
> > >    involving FIELD_PREP macro.
> > >  * Removed struct rzg2l_gpt_phase and started using RZG2L_GTCCR
> > macro
> > >    for duty_offset.
> > >  * replaced misnomer real_period->state_period.
> > >  * Added handling for values >=3D (1024 << 32) for both period
> > >    and duty cycle.
> > >  * Added comments for pwm {en,dis}abled by bootloader during probe.
> > > v4->v5:
> > >  * Added Hardware manual details
> > >  * Replaced the comment GTCNT->Counter
> > >  * Removed the macros RZG2L_GPT_IO_PER_CHANNEL and chip.npwm
> > directly
> > >    used in probe.
> > >  * Removed the unsed macro RZG2L_GTPR_MAX_VALUE
> > >  * Added driver prefix for the type name and the variable.
> > >  * Initialization of per_channel data moved from request->probe.
> > >  * Updated clr parameter for rzg2l_gpt_modify for Start count.
> > >  * Started using mutex and usage_count for handling shared
> > >    period and prescalar for the 2 channels.
> > >  * Updated the comment cycle->period.
> > >  * Removed clk_disable from rzg2l_gpt_reset_assert_pm_disable()
> > >  * Replaced pc->rzg2l_gpt.
> > >  * Updated prescale calculation.
> > >  * Moved pm_runtime_{get_sync,put} from
> > > {request,free}->{enable,disable}
> > >  * Removed platform_set_drvdata as it is unused
> > >  * Removed the variable pwm_enabled_by_bootloader
> > >  * Added dev_err_probe in various error paths in probe.
> > >  * Added an error message, if devm_pwmchip_add() fails.
> > > v3->v4:
> > >  * Changed the local variable type i from u16->u8 and
> > prescaled_period_
> > >    cycles from u64->u32 in calculate_prescale().
> > >  * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div()
> > >  * Dropped the comma after the sentinel.
> > >  * Add a variable to track pwm enabled by bootloader and added
> > comments
> > >    in probe().
> > >  * Removed unnecessary rzg2l_gpt_reset_assert_pm_disable() from
> > probe.
> > >  * Replaced devm_clk_get()->devm_clk_get_prepared()
> > >  * Removed devm_clk_get_optional_enabled()
> > > v2->v3:
> > >  * Updated limitation section
> > >  * Added prefix "RZG2L_" for all macros
> > >  * Modified prescale calculation
> > >  * Removed pwm_set_chip_data
> > >  * Updated comment related to modifying Mode and Prescaler
> > >  * Updated setting of prescale value in rzg2l_gpt_config()
> > >  * Removed else branch from rzg2l_gpt_get_state()
> > >  * removed the err label from rzg2l_gpt_apply()
> > >  * Added devm_clk_get_optional_enabled() to retain clk on status,
> > >    in case bootloader turns on the clk of pwm.
> > >  * Replaced devm_reset_control_get_exclusive-
> > >devm_reset_control_get_shared
> > >    as single reset shared between 8 channels.
> > > v1->v2:
> > >  * Added Limitations section
> > >  * dropped "_MASK" from the define names.
> > >  * used named initializer for struct phase
> > >  * Added gpt_pwm_device into a flexible array member in
> > rzg2l_gpt_chip
> > >  * Revised the logic for prescale
> > >  * Added .get_state callback
> > >  * Improved error handling in rzg2l_gpt_apply
> > >  * Removed .remove callback
> > >  * Tested driver with PWM_DEBUG enabled
> > > RFC->V1:
> > >  * Updated macros
> > >  * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
> > >  * Added rzg2l_gpt_read()
> > > ---
> > >  drivers/pwm/Kconfig         |  11 +
> > >  drivers/pwm/Makefile        |   1 +
> > >  drivers/pwm/pwm-rzg2l-gpt.c | 423
> > > ++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 435 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
> > >
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > > 60d13a949bc5..2723a3e9ff65 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -481,6 +481,17 @@ config PWM_ROCKCHIP
> > >  	  Generic PWM framework driver for the PWM controller found on
> > >  	  Rockchip SoCs.
> > >
> > > +config PWM_RZG2L_GPT
> > > +	tristate "Renesas RZ/G2L General PWM Timer support"
> > > +	depends on ARCH_RENESAS || COMPILE_TEST
> > > +	depends on HAS_IOMEM
> > > +	help
> > > +	  This driver exposes the General PWM Timer controller found in
> > Renesas
> > > +	  RZ/G2L like chips through the PWM API.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module
> > > +	  will be called pwm-rzg2l-gpt.
> > > +
> > >  config PWM_SAMSUNG
> > >  	tristate "Samsung PWM support"
> > >  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS ||
> > > COMPILE_TEST diff --git a/drivers/pwm/Makefile
> > b/drivers/pwm/Makefile
> > > index 7bf1a29f02b8..cac39b18d1ee 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -44,6 +44,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-
> > raspberrypi-poe.o
> > >  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> > >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> > >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> > > +obj-$(CONFIG_PWM_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
> > >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> > >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> > >  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> > > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-
> > gpt.c
> > > new file mode 100644 index 000000000000..c4e011f2a843
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > [...]
> > > +static void rzg2l_gpt_write(struct rzg2l_gpt_chip *rzg2l_gpt, u32
> > > +reg, u32 data) {
> > > +	iowrite32(data, rzg2l_gpt->mmio + reg); }
> > > +
> > > +static u32 rzg2l_gpt_read(struct rzg2l_gpt_chip *rzg2l_gpt, u32
> > reg)
> > > +{
> > > +	return ioread32(rzg2l_gpt->mmio + reg); }
> >=20
> > Do you really need to support PCI I/O space in this driver? If not,
> > make this writel() and readl() instead.
>=20
> Agreed.
>=20
> >=20
> > [...]
> > > +static int rzg2l_gpt_probe(struct platform_device *pdev) {
> > > +	struct rzg2l_gpt_chip *rzg2l_gpt;
> > > +	int ret;
> > > +
> > > +	rzg2l_gpt =3D devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt),
> > GFP_KERNEL);
> > > +	if (!rzg2l_gpt)
> > > +		return -ENOMEM;
> > > +
> > > +	rzg2l_gpt->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> > > +	if (IS_ERR(rzg2l_gpt->mmio))
> > > +		return PTR_ERR(rzg2l_gpt->mmio);
> > > +
> > > +	rzg2l_gpt->rstc =3D devm_reset_control_get_shared(&pdev->dev,
> > NULL);
> > > +	if (IS_ERR(rzg2l_gpt->rstc))
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
> > > +				     "get reset failed\n");
> > > +
> > > +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> > > +	if (ret)
> > > +		return dev_err_probe(&pdev->dev, ret,
> > > +				     "cannot deassert reset control\n");
> > > +
> > > +	pm_runtime_enable(&pdev->dev);
> > > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > > +				       rzg2l_gpt_reset_assert_pm_disable,
> > > +				       rzg2l_gpt);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	rzg2l_gpt->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> > > +	if (IS_ERR(rzg2l_gpt->clk))
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
> > > +				     "cannot get clock\n");
> > > +
> > > +	rzg2l_gpt->rate =3D clk_get_rate(rzg2l_gpt->clk);
> > > +	/*
> > > +	 *  We need to keep the clock on, in case the bootloader has
> > enabled the
> > > +	 *  PWM and is running during probe(). A variable pwm_enabled_by_
> > > +	 *  bootloader is set to true in that case and during first
> > > +	 *  pwm_disable(), it is set to false and release the clock
> > resource.
> > > +	 *
> > > +	 *  In case the pwm is not enabled by the bootloader,
> > devm_clk_put
> > > +	 *  disables the clk and holding a reference on the clk isn't
> > needed
> > > +	 *  because runtime-pm handles the needed enabling.
> > > +	 */
> >=20
> > Where does this happen? I'm not aware of any code that would
> > automatically enable clocks for runtime PM. Typically you would need
> > to implement driver-specific callbacks for that to happen.
>=20
> As we are using clock domain in the PM framework and supports multiple cl=
ocks
> in clock domain, a single call to pm calls such as pm_runtime_get_{sync, =
resume)=20
> enables multiple clocks on each device.
>=20
> >=20
> > > +	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
> > > +		rzg2l_gpt->pwm_enabled_by_bootloader =3D true;
> > > +	else
> > > +		devm_clk_put(&pdev->dev, rzg2l_gpt->clk);
> >=20
> > So in either case I would expect you to want to hold on to the clock
> > pointer here and use that in the runtime PM callbacks.
>=20
> But the api used here is "devm_clk_get_enabled".
> This will enable the clocks and holds the reference
> (for pwm enabled by bootloader case) as it avoids turning "off"
> the clock during later part of the boot process
> (it prevents clock off by clk_disable_unused())
>=20
> On the other case, this api will simply waste power, so we need to
> disable and remove the clk reference.
>=20
> >=20
> > This whole business of keeping a separate variable to track this also
> > seems a bit fishy to me because it only partially reflects in the
> > software state what's really going on. So I think what you really want
> > here is to call pm_runtime_set_active() before pm_runtime_enable() to
> > make sure that your device is marked as such.
> >=20
>=20
> I can add pm_runtime_set_active() followed by pm_runtime_enable() in the
> next version( This will make RPM_ACTIVE active state, But clock is not "o=
n"
> as we did not call pm_runtime_get_{sync, resume) to change it to RPM_RESU=
ME state)
>=20
> > I wonder if that alone wouldn't already solve this problem. IIRC, the
> > runtime PM infrastructure will consider a device to be runtime
> > suspended after ->probe() by default. And if the clock is indeed
> > managed by runtime PM somehow, then that might just cause it to get
> > disabled.
>=20
> Yes, that won't solve.
>=20
> Here we have 2 cases in probe,=20
>=20
> in 1 case clk to be "on" after probe(PM RESUME STATE) --> pwm enabled by =
bootloader
> and other case clk to be "off" after probe(PM SUSPENDING state) --> pwm d=
isabled by bootloader
>=20
> > Again, it'd be great to know how exactly runtime PM knows how to
> > manage the clock if you don't tell it here.
>=20
> pm_runtime_get_{sync, resume) will change the state to RPM_RESUME
> and
> pm_runtime_put will change the state to RPM_SUSPENDING.
>=20
> Please see get_state() and apply().
>=20
> > Is the clock perhaps
> > shared between multiple IPs? Perhaps a parent device that managed it
> > in runtime PM?
>=20
> No, it doesn't shared.
>=20
> Currently we need to take care of the 2 cases in probe as mentioned above
>=20
> 1) pwm enabled by bootloader:-
>=20
> we are calling "devm_clk_get_enabled" which will hold
> reference of enabled Clk( this will prevent clk_disable_unused() turning =
off the clocks
> during late init)
>=20
> 2) pwm disabled by bootloader:-
>=20
> Clock is off during probe, but in apply state we will turn it on by calli=
ng
> pm_runtime_get_sync.

I understand what and why you're doing this, but I think you're doing
this at the wrong level of abstraction. And that's what's leading to
this strange construct where you need to manually fiddle with the clock.
If you want to abstract all of this behind PM domains, then this should
be reflected properly within those PM domains.

That is, if the PWM has been enabled by the bootloader, then effectively
it's had to enable the PM domain as well (at least conceptually, even if
the bootloader may not have the same objects as Linux). So you need to
find a way to mark the PM domain as enabled as a whole rather than just
one of the clocks that happens to be part of it.

Remember, the purpose of abstraction is to hide the implementation
details (i.e. the clock). You break that abstraction if you go and
fiddle with the implementation details.

> > > +	mutex_init(&rzg2l_gpt->lock);
> > > +
> > > +	rzg2l_gpt->chip.dev =3D &pdev->dev;
> > > +	rzg2l_gpt->chip.ops =3D &rzg2l_gpt_ops;
> > > +	rzg2l_gpt->chip.npwm =3D 2;
> >=20
> > The changelog above mentions that you use a shared reset because the
> > reset is shared between 8 channels, but here you only expose 2. What's
> > going on there?
>=20
> Each hwchannel has 2 IOs. Each IO is modelled as separate channel.
> Basically, we have 8 hwchannels * 2 IO's  =3D 16 pwm channels in total.
>=20
> Please correct me if anything wrong here.

I'm asking because I recently came across a similar driver but where the
mistake was made to describe the hardware as 4 separate devices with 2
channels (or, depending on SoC generation, 1 channel) per device.
Looking at the device tree it's pretty obvious that in that case this
was really a single device with 8 (or 4, depending) channels. Most of
the time this doesn't matter and everything works, but then on some HW
generations all of a sudden you have a shared interrupt for all 8
channels, and now this becomes really difficult to describe because the
interrupt needs to be shared between 4 devices, or an extra layer is
needed to slot in the interrupt somehow.

So I'm just trying to avoid another such situation. Looking at the DTS
example from the binding in patch 1, you have gpt4 at 0x10048400 with
0x100 bytes. Does gpt3 sit at 0x10048300 with 0x100 bytes? If so, it's
likely that this is really a single large IP block that you're
artificially subdividing and that could turn into a similar issue as
above.

Thierry

--WeGM5742Gwhpfqob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM1adQACgkQ3SOs138+
s6HSSw/+O3+Oe1rCx17TevXog/CrRuLOTnVxxxIl/2VD2Vb4eIrTpo/oSV8lJ33h
Hag2wcP960Ps68psDbsAGvsqJs7X7bZzkwGlHa4QuPP5p/uZ4p3j5XfGoZTucuuU
zQFTea2P+kQX+ywjJQRhL3y9ocrTEqEKOdiB5db0fCCdZ+VebPhExMWYx3XbPIqR
IjF/0W9uJs+hFgbZiNgyuRsXARKBk4n+dSvOctuUIbv+kC5uEYcp4ZBe0QaQC/sh
uHjnvgKhDrqyZJjHF1laCTFKiEoWNEtMtMrl+eaOasoKbaOe64D+mPfAJHo3fxZN
xR/fXW7ud1O9TSZuPoe4+eSOWFHaX0Iob8XfWln7gB8WqQssUCq00vZ1J2qWqLHI
QSj+QIooQl3w63Mt6GCo1Zw4BEq5vX3EitqlV3WY/hKVqorXa71umQavrF3xWJor
dFdTdL+cTYRlhq2e6MoTJ+jdEm+a7kNAuaxHDJ2rlwqhrEAatCHMf3GoBdIqyxEb
rJkflrouXMFz42FztAPJi9pWaFhBJ5E+n6+Ujlp7Cx0ufkwi8tHxl5FxdDFJl8s3
4s2ByXcdob5kk7w/y3sZGX+m616WMJFt1gV8mIZQyoUoZt+V1QEURlGYRGcLccd5
6/QAOwvScnboNG0Pp1WLQ/7KPWvpkk8kjrdmho7QJnerAYEX0XY=
=L8dO
-----END PGP SIGNATURE-----

--WeGM5742Gwhpfqob--
