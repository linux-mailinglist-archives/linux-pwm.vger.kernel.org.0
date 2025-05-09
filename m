Return-Path: <linux-pwm+bounces-5878-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D56CAB1448
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 15:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B981B60B7C
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 13:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7293A29114C;
	Fri,  9 May 2025 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSynghda"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03AB28EA45;
	Fri,  9 May 2025 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795813; cv=none; b=nfjmHoIYaAff4+9TfaS0Gn7YStROtKcpDFjbEoOcT71uiCtM2+UDD/j0YgDcN0ZoDrnwkW2mmgSsBf8vl95WtvBthNoSfbE0/MgfCrJ09M5cEuMZZ7z0/Ocdhw2XuePRZJy38qUsz6b9E8fjDuyGR36744ZDdZf7+/1hlXYoh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795813; c=relaxed/simple;
	bh=80tz8rS/ukLQ8KhX/Bd8FTzHCq4SXnXteiNRLf7Z6bw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJeIysQd3TkvJ9R2G9bBhhTeJjpgijCbuezn4qQQCr2PJPxn/xSXb0W+yhjrYkLRHy1d5R1Y7IM6cdc5ltkKxsXLHkJ4/rSFnwdsnEgczcSgfBNjhclTUA2mA6i8JCdO6s3nsJqiiEu9KHOT0JwuBCKpNktvoONAi7GCEmkjaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSynghda; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad21a5466f6so168237366b.1;
        Fri, 09 May 2025 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746795808; x=1747400608; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QslNC+4tHpuANNSSdnNQaJCyZxinPDQUmHit+tckPos=;
        b=WSynghda2b6kdKYgr7/ZGtGTQqliwtiAqmxfqZ/yOnhTXZSaoWQ7PifRQSsAgAEF+/
         0DbtLUprGHCkzZUtrVbBTAGJfAekLnkXb9WPKy4vAeu1FYYmiYC+6vDjE0cGY4NaFlVt
         MijFvGrv8e5nCc9FRmXXWeQMXqy4O8b4JjXjfgWuVcAYQ2nxDPwy+2VD1zZuwJTLFMI+
         6ZDa3LOa0/6jx67JsdyqNo3ISrT9216JV5BOxdSLTIMwdlFVxcwVQ7RJ/cxTO4u7zZjH
         lhUUr6c6T/OzLhS3RBUp3Np0B+uzcXBGfiHLjhRNutNOQhIxcb3jaOkzanrZT8l+b9h3
         rAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746795808; x=1747400608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QslNC+4tHpuANNSSdnNQaJCyZxinPDQUmHit+tckPos=;
        b=fYXNxsuWHETdkb1HEcJ4D5CfmzlUipUD6xN6kTyBhIWMRPOg+G2RqcndfoNPCc0YEn
         WNFUj2S1rO4PNTiIWTim4/fA0Eguv8Ti0AlgpOCRpX+yhIS2CXYA+mnQnFD/X180Q/qx
         z4tuJzpq6VYghSb24vdUeWxeIV/edr/QZdE1YznZ9lerg1LwX0IgxnbaUavrOx4PfuPX
         rw6su0yLPj6nlNBFy+TZzA+6yQ/0dA9aW35lKVfG6u/wwVuhxDWh4vAKX40E4VAqEG37
         O82+LiEYawKpT1cNtnfnNWm17OxFZVhBhOe0oUhbPIRpZkHPnbDlT1Fwz9vD5wSOgy/y
         wEBw==
X-Forwarded-Encrypted: i=1; AJvYcCXu9aEw16EKvzxhK20q4pRwvW0trSNXJiLG9WXmfUXIipYdQnvXOl3mjRs6CJrgWT6NMa6hBm7sJPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGiqttWqcQ6/rfTIpFu7/WH0udqfghaKIIjEW+ZaAt5/Zvlyg1
	/IFoC4wk8Opgp9T5sZNBrvMZQlSxWB/FobbSGSiidL4gJN+IpiF8
X-Gm-Gg: ASbGncvt2VyP1zBEpywAtafDrAz70Pk5ZStqjkdaqm+5EX3VZmXr8Uzi/giOhqErww6
	koMZ9ukOhcTyBhDC4AOb+1ezWGNO4Do6tqhtTIppgbKM14tKUdb8oSRyv9V2j0Pm1n3r0Q2ezOi
	kLH0Kyhj2tfXbg0XEQIoa1KN2mZ94jxUWPq6nveG6JXieNZdoHgaLRQdDexYRX4S3ETTdq+N49T
	v+bvF1JcA2OkFcEkdWfwezyOjf6kXqFfeoA4J7p+bCCrZ1VrbbTzF6ePd1NyyisaKUSoi26UnRX
	Qi6UaAOc0TIkMpSIOjJV7KLkgJJ5smeAH1D4D7Ap1PwXGrAQlhFFtV441X56SHhHGLqWojd5
