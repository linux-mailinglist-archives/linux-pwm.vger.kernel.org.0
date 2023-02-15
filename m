Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB93D697830
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Feb 2023 09:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjBOIa5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Feb 2023 03:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbjBOIa4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Feb 2023 03:30:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF08B754
        for <linux-pwm@vger.kernel.org>; Wed, 15 Feb 2023 00:30:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSDBY-0003zR-Ho; Wed, 15 Feb 2023 09:30:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSDBV-0054Hq-Er; Wed, 15 Feb 2023 09:30:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSDBV-003hK9-Ua; Wed, 15 Feb 2023 09:30:37 +0100
Date:   Wed, 15 Feb 2023 09:30:37 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Message-ID: <20230215083037.ivlmqhp4xngnexca@pengutronix.de>
References: <20230202165732.305650-1-biju.das.jz@bp.renesas.com>
 <20230202165732.305650-7-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vuke3fan3qj4cmkl"
Content-Disposition: inline
In-Reply-To: <20230202165732.305650-7-biju.das.jz@bp.renesas.com>
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


--vuke3fan3qj4cmkl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm working on my review backlog, sorry that it took so long.

On Thu, Feb 02, 2023 at 04:57:32PM +0000, Biju Das wrote:
> Add support for RZ/G2L MTU3a PWM driver. The IP supports
> following PWM modes
>=20
> 1) PWM mode{1,2}
> 2) Reset-synchronized PWM mode
> 3) Complementary PWM mode{1,2,3}

It's unclear to me what "PWM mode1" and the other modes are. I suspect
this is some chip specific naming that isn't understandable for
outsiders? Would be great to explain that a bit more.

> This patch adds basic pwm mode 1 support for RZ/G2L MTU3a pwm driver
> by creating separate logical channels for each IOs.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v11->v12:
>  * Updated header file to <linux/mfd/rz-mtu3.h> as core driver is in MFD.
>  * Reordered get_state()
> v10->v11:
>  * No change.
> v9->v10:
>  * No change.
> v8->v9:
>  * Added prescale/duty_cycle variables to struct rz_mtu3_pwm_chip and
>    cached this values in rz_mtu3_pwm_config and used this cached values
>    in get_state(), if PWM is disabled.
>  * Added return code for get_state()
> v7->v8:
>  * Simplified rz_mtu3_pwm_request by calling rz_mtu3_request_channel()
>  * Simplified rz_mtu3_pwm_free by calling rz_mtu3_release_channel()
> v6->v7:
>  * Added channel specific mutex lock to avoid race between counter
>    device and rz_mtu3_pwm_{request,free}
>  * Added pm_runtime_resume_and_get in rz_mtu3_pwm_enable()
>  * Added pm_runtime_put_sync in rz_mtu3_pwm_disable()
>  * Updated rz_mtu3_pwm_config()
>  * Updated rz_mtu3_pwm_apply()
> v5->v6:
>  * Updated commit and Kconfig description
>  * Sorted the header
>  * Replaced dev_get_drvdata from rz_mtu3_pwm_pm_disable()
>  * Replaced SET_RUNTIME_PM_OPS->DEFINE_RUNTIME_DEV_PM_OPS and removed
>    __maybe_unused from suspend/resume()
> v4->v5:
>  * pwm device is instantiated by mtu3a core driver.
> v3->v4:
>  * There is no resource associated with "rz-mtu3-pwm" compatible
>    and moved the code to mfd subsystem as it binds against "rz-mtu".
>  * Removed struct platform_driver rz_mtu3_pwm_driver.
> v2->v3:
>  * No change.
> v1->v2:
>  * Modelled as a single PWM device handling multiple channles.
>  * Used PM framework to manage the clocks.
> ---
>  drivers/pwm/Kconfig       |  11 +
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-rz-mtu3.c | 485 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 497 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rz-mtu3.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 31cdc9dae3c5..c54cbeabe093 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -492,6 +492,17 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
> =20
> +config PWM_RZ_MTU3
> +	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
> +	depends on RZ_MTU3 || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver exposes the MTU3a PWM Timer controller found in Renesas
> +	  RZ/G2L like chips through the PWM API.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-rz-mtu3.
> +
>  config PWM_SAMSUNG
>  	tristate "Samsung PWM support"
>  	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index a95aabae9115..6b75c0145336 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_RZV2M)		+=3D pwm-rzv2m.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
>  obj-$(CONFIG_PWM_SL28CPLD)	+=3D pwm-sl28cpld.o
> diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
> new file mode 100644
> index 000000000000..d94e3fc36dfb
> --- /dev/null
> +++ b/drivers/pwm/pwm-rz-mtu3.c
> @@ -0,0 +1,485 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L MTU3a PWM Timer driver
> + *
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + *
> + * Hardware manual for this IP can be found here
> + * https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-u=
sers-manual-hardware-0?language=3Den
> + *
> + * Limitations:
> + * - When PWM is disabled, the output is driven to Hi-Z.
> + * - While the hardware supports both polarities, the driver (for now)
> + *   only handles normal polarity.
> + * - While the hardware supports pwm mode{1,2}, reset-synchronized pwm a=
nd
> + *   complementary pwm modes, the driver (for now) only handles pwm mode=
1.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/limits.h>
> +#include <linux/mfd/rz-mtu3.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/time.h>
> +
> +#define RZ_MTU3_TMDR1_MD_NORMAL		(0)
> +#define RZ_MTU3_TMDR1_MD_PWM_MODE_1	(2)

