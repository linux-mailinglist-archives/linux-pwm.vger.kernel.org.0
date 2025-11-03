Return-Path: <linux-pwm+bounces-7581-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8C1C2CC12
	for <lists+linux-pwm@lfdr.de>; Mon, 03 Nov 2025 16:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31BF634A633
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Nov 2025 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D4231E102;
	Mon,  3 Nov 2025 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dR4lyfqy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5C7313E01;
	Mon,  3 Nov 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183566; cv=none; b=dK4nsklbqchLJvcxfsf/t8nIbbwaVvK3LPASeKj8zkFbNJAbhBF+ZS4pjUIufIZ/P9P960oDrjmiimM0m9zXWjKspMyAH3qzUFAgDc/RWyrcuGz6f8ZafO/rqEw/OMg/0kx9ZOETivp67t9x0nfwIBYhRI9BWZEr/fwmHfTXUHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183566; c=relaxed/simple;
	bh=vTEEqBvf4uzbZw74WdV2qWj7leVepYcRsHzgRilYAj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLEx0+qHjJ2B4oN+ks+koZ1nYfbfC0Ob3mgGP2CHqqPLYS/ipZg1/siN/CAb4+SVadmOo8hPzjxxxgL7HgA3BdUbEM4fw2tDXHOiVMdbPFaDPh7gTGrxG8EvR6N4PrV262YjwpVzTj/ziUZF7np3BjuUF4uQIeR07xT2u4APMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dR4lyfqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6021C4CEFD;
	Mon,  3 Nov 2025 15:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762183563;
	bh=vTEEqBvf4uzbZw74WdV2qWj7leVepYcRsHzgRilYAj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dR4lyfqyfIeJ3Ig5IPvfd8uQHC7OCGkNY5Ighzdr7vuELihzTMXwpe1J33wj3KKqF
	 yXmy51zxJLjI4GwonRG1NW5zAvQittC2tg3yCjRcZMgdiNt30fumnf97uLkEaLYA+4
	 r6swm9vdmo8l8qyKlx6b9m3eX9FfPDwKiTLK9JjVkvYookjhlcFEBfKoOVT0WsG9+p
	 82keLUNdicu7twpN0Qvj8BU2ViUhie01STXSh+ioYOCdTJddR+uVE8NIufhxzLUmM/
	 5GGmf0rKR9Akh31tWmPTVFX7fFXFURZ+UPi8gqlwg3/kVJsyQmz7JnBtqO5mhL3JQK
	 383L40wVejGiQ==
Date: Mon, 3 Nov 2025 15:25:56 +0000
From: Lee Jones <lee@kernel.org>
To: Johan Jonker <jbx6244@yandex.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	William Breathitt Gray <wbg@kernel.org>, kernel@collabora.com,
	Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
	linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/5] mfd: Add Rockchip mfpwm driver
Message-ID: <20251103152556.GB8064@google.com>
References: <20251027-rk3576-pwm-v3-0-654a5cb1e3f8@collabora.com>
 <20251027-rk3576-pwm-v3-2-654a5cb1e3f8@collabora.com>
 <16341fe2-7d2b-45a6-a861-93950c1bbd1f@yandex.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16341fe2-7d2b-45a6-a861-93950c1bbd1f@yandex.com>

On Tue, 28 Oct 2025, Johan Jonker wrote:

