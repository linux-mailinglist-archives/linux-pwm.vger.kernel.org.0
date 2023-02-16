Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C45698E10
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Feb 2023 08:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBPHww (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Feb 2023 02:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBPHwv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Feb 2023 02:52:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572BD41B5F
        for <linux-pwm@vger.kernel.org>; Wed, 15 Feb 2023 23:52:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSZ4E-0003LE-E7; Thu, 16 Feb 2023 08:52:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSZ4A-005J4P-TO; Thu, 16 Feb 2023 08:52:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSZ4B-003ywu-6x; Thu, 16 Feb 2023 08:52:31 +0100
Date:   Thu, 16 Feb 2023 08:52:31 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lee Jones <lee@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Message-ID: <20230216075231.xnmblxocmlsab5nv@pengutronix.de>
References: <20230202165732.305650-1-biju.das.jz@bp.renesas.com>
 <20230202165732.305650-7-biju.das.jz@bp.renesas.com>
 <20230215083037.ivlmqhp4xngnexca@pengutronix.de>
 <OS0PR01MB5922D6990B0AC75AA278FE1386A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pghvp72hz7albmpg"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922D6990B0AC75AA278FE1386A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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


--pghvp72hz7albmpg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Biju,

On Wed, Feb 15, 2023 at 07:14:12PM +0000, Biju Das wrote:
> > Subject: Re: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
> >=20
> > On Thu, Feb 02, 2023 at 04:57:32PM +0000, Biju Das wrote:
> > > Add support for RZ/G2L MTU3a PWM driver. The IP supports following PWM
> > > modes
> > >
> > > 1) PWM mode{1,2}
> > > 2) Reset-synchronized PWM mode
> > > 3) Complementary PWM mode{1,2,3}
> >=20
> > It's unclear to me what "PWM mode1" and the other modes are. I suspect =
this
> > is some chip specific naming that isn't understandable for outsiders? W=
ould
> > be great to explain that a bit more.
>=20
> Ok I will add below to Limitation sections. Is it ok?
>=20
> PWM Mode 1: PWM waveforms are output from the MTIOCnA and MTIOCnC pins by
> pairing TGRA with TGRB and TGRC with TGRD. The levels specified by the
> TIOR.IOA[3:0] and IOC[3:0] bits are output from the MTIOCnA and MTIOCnC p=
ins
> at compare matches A and C, and the level specified by the TIOR.IOB[3:0] =
and
> IOD[3:0] bits are output at compare matches B and D (n =3D 0 to 4, 6, 7).
>=20
>=20
> PWM Mode 2: PWM waveform output is generated using one TGR as the cycle
> register and the others as duty registers.
>=20
> Reset-Synchronized PWM Mode: In the reset-synchronized PWM mode, three ph=
ases
> of positive and negative PWM waveforms (six phases in total) that share a
> common wave transition point can be output by combining MTU3 and MTU4 and
> MTU6 and MTU7.
>=20
> Complementary PWM Mode: In complementary PWM mode, dead time can be set f=
or
> PWM waveforms to be output. The dead time is the period during which the =
upper
> and lower arm transistors are set to the inactive level in order to preve=
nt
> short-circuiting of the arms.Six positive-phase and six negative-phase PWM
> waveforms (12 phases in total)with dead time can be output by combining
> MTU3/ MTU4 and MTU6/MTU7.
>=20
> In complementary PWM mode, nine registers (compare registers, buffer regi=
sters,
> and temporary registers) are used to control the duty ratio for the PWM o=
utput.
> Complementary PWM mode 1 (transfer at crest)
> Complementary PWM mode 2 (transfer at trough)
> Complementary PWM mode 3 (transfer at crest and trough)

I read it five times now and still don't get it. The problem (maybe) is
that there are many abbreviations I don't understand. Most critical is:
What is a TGR?

I think I understand the following: Your hardware has one(?) freerunning
counter "TCNT". TGRs get set to a value where something happens when
TCNT reaches that value. In figure 16.27, reaching TGRA resets TCNT to 0
and the output value to low. Reaching TGRB sets the output value to
high. So far so easy. (Apart from your description of mode 1 talking
about four TGRs and two pins which could just be two independent PWMs
(in the sense of the pwm framework)?)

