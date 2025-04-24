Return-Path: <linux-pwm+bounces-5696-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B56E3A9B3AB
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 18:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5201BA43A9
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31DC27F74A;
	Thu, 24 Apr 2025 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV+a8i/e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3225BAF0;
	Thu, 24 Apr 2025 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511524; cv=none; b=pOMkFYzY8Pojr1QdUY9zcSRf7AhotCkn8Bi8hg2rSqxvTT75dgX4Rj6qsM7NWDfalVeqk7IZGoRDC8qiCdcQk/D4ve1O8i0xhyeQ6mlHx+XM9lZvcuEX3jfbTVmDOKRZxOQlhDJg/pE6+4ga+ZZ+J1OFRMSHb3MKdqJT8HcmiOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511524; c=relaxed/simple;
	bh=3+y5pOMRspgrvZDe7B/mcBxCWuXrILPVQqYVpLztFhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOB4CdmeITYwaEc2UGoraQ5myoY/J0O2NgMCw36yMUTZOxsUQjmUwNsWa8x4bCAx0aMXLawe0EuGYg3OVpZh9btlD+A8Bhy639tW+TiA4623oT0P3Yh0TwHW+H/vuEkGDDgcNwD7RIOU2Z30DuSJ9RgEqn8WvN6nhwyk/kugDbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MV+a8i/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8455EC4CEE3;
	Thu, 24 Apr 2025 16:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745511524;
	bh=3+y5pOMRspgrvZDe7B/mcBxCWuXrILPVQqYVpLztFhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MV+a8i/egRGEW2AjsD3opoof4TGi2B+lMa7DeZkFROReaw/OKbxUaIQOul5tFKyzq
	 4pJp1cpASF3FMZ3pindZukEnK/s6XMAsuYZ2w0gGBkql72npyO0rHepXSuZCf7JyGq
	 OeKsBJ3GELq0fbI9YGjn9rfj70cpczFgAi+dR1s0pCOgruZDOGBgdXKlRbPzJpPgys
	 lIVzUX/kFMdlFLqX3GyPuYZxWXyvRRgE2TX7IAPEpOP8VYLfd9EXzktutLI32XVGdd
	 1DyXMXd0f1y0K3l6vL41aLBDAYzYlFwWmd9TRrfdDU74a73jNfKd9h8+GU2D+MD10n
	 5xioMDw6/u6Lw==
Date: Thu, 24 Apr 2025 17:18:38 +0100
From: Lee Jones <lee@kernel.org>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 06/17] mfd: adp5585: add support for adp5589
Message-ID: <20250424161838.GM8734@google.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-6-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-6-3a799c3ed812@analog.com>

On Tue, 15 Apr 2025, Nuno Sá via B4 Relay wrote:

> From: Nuno Sá <nuno.sa@analog.com>
> 
> The ADP5589 is a 19 I/O port expander with built-in keypad matrix decoder,
> programmable logic, reset generator, and PWM generator.
> 
> This patch adds the foundation to add support for the adp5589 gpio and pwm
> drivers. Most importantly, we need to differentiate between some
> registers addresses. It also hints to future keymap support.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/mfd/adp5585.c       | 223 +++++++++++++++++++++++++++++++++++++++++---
>  include/linux/mfd/adp5585.h |  57 ++++++++++-
>  2 files changed, 268 insertions(+), 12 deletions(-)

[...]

> + * Bank 0 covers pins "GPIO 1/R0" to "GPIO 8/R7", numbered 0 to 7 by the
> + * driver, bank 1 covers pins "GPIO 9/C0" to "GPIO 16/C7", numbered 8 to
> + * 15 and bank 3 covers pins "GPIO 17/C8" to "GPIO 19/C10", numbered 16 to 18.
> + */
> +#define ADP5589_BANK(n)			((n) >> 3)
> +#define ADP5589_BIT(n)			BIT((n) & 0x7)
> +
> +struct adp5585_regs {
> +	unsigned int debounce_dis_a;
> +	unsigned int rpull_cfg_a;
> +	unsigned int gpo_data_a;
> +	unsigned int gpo_out_a;
> +	unsigned int gpio_dir_a;
> +	unsigned int gpi_stat_a;
> +	unsigned int pwm_cfg;
> +	unsigned int pwm_offt_low;
> +	unsigned int pwm_ont_low;
> +	unsigned int gen_cfg;
> +	unsigned int ext_cfg;
> +};
> +
> +struct adp5585_info {
> +	const struct mfd_cell *adp5585_devs;

Okay, we are never doing this.  Either use OF for platform registration
or use MFD (or ACPI or PCI), but please do not pass MFD data through OF.

> +	const struct regmap_config *regmap_config;
> +	const struct adp5585_regs *regs;
> +	unsigned int n_devs;
> +	unsigned int id;

What ID is this?  We already have platform IDs and MFD cell IDs.

> +	u8 max_rows;
> +	u8 max_cols;
> +};
> +
>  struct regmap;
>  
>  struct adp5585_dev {
>  	struct regmap *regmap;
> +	const struct adp5585_info *info;
>  };
>  
>  #endif
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones [李琼斯]