X-Google-Smtp-Source: AGHT+IHk3TyLlLjvo1ZrhqhjfhLstv7wfNUl+sKT5uehFdm+9guCwaw/36eH5MrLGRMtgsX1R0gYXg==
X-Received: by 2002:a17:907:7b9f:b0:ac7:3929:25f9 with SMTP id a640c23a62f3a-ad1fcd024cfmr656484766b.29.1746795807043;
        Fri, 09 May 2025 06:03:27 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2290a4cc2sm41035566b.183.2025.05.09.06.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 06:03:26 -0700 (PDT)
Message-ID: <681dfd1e.170a0220.1d9a3f.15ad@mx.google.com>
X-Google-Original-Message-ID: <aB39G7LOWhN6t-wo@Ansuel-XPS.>
Date: Fri, 9 May 2025 15:03:23 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v12] pwm: airoha: Add support for EN7581 SoC
References: <20250407173559.29600-1-ansuelsmth@gmail.com>
 <q46vqvt4ebepk47as3vhx24fqfnv2ollatjzjw5hbxtcbaklff@exkozghztvlv>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <q46vqvt4ebepk47as3vhx24fqfnv2ollatjzjw5hbxtcbaklff@exkozghztvlv>

On Fri, May 09, 2025 at 12:39:37PM +0200, Uwe Kleine-König wrote:
> Hello Christian,
> 
> thanks for your patience.
>

Hi Uwe,

thanks a lot for the review. I was just starting reviewing some patch on
patchwork so I could remove some work from you but you were faster...

> On Mon, Apr 07, 2025 at 07:35:53PM +0200, Christian Marangi wrote:
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
> > Changes v12:
> > - Make shift function more readable
> > - Use unsigned int where possible
> > - Better comment some SIPO strangeness
> > - Move SIPO init after flash map config
> > - Retrun real values in get_state instead of the
> >   one saved in bucket
> > - Improve period_ns parsing so we can better share generators
> > 
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
> >  drivers/pwm/pwm-airoha.c | 506 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 518 insertions(+)
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
> > index 000000000000..05dd34656c23
> > --- /dev/null
> > +++ b/drivers/pwm/pwm-airoha.c
> > @@ -0,0 +1,506 @@
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
> 
> alphabetic ordering would be nice for the includes.
> 
> > +#include <asm/div64.h>
> 
> linux/math64.h is the right include for div_u64 et al.
> 
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
> > +
> > +static void airoha_pwm_get_flash_map_addr_and_shift(unsigned int hwpwm,
> > +						    u32 *addr, u32 *shift)
> > +{
> > +	unsigned int offset, hwpwm_bit;
> > +
> > +	if (hwpwm >= AIROHA_PWM_NUM_GPIO) {
> > +		unsigned int sipohwpwm = hwpwm - AIROHA_PWM_NUM_GPIO;
> > +
> > +		offset = sipohwpwm / AIROHA_PWM_PINS_PER_FLASH_MAP;
> > +		hwpwm_bit = sipohwpwm % AIROHA_PWM_PINS_PER_FLASH_MAP;
> > +
> > +		/* One FLASH_MAP register handles 8 pins */
> > +		*shift = AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(hwpwm_bit);
> > +		*addr = AIROHA_PWM_REG_SIPO_FLASH_MAP(offset);
> > +	} else {
> > +		offset = hwpwm / AIROHA_PWM_PINS_PER_FLASH_MAP;
> > +		hwpwm_bit = hwpwm % AIROHA_PWM_PINS_PER_FLASH_MAP;
> > +
> > +		/* One FLASH_MAP register handles 8 pins */
> > +		*shift = AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(hwpwm_bit);
> > +		*addr = AIROHA_PWM_REG_GPIO_FLASH_MAP(offset);
> > +	}
> > +}
> > +
> > +static void airoha_pwm_get_ticks_from_ns(u64 period_ns, u32 *period_tick,
> > +					 u64 duty_ns, u32 *duty_tick)
> > +{
> > +	u64 tmp_duty_tick;
> > +
> > +	*period_tick = div_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> > +
> > +	tmp_duty_tick = mul_u64_u64_div_u64(duty_ns, AIROHA_PWM_DUTY_FULL,
> > +					    period_ns);
> 
> So period can be set to multiples of 4 ms. If you request
> 
> 	.period_ns = 11999 ns
> 	.duty_ns = 4016 ns
> 
> the hardware should configure 
> 
> 	.period = 8000 ns
> 	.duty_cycle = 4015.6862745098038 ns (i.e. 128/255 * period)
> 
> corresponding to period_tick = 2 and duty_tick = 128.
> 
> However you calculate duty_tick = 85.
> 
> I would expect that with having PWM_DEBUG enabled you get a warning when
> you do:
> 
> 	pwmset -P 8000 -D 4016
> 	pwmset -P 11999 -D 4016
> 

I addressed all the other comments but this is the only thing that I'm
confused about.

Where 85 comes from?

I tested your command and I can correctly observe the values getting
set to the expected tick.

And I don't have the idempotent warning from PWM debug.

With period = 8000 and duty to 4016, period tick is set to 0x2 and duty
is set to 0x80 (128)

When PWM debug repply the configuration and read the state, it gets
period 0x8000 and duty 4015,687.

And those are the expected values. Am I missing something here?

mul_u64_u64_div_u64 does
duty_ns * 255 / period_ns (to make integer calculation)

in get we do

duty_tick * period_ns / 255

> > +	if (tmp_duty_tick > AIROHA_PWM_DUTY_FULL)
> > +		tmp_duty_tick = AIROHA_PWM_DUTY_FULL;
> 
> This can only happen when duty_ns > period_ns is passed to
> airoha_pwm_get_ticks_from_ns(). You can rule that out if you do in
> .apply():
> 
> 	if (period_ns > AIROHA_PWM_PERIOD_MAX_NS) {
> 		period_ns = AIROHA_PWM_PERIOD_MAX_NS;
> 
> 		if (duty_ns > period_ns)
> 			duty_ns = period_ns;
> 	}
> 
> which should be a tad cheaper.
> 
> > +	*duty_tick = tmp_duty_tick;
> > +}
> > +
> > +static void airoha_pwm_get_bucket(struct airoha_pwm *pc, int bucket,
> > +				  u64 *period_ns, u64 *duty_ns)
> > +{
> > +	u32 period_tick, duty_tick;
> > +	unsigned int offset;
> > +	u32 shift, val;
> > +
> > +	offset = bucket / AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
> > +	shift = bucket % AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
> > +	shift = AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
> > +
> > +	regmap_read(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset), &val);
> > +
> > +	period_tick = FIELD_GET(AIROHA_PWM_WAVE_GEN_CYCLE, val >> shift);
> 
> What a pity that FIELD_GET only works for compile time constants.
> 

