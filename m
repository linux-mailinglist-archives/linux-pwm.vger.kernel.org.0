Return-Path: <linux-pwm+bounces-5322-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96491A7A160
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 12:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB1A174B4A
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 10:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ADA24BCF9;
	Thu,  3 Apr 2025 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU+mthn0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9B24BC08;
	Thu,  3 Apr 2025 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743677435; cv=none; b=RM9pBUVDGa+ejEGzZ9QVCOOTa8LmGuPE60JS88iD24BGcJHI778ZedPRMh840+jCMp5Da7vI97JujhNC4WpuvQZELXNybNfqp5UIRsxT9ovESgpQ7+IeruZl8gbhv4aianWLZe8cNqhgRyjj16VVLZykyAzFG+tka20YXTUxGnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743677435; c=relaxed/simple;
	bh=gDnfO8mflkucyzKGyk6orrLUhCiE3XQUcqEDlrU/dSI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEgnVQmjB5OO5b4ubN8PqimUAdnFbzzbNDnfum2M2sTbneM94EQEiqqoSG5RSskU0QoVCflnAjgr9VddmReltcaLsVX1Qtyu8Qg5oCDkpa4dFLiC0jN986VTrwsJweTZgnM/helAaT9jgj1FiTS5ccxPlhUZF3UXrJUiDLPVmqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fU+mthn0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so5864725e9.0;
        Thu, 03 Apr 2025 03:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743677431; x=1744282231; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lzrkUSkgfunAu5+4pmpReiZ/ei7BNySo6eO3c015EPc=;
        b=fU+mthn0r10Thr2QppO/nN6pvUrN3T2Xz+Aes4DPSIH10y1Bw0xtZ2y8rZZc6UoZ8S
         N/lGCsRlavSlQKxtv+aokQ5rnNP/sMyXNgjdK0p37eF8AxjkHYzljcmYYS0btClFXG+Q
         tlfk22k4JXFUWCPs10DSvEpqs13hUmKXs0QsG+Hu36oQlFRjyof8PQ45ORHbNcI7toby
         QhFT+nS4feo/07jVKXMNn1Of+KEHM/c6v8MDeulc3RzHVMz0F8/DFVCiBeRbQgLQ6b8w
         +LY5ptKAnFeJvvoDAfjBpXLsBCUVwuKDwF6GOX+RN65XpDoVxKqLnD9pj3kUKgt0gHVN
         m4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743677431; x=1744282231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzrkUSkgfunAu5+4pmpReiZ/ei7BNySo6eO3c015EPc=;
        b=TzGb70ip7nUYOCkGzyyokfPOcrdeuokqWhTCiXxA6fLfXbOHOvwYKejZ6eC3E0LIQm
         fe0EtCe6XB3g4PtFj/CttW1TOW/UWWJfOyDrGXpAUyP7KQx7t5uqCMrUqF2xvqfhVdap
         Y3MNzcJeSiMxnGd0mARGMG3Woe+iN+2x67kv3WZRMpL1FgtvUISvDiMcLrJy2/B4u8QQ
         cFb90niZ3zY8uGwCC7pOnHw4CAWjsBeJfmVakXvopHNAlSjLSSL2KGtBZn8J7vhQIBR4
         gSNNjBS6YxyNerzAVkRhN2pUKbP8sW1SbYL2udlW2z0KqiWmsh9JTyy6PXdNopWufBYB
         sCrg==
X-Forwarded-Encrypted: i=1; AJvYcCVE6bGJSuzYMk4Fb+TxtIwS0qnwoC1BhqNlvbJVCi8+OS3z0wYc7sxqSXyDUULh236sexr6ONoHVR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTsaPfTiZ51IlWc1+qNc4PIFmEYhabNVnUr0axVtZR+w2rZg+z
	hq8fhFT62+PQj9mDCRDMAmnrpJ+A6urN7F2NlaIhRCHokrUucJ4Fk+kjlg==
X-Gm-Gg: ASbGncvYLx97UibmrOG6g7hj+JVSYvQOELnB2A4HMocskg1ingHhrkeiQxwVSiLzpVD
	+2AVBe/MgOCREcf9HDEf45ybUL2CTamvmN1z/iEaV4a0vRJoNfPj5X+FjV7XrxPUWXZAZZyITpE
	y53nL8O67ieJ6G62dU3hdtw3NF7mU3ctniRkiKQCFsWAh9rpN7p6XmErJIhQmAVvHP+jR7wMx/l
	yw9tZXsuR9InXoSkaVHLksQKD/8b+dpL0Kv/rRU46MV4bmR3kfAzrJxWTIey6INiLmaVWV7qYP+
	S8MJymWE2KBYXYnvsFojL6/5GcXsH4+RnyAB5xntqnuRfjXR8XPruvDePlf3d9hAcJaEqKiNhvY
	+2jVn8KsHq48=
