Return-Path: <linux-pwm+bounces-4099-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659CD9D128B
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2024 14:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B52B226B2
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2024 13:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF94119C560;
	Mon, 18 Nov 2024 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJmNUaTe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC811E505;
	Mon, 18 Nov 2024 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731938226; cv=none; b=OUXS6TgjdniUBOjyxrhTvTHsN/0Zo6uxFJPlz9Gxe3lPXjXRTP+jDlnTlU5rVf4nOTVtXF5Ps7W+JSLmvKIDqeiCzkI6nPeDDA0kEnXAyM0Hqo7Jd8Rutk1gzApdYCf9way+lxxpN2b7mvC7n4i6gUS/7Zr8lAEvPdoRxED1x4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731938226; c=relaxed/simple;
	bh=eKx14vhsPqt3aVBLymJxdMOfVUlohtPd719hxRQ6wuE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1Px7Nsqxc5nn+y4z+ysmoA0gjJZQTLlGjZJvGPArFzX0LqKT+jso3H+87GQ1H2rBphGZrl4VA7fp4sOB3RB+kyk/BSVuT0nI/WdRDA58FILo4jPGAMl6QzNDexTfWtqxYJXPUUK+Mm8vkYH5JnaffWJQgcISaC1FYlm6OV2ynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJmNUaTe; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-382325b0508so1536679f8f.3;
        Mon, 18 Nov 2024 05:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731938223; x=1732543023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y5g0SDxq/NK6cMbSW02p9WJnfU+yS5PFEVoK2tgPY/Q=;
        b=FJmNUaTe3J0HIiKoccoKcnCwX+1hISxaWrTEOE4ioBzkae8FYy5lA0zZDu7IW6aKse
         gxTtLrClr3XaXMRVXBi+GwWunGB3Ia/DUTFf45UhqYhhxVnwvrNiVDJieTFUVi2Gi9hM
         JE0lTfQvx3HGv1kG45OkbTzAaM1VUGenvZaH7No5bGBuNamyO81x/odZJxSiKZIg0qhl
         Evco4bxPBJCQaN70t4/pSnhiWFssP76AlTdwnsEJwpSN/9UCn8CsjUksFr2IAI9j9wr3
         pCmFUMZ32hz2IRrA+fFZUK/lWYkYXttJnAT1/5Cu6I6Q7PAeKWdWan3I6EpzkoqxcYBR
         HPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731938223; x=1732543023;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5g0SDxq/NK6cMbSW02p9WJnfU+yS5PFEVoK2tgPY/Q=;
        b=UMaZBm3bABSG/HCRFZa76HkXuW+Tflr5Pf5OQTdKt/CVAjBnFG87XMV6aauuUsWuxd
         1D52PMewhJKhJycVeaZJFjoDYKArGzA/z5kfTtCAR6oJbI/7yfcc5aNLZIUFRN/3Vi5K
         oaDeszBsQn5DtxKsrGm2BirKkO7hivPy57sOLKSYETJqWMJ3Yd81MghePE2xPQQYMk2B
         rMCDxVae/BSEbioPwYtnnABtLKCVu/gpm5sH8BGuj8JwORd3y5JE6NgL904kMmCT+4UN
         qqsZ8wH4E+WpGGMwK6qbIbOc3KV50z77/2d35lvXNLff+kRsPDnX0d5LrNlW+NuokHtP
         V+dA==
X-Forwarded-Encrypted: i=1; AJvYcCV5UWPj5ndsbSqfZNEi/RPOu/TZrnNebvSIa7yceuTBqTMCAOZQ70R3ZvaIsff9UCkhRGO7UzpEHplOgA==@vger.kernel.org, AJvYcCVpO/8tzl6AvYu1/gwFqk6W4pb8Bmy/WbPCZt2YBwPtKWgHAoRavUBqm/Gl/aKlluM/4J6nAz92HGwR@vger.kernel.org, AJvYcCXDjDUO0gBpiGfcrvkKJMZtrVhrMo84Rv0CtK6ZpBQI58Sbk2kqew9kuw5Ovz/aMToqDeDP7Y+A7SB0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/I6fMyaqO8Hp7Kwjj0PpzBom6iwvhv2/yvzOxHMIx+O4lKsL
	nv60zIe7gNY3mwT8fTGxTYIalxDzghZ1vVURpnGh/2rRljk/eAQx
X-Google-Smtp-Source: AGHT+IF94nbHwzjCLpDarWT5yfUcXTqkaO1krUW7QphggrRZZYmFNp3AV0Tm25ZBZzhDuW3XljIjSA==
X-Received: by 2002:a5d:6489:0:b0:382:4b5c:418c with SMTP id ffacd0b85a97d-3824b5c4381mr515794f8f.55.1731938223123;
        Mon, 18 Nov 2024 05:57:03 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382456ba017sm3895573f8f.97.2024.11.18.05.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 05:57:02 -0800 (PST)
Message-ID: <673b47ae.df0a0220.2187ad.bc2a@mx.google.com>
X-Google-Original-Message-ID: <ZztHqr6wdb2nmFke@Ansuel-XPS.>
Date: Mon, 18 Nov 2024 14:56:58 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v10] pwm: airoha: Add support for EN7581 SoC
References: <20241103-en7581-pinctrl-v10-1-1990fb6996a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103-en7581-pinctrl-v10-1-1990fb6996a0@kernel.org>

