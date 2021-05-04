Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCB8372E8F
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 19:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhEDRQu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 13:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhEDRQu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 May 2021 13:16:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00535C061763
        for <linux-pwm@vger.kernel.org>; Tue,  4 May 2021 10:15:54 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ldyeH-0001PQ-I3; Tue, 04 May 2021 19:15:53 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ldyeG-0001B0-J2; Tue, 04 May 2021 19:15:52 +0200
Date:   Tue, 4 May 2021 19:15:52 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        michal.simek@xilinx.com, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210504171552.uccctqzbcffiqhu7@pengutronix.de>
References: <20210503214413.3145015-1-sean.anderson@seco.com>
 <20210503214413.3145015-2-sean.anderson@seco.com>
 <20210504085112.edyy6loprfzejrjl@pengutronix.de>
 <2ef7de6f-4d17-e81a-11bc-27eb382577a7@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2z6f7s3waobdksi5"
Content-Disposition: inline
In-Reply-To: <2ef7de6f-4d17-e81a-11bc-27eb382577a7@seco.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2z6f7s3waobdksi5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Tue, May 04, 2021 at 10:46:39AM -0400, Sean Anderson wrote:
> On 5/4/21 4:51 AM, Uwe Kleine-K=F6nig wrote:
> > On Mon, May 03, 2021 at 05:44:13PM -0400, Sean Anderson wrote:
> >> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
> >> found on Xilinx FPGAs. There is another driver for this device located
> >> at arch/microblaze/kernel/timer.c, but it is only used for timekeeping.
> >> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
> >>
> >> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_=
timer/v1_03_a/axi_timer_ds764.pdf
> >>
> >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> >> ---
> >>
> >>   arch/arm64/configs/defconfig |   1 +
> >>   drivers/pwm/Kconfig          |  11 ++
> >>   drivers/pwm/Makefile         |   1 +
> >>   drivers/pwm/pwm-xilinx.c     | 322 +++++++++++++++++++++++++++++++++=
++
> >>   4 files changed, 335 insertions(+)
> >>   create mode 100644 drivers/pwm/pwm-xilinx.c
> >>
> >> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconf=
ig
> >> index 08c6f769df9a..81794209f287 100644
> >> --- a/arch/arm64/configs/defconfig
> >> +++ b/arch/arm64/configs/defconfig
> >> @@ -1083,6 +1083,7 @@ CONFIG_PWM_SAMSUNG=3Dy
> >>   CONFIG_PWM_SL28CPLD=3Dm
> >>   CONFIG_PWM_SUN4I=3Dm
> >>   CONFIG_PWM_TEGRA=3Dm
> >> +CONFIG_PWM_XILINX=3Dm
> >>   CONFIG_SL28CPLD_INTC=3Dy
> >>   CONFIG_QCOM_PDC=3Dy
> >>   CONFIG_RESET_IMX7=3Dy
> >
> > I think this should go into a separate patch once this driver is
> > accepted. This can then go via the ARM people.
>=20
> Sure.
>=20
> >
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index d3371ac7b871..01e62928f4bf 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -628,4 +628,15 @@ config PWM_VT8500
> >>   	  To compile this driver as a module, choose M here: the module
> >>   	  will be called pwm-vt8500.
> >>
> >> +config PWM_XILINX
> >> +	tristate "Xilinx AXI Timer PWM support"
> >> +	depends on !MICROBLAZE
> >
> > I don't understand this dependency.
>=20
> As noted in the commit message, there is already a driver for this
> device for microblaze systems. To prevent conflicts, this driver is
> disabled on microblaze.

OK, already understood that after reading the other replies to this
thread. As noted there, please add a comment describing the problem. You
probably also need some more dependencies, at least COMMON_CLK for
clk_rate_exclusive_get() and probably also HAS_IOMEM for readl/writel.

> >> +#include <asm/io.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/device.h>
> >> +#include <linux/debugfs.h>
> >> +#include <linux/module.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/pwm.h>
> >> +
> >> +#define TCSR0	0x00
> >> +#define TLR0	0x04
> >> +#define TCR0	0x08
> >> +#define TCSR1	0x10
> >> +#define TLR1	0x14
> >> +#define TCR1	0x18
> >> +
> >> +#define TCSR_MDT	BIT(0)
> >> +#define TCSR_UDT	BIT(1)
> >> +#define TCSR_GENT	BIT(2)
> >> +#define TCSR_CAPT	BIT(3)
> >> +#define TCSR_ARHT	BIT(4)
> >> +#define TCSR_LOAD	BIT(5)
> >> +#define TCSR_ENIT	BIT(6)
> >> +#define TCSR_ENT	BIT(7)
> >> +#define TCSR_TINT	BIT(8)
> >> +#define TCSR_PWMA	BIT(9)
> >> +#define TCSR_ENALL	BIT(10)
> >> +#define TCSR_CASC	BIT(11)
> >
> > I'd like to see a prefix for these defines, something like XILINX_PWM_
> > maybe?
>=20
> I don't think that's necessary, since these defines are used only for
> this file. In particular, adding a prefix like that would significantly
> lengthen lines which add several flags.