X-Google-Smtp-Source: AGHT+IFlGVMd2ZqJKetEl7ije0MHhSghHarKS98DpkE1/DXVe1RiUGvWan6yhRKB0GyJeLHKKxsilw==
X-Received: by 2002:a05:600c:154d:b0:43c:fbe2:df3c with SMTP id 5b1f17b1804b1-43ec14cd5bfmr16644155e9.26.1743677430294;
        Thu, 03 Apr 2025 03:50:30 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec16ba978sm18278335e9.23.2025.04.03.03.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 03:50:29 -0700 (PDT)
Message-ID: <67ee67f5.050a0220.38e02.5bc2@mx.google.com>
X-Google-Original-Message-ID: <Z-5n80n9s1VrqdTY@Ansuel-XPS.>
Date: Thu, 3 Apr 2025 12:50:27 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [RESEND PATCH v11] pwm: airoha: Add support for EN7581 SoC
References: <20250226002537.3752-1-ansuelsmth@gmail.com>
 <cdwttmqcvhetlf446gsaxsta76ojlqckxc253svho4xsm7qxhs@6otqm6yyuvfh>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdwttmqcvhetlf446gsaxsta76ojlqckxc253svho4xsm7qxhs@6otqm6yyuvfh>

On Thu, Apr 03, 2025 at 11:58:48AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Feb 26, 2025 at 01:24:42AM +0100, Christian Marangi wrote:
> > From: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > 
> > Introduce driver for PWM module available on EN7581 SoC.
> > 
> > Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v11:
> > - Fix wrong calculation of period and duty
> > - Use AIROHA_PWM prefix for each define
> > - Drop set/get special define in favour of BITS and GENMASK
> > - Correctly use dev_err_probe
> > - Init bucket with initial values
> > - Rework define to make use of FIELD_PREP and FIELD_GET
> > 
> > Changes in v10:
> > - repost just patch 6/6 (pwm driver) since patches {1/6-5/6} have been
> >   already applied in linux-pinctrl tree
> > - pwm: introduce AIROHA_PWM_FIELD_GET and AIROHA_PWM_FIELD_SET macros to
> >   get/set field with non-const mask
> > - pwm: simplify airoha_pwm_get_generator() to report unused generator
> >   and remove double lookup
> > - pwm: remove device_node pointer in airoha_pwm struct since this is
> >   write-only field
> > - pwm: cosmetics
> > - Link to v9: https://lore.kernel.org/r/20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org
> > 
> > Changes in v9:
> > - pwm: remove unused properties
> > - Link to v8: https://lore.kernel.org/r/20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org
> > 
> > Changes in v8:
> > - pwm: add missing properties documentation
> > - Link to v7: https://lore.kernel.org/r/20241016-en7581-pinctrl-v7-0-4ff611f263a7@kernel.org
> > 
> > Changes in v7:
> > - pinctrl: cosmetics
> > - pinctrl: fix compilation warning
> > - Link to v6: https://lore.kernel.org/r/20241013-en7581-pinctrl-v6-0-2048e2d099c2@kernel.org
> > 
> > Changes in v6:
> > - pwm: rely on regmap APIs
> > - pwm: introduce compatible string
> > - pinctrl: introduce compatible string
> > - remove airoha-mfd driver
> > - add airoha,en7581-pinctrl binding
> > - add airoha,en7581-pwm binding
> > - update airoha,en7581-gpio-sysctl binding
> > - Link to v5: https://lore.kernel.org/r/20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org
> > 
> > Changes in v5:
> > - use spin_lock in airoha_pinctrl_rmw instead of a mutex since it can run
> >   in interrupt context
> > - remove unused includes in pinctrl driver
> > - since the irq_chip is immutable, allocate the gpio_irq_chip struct
> >   statically in pinctrl driver
> > - rely on regmap APIs in pinctrl driver but keep the spin_lock local to the
> >   driver
> > - rely on guard/guard_scope APIs in pinctrl driver
> > - improve naming convention pinctrl driver
> > - introduce airoha_pinconf_set_pin_value utility routine
> > - Link to v4: https://lore.kernel.org/r/20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org
> > 
> > Changes in v4:
> > - add 'Limitation' description in pwm driver
> > - fix comments in pwm driver
> > - rely on mfd->base __iomem pointer in pwm driver, modify register
> >   offsets according to it and get rid of sgpio_cfg, flash_cfg and
> >   cycle_cfg pointers
> > - simplify register utility routines in pwm driver
> > - use 'generator' instead of 'waveform' suffix for pwm routines
> > - fix possible overflow calculating duty cycle in pwm driver
> > - do not modify pwm state in free callback in pwm driver
> > - cap the maximum period in pwm driver
> > - do not allow inverse polarity in pwm driver
> > - do not set of_xlate callback in the pwm driver and allow the stack to
> >   do it
> > - fix MAINTAINERS file for airoha pinctrl driver
> > - fix undefined reference to __ffsdi2 in pinctrl driver
> > - simplify airoha,en7581-gpio-sysctl.yam binding
> > - Link to v3: https://lore.kernel.org/r/20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org
> > 
> > Changes in v3:
> > - introduce airoha-mfd driver
> > - add pwm driver to the same series
> > - model pinctrl and pwm drivers as childs of a parent mfd driver.
> > - access chip-scu memory region in pinctrl driver via syscon
> > - introduce a single airoha,en7581-gpio-sysctl.yaml binding and get rid
> >   of dedicated bindings for pinctrl and pwm
> > - add airoha,en7581-chip-scu.yaml binding do the series
> > - Link to v2: https://lore.kernel.org/r/20240822-en7581-pinctrl-v2-0-ba1559173a7f@kernel.org
> > 
> > Changes in v2:
> > - Fix compilation errors
> > - Collapse some register mappings for gpio and irq controllers
> > - update dt-bindings according to new register mapping
> > - fix some dt-bindings errors
> > - Link to v1: https://lore.kernel.org/all/cover.1723392444.git.lorenzo@kernel.org/
> > 
> >  drivers/pwm/Kconfig      |  11 +
> >  drivers/pwm/Makefile     |   1 +
> >  drivers/pwm/pwm-airoha.c | 488 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 500 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-airoha.c
> > 
> > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > index 63beb0010e3e..e939187784c0 100644
> > --- a/drivers/pwm/Kconfig
> > +++ b/drivers/pwm/Kconfig
> > @@ -54,6 +54,17 @@ config PWM_ADP5585
> >  	  This option enables support for the PWM function found in the Analog
> >  	  Devices ADP5585.
> >  
> > +config PWM_AIROHA
> > +	tristate "Airoha PWM support"
> > +	depends on ARCH_AIROHA || COMPILE_TEST
> > +	depends on OF
> > +	select REGMAP_MMIO
> > +	help
> > +	  Generic PWM framework driver for Airoha SoC.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called pwm-airoha.
> > +
> >  config PWM_APPLE
> >  	tristate "Apple SoC PWM support"
> >  	depends on ARCH_APPLE || COMPILE_TEST
> > diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> > index 539e0def3f82..97c1c79bbc54 100644
> > --- a/drivers/pwm/Makefile
> > +++ b/drivers/pwm/Makefile
> > @@ -2,6 +2,7 @@
> >  obj-$(CONFIG_PWM)		+= core.o
> >  obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
> >  obj-$(CONFIG_PWM_ADP5585)	+= pwm-adp5585.o
> > +obj-$(CONFIG_PWM_AIROHA)	+= pwm-airoha.o
> >  obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
> >  obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
> >  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
> > diff --git a/drivers/pwm/pwm-airoha.c b/drivers/pwm/pwm-airoha.c
> > new file mode 100644
> > index 000000000000..51d02a5ff064
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-airoha.c
> > @@ -0,0 +1,488 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2022 Markus Gothe <markus.gothe@genexis.eu>
> > + *
> > + *  Limitations:
> > + *  - Only 8 concurrent waveform generators are available for 8 combinations of
> > + *    duty_cycle and period. Waveform generators are shared between 16 GPIO
> > + *    pins and 17 SIPO GPIO pins.
> > + *  - Supports only normal polarity.
> > + *  - On configuration the currently running period is completed.
> > + *  - Minimum supported period is 4ms
> > + *  - Maximum supported period is 1s
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pwm.h>
> > +#include <linux/gpio.h>
> > +#include <linux/bitops.h>
> > +#include <linux/regmap.h>
> > +#include <asm/div64.h>
> > +
> > +#define AIROHA_PWM_REG_SGPIO_LED_DATA		0x0024
> > +#define AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG	BIT(31)
> > +#define AIROHA_PWM_SGPIO_LED_DATA_DATA		GENMASK(16, 0)
> > +
> > +#define AIROHA_PWM_REG_SGPIO_CLK_DIVR		0x0028
> > +#define AIROHA_PWM_SGPIO_CLK_DIVR		GENMASK(1, 0)
> > +
> > +#define AIROHA_PWM_REG_SGPIO_CLK_DLY		0x002c
> > +
> > +#define AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG	0x0030
> > +#define AIROHA_PWM_SERIAL_GPIO_FLASH_MODE	BIT(1)
> > +#define AIROHA_PWM_SERIAL_GPIO_MODE_74HC164	BIT(0)
> > +
> > +#define AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(_n)	(0x003c + (4 * (_n)))
> > +#define AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(_n) (16 * (_n))
> > +#define AIROHA_PWM_GPIO_FLASH_PRD_LOW		GENMASK(15, 8)
> > +#define AIROHA_PWM_GPIO_FLASH_PRD_HIGH		GENMASK(7, 0)
> > +
> > +#define AIROHA_PWM_REG_GPIO_FLASH_MAP(_n)	(0x004c + (4 * (_n)))
> > +#define AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(_n) (4 * (_n))
> > +#define AIROHA_PWM_GPIO_FLASH_EN		BIT(3)
> > +#define AIROHA_PWM_GPIO_FLASH_SET_ID		GENMASK(2, 0)
> > +
> > +/* Register map is equal to GPIO flash map */
> > +#define AIROHA_PWM_REG_SIPO_FLASH_MAP(_n)	(0x0054 + (4 * (_n)))
> > +
> > +#define AIROHA_PWM_REG_CYCLE_CFG_VALUE(_n)	(0x0098 + (4 * (_n)))
> > +#define AIROHA_PWM_REG_CYCLE_CFG_SHIFT(_n)	(8 * (_n))
> > +#define AIROHA_PWM_WAVE_GEN_CYCLE		GENMASK(7, 0)
> > +
> > +/* GPIO/SIPO flash map handles 8 pins in one register */
> > +#define AIROHA_PWM_PINS_PER_FLASH_MAP		8
> > +/* Cycle cfg handles 4 generators in one register */
> > +#define AIROHA_PWM_BUCKET_PER_CYCLE_CFG		4
> > +/* Flash producer handles 2 generators in one register */
> > +#define AIROHA_PWM_BUCKET_PER_FLASH_PROD	2
> > +
> > +#define AIROHA_PWM_NUM_BUCKETS			8
> > +/*
> > + * The first 16 GPIO pins, GPIO0-GPIO15, are mapped into 16 PWM channels, 0-15.
> > + * The SIPO GPIO pins are 17 pins which are mapped into 17 PWM channels, 16-32.
> > + * However, we've only got 8 concurrent waveform generators and can therefore
> > + * only use up to 8 different combinations of duty cycle and period at a time.
> > + */
> > +#define AIROHA_PWM_NUM_GPIO			16
> > +#define AIROHA_PWM_NUM_SIPO			17
> > +#define AIROHA_PWM_MAX_CHANNELS			(AIROHA_PWM_NUM_GPIO + AIROHA_PWM_NUM_SIPO)
> > +
> > +struct airoha_pwm_bucket {
> > +	/* Bitmask of PWM channels using this bucket */
> > +	u64 used;
> > +	u64 period_ns;
> > +	u64 duty_ns;
> > +};
> > +
> > +struct airoha_pwm {
> > +	struct regmap *regmap;
> > +
> > +	u64 initialized;
> > +
> > +	struct airoha_pwm_bucket buckets[AIROHA_PWM_NUM_BUCKETS];
> > +
> > +	/* Cache bucket used by each pwm channel */
> > +	u8 channel_bucket[AIROHA_PWM_MAX_CHANNELS];
> > +};
> > +
> > +/* The PWM hardware supports periods between 4 ms and 1 s */
> > +#define AIROHA_PWM_PERIOD_TICK_NS	(4 * NSEC_PER_MSEC)
> > +#define AIROHA_PWM_PERIOD_MAX_NS	(1 * NSEC_PER_SEC)
> > +/* It is represented internally as 1/250 s between 1 and 250. Unit is ticks. */
> > +#define AIROHA_PWM_PERIOD_MIN		1
> > +#define AIROHA_PWM_PERIOD_MAX		250
> > +/* Duty cycle is relative with 255 corresponding to 100% */
> > +#define AIROHA_PWM_DUTY_FULL		255
> 
> Just for my understanding: So the input clock runs at a multiple of
> 63750 Hz.
>