IMHO it would make sense to put these definitions to where RZ_MTU3_TMDR1
is defined. And I'd do it like this:

	* Timer mode register 1 */
	#define RZ_MTU3_TMDR1			5
	#define RZ_MTU3_TMDR1_MD			GENMASK(3, 0)
	#define RZ_MTU3_TMDR1_MD_NORMAL				FIELD_PREP(RZ_MTU3_TMDR1_MD, 0)
	#define RZ_MTU3_TMDR1_MD_PWMMODE1			FIELD_PREP(RZ_MTU3_TMDR1_MD, 2)

> +#define RZ_MTU3_TIOR_OC_RETAIN		(0)
> +#define RZ_MTU3_TIOR_OC_0_H_COMP_MATCH	(2)
> +#define RZ_MTU3_TIOR_OC_1_TOGGLE	(7)
> +#define RZ_MTU3_TIOR_OC_IOA		GENMASK(3, 0)
> +
> +#define RZ_MTU3_TCR_CCLR_TGRC		(5 << 5)
> +#define RZ_MTU3_TCR_CKEG_RISING		(0 << 3)
> +
> +#define RZ_MTU3_TCR_TPCS		GENMASK(2, 0)
> +
> +#define RZ_MTU3_MAX_PWM_MODE1_CHANNELS	(12)
> +
> +#define RZ_MTU3_MAX_HW_PWM_CHANNELS	(7)
> +
> +static const u8 rz_mtu3_pwm_mode1_num_ios[] =3D { 2, 1, 1, 2, 2, 2, 2 };
> +
> +/**
> + * struct rz_mtu3_pwm_chip - MTU3 pwm private data
> + *
> + * @chip: MTU3 pwm chip data
> + * @clk: MTU3 module clock
> + * @lock: Lock to prevent concurrent access for usage count
> + * @rate: MTU3 clock rate
> + * @user_count: MTU3 usage count
> + * @rz_mtu3_channel: HW channels for the PWM
> + */
> +
> +struct rz_mtu3_pwm_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	struct mutex lock;
> +	unsigned long rate;
> +	u32 user_count[RZ_MTU3_MAX_HW_PWM_CHANNELS];
> +	struct rz_mtu3_channel *ch[RZ_MTU3_MAX_HW_PWM_CHANNELS];
> +
> +	/*
> +	 * The driver cannot read the current duty cycle/prescale from the
> +	 * hardware if the hardware is disabled. Cache the last programmed
> +	 * duty cycle/prescale value to return in that case.

If the hardware is disabled, just doing .enabled =3D false in .get_state
is fine and easier. So this can be dropped I think.

> +	 */
> +	u8 prescale[RZ_MTU3_MAX_HW_PWM_CHANNELS];
> +	unsigned int duty_cycle[RZ_MTU3_MAX_PWM_MODE1_CHANNELS];
> +};
> +
> +static inline struct rz_mtu3_pwm_chip *to_rz_mtu3_pwm_chip(struct pwm_ch=
ip *chip)
> +{
> +	return container_of(chip, struct rz_mtu3_pwm_chip, chip);
> +}
> +
> +static u8 rz_mtu3_pwm_calculate_prescale(struct rz_mtu3_pwm_chip *rz_mtu=
3,
> +					 u64 period_cycles)
> +{
> +	u32 prescaled_period_cycles;
> +	u8 prescale;
> +
> +	prescaled_period_cycles =3D period_cycles >> 16;
> +	if (prescaled_period_cycles >=3D 16)
> +		prescale =3D 3;
> +	else
> +		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;
> +
> +	return prescale;
> +}
> +
> +static struct rz_mtu3_channel *
> +rz_mtu3_get_hw_channel(struct rz_mtu3_pwm_chip *rz_mtu3_pwm, u32 channel)
> +{
> +	unsigned int i, ch_index =3D 0;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(rz_mtu3_pwm_mode1_num_ios); i++) {
> +		ch_index +=3D rz_mtu3_pwm_mode1_num_ios[i];
> +
> +		if (ch_index > channel)
> +			break;
> +	}
> +
> +	return rz_mtu3_pwm->ch[i];
> +}
> +
> +static u32 rz_mtu3_get_hw_channel_index(struct rz_mtu3_pwm_chip *rz_mtu3=
_pwm,
> +					struct rz_mtu3_channel *ch)
> +{
> +	u32 i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(rz_mtu3_pwm_mode1_num_ios); i++) {
> +		if (ch =3D=3D rz_mtu3_pwm->ch[i])
> +			break;
> +	}
> +
> +	return i;
> +}
> +
> +static bool rz_mtu3_pwm_is_second_channel(u32 ch_index, u32 hwpwm)
> +{
> +	u32 i, pwm_ch_index =3D 0;
> +
> +	for (i =3D 0; i < ch_index; i++)
> +		pwm_ch_index +=3D rz_mtu3_pwm_mode1_num_ios[i];
> +
> +	return pwm_ch_index !=3D hwpwm;
> +}