This is something where Thierry and I don't agree, so you can at least
expect support for your point. Still I see a value that is usually worth
the additional horizontal space.

The prefix would make it obvious that this is a local symbol. It also
helps to jump to the right definition if you use ctags or something
similar.

The most affected code lines are probably:

+	return !(~tcsr0 & TCSR_SET || tcsr0 & (TCSR_CLEAR | TCSR_CASC) ||
+		 ~tcsr1 & TCSR_SET || tcsr1 & TCSR_CLEAR);

which IMHO is already hard to read and adding a newline after each ||
doesn't hurt.

Or write it as:

	#define XILINX_PWM_TCSR_RUN_SET			\
			(XILINX_PWM_TCSR_GENT |		\
			 XILINX_PWM_TCSR_ARHT |		\
			 XILINX_PWM_TCSR_ENT |		\
			 XILINX_PWM_TCSR_PWMA)

	#define XILINX_PWM_TCSR_RUN_CLEAR		\
			 (XILINX_PWM_TCSR_MDT | \
			 XILINX_PWM_TCSR_LOAD)

	#define XILINX_PWM_TCSR_RUN_MASK		\
			(XILINX_PWM_TCSR_RUN_SET | XILINX_PWM_TCSR_RUN_CLEAR)


	...

	/*
	 * Both TCSR registers must be setup according to the running
	 * value, TCSR0 must also have the CASC bit set.
	 */
	if ((tcsr0 & XILINX_PWM_TCSR_RUN_MASK) !=3D XILINX_PWM_TCSR_RUN_SET ||
	    !(tcsr0 & TCSR_CASC) ||
	    (tcsr1 & XILINX_PWM_TCSR_RUN_MASK) !=3D XILINX_PWM_TCSR_RUN_SET)

which IMHO is better understandable and still fits the line length.
(Or simplify the check to only test for a single bit?)

+			tcsr0 =3D (TCSR_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
+			tcsr1 =3D TCSR_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);

is similar. I wonder if it makes sense to drop ENT from the default bit
mask and if after that xilinx_pwm_is_enabled() yields true. I also don't
understand the semantic of the UDT bit. You never modify it. Assuming it
has a relevant meaning the driver's behaviour depends on the value the
bootloader initialized that bit to?

So these lines might need some explanation anyhow and having to write it
over several lines doesn't actually hurt.

	bool enabled =3D xilinx_pwm_is_enabled(readl(pwm->regs + TCSR0),
					     readl(pwm->regs + TCSR1));

could be rewritten as

	u32 tcsr0 =3D readl(pwm->regs + XILINX_PWM_TCSR0);
	u32 tcsr1 =3D readl(pwm->regs + XILINX_PWM_TCSR1);
	bool enabled =3D xilinx_pwm_is_enabled(tcsr0, tcsr1);

which IMHO reads better and the required horizontal space is even less
than with your lines even tough I have added a prefix.