It should yes, but I need to confirm this.

> > +static void airoha_pwm_get_flash_map_addr_and_shift(unsigned int hwpwm,
> > +						    u32 *addr, u32 *shift)
> > +{
> > +	u64 offset = hwpwm;
> 
> unsigned int should be big enough here. This also makes the divisions a
> tad cheaper.
> 
> > +
> > +	if (hwpwm >= AIROHA_PWM_NUM_GPIO)
> > +		offset -= AIROHA_PWM_NUM_GPIO;
> > +
> > +	/* One FLASH_MAP register handles 8 pins */
> > +	*shift = do_div(offset, AIROHA_PWM_PINS_PER_FLASH_MAP);
> > +	*shift = AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(*shift);
> > +
> > +	if (offset < AIROHA_PWM_NUM_GPIO)
> > +		*addr = AIROHA_PWM_REG_GPIO_FLASH_MAP(offset);
> > +	else
> > +		*addr = AIROHA_PWM_REG_SIPO_FLASH_MAP(offset);
> 
> A single if would be a bit more straight forward. Something like:
> 
> 	static void airoha_pwm_get_flash_map_addr_and_shift(unsigned int hwpwm,
> 							    unsigned int *addr, unsigned int *shift)
> 	{
> 		u64 offset = hwpwm;
> 	
> 		if (hwpwm >= AIROHA_PWM_NUM_GPIO) {
> 			unsigned sipohwpwm = hwpwm - AIROHA_PWM_NUM_GPIO;
> 
> 			*shift = AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(sipohwpwm % AIROHA_PWM_PINS_PER_FLASH_MAP)
> 			*addr = AIROHA_PWM_REG_SIPO_FLASH_MAP(sipohwpwm);
> 		} else {
> 			*shift = AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(hwpwm % AIROHA_PWM_PINS_PER_FLASH_MAP)
> 			*addr = AIROHA_PWM_REG_GPIO_FLASH_MAP(hwpwm);
> 		}
> 	}
> 

I think you missed the do_div that do side effect on offset. Also that
needs to be / AIROHA_PWM_PINS_PER_FLASH_MAP.

To make it more readable I will duplicate the code for the 2 block.

> > +}
> > +
> > +static void airoha_pwm_get_ticks_from_ns(u64 period_ns, u32 *period_tick,
> > +					 u64 duty_ns, u32 *duty_tick)
> > +{
> > +	period_ns = min_t(u64, period_ns, AIROHA_PWM_PERIOD_MAX_NS);
> > +	*period_tick = div_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> > +
> > +	*duty_tick = mul_u64_u64_div_u64(duty_ns, AIROHA_PWM_DUTY_FULL,
> > +					 *period_tick * AIROHA_PWM_PERIOD_TICK_NS);
> > +	*duty_tick = min_t(u32, *duty_tick, AIROHA_PWM_DUTY_FULL);
> > +}
> > +
> > +static void airoha_pwm_fill_bucket(struct airoha_pwm *pc, int bucket)
> > +{
> > +	u64 offset, period_ns, duty_ns;
> > +	u32 period_tick, duty_tick;
> > +	u32 shift, val;
> > +
> > +	offset = bucket;
> > +	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_CYCLE_CFG);
> > +	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
> > +
> > +	regmap_read(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset), &val);
> > +
> > +	period_tick = FIELD_GET(AIROHA_PWM_WAVE_GEN_CYCLE, val >> shift);
> > +	period_ns = period_tick * AIROHA_PWM_PERIOD_TICK_NS;
> > +
> > +	offset = bucket;
> > +	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
> > +	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
> > +
> > +	regmap_read(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> > +		    &val);
> > +
> > +	duty_tick = FIELD_GET(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, val >> shift);
> > +	duty_ns = mul_u64_u64_div_u64(duty_tick, period_ns, AIROHA_PWM_DUTY_FULL);
> > +
> > +	pc->buckets[bucket].period_ns = period_ns;
> > +	pc->buckets[bucket].duty_ns = duty_ns;
> > +}
> > +
> > +static int airoha_pwm_get_generator(struct airoha_pwm *pc, u64 duty_ns,
> > +				    u64 period_ns)
> > +{
> > +	int i, unused = -1;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(pc->buckets); i++) {
> > +		struct airoha_pwm_bucket *bucket = &pc->buckets[i];
> > +		u32 duty_tick, duty_tick_bucket;
> > +		u32 period_tick;
> > +
> > +		/* If found, save an unused bucket to return it later */
> > +		if (!bucket->used && unused == -1) {
> > +			unused = i;
> > +			continue;
> > +		}
> > +
> > +		if (duty_ns == bucket->duty_ns &&
> > +		    period_ns == bucket->period_ns)
> > +			return i;
> 
> If period_ns == 4010 and bucket->period_ns == 4000 you're not
> considering *bucket even though it has the right period setting.
> (period_ns is the requested period and not the expected period actually
> implemented by HW, right?)
> 

Doesn't that requires a different generator? The value we store in the
bucket is the requested period yes.

> > +		/*
> > +		 * Unlike duty cycle zero, which can be handled by
> > +		 * disabling PWM, a generator is needed for full duty
> > +		 * cycle but it can be reused regardless of period
> > +		 */
> > +		airoha_pwm_get_ticks_from_ns(period_ns, &period_tick,
> > +					     duty_ns, &duty_tick);
> > +		airoha_pwm_get_ticks_from_ns(bucket->period_ns, &period_tick,
> > +					     bucket->duty_ns, &duty_tick_bucket);
> > +		if (duty_tick == AIROHA_PWM_DUTY_FULL &&
> > +		    duty_tick == duty_tick_bucket)
> > +			return i;
> > +	}
> > +
> > +	return unused;
> > +}
> > +
> > +static void airoha_pwm_release_bucket_config(struct airoha_pwm *pc,
> > +					     unsigned int hwpwm)
> > +{
> > +	int bucket;
> > +
> > +	/* Nothing to clear, PWM channel never used */
> > +	if (!(pc->initialized & BIT_ULL(hwpwm)))
> > +		return;
> > +
> > +	bucket = pc->channel_bucket[hwpwm];
> > +	pc->buckets[bucket].used &= ~BIT_ULL(hwpwm);
> > +}
> > +
> > +static int airoha_pwm_consume_generator(struct airoha_pwm *pc,
> > +					u64 duty_ns, u64 period_ns,
> > +					unsigned int hwpwm)
> > +{
> > +	int bucket;
> > +
> > +	/*
> > +	 * Search for a bucket that already satisfy duty and period
> > +	 * or an unused one.
> > +	 * If not found, -1 is returned.
> > +	 */
> > +	bucket = airoha_pwm_get_generator(pc, duty_ns, period_ns);
> > +	if (bucket < 0)
> > +		return bucket;
> > +
> > +	airoha_pwm_release_bucket_config(pc, hwpwm);
> > +	pc->buckets[bucket].used |= BIT_ULL(hwpwm);
> > +	pc->buckets[bucket].period_ns = period_ns;
> > +	pc->buckets[bucket].duty_ns = duty_ns;
> > +
> > +	return bucket;
> > +}
> > +
> > +static int airoha_pwm_sipo_init(struct airoha_pwm *pc)
> > +{
> > +	u32 val;
> > +
> > +	if (!(pc->initialized >> AIROHA_PWM_NUM_GPIO))
> > +		return 0;
> > +
> > +	regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> > +			  AIROHA_PWM_SERIAL_GPIO_MODE_74HC164);
> > +
> > +	/* Configure shift register timings, use 32x divisor */
> > +	regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DIVR,
> > +		     FIELD_PREP(AIROHA_PWM_SGPIO_CLK_DIVR, 0x3));
> > +
> > +	/*
> > +	 * The actual delay is clock + 1.
> > +	 * Notice that clock delay should not be greater
> > +	 * than (divisor / 2) - 1.
> > +	 * Set to 0 by default. (aka 1)
> > +	 */
> > +	regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DLY, 0x0);
> > +
> > +	/*
> > +	 * It it necessary to after muxing explicitly shift out all
> > +	 * zeroes to initialize the shift register before enabling PWM
> > +	 * mode because in PWM mode SIPO will not start shifting until
> > +	 * it needs to output a non-zero value (bit 31 of led_data
> > +	 * indicates shifting in progress and it must return to zero
> > +	 * before led_data can be written or PWM mode can be set)
> > +	 */
> > +	if (regmap_read_poll_timeout(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA, val,
> > +				     !(val & AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG),
> > +				     10, 200 * USEC_PER_MSEC))
> > +		return -ETIMEDOUT;
> > +
> > +	regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA,
> > +			  AIROHA_PWM_SGPIO_LED_DATA_DATA);
> > +	if (regmap_read_poll_timeout(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA, val,
> > +				     !(val & AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG),
> > +				     10, 200 * USEC_PER_MSEC))
> > +		return -ETIMEDOUT;
> > +
> > +	/* Set SIPO in PWM mode */
> > +	regmap_set_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> > +			AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);
> > +
> > +	return 0;
> > +}
> > +
> > +static void airoha_pwm_calc_bucket_config(struct airoha_pwm *pc, int bucket,
> > +					  u64 duty_ns, u64 period_ns)
> > +{
> > +	u32 period_tick, duty_tick;
> > +	u32 mask, shift, val;
> > +	u64 offset;
> > +
> > +	airoha_pwm_get_ticks_from_ns(period_ns, &period_tick,
> > +				     duty_ns, &duty_tick);
> > +
> > +	offset = bucket;
> > +	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_CYCLE_CFG);
> > +	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
> > +
> > +	/* Configure frequency divisor */
> > +	mask = AIROHA_PWM_WAVE_GEN_CYCLE << shift;
> > +	val = FIELD_PREP(AIROHA_PWM_WAVE_GEN_CYCLE, period_tick) << shift;
> > +	regmap_update_bits(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset), mask, val);
> > +
> > +	offset = bucket;
> > +	shift = do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
> > +	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
> > +
> > +	/* Configure duty cycle */
> > +	mask = AIROHA_PWM_GPIO_FLASH_PRD_HIGH << shift;
> > +	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, duty_tick) << shift;
> > +	regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> > +			   mask, val);
> > +
> > +	mask = AIROHA_PWM_GPIO_FLASH_PRD_LOW << shift;
> > +	val = FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_LOW,
> > +			 AIROHA_PWM_DUTY_FULL - duty_tick) << shift;
> > +	regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> > +			   mask, val);
> > +}
> > +
> > +static void airoha_pwm_config_flash_map(struct airoha_pwm *pc,
> > +					unsigned int hwpwm, int index)
> > +{
> > +	u32 addr, shift;
> > +
> > +	airoha_pwm_get_flash_map_addr_and_shift(hwpwm, &addr, &shift);
> > +
> > +	/* index -1 means disable PWM channel */
> > +	if (index < 0) {
> > +		/*
> > +		 * Change of waveform takes effect immediately but
> > +		 * disabling has some delay so to prevent glitching
> > +		 * only the enable bit is touched when disabling.
> > +		 * Duty cycle can't be set to 0 as it might be shared with
> > +		 * others channels with same duty cycle.
> 
> clearing enable changes the output to low anyhow, so there would be no
> gain in explicitly setting the duty to 0?
> 

I probably need to rework this comment, this is what we already do, for
PWM disable, we disable the LED and release the bucket, we don't setup
the duty cycle to 0.

> > +		 */
> > +		regmap_clear_bits(pc->regmap, addr,
> 
> regmap_clear_bits expects an unsigned int as 2nd parameter, so maybe use
> this type for addr.
> 
> > +				  AIROHA_PWM_GPIO_FLASH_EN << shift);
> > +		return;
> > +	}
> > +
> > +	regmap_update_bits(pc->regmap, addr,
> > +			   AIROHA_PWM_GPIO_FLASH_SET_ID << shift,
> > +			   FIELD_PREP(AIROHA_PWM_GPIO_FLASH_SET_ID, index) << shift);
> 
> Huh, I'd prefer:
> 
> 	regmap_update_bits(pc->regmap, addr,
> 			   AIROHA_PWM_GPIO_FLASH_SET_ID(hwpwm % 8)
> 			   FIELD_PREP(AIROHA_PWM_GPIO_FLASH_SET_ID(hwpwm % 8), index));
> 
> (That probably doesn't work out of the box because of the
> __builtin_constant_p check on mask, so you might need a local
> alternative to FIELD_PREP without that check.)
> 

Honestly it's not worth to introduce custom FIELD_PREP for this. Yes the
problem is that FIELD_PREP requires constant mask so hwpwm % 8 is
problematic. An old implementation had stuff in define but resulted in
very ugly and confusing define and macro. The shift and FIELD_PREP
permits a much cleaner description in the define part at the cost of
that additional << shift needed.

Hope you can understand why I think it's better to keep it this way.

> > +	regmap_set_bits(pc->regmap, addr, AIROHA_PWM_GPIO_FLASH_EN << shift);
> > +}
> > +
> > +static int airoha_pwm_config(struct airoha_pwm *pc, struct pwm_device *pwm,
> > +			     u64 duty_ns, u64 period_ns)
> > +{
> > +	int bucket, hwpwm = pwm->hwpwm;
> 
> hwpwm is unsigned.
> 
> > +	bucket = airoha_pwm_consume_generator(pc, duty_ns, period_ns,
> > +					      hwpwm);
> > +	if (bucket < 0)
> > +		return -EBUSY;
> > +
> > +	/*
> > +	 * For SIPO reinit is always needed to trigger the shift register chip
> > +	 * and apply the new flash configuration.
> 
> I don't understand that sentence. What is the shift register chip? What
> is a flash configuration?
> 

The SoC can have attached a shift register chip to supports multiple LEDs.
The handling of this chip and comunication is done internally to the SoC
and it's exposed to register with these additional register.

When such channel are used with an assumed shift register, to apply the
new configuration in airoha_pwm_config_flash_map(), the shift register
chip needs to be reinit to actually refresh the chip internal register
with the new "flash configuration" (aka the values for
AIROHA_PWM_GPIO_FLASH_SET_ID)

Will add more comments to this to make it more clear.

> > +	 */
> > +	if (!(pc->initialized & BIT_ULL(hwpwm)) && hwpwm >= AIROHA_PWM_NUM_GPIO)
> > +		airoha_pwm_sipo_init(pc);
> 
> The comment says "always", but here you skip if pc->initialized has the
> respective bit cleared?
> 

Yes because the channel gets disabled by the SoC so we don't care to
refresh the internal configuration of the shift register. The reinit is
needed only on configuring the ID.

> > +	airoha_pwm_calc_bucket_config(pc, bucket, duty_ns, period_ns);
> > +	airoha_pwm_config_flash_map(pc, hwpwm, bucket);
> > +
> > +	pc->initialized |= BIT_ULL(hwpwm);
> > +	pc->channel_bucket[hwpwm] = bucket;
> > +
> > +	return 0;
> > +}
> > +
> > +static void airoha_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> > +{
> > +	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
> > +
> > +	/* Disable PWM and release the bucket */
> > +	airoha_pwm_config_flash_map(pc, pwm->hwpwm, -1);
> > +	airoha_pwm_release_bucket_config(pc, pwm->hwpwm);
> > +	pc->initialized &= ~BIT_ULL(pwm->hwpwm);
> > +	if (!(pc->initialized >> AIROHA_PWM_NUM_GPIO))
> > +		regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> > +				  AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);
> 
> What is the objective of the if block? (-> comment)
> 