I don't understand that channel allocation, maybe worth an explaining
comment?!

> +static bool rz_mtu3_pwm_is_ch_enabled(struct rz_mtu3_pwm_chip *rz_mtu3_p=
wm,
> +				      u32 hwpwm)
> +{
> +	struct rz_mtu3_channel *ch;
> +	bool is_channel_en;
> +	u32 ch_index;
> +	u8 val;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +	is_channel_en =3D rz_mtu3_is_enabled(ch);
> +
> +	if (rz_mtu3_pwm_is_second_channel(ch_index, hwpwm))
> +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORL);
> +	else
> +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TIORH);
> +
> +	return (is_channel_en && (val & RZ_MTU3_TIOR_OC_IOA));
> +}
> +
> +static int rz_mtu3_pwm_request(struct pwm_chip *chip, struct pwm_device =
*pwm)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_channel *ch;
> +	u32 ch_index;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +	if (!rz_mtu3_pwm->user_count[ch_index] && !rz_mtu3_request_channel(ch))
> +		return -EBUSY;
> +
> +	mutex_lock(&rz_mtu3_pwm->lock);
> +	rz_mtu3_pwm->user_count[ch_index]++;
> +	mutex_unlock(&rz_mtu3_pwm->lock);

The lock must protect the check, too, otherwise that's racy.