PWM mode 2 (figure 16.28) is the same just with more outputs. MTU1.TGRB
defines the period (as did TGRB in the above example) and there are
several other TGRx that define the duty cycle of one output each which
all share the same period. So if I restrict mode 2 to just MTU1.TRGB and
MTU1.TRGA I have mode 1.

So I don't get the difference between the two modes.

Describing modes (Reset-Synchronized PWM Mode and Complementary PWM
Mode) that are not relevant to the driver (yet?), doesn't help
understanding the hardware either.

> > > This patch adds basic pwm mode 1 support for RZ/G2L MTU3a pwm driver
> > > by creating separate logical channels for each IOs.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > ---
> > > v11->v12:
> > >  * Updated header file to <linux/mfd/rz-mtu3.h> as core driver is in =
MFD.
> > >  * Reordered get_state()
> > > v10->v11:
> > >  * No change.
> > > v9->v10:
> > >  * No change.
> > > v8->v9:
> > >  * Added prescale/duty_cycle variables to struct rz_mtu3_pwm_chip and
> > >    cached this values in rz_mtu3_pwm_config and used this cached valu=
es
> > >    in get_state(), if PWM is disabled.
> > >  * Added return code for get_state()
> > > v7->v8:
> > >  * Simplified rz_mtu3_pwm_request by calling rz_mtu3_request_channel()
> > >  * Simplified rz_mtu3_pwm_free by calling rz_mtu3_release_channel()
> > > v6->v7:
> > >  * Added channel specific mutex lock to avoid race between counter
> > >    device and rz_mtu3_pwm_{request,free}
> > >  * Added pm_runtime_resume_and_get in rz_mtu3_pwm_enable()
> > >  * Added pm_runtime_put_sync in rz_mtu3_pwm_disable()
> > >  * Updated rz_mtu3_pwm_config()
> > >  * Updated rz_mtu3_pwm_apply()
> > > v5->v6:
> > >  * Updated commit and Kconfig description
> > >  * Sorted the header
> > >  * Replaced dev_get_drvdata from rz_mtu3_pwm_pm_disable()
> > >  * Replaced SET_RUNTIME_PM_OPS->DEFINE_RUNTIME_DEV_PM_OPS and removed
> > >    __maybe_unused from suspend/resume()
> > > v4->v5:
> > >  * pwm device is instantiated by mtu3a core driver.
> > > v3->v4:
> > >  * There is no resource associated with "rz-mtu3-pwm" compatible
> > >    and moved the code to mfd subsystem as it binds against "rz-mtu".
> > >  * Removed struct platform_driver rz_mtu3_pwm_driver.
> > > v2->v3:
> > >  * No change.
> > > v1->v2:
> > >  * Modelled as a single PWM device handling multiple channles.
> > >  * Used PM framework to manage the clocks.
> > > ---
> > >  drivers/pwm/Kconfig       |  11 +
> > >  drivers/pwm/Makefile      |   1 +
> > >  drivers/pwm/pwm-rz-mtu3.c | 485
> > > ++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 497 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-rz-mtu3.c
> > >
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig index
> > > 31cdc9dae3c5..c54cbeabe093 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -492,6 +492,17 @@ config PWM_ROCKCHIP
> > >  	  Generic PWM framework driver for the PWM controller found on
> > >  	  Rockchip SoCs.
> > >
> > > +config PWM_RZ_MTU3
> > > +	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> > > +	depends on RZ_MTU3 || COMPILE_TEST
> > > +	depends on HAS_IOMEM
> > > +	help
> > > +	  This driver exposes the MTU3a PWM Timer controller found in Renes=
as
> > > +	  RZ/G2L like chips through the PWM API.
> > > +
> > > +	  To compile this driver as a module, choose M here: the module
> > > +	  will be called pwm-rz-mtu3.
> > > +
> > >  config PWM_SAMSUNG
> > >  	tristate "Samsung PWM support"
> > >  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS ||
> > > COMPILE_TEST diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > > index a95aabae9115..6b75c0145336 100644
> > > --- a/drivers/pwm/Makefile
> > > +++ b/drivers/pwm/Makefile
> > > @@ -45,6 +45,7 @@ obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
> > >  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
> > >  obj-$(CONFIG_PWM_RZV2M)		+=3D pwm-rzv2m.o
> > >  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> > > +obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
> > >  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
> > >  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> > >  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> > > diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c new
> > > file mode 100644 index 000000000000..d94e3fc36dfb
> > > --- /dev/null
> > > +++ b/drivers/pwm/pwm-rz-mtu3.c
> > > @@ -0,0 +1,485 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Renesas RZ/G2L MTU3a PWM Timer driver
> > > + *
> > > + * Copyright (C) 2022 Renesas Electronics Corporation
> > > + *
> > > + * Hardware manual for this IP can be found here
> > > + *
> > > +https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-u
> > > +sers-manual-hardware-0?language=3Den
> > > + *
> > > + * Limitations:
> > > + * - When PWM is disabled, the output is driven to Hi-Z.
> > > + * - While the hardware supports both polarities, the driver (for no=
w)
> > > + *   only handles normal polarity.
> > > + * - While the hardware supports pwm mode{1,2}, reset-synchronized p=
wm
> > and
> > > + *   complementary pwm modes, the driver (for now) only handles pwm
> > mode1.
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/limits.h>
> > > +#include <linux/mfd/rz-mtu3.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/pwm.h>
> > > +#include <linux/time.h>
> > > +
> > > +#define RZ_MTU3_TMDR1_MD_NORMAL		(0)
> > > +#define RZ_MTU3_TMDR1_MD_PWM_MODE_1	(2)
> >=20
> > IMHO it would make sense to put these definitions to where RZ_MTU3_TMDR=
1 is
> > defined. And I'd do it like this:
> >=20
> > 	* Timer mode register 1 */
> > 	#define RZ_MTU3_TMDR1			5
> > 	#define RZ_MTU3_TMDR1_MD			GENMASK(3, 0)
> > 	#define RZ_MTU3_TMDR1_MD_NORMAL
> > 	FIELD_PREP(RZ_MTU3_TMDR1_MD, 0)
> > 	#define RZ_MTU3_TMDR1_MD_PWMMODE1
> > 	FIELD_PREP(RZ_MTU3_TMDR1_MD, 2)
>=20
> Agreed, will move to include/linux/mfd/rz-mtu3.h.
>=20
> >=20
> > > +#define RZ_MTU3_TIOR_OC_RETAIN		(0)
> > > +#define RZ_MTU3_TIOR_OC_0_H_COMP_MATCH	(2)
> > > +#define RZ_MTU3_TIOR_OC_1_TOGGLE	(7)
> > > +#define RZ_MTU3_TIOR_OC_IOA		GENMASK(3, 0)
> > > +
> > > +#define RZ_MTU3_TCR_CCLR_TGRC		(5 << 5)
> > > +#define RZ_MTU3_TCR_CKEG_RISING		(0 << 3)
> > > +
> > > +#define RZ_MTU3_TCR_TPCS		GENMASK(2, 0)
> > > +
> > > +#define RZ_MTU3_MAX_PWM_MODE1_CHANNELS	(12)
> > > +
> > > +#define RZ_MTU3_MAX_HW_PWM_CHANNELS	(7)
> > > +
> > > +static const u8 rz_mtu3_pwm_mode1_num_ios[] =3D { 2, 1, 1, 2, 2, 2, 2
> > > +};
> > > +
> > > +/**
> > > + * struct rz_mtu3_pwm_chip - MTU3 pwm private data
> > > + *
> > > + * @chip: MTU3 pwm chip data
> > > + * @clk: MTU3 module clock
> > > + * @lock: Lock to prevent concurrent access for usage count
> > > + * @rate: MTU3 clock rate
> > > + * @user_count: MTU3 usage count
> > > + * @rz_mtu3_channel: HW channels for the PWM  */
> > > +
> > > +struct rz_mtu3_pwm_chip {
> > > +	struct pwm_chip chip;
> > > +	struct clk *clk;
> > > +	struct mutex lock;
> > > +	unsigned long rate;
> > > +	u32 user_count[RZ_MTU3_MAX_HW_PWM_CHANNELS];
> > > +	struct rz_mtu3_channel *ch[RZ_MTU3_MAX_HW_PWM_CHANNELS];
> > > +
> > > +	/*
> > > +	 * The driver cannot read the current duty cycle/prescale from the
> > > +	 * hardware if the hardware is disabled. Cache the last programmed
> > > +	 * duty cycle/prescale value to return in that case.
> >=20
> > If the hardware is disabled, just doing .enabled =3D false in .get_stat=
e is
> > fine and easier. So this can be dropped I think.
>=20
> Yes, it can be dropped, after adding below check in get_state()
>=20
> +       if (state->duty_cycle > state->period)
> +               state->duty_cycle =3D state->period;
> +
>=20
> >=20
> > > +	 */
> > > +	u8 prescale[RZ_MTU3_MAX_HW_PWM_CHANNELS];
> > > +	unsigned int duty_cycle[RZ_MTU3_MAX_PWM_MODE1_CHANNELS];
> > > +};
> > > +
> > > +static inline struct rz_mtu3_pwm_chip *to_rz_mtu3_pwm_chip(struct
> > > +pwm_chip *chip) {
> > > +	return container_of(chip, struct rz_mtu3_pwm_chip, chip); }
> > > +
> > > +static u8 rz_mtu3_pwm_calculate_prescale(struct rz_mtu3_pwm_chip
> > *rz_mtu3,
> > > +					 u64 period_cycles)
> > > +{
> > > +	u32 prescaled_period_cycles;
> > > +	u8 prescale;
> > > +
> > > +	prescaled_period_cycles =3D period_cycles >> 16;
> > > +	if (prescaled_period_cycles >=3D 16)
> > > +		prescale =3D 3;
> > > +	else
> > > +		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;
> > > +
> > > +	return prescale;
> > > +}
> > > +
> > > +static struct rz_mtu3_channel *
> > > +rz_mtu3_get_hw_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32
> > > +channel) {
> > > +	unsigned int i, ch_index =3D 0;
> > > +
> > > +	for (i =3D 0; i < ARRAY_SIZE(rz_mtu3_pwm_mode1_num_ios); i++) {
> > > +		ch_index +=3D rz_mtu3_pwm_mode1_num_ios[i];
> > > +
> > > +		if (ch_index > channel)
> > > +			break;
> > > +	}
> > > +
> > > +	return rz_mtu3_pwm->ch[i];
> > > +}
> > > +
> > > +static u32 rz_mtu3_get_hw_channel_index(struct rz_mtu3_pwm_chip
> > *rz_mtu3_pwm,
> > > +					struct rz_mtu3_channel *ch)
> > > +{
> > > +	u32 i;
> > > +
> > > +	for (i =3D 0; i < ARRAY_SIZE(rz_mtu3_pwm_mode1_num_ios); i++) {
> > > +		if (ch =3D=3D rz_mtu3_pwm->ch[i])
> > > +			break;
> > > +	}
> > > +
> > > +	return i;
> > > +}
> > > +
> > > +static bool rz_mtu3_pwm_is_second_channel(u32 ch_index, u32 hwpwm) {
> > > +	u32 i, pwm_ch_index =3D 0;
> > > +
> > > +	for (i =3D 0; i < ch_index; i++)
> > > +		pwm_ch_index +=3D rz_mtu3_pwm_mode1_num_ios[i];
> > > +
> > > +	return pwm_ch_index !=3D hwpwm;
> > > +}
> >=20
> > I don't understand that channel allocation, maybe worth an explaining
> > comment?!
>=20
> I will add below comment just above rz_mtu3_get_hw_channel(). Is it ok?
>=20
> +/*
> + * PWM Mode1 has MTU{0..4}, MTU6 and MTU7, Probe function skips MTU5 and=
 MTU8.

What is MTU?

> + * So struct rz_mtu3_channel *ch contains only PWM mode1 MTU channels.
> + * MTU{1, 2} channels has a single IO each compared to 2 IOs for the res=
t of the
> + * channels. A LUT rz_mtu3_pwm_mode1_num_ios introduced to get the PWM c=
hannel
> + * and HW channel.

What is LUT?=20

These channels are about which TRG can influence which output?

> + */
>=20
> >=20
> > > +static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip
> > *rz_mtu3_pwm,
> > > +				      u32 hwpwm)
> > > +{
> > > +	struct rz_mtu3_channel *ch;
> > > +	bool is_channel_en;
> > > +	u32 ch_index;
> > > +	u8 val;
> > > +
> > > +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, hwpwm);
> > > +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> > > +	is_channel_en =3D rz_mtu3_is_enabled(ch);
> > > +
> > > +	if (rz_mtu3_pwm_is_second_channel(ch_index, hwpwm))
> > > +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORL);
> > > +	else
> > > +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORH);
> > > +
> > > +	return (is_channel_en && (val & RZ_MTU3_TIOR_OC_IOA)); }
> > > +
> > > [...]
> > > +	/*
> > > +	 * If the PWM channel is disabled, make sure to turn on the clock
> > > +	 * before writing the register.
> > > +	 */
> > > +	if (!pwm->state.enabled) {
> > > +		err =3D pm_runtime_resume_and_get(chip->dev);
> > > +		if (err)
> > > +			return err;
> > > +	}
> >=20
> > Maybe it's easier to call pm_runtime_resume_and_get() unconditionally?
>=20
> OK, will use below unconditional call instead. Is it ok?
>=20
> pm_runtime_get_sync(chip->dev);

