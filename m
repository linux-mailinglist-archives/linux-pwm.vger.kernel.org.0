Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFF9396F54
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jun 2021 10:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbhFAItX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Jun 2021 04:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbhFAItX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Jun 2021 04:49:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D47BC061574
        for <linux-pwm@vger.kernel.org>; Tue,  1 Jun 2021 01:47:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso1000465wmh.4
        for <linux-pwm@vger.kernel.org>; Tue, 01 Jun 2021 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e2iKj7zCwXw8DooKZ9IYIlYsyY7Y6y/Vqg6VLw15jxg=;
        b=e4sXAJ4CT+RhoBPm5y8Hmq5oeKnrDZ/tN7WhPbI5OizOkDj/c4oLwhEO+bZdq2bY4T
         RgJxhzwbYiWAj4uUztmmLCvsfw38GRF9gv4NRZuOTgRS38TsWX47dv7IE8mUoCCfiarR
         Gn9Ij5YN7R5gQA6X7xCKWAXAvZlagmaiy2wtYew6PoqpztgTUVK5FuXGIkFQhWlOoXUX
         ZEqm/VccWj0wIVlJ2f1fyW8Dz0kmFKIP2im6KPk5eRR+uOMiOi/uVzitNTc4R3pAz3LP
         vl6ijEwbP8uludf0dExgdlFabHOl3Xnk0F5HnCrCV/IS0rkpJAmu0hUflCBKglBrpT7j
         sC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e2iKj7zCwXw8DooKZ9IYIlYsyY7Y6y/Vqg6VLw15jxg=;
        b=C6B9lDpzfO4Czwbs0HenjLZZLR2dMdCL1y8W1QwFeJtvKa3rXf1M+Akb2p3RhVCNfG
         j1UzgBLvx6hW1vKFsyV3MieIrx1kssjKB/C85mNQet2UaEkQdrQ0f3SpdPFVoXmJ0rv0
         3n1k0PT94CYdcY4pBcN9PMd3CV+jAiouWKJckgjixH5BNje8Wkp22L0FKX7czbJ8sI31
         ovPPOZhkP1pV6UKUVjXml2iQin2RAG1cgrdYa8X6h+/vZDqF98Y/06tNHV6+vYHussRv
         eOp8C47Ct5/+io7wjFhtOZZr1rk5AoybZGOBoOwail+Q4ESAxKFhx6eCGe84I1JV0Ha9
         T+EA==
X-Gm-Message-State: AOAM530/T5a4Ss2wnLPy9q2MX7IZCCfGcF9XNxc/WX/kKer8ghLBL/bl
        xslmiYMnLawtUzVYQJQ9DkuYrFMODYWDAg==
X-Google-Smtp-Source: ABdhPJx/igAFckTnXTnz6o7aF5Nn8EH6ONEImQdJrkqlAEOHqXHUuqWPcXbTujiEJaYApXzFrSQKdQ==
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr5653541wml.51.1622537259959;
        Tue, 01 Jun 2021 01:47:39 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id z12sm21854339wmc.5.2021.06.01.01.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 01:47:39 -0700 (PDT)
Date:   Tue, 1 Jun 2021 09:47:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 2/3] clocksource: Rewrite Xilinx AXI timer driver
Message-ID: <20210601084734.GX543307@dell>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <20210528214522.617435-2-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210528214522.617435-2-sean.anderson@seco.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 28 May 2021, Sean Anderson wrote:

> This rewrites the Xilinx AXI timer driver to be more platform agnostic.
> Some common code has been split off so it can be reused. These routines
> currently live in drivers/mfd. The largest changes have taken place in the
> initialization:
> 
> - We now support any number of timer devices, possibly with only one
>   counter each. The first counter will be used as a clocksource. Every
>   other counter will be used as a clockevent.
> - We do not use timer_of_init because we need to perform some tasks in
>   between different stages. For example, we must ensure that ->read and
>   ->write are initialized before registering the irq. This can only happen
>   after we have gotten the register base (to detect endianness). We also
>   have a rather unusual clock initialization sequence in order to remain
>   backwards compatible. Due to this, it's ok for the initial clock request
>   to fail, and we do not want other initialization to be undone. Lastly, it
>   is more convenient to do one allocation for xilinx_clockevent_device than
>   to do one for timer_of and one for xilinx_timer_priv.
> - We now pay attention to xlnx,count-width and handle smaller width timers.
>   The default remains 32.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> This has been tested on microblaze qemu.
> 
> Changes in v4:
> - Break out clock* drivers into their own file
> 
>  arch/microblaze/kernel/Makefile    |   3 +-
>  arch/microblaze/kernel/timer.c     | 326 -----------------------------
>  drivers/clocksource/Kconfig        |  11 +
>  drivers/clocksource/Makefile       |   1 +
>  drivers/clocksource/timer-xilinx.c | 300 ++++++++++++++++++++++++++
>  drivers/mfd/Makefile               |   4 +
>  drivers/mfd/xilinx-timer.c         | 147 +++++++++++++

I'm confused!

>  include/linux/mfd/xilinx-timer.h   | 134 ++++++++++++
>  8 files changed, 598 insertions(+), 328 deletions(-)
>  delete mode 100644 arch/microblaze/kernel/timer.c
>  create mode 100644 drivers/clocksource/timer-xilinx.c
>  create mode 100644 drivers/mfd/xilinx-timer.c
>  create mode 100644 include/linux/mfd/xilinx-timer.h