> +
> +	return 0;
> +}
> +
> +static void rz_mtu3_pwm_free(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_channel *ch;
> +	u32 ch_index;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +
> +	mutex_lock(&rz_mtu3_pwm->lock);
> +	rz_mtu3_pwm->user_count[ch_index]--;
> +	mutex_unlock(&rz_mtu3_pwm->lock);
> +
> +	if (!rz_mtu3_pwm->user_count[ch_index])
> +		rz_mtu3_release_channel(ch);

I didn't check what rz_mtu3_release_channel() does, but I wonder what
happens if another thread calls rz_mtu3_pwm_request for the same channel
just after the if check.

> +}
> +
> +static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> +			      struct pwm_device *pwm)
> +{
> +	struct rz_mtu3_channel *ch;
> +	u32 ch_index;
> +	u8 val;
> +	int rc;
> +
> +	rc =3D pm_runtime_resume_and_get(rz_mtu3_pwm->chip.dev);
> +	if (rc)
> +		return rc;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +	val =3D (RZ_MTU3_TIOR_OC_1_TOGGLE << 4) | RZ_MTU3_TIOR_OC_0_H_COMP_MATC=
H;
> +
> +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_MD_PWM_MODE_1);
> +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm))
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORL, val);
> +	else
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORH, val);
> +
> +	if (rz_mtu3_pwm->user_count[ch_index] <=3D 1)
> +		rz_mtu3_enable(ch);
> +
> +	return 0;
> +}
> +
> +static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
> +				struct pwm_device *pwm)
> +{
> +	struct rz_mtu3_channel *ch;
> +	u32 ch_index;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +
> +	/* Return to normal mode and disable output pins of MTU3 channel */
> +	if (rz_mtu3_pwm->user_count[ch_index] <=3D 1)
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_MD_NORMAL);
> +
> +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm))
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORL, RZ_MTU3_TIOR_OC_RETAIN);
> +	else
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIORH, RZ_MTU3_TIOR_OC_RETAIN);
> +
> +	if (rz_mtu3_pwm->user_count[ch_index] <=3D 1)
> +		rz_mtu3_disable(ch);
> +
> +	pm_runtime_put_sync(rz_mtu3_pwm->chip.dev);
> +}
> +
> +static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_channel *ch;
> +	u8 prescale, val;
> +	u32 ch_index;
> +	u16 dc, pv;
> +	u64 tmp;
> +
> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +	pm_runtime_get_sync(chip->dev);
> +	state->enabled =3D rz_mtu3_pwm_is_ch_enabled(rz_mtu3_pwm, pwm->hwpwm);
> +	if (state->enabled) {
> +		val =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TCR);
> +		prescale =3D FIELD_GET(RZ_MTU3_TCR_TPCS, val);
> +
> +		if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm)) {
> +			dc =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRD);
> +			pv =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRC);
> +		} else {
> +			dc =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRB);
> +			pv =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TGRA);
> +		}
> +
Add a comment like:

	/* With prescale <=3D 7 and pv <=3D 0xffff this doesn't overflow. */

> +		tmp =3D NSEC_PER_SEC * (u64)pv << (2 * prescale);
> +		state->period =3D DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
> +	} else {
> +		/* If the PWM is disabled, use the cached value. */
> +		prescale =3D rz_mtu3_pwm->prescale[ch_index];
> +		dc =3D rz_mtu3_pwm->duty_cycle[pwm->hwpwm];
> +	}
> +
> +	tmp =3D NSEC_PER_SEC * (u64)dc << (2 * prescale);
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	pm_runtime_put(chip->dev);

Can it happen that dc > pv? I assume this implements a 100% relative
duty then. Please set .duty_cycle =3D .period in this case.

> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      const struct pwm_state *state)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	struct rz_mtu3_channel *ch;
> +	unsigned long pv, dc;
> +	u64 period_cycles;
> +	u64 duty_cycles;
> +	u32 ch_index;
> +	u8 prescale;
> +	int err;
> +	u8 val;
> +
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflowing the following
> +	 * calculation.
> +	 */
> +	if (rz_mtu3_pwm->rate > NSEC_PER_SEC)
> +		return -EINVAL;

Maybe refuse this case in .probe() already?