Try it and if it's simpler stick to it, if not, my suggestion was wrong.

> > > +	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;
> > > +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm)) {
> > > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
> > > +				      RZ_MTU3_TCR_CCLR_TGRC | val);
> > > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRD, dc);
> > > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRC, pv);
> > > +	} else {
> > > +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
> > > +				      RZ_MTU3_TCR_CCLR_TGRA | val);
> > > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRB, dc);
> > > +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, pv);
> > > +	}
> > > +
> > > [...]
> > > +static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_pwm_pm_ops,
> > > +				 rz_mtu3_pwm_pm_runtime_suspend,
> > > +				 rz_mtu3_pwm_pm_runtime_resume, NULL);
> > > +
> > > +static void rz_mtu3_pwm_pm_disable(void *data) {
> > > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D data;
> > > +
> > > +	pm_runtime_disable(rz_mtu3_pwm->chip.dev);
> > > +	pm_runtime_set_suspended(rz_mtu3_pwm->chip.dev);
> > > +}
> > > +
> > > +static int rz_mtu3_pwm_probe(struct platform_device *pdev) {
> > > +	struct rz_mtu3 *ddata =3D dev_get_drvdata(pdev->dev.parent);
> > > +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
> > > +	struct device *dev =3D &pdev->dev;
> > > +	int num_pwm_hw_ch =3D 0;
> > > +	unsigned int i;
> > > +	int ret;
> > > +
> > > +	rz_mtu3_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm),
> > GFP_KERNEL);
> > > +	if (!rz_mtu3_pwm)
> > > +		return -ENOMEM;
> > > +
> > > +	rz_mtu3_pwm->clk =3D ddata->clk;
> > > +	rz_mtu3_pwm->rate =3D clk_get_rate(rz_mtu3_pwm->clk);
> >=20
> > Note that clk_get_rate isn't reliable for disabled clocks, so please en=
able
> > first and then call clk_get_rate(). Also consider calling
> > clk_rate_exclusive_get().
>=20
>=20
> OK, will call get_rate() after enable. Runtime PM use clockenable/disable
> Frequently, so unnecessary to use clk_rate_exclusive_{get,put}. Is it ok?

