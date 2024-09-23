Return-Path: <linux-pwm+bounces-3328-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C578897E920
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 11:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562BA1F21D34
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 09:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341EA194AFE;
	Mon, 23 Sep 2024 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvUneDpE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCFA8479;
	Mon, 23 Sep 2024 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085237; cv=none; b=oguVboyZ6gOOkXU16oz/ncanXxgZYgq3jc0OCK7n+GXUNSeu2ugeD2CwDXm5ZjHH8rEVflDAXOEEviyIBs0qIwFrmxh/YejR2tebCx4R/eutOMHULwh/KFx3d5BQN1hvB5ENDz76MSkifw1WBb+SERNQAgF/P+Skxs/Do29gZ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085237; c=relaxed/simple;
	bh=2d106uzkR+8RT+3V8DfFcnrtgh3IoT5F3iqW40LwDNM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKyl7rNjmvctXYM0N3PI7Vr+At2bVPXGCBE9hxeKBrbXdt1p5bNQz+f6Yd6w6BPK+oVzr/V8URkR/rlbFmO5DL7N7Z481yO1eOb+vrgkjcYi3dqodcsT/8e5PpLB0fDK0cDfFFg+k+pAZe8hriWyDyBRlyzhuxG537cKxZB7doo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvUneDpE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-378f600e090so2318874f8f.3;
        Mon, 23 Sep 2024 02:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727085233; x=1727690033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W/G5Y1Yc2GdbX/HaGBtPNbObghnd/ierGxsK5LlHR+M=;
        b=TvUneDpEWXe0KAHmm/mAHmajWaaIDWHnd/P1qGgu+lVy3NFIh/Q68WxJiXTumSj6gk
         kEdt9Mg8JQtz+snk9Jw6Hhxwxr70hS06IbvpdZMbzhQCVZMyEy80br5anDwKUuOV6x/a
         9jEZqVZxBTNtFpbAgnmNXZx/KkQ/9s0RyFhDCpJgeSaTjlKpJ9N3sTZ3bQdIAIYpv27h
         mgVrAK7/eM0J618HmGlJK78LztN+0JthrfnDG24AEz42afuuJ4pxmVUewM04EgfWAWci
         hNv4kDNbVqdFYYFIqK4mlh172IlYrzlRwCI0614UDEjTQDxyD4nHl5Rq0Muqazeg74UR
         p/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727085233; x=1727690033;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/G5Y1Yc2GdbX/HaGBtPNbObghnd/ierGxsK5LlHR+M=;
        b=O9yQ/BTnUvV27w0gXWM5DJE+dSAQRB1tahjXZbkYzrED7pSIR1Veg6U3sKQrxExE4P
         mXGV83ji/4UvElyDTDtTQ3gbsxKRTojkJBKaOQJihxJgFG5irwMCGlzZQLzMfXa9iKp1
         AzR+wO5fIGf1lQgnJyGDhMiVkr38/KjljozzKmhxru98gMb6ZlD0+wOFxhtEkFppfTWM
         Tl7VuON5Q36ciuMFkEod9YT1JOS7SpZXttWcvXbXRYae3U64sQftg05tnsdY7V2rw9uK
         MGyRver4b/PgDyzwmeSXYeAYMwOzLqYCZkHB/eT6YONNeS/nSR3K44SA/7sVQmgut+k6
         z95g==
X-Forwarded-Encrypted: i=1; AJvYcCU8vmZSeRvJJ0rvzPNmDroQEM/edvY6azUI7i9yKK8oaG0SmG0CNsab3YnBbYszNgsIeHOewuDGiq3i@vger.kernel.org, AJvYcCWhVHE7IHYXj9Rz/S8D1zc02gMTHRQ/vllg8QrNJDlKoi158H89jdJNy+DoYWoK4aHq5FEBlv+bDcBTZg==@vger.kernel.org, AJvYcCWmPUHSO8Jwqkl9btt+SHw2+ILwWOMO7nxZoqFZYS3BryGkWWEFSo+4sQB1Z8ZLNdUp3tezH6/xOY1d@vger.kernel.org
X-Gm-Message-State: AOJu0YzVDaZhS4U68mTQUoELdGblKNSloNaVcqwDO8MBuJVO4kYgh8w4
	d/PUcmk+L8gEVSlBRboqfPWEU5JRQB1VbQwcFIwyVJ8kATWdbGph
X-Google-Smtp-Source: AGHT+IHFcRqze8NF48rSN4RfnRVSC5MCHRlQsylzZ05QxbfMJ+tA5vQe9UKElu6ng0HSNIhzNc4qfQ==
X-Received: by 2002:a5d:5f83:0:b0:374:c977:363 with SMTP id ffacd0b85a97d-37a43154e86mr7174926f8f.24.1727085233174;
        Mon, 23 Sep 2024 02:53:53 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7805193sm23850774f8f.98.2024.09.23.02.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 02:53:52 -0700 (PDT)
Message-ID: <66f13ab0.5d0a0220.b0c27.b441@mx.google.com>
X-Google-Original-Message-ID: <ZvE6rpnzlrUJHKLx@Ansuel-XPS.>
Date: Mon, 23 Sep 2024 11:53:50 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v4 0/5] Add mfd, pinctrl and pwm support to EN7581 SoC
References: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org>

On Wed, Sep 11, 2024 at 09:50:00PM +0200, Lorenzo Bianconi wrote:
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
> 
> ---
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
> 
> ---
> Benjamin Larsson (1):
>       pwm: airoha: Add support for EN7581 SoC
> 
> Christian Marangi (2):
>       dt-bindings: mfd: Add support for Airoha EN7581 GPIO System Controller
>       mfd: airoha: Add support for Airoha EN7581 MFD
> 
> Lorenzo Bianconi (2):
>       dt-bindings: arm: airoha: Add the chip-scu node for EN7581 SoC
>       pinctrl: airoha: Add support for EN7581 SoC
> 
>  .../bindings/arm/airoha,en7581-chip-scu.yaml       |   42 +
>  .../bindings/mfd/airoha,en7581-gpio-sysctl.yaml    |  433 +++
>  MAINTAINERS                                        |    7 +
>  drivers/mfd/Kconfig                                |    8 +
>  drivers/mfd/Makefile                               |    2 +
>  drivers/mfd/airoha-en7581-gpio-mfd.c               |   72 +
>  drivers/pinctrl/mediatek/Kconfig                   |   16 +-
>  drivers/pinctrl/mediatek/Makefile                  |    1 +
>  drivers/pinctrl/mediatek/pinctrl-airoha.c          | 2964 ++++++++++++++++++++
>  drivers/pwm/Kconfig                                |   10 +
>  drivers/pwm/Makefile                               |    1 +
>  drivers/pwm/pwm-airoha.c                           |  414 +++
>  include/linux/mfd/airoha-en7581-mfd.h              |    9 +
>  13 files changed, 3978 insertions(+), 1 deletion(-)
> ---
> base-commit: 264c13114bd71ddfd7b25c7b94f6cda4587eca25
> change-id: 20240818-en7581-pinctrl-1bf120154be0
> prerequisite-change-id: 20240705-for-6-11-bpf-a349efc08df8:v2
> 
>

Hi,

any news with this? Rob reviewed the DT schemas and he is ok with them.

Any other comments for the MFD driver and/or the pinctrl or PWM driver?

-- 
	Ansuel