> +	ch =3D rz_mtu3_get_hw_channel(rz_mtu3_pwm, pwm->hwpwm);
> +	ch_index =3D rz_mtu3_get_hw_channel_index(rz_mtu3_pwm, ch);
> +	period_cycles =3D mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
> +					NSEC_PER_SEC);
> +	prescale =3D rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm, period_cycles);
> +
> +	if (period_cycles >> (2 * prescale) <=3D U16_MAX)
> +		pv =3D period_cycles >> (2 * prescale);
> +	else
> +		pv =3D U16_MAX;
> +
> +	duty_cycles =3D mul_u64_u32_div(state->duty_cycle, rz_mtu3_pwm->rate,
> +				      NSEC_PER_SEC);
> +	if (duty_cycles >> (2 * prescale) <=3D U16_MAX)
> +		dc =3D duty_cycles >> (2 * prescale);
> +	else
> +		dc =3D U16_MAX;
> +
> +	/*
> +	 * Store the duty cycle/prescale for future reference in cases where the
> +	 * corresponding registers can't be read (i.e. when the PWM is disabled=
).
> +	 */
> +	rz_mtu3_pwm->prescale[ch_index] =3D prescale;
> +	rz_mtu3_pwm->duty_cycle[pwm->hwpwm] =3D dc;

Above I suggested to drop this, but if you don't: This is broken.
rz_mtu3_pwm_config is only ever called with .enable =3D 1 and the values
are not updated when .apply() is called with .enable =3D 0, so you're
investing some effort to report an outdated value that is ignored in the
end.

> +	/*
> +	 * If the PWM channel is disabled, make sure to turn on the clock
> +	 * before writing the register.
> +	 */
> +	if (!pwm->state.enabled) {
> +		err =3D pm_runtime_resume_and_get(chip->dev);
> +		if (err)
> +			return err;
> +	}

Maybe it's easier to call pm_runtime_resume_and_get() unconditionally?

> +	val =3D RZ_MTU3_TCR_CKEG_RISING | prescale;
> +	if (rz_mtu3_pwm_is_second_channel(ch_index, pwm->hwpwm)) {
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
> +				      RZ_MTU3_TCR_CCLR_TGRC | val);
> +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRD, dc);
> +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRC, pv);
> +	} else {
> +		rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR,
> +				      RZ_MTU3_TCR_CCLR_TGRA | val);
> +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRB, dc);
> +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, pv);
> +	}
> +
> +	/* If the PWM is not enabled, turn the clock off again to save power. */
> +	if (!pwm->state.enabled)
> +		pm_runtime_put(chip->dev);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D to_rz_mtu3_pwm_chip(chip);
> +	bool enabled =3D pwm->state.enabled;
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		if (enabled)
> +			rz_mtu3_pwm_disable(rz_mtu3_pwm, pwm);
> +
> +		return 0;
> +	}
> +
> +	ret =3D rz_mtu3_pwm_config(chip, pwm, state);
> +	if (ret)
> +		return ret;
> +
> +	if (!enabled)
> +		ret =3D rz_mtu3_pwm_enable(rz_mtu3_pwm, pwm);
> +
> +	return ret;
> +}
> +
> +static const struct pwm_ops rz_mtu3_pwm_ops =3D {
> +	.request =3D rz_mtu3_pwm_request,
> +	.free =3D rz_mtu3_pwm_free,
> +	.get_state =3D rz_mtu3_pwm_get_state,
> +	.apply =3D rz_mtu3_pwm_apply,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int rz_mtu3_pwm_pm_runtime_suspend(struct device *dev)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(rz_mtu3_pwm->clk);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_pwm_pm_runtime_resume(struct device *dev)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(rz_mtu3_pwm->clk);
> +
> +	return 0;
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_pwm_pm_ops,
> +				 rz_mtu3_pwm_pm_runtime_suspend,
> +				 rz_mtu3_pwm_pm_runtime_resume, NULL);
> +
> +static void rz_mtu3_pwm_pm_disable(void *data)
> +{
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm =3D data;
> +
> +	pm_runtime_disable(rz_mtu3_pwm->chip.dev);
> +	pm_runtime_set_suspended(rz_mtu3_pwm->chip.dev);
> +}
> +
> +static int rz_mtu3_pwm_probe(struct platform_device *pdev)
> +{
> +	struct rz_mtu3 *ddata =3D dev_get_drvdata(pdev->dev.parent);
> +	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
> +	struct device *dev =3D &pdev->dev;
> +	int num_pwm_hw_ch =3D 0;
> +	unsigned int i;
> +	int ret;
> +
> +	rz_mtu3_pwm =3D devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm), GFP_KERN=
EL);
> +	if (!rz_mtu3_pwm)
> +		return -ENOMEM;
> +
> +	rz_mtu3_pwm->clk =3D ddata->clk;
> +	rz_mtu3_pwm->rate =3D clk_get_rate(rz_mtu3_pwm->clk);