One doesn't have to do with the other. After calling
clk_rate_exclusive_get() you can be sure that no other driver does
anything to change the clk which would mess with the emitted signals.

I don't know the exact semantics of clk_rate_exclusive_get(), but I'd
assume that even if you disable the clock you should be able to rely on
it running at the same rate after reenable.

> > > +	for (i =3D 0; i < RZ_MTU_NUM_CHANNELS; i++) {
> > > +		if (i =3D=3D RZ_MTU5 || i =3D=3D RZ_MTU8)
> > > +			continue;
> > > +
> > > +		rz_mtu3_pwm->ch[num_pwm_hw_ch] =3D &ddata->channels[i];
> > > +		rz_mtu3_pwm->ch[num_pwm_hw_ch]->dev =3D dev;
> > > +		num_pwm_hw_ch++;
> > > +	}
> > > +
> > > +	mutex_init(&rz_mtu3_pwm->lock);
> > > +	platform_set_drvdata(pdev, rz_mtu3_pwm);
> >=20
> > This is unused.
>=20
> Nope. It used in runtime PM calls.

Oh, indeed. Looking that up I saw that you didn't check the return
values of clk_disable_unprepare() and clk_prepare_enable() in them.

> > > +	pm_runtime_set_active(&pdev->dev);
> > > +	pm_runtime_enable(&pdev->dev);
> > > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > > +				       rz_mtu3_pwm_pm_disable,
> > > +				       rz_mtu3_pwm);
> > > +	if (ret < 0)
> > > +		goto disable_clock;
> > > +
> > > +	rz_mtu3_pwm->chip.dev =3D &pdev->dev;
> > > +	rz_mtu3_pwm->chip.ops =3D &rz_mtu3_pwm_ops;
> > > +	rz_mtu3_pwm->chip.npwm =3D RZ_MTU3_MAX_PWM_MODE1_CHANNELS;
> > > +	ret =3D devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
> > > +	if (ret) {
> > > +		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> > > +		goto disable_clock;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +disable_clock:
> > > +	clk_disable_unprepare(rz_mtu3_pwm->clk);
> > > +	return ret;
> > > +}
> >=20
> > On .remove the clk isn't disabled.
>=20
> It is not required. It is already disabled after probe.
>=20
> Clock_enable_prepare  enables the clk during probe, Then later
> PM runtime suspend turns off the clock using clk_prepare_disable().
>=20
> On error case, in probe, PM suspend won't get called, So we need to use
> clk_prepare_disable().
>=20
> After probe:
> [   15.680492] rzg2l-cpg 11010000.clock-controller: CLK_ON 1336/mtu_x_mck=
 ON