On Sun, Nov 03, 2024 at 10:04:04PM +0100, Lorenzo Bianconi wrote:
> From: Benjamin Larsson <benjamin.larsson@genexis.eu>
> 
> Introduce driver for PWM module available on EN7581 SoC.
> 
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Introduce airoha-mfd driver in order to load pinctrl and pwm drivers for
> EN7581 SoC. airoha-mfd is needed since both pinctrl and pwm drivers
> needs to access the same memory block (gpio memory region) to configure
> {gio,irq}_chip and pwm functionalities respectively, so model them as
> childs of a parent mfd driver.
> Current EN7581 pinctrl driver supports the following functionalities:
> - pin multiplexing via chip_scu syscon
> - pin pull-up, pull-down, open-drain, current strength,
>   {input,output}_enable, output_{low,high} via chip_scu syscon
> - gpio controller
> - irq controller
> ---
> Changes in v10:
> - repost just patch 6/6 (pwm driver) since patches {1/6-5/6} have been
>   already applied in linux-pinctrl tree
> - pwm: introduce AIROHA_PWM_FIELD_GET and AIROHA_PWM_FIELD_SET macros to
>   get/set field with non-const mask
> - pwm: simplify airoha_pwm_get_generator() to report unused generator
>   and remove double lookup
> - pwm: remove device_node pointer in airoha_pwm struct since this is
>   write-only field
> - pwm: cosmetics
> - Link to v9: https://lore.kernel.org/r/20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org
> 
> Changes in v9:
> - pwm: remove unused properties
> - Link to v8: https://lore.kernel.org/r/20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org
> 
> Changes in v8:
> - pwm: add missing properties documentation
> - Link to v7: https://lore.kernel.org/r/20241016-en7581-pinctrl-v7-0-4ff611f263a7@kernel.org
> 
> Changes in v7:
> - pinctrl: cosmetics
> - pinctrl: fix compilation warning
> - Link to v6: https://lore.kernel.org/r/20241013-en7581-pinctrl-v6-0-2048e2d099c2@kernel.org
> 
> Changes in v6:
> - pwm: rely on regmap APIs
> - pwm: introduce compatible string
> - pinctrl: introduce compatible string
> - remove airoha-mfd driver
> - add airoha,en7581-pinctrl binding
> - add airoha,en7581-pwm binding
> - update airoha,en7581-gpio-sysctl binding
> - Link to v5: https://lore.kernel.org/r/20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org
> 
> Changes in v5:
> - use spin_lock in airoha_pinctrl_rmw instead of a mutex since it can run
>   in interrupt context
> - remove unused includes in pinctrl driver
> - since the irq_chip is immutable, allocate the gpio_irq_chip struct
>   statically in pinctrl driver
> - rely on regmap APIs in pinctrl driver but keep the spin_lock local to the
>   driver
> - rely on guard/guard_scope APIs in pinctrl driver
> - improve naming convention pinctrl driver
> - introduce airoha_pinconf_set_pin_value utility routine
> - Link to v4: https://lore.kernel.org/r/20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org
> 
> Changes in v4:
> - add 'Limitation' description in pwm driver
> - fix comments in pwm driver
> - rely on mfd->base __iomem pointer in pwm driver, modify register
>   offsets according to it and get rid of sgpio_cfg, flash_cfg and
>   cycle_cfg pointers
> - simplify register utility routines in pwm driver
> - use 'generator' instead of 'waveform' suffix for pwm routines
> - fix possible overflow calculating duty cycle in pwm driver
> - do not modify pwm state in free callback in pwm driver
> - cap the maximum period in pwm driver
> - do not allow inverse polarity in pwm driver
> - do not set of_xlate callback in the pwm driver and allow the stack to
>   do it
> - fix MAINTAINERS file for airoha pinctrl driver
> - fix undefined reference to __ffsdi2 in pinctrl driver
> - simplify airoha,en7581-gpio-sysctl.yam binding
> - Link to v3: https://lore.kernel.org/r/20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org
> 
> Changes in v3:
> - introduce airoha-mfd driver
> - add pwm driver to the same series
> - model pinctrl and pwm drivers as childs of a parent mfd driver.
> - access chip-scu memory region in pinctrl driver via syscon
> - introduce a single airoha,en7581-gpio-sysctl.yaml binding and get rid
>   of dedicated bindings for pinctrl and pwm
> - add airoha,en7581-chip-scu.yaml binding do the series
> - Link to v2: https://lore.kernel.org/r/20240822-en7581-pinctrl-v2-0-ba1559173a7f@kernel.org
> 
> Changes in v2:
> - Fix compilation errors
> - Collapse some register mappings for gpio and irq controllers
> - update dt-bindings according to new register mapping
> - fix some dt-bindings errors
> - Link to v1: https://lore.kernel.org/all/cover.1723392444.git.lorenzo@kernel.org/

Hi Uwe,

since you gave revision for v9, any news with this? Is everything good
now? It's sad if this last piece doesn't get through after all this
efforts with the previous series :(

-- 
	Ansuel