[...]

> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
> + *
> + * For Xilinx LogiCORE IP AXI Timer documentation, refer to DS764:
> + * https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/mfd/xilinx-timer.h>
> +#include <linux/of.h>
> +#include <asm/io.h>

RED FLAG: You are not using the MFD API here.

> +#define TCSR0	0x00
> +#define TLR0	0x04
> +#define TCR0	0x08
> +#define TCSR1	0x10
> +#define TLR1	0x14
> +#define TCR1	0x18
> +
> +#define TCSR_MDT	BIT(0)
> +#define TCSR_UDT	BIT(1)
> +#define TCSR_GENT	BIT(2)
> +#define TCSR_CAPT	BIT(3)
> +#define TCSR_ARHT	BIT(4)
> +#define TCSR_LOAD	BIT(5)
> +#define TCSR_ENIT	BIT(6)
> +#define TCSR_ENT	BIT(7)
> +#define TCSR_TINT	BIT(8)
> +#define TCSR_PWMA	BIT(9)
> +#define TCSR_ENALL	BIT(10)
> +#define TCSR_CASC	BIT(11)
> +
> +/* readl/writel wrappers to support BE systems */
> +
> +static u32 xilinx_ioread32be(const void __iomem *addr)
> +{
> +	return ioread32be(addr);
> +}
> +
> +static void xilinx_iowrite32be(u32 value, void __iomem *addr)
> +{
> +	iowrite32be(value, addr);
> +}
> +
> +static u32 xilinx_ioread32(const void __iomem *addr)
> +{
> +	return ioread32(addr);
> +}
> +
> +static void xilinx_iowrite32(u32 value, void __iomem *addr)
> +{
> +	iowrite32(value, addr);
> +}

Abstraction for the sake of abstraction, is not allowed.

Just use the io*() calls directly in-place.

> +int xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 *tlr,
> +			    u32 tcsr, u64 cycles)
> +{
> +	if (cycles < 2 || cycles > priv->max + 2)
> +		return -ERANGE;
> +
> +	if (tcsr & TCSR_UDT)
> +		*tlr = cycles - 2;
> +	else
> +		*tlr = priv->max - cycles + 2;
> +
> +	return 0;
> +}
> +
> +int xilinx_timer_tlr_period(struct xilinx_timer_priv *priv, u32 *tlr,
> +			    u32 tcsr, unsigned int period)
> +{
> +	u64 cycles = DIV_ROUND_DOWN_ULL((u64)period * clk_get_rate(priv->clk),
> +					NSEC_PER_SEC);
> +
> +	return xilinx_timer_tlr_cycles(priv, tlr, tcsr, cycles);
> +}
> +
> +unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
> +				     u32 tlr, u32 tcsr)
> +{
> +	u64 cycles;
> +
> +	if (tcsr & TCSR_UDT)
> +		cycles = tlr + 2;
> +	else
> +		cycles = priv->max - tlr + 2;
> +
> +	return DIV_ROUND_UP_ULL(cycles * NSEC_PER_SEC,
> +				clk_get_rate(priv->clk));
> +}
> +
> +int xilinx_timer_common_init(struct device_node *np,
> +			     struct xilinx_timer_priv *priv,
> +			     u32 *one_timer)
> +{
> +	int ret;
> +	u32 tcsr0, width;
> +
> +
> +	priv->read = xilinx_ioread32;
> +	priv->write = xilinx_iowrite32;
> +	/*
> +	 * If PWM mode is enabled, we should try not to disturb it. Use
> +	 * CAPT since if PWM mode is enabled then MDT will be set as
> +	 * well.
> +	 *
> +	 * First, clear CAPT and verify that it has been cleared
> +	 */
> +	tcsr0 = xilinx_timer_read(priv, TCSR0);
> +	xilinx_timer_write(priv, tcsr0 & ~(TCSR_CAPT & swab(TCSR_CAPT)), TCSR0);
> +	tcsr0 = xilinx_timer_read(priv, TCSR0);
> +	if (tcsr0 & (TCSR_CAPT | swab(TCSR_CAPT))) {
> +		pr_err("%pOF: cannot determine endianness\n", np);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Then check to make sure our write sticks */
> +	xilinx_timer_write(priv, tcsr0 | TCSR_CAPT, TCSR0);
> +	if (!(xilinx_timer_read(priv, TCSR0) & TCSR_CAPT)) {
> +		priv->read = xilinx_ioread32be;
> +		priv->write = xilinx_iowrite32be;
> +	}
> +
> +	ret = of_property_read_u32(np, "xlnx,one-timer-only", one_timer);
> +	if (ret) {
> +		pr_err("%pOF: err %d: xlnx,one-timer-only\n", np, ret);
> +		return ret;
> +	} else if (*one_timer && *one_timer != 1) {
> +		pr_err("%pOF: xlnx,one-timer-only must be 0 or 1\n", np);
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_u32(np, "xlnx,count-width", &width);
> +	if (ret == -EINVAL) {
> +		width = 32;
> +	} else if (ret) {
> +		pr_err("%pOF: err %d: xlnx,count-width\n", np, ret);
> +		return ret;
> +	} else if (width < 8 || width > 32) {
> +		pr_err("%pOF: invalid counter width\n", np);
> +		return -EINVAL;
> +	}
> +	priv->max = BIT_ULL(width) - 1;
> +
> +	return 0;
> +}

This is *all* timer stuff.

What is your rationale for dumping this into MFD?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