> >> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*unused,
> >> +			    const struct pwm_state *state)
> >> +{
> >> +	struct xilinx_pwm_device *pwm =3D xilinx_pwm_chip_to_device(chip);
> >> +	u32 tlr0, tlr1;
> >> +	u32 tcsr0 =3D readl(pwm->regs + TCSR0);
> >> +	u32 tcsr1 =3D readl(pwm->regs + TCSR1);
> >> +	bool enabled =3D xilinx_pwm_is_enabled(tcsr0, tcsr1);
> >> +
> >> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> >> +		return -EINVAL;
> >> +
> >> +	if (!enabled && state->enabled)
> >> +		clk_rate_exclusive_get(pwm->clk);
> >
> > Missing error checking.
>=20
> This cannot fail.

Oh indeed. IMHO it should be changed to return void and the comment
"Returns 0 on success, -EERROR otherwise" should be adapted to reality.

> >> +	tlr1 =3D xilinx_pwm_calc_tlr(pwm, tcsr1, state->duty_cycle);
> >> +	writel(tlr0, pwm->regs + TLR0);
> >> +	writel(tlr1, pwm->regs + TLR1);
> >
> > How does the hardware behave here? E.g. can it happen that after writing
> > TLR0 we can see a cycle with the new period but the old duty_cycle? Does
> > it complete the currently running period?
>=20
> TLR is the value loaded into TCR when the counter resets. I believe this
> happens at the rising edge for TCR0 and at the falling edge for TCR1,
> but the exact behavior is not documented. Therefore, changing the value
> of TLR will not affect the current cycle.

So we might still get a mixed period if the counter resets between the
two writel commands, right?

> > If state->enabled =3D=3D 0 you want to disable first to prevent that the
> > (maybe) new values for period and duty_cycle are emitted by the
> > hardware.
> >
> >> +	if (state->enabled) {
> >> +		/* Only touch the TCSRs if we aren't already running */
> >> +		if (!enabled) {
> >> +			/* Load TLR into TCR */
> >> +			writel(tcsr0 | TCSR_LOAD, pwm->regs + TCSR0);
> >> +			writel(tcsr1 | TCSR_LOAD, pwm->regs + TCSR1);
> >> +			/* Enable timers all at once with ENALL */
> >> +			tcsr0 =3D (TCSR_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
> >> +			tcsr1 =3D TCSR_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
> >> +			writel(tcsr0, pwm->regs + TCSR0);
> >> +			writel(tcsr1, pwm->regs + TCSR1);
> >> +		}
> >> +	} else {
> >> +		writel(tcsr0 & ~TCSR_ENT, pwm->regs + TCSR0);
> >> +		writel(tcsr1 & ~TCSR_ENT, pwm->regs + TCSR1);
> >
> > How does the hardware behave on disable? Does it always emit a low
> > level? Does it complete the currently running period?
>=20
> I don't know. My suspicion is that the output stops at whatever its
> current value is.

Would be great if you could find out that. Please document that in the
Limitations paragraph at the top of the driver.
=20
> > This is unusual to have in a driver. Something like memtool[1] should
> > work just fine, then you don't need this debugfs file. Together with pwm
> > tracing this should be good enough.
>=20
> I didn't have memtool on my test system, so I added this. I can remove
> it from the next patch if you'd like.

Yes, please remove it. (And install memtool or one of its alternatives
:-).

> >> +	pwm->clk =3D devm_clk_get(dev, NULL);
> >> +	if (IS_ERR(pwm->clk))
> >> +		return dev_err_probe(dev, PTR_ERR(pwm->clk), "missing clock\n");
> >> +
> >> +	ret =3D clk_prepare_enable(pwm->clk);
> >> +	if (ret) {
> >> +		dev_err(dev, "clock enable failed\n");
> >> +		return ret;
> >
> > You can use dev_err_probe here, too, for consistency.
>=20
> Ok. Though in this case we will never get -EPROBE_DEFER from
> clk_prepare_enable, so dev_err_probe is not as useful.

Everything it does here is useful, and the overhead is only the check
against -EPROBE_DEFER. In return you get consistent error handling and
the messages are also all in the same format. (And compared to your
version the error message also gives a hint about the actual problem as
it emits the error code.)

> >> +static int xilinx_pwm_remove(struct platform_device *pdev)
> >> +{
> >> +	struct xilinx_pwm_device *pwm =3D platform_get_drvdata(pdev);
> >> +	bool enabled =3D xilinx_pwm_is_enabled(readl(pwm->regs + TCSR0),
> >> +					     readl(pwm->regs + TCSR1));
> >> +
> >> +	if (enabled)
> >> +		clk_rate_exclusive_put(pwm->clk);

Note that I misunderstood what clk_rate_exclusive_put does. This only
drops the lock on the clock that prevents that others modify the clock
rate. So that call is fine.

> > This looks wrong. You should rely on the consumer that they disable the
> > PWM.
>=20
> What about a PWM regulator with always-on?

So in general: What do you think should happen? When the remove function
is called the PWM regulator driver is already gone, so there is no way
to get the information that the PWM should stay on ...
=20
> >> +	clk_disable_unprepare(pwm->clk);

=2E.. and still you stop the PWM here (or does that only affect access to
its registers?)

So it's a delicate topic and there isn't the single right thing to do
here. So usually I request to free all resources allocated in .probe()
and otherwise leave the hardware alone. Now that I understood
clk_rate_exclusive_put() the status quo is fine for me. Just call
pwmchip_remove first and only then release the resources needed to
operate the PWM.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2z6f7s3waobdksi5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCRgUUACgkQwfwUeK3K
7AkQewf+Iy5tpEXhkQbtRxo6PdqBalrdTjEgXUrjnGoNujiGYX4Th4xNWhEhQKSP
cctHR1gMKLKySjJW6YSJ1Ml/jsP/u/ENR29eH63kUCNP6H7jzxNjYi83XIzxtcDG
+HT67ZgoVMu4S4oSZ2oM5QfpQcTzPr0AXIKRQICYf1Z7VFzB/UBScV5nnoJQqbs7
89mog9aOIHUq871YDdeUsR/e/03R1cqxKyUYernXq2CUPty/FllRvg7GAK8OtYDE
+p3C3vxY5pCiqT26Pd1glWzf3juMsEfGtT2X1U2lmqAikhgFBNz7REE8a0xWzN9B
D3DqMukQbJeRljBcb16BTFImn2o2+A==
=SLfk
-----END PGP SIGNATURE-----

--2z6f7s3waobdksi5--