There were some proposal for this but they were always rejected.

> > +	*period_ns = period_tick * AIROHA_PWM_PERIOD_TICK_NS;
> > +
> > +	offset = bucket / AIROHA_PWM_BUCKET_PER_FLASH_PROD;
> > +	shift = bucket % AIROHA_PWM_BUCKET_PER_FLASH_PROD;
> > +	shift = AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
> > +
> > +	regmap_read(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> > +		    &val);
> > +
> > +	duty_tick = FIELD_GET(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, val >> shift);
> > +	*duty_ns = DIV_U64_ROUND_UP(duty_tick * *period_ns, AIROHA_PWM_DUTY_FULL);
> 
> The multiplication cannot overflow here I assume because duty_tick and
> *period_ns are small enough. Please justify that in a comment.
> 
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
> > +
> > +		/*
> > +		 * Unlike duty cycle zero, which can be handled by
> > +		 * disabling PWM, a generator is needed for full duty
> > +		 * cycle but it can be reused regardless of period
> > +		 */
> > +		airoha_pwm_get_ticks_from_ns(period_ns, &period_tick,
> > +					     duty_ns, &duty_tick);
> > +		airoha_pwm_get_ticks_from_ns(bucket->period_ns, &period_tick,
> > +					     bucket->duty_ns, &duty_tick_bucket);
> 
> This uselessly calculates the value for &period_tick twice :-\
> 
> > +		if (duty_tick == AIROHA_PWM_DUTY_FULL &&
> > +		    duty_tick == duty_tick_bucket)
> 
> I would say that
> 
> 	if (duty_tick == AIROHA_PWM_DUTY_FULL &&
> 	    duty_tick_bucket == AIROHA_PWM_DUTY_FULL)
> 
> is more intuitive here. Do you agree?
> 
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
> 
> You're supposed to configure the maximal possible period not bigger than
> the requested one. So if period_ns = 16 ms, picking a bucket that has
> period_ns = 12 ns is better than having to give up.
> 
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
> 
> What is `clock`?
> 
> > +	 * Notice that clock delay should not be greater
> > +	 * than (divisor / 2) - 1.
> 
> `divisor` is the value written to AIROHA_PWM_SGPIO_CLK_DIVR?
> 
> > +	 * Set to 0 by default. (aka 1)
> 
> Set to 0 by default corresponding to a delay of 1 ms (or 4 ms or what?)
> 

I added additional comments, this is related to the shift register chip,
doesn't affect PWM.

> > +	regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DLY, 0x0);
> > +
> > +	/*
> > +	 * It it necessary to after muxing explicitly shift out all
> > +	 * zeroes to initialize the shift register before enabling PWM
> 
> My German ear suggests: "It is necessary to explicitly shift out all
> zeros after muxing to ..."
> 
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
> 
> Best regards
> Uwe



-- 
	Ansuel