> [   15.725015] rzg2l-cpg 11010000.clock-controller: CLK_ON 1336/mtu_x_mck=
 OFF
> devmem2 0x11010538 | grep Read
>=20
> Unbind and bind call reports, balanced clk usage.
>=20
> Please correct me, if I am wrong or need any clarification.

As I missed the PM callbacks you are right I think. (I didn't recheck the
logic now though.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pghvp72hz7albmpg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPt4LgACgkQwfwUeK3K
7AkjYQf+IrMof1IGbNRq86uR92GwjjEzHvUV6u3qJeWxF1gOJm/vAPAZL6hwXrVi
tMhhuH2fmasP7Ctgu1W7B6DnjRpFlLMFN2I8B+FpLlgULfUw+KYjh1D4ccLQJRGH
z1nl/3qRLHTPa70qihujvtbH+b2bxYVREBRuRMEOdeMmzEAH7MqgLWCMCXIzdfUn
CDH1uxVAYX5yYUCiSCSM0JBTV46kt1sMMF7KBsrrGMoceYErYxzlHk/GtwgFxR6e
n722+wMFh7aCJ4hEvKZkqR3m9wcKLWAQCxugF+OzIatArIdGTJsFzkV9TFg0jec6
Ki33PzZ9X7m4OnOEgR/IWZkaxODn0w==
=Sd+8
-----END PGP SIGNATURE-----

--pghvp72hz7albmpg--