no Serial GPIO used so we disable the shift register PWM mode. Will add
comments.

> > +}
> > +
> > +static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			    const struct pwm_state *state)
> > +{
> > +	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
> > +	u64 period_ns = state->period;
> > +
> > +	/* Only normal polarity is supported */
> > +	if (state->polarity == PWM_POLARITY_INVERSED)
> > +		return -EINVAL;
> > +
> > +	if (!state->enabled) {
> > +		airoha_pwm_disable(chip, pwm);
> 
> Maybe pass pc instead of chip here to not have to call
> pwmchip_get_drvdata() again. (Alternatively introduce a wrapper around
> pwmchip_get_drvdata() that is marked __pure and returns the right type.)
> 
> > +		return 0;
> > +	}
> > +
> > +	if (period_ns < AIROHA_PWM_PERIOD_TICK_NS)
> > +		return -EINVAL;
> > +
> > +	return airoha_pwm_config(pc, pwm, state->duty_cycle, period_ns);
> > +}
> > +
> > +static int airoha_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > +				struct pwm_state *state)
> > +{
> > +	struct airoha_pwm *pc = pwmchip_get_drvdata(chip);
> > +	int ret, hwpwm = pwm->hwpwm;
> > +	u32 addr, shift, val;
> > +	u8 bucket;
> > +
> > +	airoha_pwm_get_flash_map_addr_and_shift(hwpwm, &addr, &shift);
> > +
> > +	ret = regmap_read(pc->regmap, addr, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	state->enabled = FIELD_GET(AIROHA_PWM_GPIO_FLASH_EN, val >> shift);
> > +	if (!state->enabled)
> > +		return 0;
> > +
> > +	state->polarity = PWM_POLARITY_NORMAL;
> > +
> > +	bucket = FIELD_GET(AIROHA_PWM_GPIO_FLASH_SET_ID, val >> shift);
> > +	state->period = pc->buckets[bucket].period_ns;
> 
> Does .period_ns hold the requested or the actual period? You should
> return the latter.
> 

Problem is that putting .period_ns here cause error in the PWM_DEBUG
validations. This is caused by the conversion error of the various / and
* done to convert tick to ns. Also on applying the configuration we
already do all the validation to make sure the request value is the
expected one.

For the initial values, there is airoha_pwm_fill_bucket that read the
current PWM values at boot and fill the buckets with the current values.

This is the compromise I found to handle both pre-configured bucket and
also handle the division errors in the ns - tick conversion.

Hope this is acceptable, do you have hint on better handling this?

> > +	state->duty_cycle = pc->buckets[bucket].duty_ns;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct pwm_ops airoha_pwm_ops = {
> > +	.apply = airoha_pwm_apply,
> > +	.get_state = airoha_pwm_get_state,
> > +};
> > +
> > +static int airoha_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct airoha_pwm *pc;
> > +	struct pwm_chip *chip;
> > +	int i, ret;
> > +
> > +	chip = devm_pwmchip_alloc(dev, AIROHA_PWM_MAX_CHANNELS, sizeof(*pc));
> > +	if (IS_ERR(chip))
> > +		return PTR_ERR(chip);
> > +
> > +	chip->ops = &airoha_pwm_ops;
> > +	pc = pwmchip_get_drvdata(chip);
> > +
> > +	pc->regmap = device_node_to_regmap(dev->parent->of_node);
> > +	if (IS_ERR(pc->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(pc->regmap), "Failed to get PWM regmap\n");
> > +
> > +	/* Fill buckets with initial values */
> > +	for (i = 0; i < AIROHA_PWM_NUM_BUCKETS; i++)
> > +		airoha_pwm_fill_bucket(pc, i);
> > +
> > +	ret = devm_pwmchip_add(&pdev->dev, chip);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id airoha_pwm_of_match[] = {
> > +	{ .compatible = "airoha,en7581-pwm" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, airoha_pwm_of_match);
> > +
> > +static struct platform_driver airoha_pwm_driver = {
> > +	.driver = {
> > +		.name = "pwm-airoha",
> > +		.of_match_table = airoha_pwm_of_match,
> > +	},
> > +	.probe = airoha_pwm_probe,
> > +};
> > +module_platform_driver(airoha_pwm_driver);
> > +
> > +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
> > +MODULE_AUTHOR("Markus Gothe <markus.gothe@genexis.eu>");
> > +MODULE_AUTHOR("Benjamin Larsson <benjamin.larsson@genexis.eu>");
> > +MODULE_DESCRIPTION("Airoha EN7581 PWM driver");
> > +MODULE_LICENSE("GPL");
> 
> Best regards
> Uwe



-- 
	Ansuel