Note that clk_get_rate isn't reliable for disabled clocks, so please
enable first and then call clk_get_rate(). Also consider calling
clk_rate_exclusive_get().

> +	for (i =3D 0; i < RZ_MTU_NUM_CHANNELS; i++) {
> +		if (i =3D=3D RZ_MTU5 || i =3D=3D RZ_MTU8)
> +			continue;
> +
> +		rz_mtu3_pwm->ch[num_pwm_hw_ch] =3D &ddata->channels[i];
> +		rz_mtu3_pwm->ch[num_pwm_hw_ch]->dev =3D dev;
> +		num_pwm_hw_ch++;
> +	}
> +
> +	mutex_init(&rz_mtu3_pwm->lock);
> +	platform_set_drvdata(pdev, rz_mtu3_pwm);

This is unused.

> +	clk_prepare_enable(rz_mtu3_pwm->clk);

Missing error checking.

> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       rz_mtu3_pwm_pm_disable,
> +				       rz_mtu3_pwm);
> +	if (ret < 0)
> +		goto disable_clock;
> +
> +	rz_mtu3_pwm->chip.dev =3D &pdev->dev;
> +	rz_mtu3_pwm->chip.ops =3D &rz_mtu3_pwm_ops;
> +	rz_mtu3_pwm->chip.npwm =3D RZ_MTU3_MAX_PWM_MODE1_CHANNELS;
> +	ret =3D devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
> +		goto disable_clock;
> +	}
> +
> +	return 0;
> +
> +disable_clock:
> +	clk_disable_unprepare(rz_mtu3_pwm->clk);
> +	return ret;
> +}

On .remove the clk isn't disabled.

> +
> +static struct platform_driver rz_mtu3_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-rz-mtu3",
> +		.pm =3D pm_ptr(&rz_mtu3_pwm_pm_ops),
> +	},
> +	.probe =3D rz_mtu3_pwm_probe,
> +};
> +module_platform_driver(rz_mtu3_pwm_driver);
> +
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_ALIAS("platform:pwm-rz-mtu3");
> +MODULE_DESCRIPTION("Renesas RZ/G2L MTU3a PWM Timer Driver");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vuke3fan3qj4cmkl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPsmCoACgkQwfwUeK3K
7AneJAf/ZX/IvVlbcS4PvO4TZhKrGL6ZCEV5eOd/Sz1X6BPzKX/xasjL4ZcuAw/w
7m+FHvz+YY5L5MCDCsnjFtITmojSWI0q88zxj9708EOF6+mdPqxFnFbQ4rb9Ua/G
ogXtDyrPQ4gW7QW/A7oJAu7Ce7q5NRIWPDHkLrEMH1IK96Zagp2hkImLOMBWBy9T
op92FjGYgy776wN6LNC6uLg1TfP6VOUqZCSp0kJHk+ljQOUChNzEFgb1MR7XpdRm
Euq8LBPOW3sduzzMThOZJT4FiJTxK6lyCpn7yZ0lctOlobJ8/dQMhTwT+YqehDGI
FotSOhFuLRXAfd7D4ymGODzA2xQTiQ==
=wKX4
-----END PGP SIGNATURE-----

--vuke3fan3qj4cmkl--