> 
> 
> On 10/27/25 18:11, Nicolas Frattaroli wrote:
> > With the Rockchip RK3576, the PWM IP used by Rockchip has changed
> > substantially. Looking at both the downstream pwm-rockchip driver as
> > well as the mainline pwm-rockchip driver made it clear that with all its
> > additional features and its differences from previous IP revisions, it
> > is best supported in a new driver.
> > 
> > This brings us to the question as to what such a new driver should be.
> > To me, it soon became clear that it should actually be several new
> > drivers, most prominently when Uwe Kleine-König let me know that I
> > should not implement the pwm subsystem's capture callback, but instead
> > write a counter driver for this functionality.
> > 
> > Combined with the other as-of-yet unimplemented functionality of this
> > new IP, it became apparent that it needs to be spread across several
> > subsystems.
> > 
> > For this reason, we add a new MFD core driver, called mfpwm (short for
> > "Multi-function PWM"). This "parent" driver makes sure that only one
> > device function driver is using the device at a time, and is in charge
> > of registering the MFD cell devices for the individual device functions
> > offered by the device.
> > 
> > An acquire/release pattern is used to guarantee that device function
> > drivers don't step on each other's toes.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  MAINTAINERS                        |   2 +
> >  drivers/mfd/Kconfig                |  15 ++
> >  drivers/mfd/Makefile               |   1 +
> >  drivers/mfd/rockchip-mfpwm.c       | 340 +++++++++++++++++++++++++++
> >  include/linux/mfd/rockchip-mfpwm.h | 454 +++++++++++++++++++++++++++++++++++++
> >  5 files changed, 812 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index baecabab35a2..8f3235ba825e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -22372,6 +22372,8 @@ L:	linux-rockchip@lists.infradead.org
> >  L:	linux-pwm@vger.kernel.org
> >  S:	Maintained
> 
> >  F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
> 
> A question not so much for Nicolas specific:
> The yaml documents already have a 'maintainers' entry.
> However MAINTAINERS is full yaml entries.
> Could someone explain why we still need dual registration?
> 
> maintainers:
>   - Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> > +F:	drivers/soc/rockchip/mfpwm.c
> > +F:	include/soc/rockchip/mfpwm.h
> 
> different file name and location?
> 
>   drivers/mfd/rockchip-mfpwm.c       | 340 +++++++++++++++++++++++++++
>   include/linux/mfd/rockchip-mfpwm.h | 454 +++++++++++++++++++++++++++++++++++++
> 
> 
> >  
> >  ROCKCHIP RK3568 RANDOM NUMBER GENERATOR SUPPORT
> >  M:	Daniel Golle <daniel@makrotopia.org>
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index dbeac6825a10..8b3a3160fbdf 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1367,6 +1367,21 @@ config MFD_RC5T583
> >  	  Additional drivers must be enabled in order to use the
> >  	  different functionality of the device.
> >  
> > +config MFD_ROCKCHIP_MFPWM
> > +	tristate "Rockchip multi-function PWM controller"
> > +	depends on OF
> > +	depends on HAS_IOMEM
> > +	depends on COMMON_CLK
> > +	select MFD_CORE
> > +	help
> > +	  Some Rockchip SoCs, such as the RK3576, use a PWM controller that has
> > +	  several different functions, such as generating PWM waveforms but also
> > +	  counting waveforms.
> > +
> > +	  This driver manages the overall device, and selects between different
> > +	  functionalities at runtime as needed. Drivers for them are implemented
> > +	  in their respective subsystems.
> > +
> >  config MFD_RK8XX
> >  	tristate
> >  	select MFD_CORE
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index e75e8045c28a..ebadbaea9e4a 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -231,6 +231,7 @@ obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
> >  obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
> >  obj-$(CONFIG_MFD_NTXEC)		+= ntxec.o
> >  obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
> > +obj-$(CONFIG_MFD_ROCKCHIP_MFPWM)	+= rockchip-mfpwm.o
> >  obj-$(CONFIG_MFD_RK8XX)		+= rk8xx-core.o
> >  obj-$(CONFIG_MFD_RK8XX_I2C)	+= rk8xx-i2c.o
> >  obj-$(CONFIG_MFD_RK8XX_SPI)	+= rk8xx-spi.o
> > diff --git a/drivers/mfd/rockchip-mfpwm.c b/drivers/mfd/rockchip-mfpwm.c
> > new file mode 100644
> > index 000000000000..08c2d8da41b7
> > --- /dev/null
> > +++ b/drivers/mfd/rockchip-mfpwm.c
> > @@ -0,0 +1,340 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2025 Collabora Ltd.
> > + *
> > + * A driver to manage all the different functionalities exposed by Rockchip's
> > + * PWMv4 hardware.
> > + *
> > + * This driver is chiefly focused on guaranteeing non-concurrent operation
> > + * between the different device functions, as well as setting the clocks.
> > + * It registers the device function platform devices, e.g. PWM output or
> > + * PWM capture.
> > + *
> > + * Authors:
> > + *     Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > + */
> > +
> > +#include <linux/array_size.h>
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/rockchip-mfpwm.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/overflow.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/spinlock.h>
> > +
> > +/**
> > + * struct rockchip_mfpwm - private mfpwm driver instance state struct
> > + * @pdev: pointer to this instance's &struct platform_device
> > + * @base: pointer to the memory mapped registers of this device
> > + * @pwm_clk: pointer to the PLL clock the PWM signal may be derived from
> > + * @osc_clk: pointer to the fixed crystal the PWM signal may be derived from
> > + * @rc_clk: pointer to the RC oscillator the PWM signal may be derived from
> > + * @chosen_clk: a clk-mux of pwm_clk, osc_clk and rc_clk
> > + * @pclk: pointer to the APB bus clock needed for mmio register access
> > + * @active_func: pointer to the currently active device function, or %NULL if no
> > + *               device function is currently actively using any of the shared
> > + *               resources. May only be checked/modified with @state_lock held.
> > + * @acquire_cnt: number of times @active_func has currently mfpwm_acquire()'d
> > + *               it. Must only be checked or modified while holding @state_lock.
> > + * @state_lock: this lock is held while either the active device function, the
> > + *              enable register, or the chosen clock is being changed.
> > + * @irq: the IRQ number of this device
> > + */
> > +struct rockchip_mfpwm {
> > +	struct platform_device *pdev;
> > +	void __iomem *base;
> > +	struct clk *pwm_clk;
> > +	struct clk *osc_clk;
> > +	struct clk *rc_clk;
> > +	struct clk *chosen_clk;
> > +	struct clk *pclk;
> > +	struct rockchip_mfpwm_func *active_func;
> > +	unsigned int acquire_cnt;
> > +	spinlock_t state_lock;
> > +	int irq;
> > +};
> > +
> > +static atomic_t subdev_id = ATOMIC_INIT(0);
> > +
> > +static inline struct rockchip_mfpwm *to_rockchip_mfpwm(struct platform_device *pdev)
> > +{
> > +	return platform_get_drvdata(pdev);
> > +}
> > +
> > +static int mfpwm_check_pwmf(const struct rockchip_mfpwm_func *pwmf,
> > +			    const char *fname)
> > +{
> > +	struct device *dev = &pwmf->parent->pdev->dev;
> > +
> > +	if (IS_ERR_OR_NULL(pwmf)) {
> > +		dev_warn(dev, "called %s with an erroneous handle, no effect\n",
> > +			 fname);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (IS_ERR_OR_NULL(pwmf->parent)) {
> > +		dev_warn(dev, "called %s with an erroneous mfpwm_func parent, no effect\n",
> > +			 fname);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +__attribute__((nonnull))
> > +static int mfpwm_do_acquire(struct rockchip_mfpwm_func *pwmf)
> > +{
> > +	struct rockchip_mfpwm *mfpwm = pwmf->parent;
> > +	unsigned int cnt;
> > +
> > +	if (mfpwm->active_func && pwmf->id != mfpwm->active_func->id)
> > +		return -EBUSY;
> > +
> > +	if (!mfpwm->active_func)
> > +		mfpwm->active_func = pwmf;
> > +
> > +	if (!check_add_overflow(mfpwm->acquire_cnt, 1, &cnt)) {
> > +		mfpwm->acquire_cnt = cnt;
> > +	} else {
> > +		dev_warn(&mfpwm->pdev->dev, "prevented acquire counter overflow in %s\n",
> > +			 __func__);
> > +		return -EOVERFLOW;
> > +	}
> > +
> > +	dev_dbg(&mfpwm->pdev->dev, "%d acquired mfpwm, acquires now at %u\n",
> > +		pwmf->id, mfpwm->acquire_cnt);
> > +
> > +	return clk_enable(mfpwm->pclk);
> > +}
> > +
> > +int mfpwm_acquire(struct rockchip_mfpwm_func *pwmf)
> > +{
> > +	struct rockchip_mfpwm *mfpwm;
> > +	unsigned long flags;
> > +	int ret = 0;
> > +
> > +	ret = mfpwm_check_pwmf(pwmf, "mfpwm_acquire");
> > +	if (ret)
> > +		return ret;
> > +
> > +	mfpwm = pwmf->parent;
> > +	dev_dbg(&mfpwm->pdev->dev, "%d is attempting to acquire\n", pwmf->id);
> > +
> > +	if (!spin_trylock_irqsave(&mfpwm->state_lock, flags))
> > +		return -EBUSY;
> > +
> > +	ret = mfpwm_do_acquire(pwmf);
> > +
> > +	spin_unlock_irqrestore(&mfpwm->state_lock, flags);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(mfpwm_acquire, "ROCKCHIP_MFPWM");
> > +
> > +__attribute__((nonnull))
> > +static void mfpwm_do_release(const struct rockchip_mfpwm_func *pwmf)
> > +{
> > +	struct rockchip_mfpwm *mfpwm = pwmf->parent;
> > +
> > +	if (!mfpwm->active_func)
> > +		return;
> > +
> > +	if (mfpwm->active_func->id != pwmf->id)
> > +		return;
> > +
> > +	/*
> > +	 * No need to check_sub_overflow here, !mfpwm->active_func above catches
> > +	 * this type of problem already.
> > +	 */
> > +	mfpwm->acquire_cnt--;
> > +
> > +	if (!mfpwm->acquire_cnt)
> > +		mfpwm->active_func = NULL;
> > +
> > +	clk_disable(mfpwm->pclk);
> > +}
> > +
> > +void mfpwm_release(const struct rockchip_mfpwm_func *pwmf)
> > +{
> > +	struct rockchip_mfpwm *mfpwm;
> > +	unsigned long flags;
> > +
> > +	if (mfpwm_check_pwmf(pwmf, "mfpwm_release"))
> > +		return;
> > +
> > +	mfpwm = pwmf->parent;
> > +
> > +	spin_lock_irqsave(&mfpwm->state_lock, flags);
> > +	mfpwm_do_release(pwmf);
> > +	dev_dbg(&mfpwm->pdev->dev, "%d released mfpwm, acquires now at %u\n",
> > +		pwmf->id, mfpwm->acquire_cnt);
> > +	spin_unlock_irqrestore(&mfpwm->state_lock, flags);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(mfpwm_release, "ROCKCHIP_MFPWM");
> > +
> > +/**
> > + * mfpwm_register_subdev - register a single mfpwm_func
> > + * @mfpwm: pointer to the parent &struct rockchip_mfpwm
> > + * @name: sub-device name string
> > + *
> > + * Allocate a single &struct mfpwm_func, fill its members with appropriate data,
> > + * and register a new mfd cell.
> > + *
> > + * Returns: 0 on success, negative errno on error
> > + */
> > +static int mfpwm_register_subdev(struct rockchip_mfpwm *mfpwm,
> > +				 const char *name)
> > +{
> > +	struct rockchip_mfpwm_func *func;
> > +	struct mfd_cell cell = {};
> > +
> > +	func = devm_kzalloc(&mfpwm->pdev->dev, sizeof(*func), GFP_KERNEL);
> > +	if (IS_ERR(func))
> > +		return PTR_ERR(func);
> > +	func->irq = mfpwm->irq;
> > +	func->parent = mfpwm;
> > +	func->id = atomic_inc_return(&subdev_id);
> > +	func->base = mfpwm->base;
> > +	func->core = mfpwm->chosen_clk;
> > +	cell.name = name;
> > +	cell.platform_data = func;
> > +	cell.pdata_size = sizeof(*func);
> > +	// cell.ignore_resource_conflicts = true;
> > +	// cell.resources = mfpwm->pdev->resource;
> > +	// cell.num_resources = mfpwm->pdev->num_resources;
> > +
> > +	return devm_mfd_add_devices(&mfpwm->pdev->dev, func->id, &cell, 1, NULL,
> > +				    0, NULL);
> > +}
> > +
> > +static int mfpwm_register_subdevs(struct rockchip_mfpwm *mfpwm)
> > +{
> > +	int ret;
> > +
> 
> > +	ret = mfpwm_register_subdev(mfpwm, "pwm-rockchip-v4");
> 
> Not sure who came up with this name?
> In case we need to filter wouldn't be easier to order it just like the bindings: manufacture '-' function

Please snip your replies in the future.

-- 
Lee Jones [李琼斯]

