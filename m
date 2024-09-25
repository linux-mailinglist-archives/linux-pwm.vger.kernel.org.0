Return-Path: <linux-pwm+bounces-3362-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EB29856A9
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2024 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108841C2112D
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Sep 2024 09:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646E31514CB;
	Wed, 25 Sep 2024 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUX3m39M"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD4D14B967;
	Wed, 25 Sep 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257878; cv=none; b=cGeWjYBY/mw21mrlkoI6dwAfb/RUTm5bVP18xMxuvU6W6ZWeJoYJgTpQT6wjec1f5Z8gIfrk7LfSDVZAe6Hz6L6hEQVYdIb1DMRW0GWw4pQVbIoPFTMZ2ZX7qPt8t/Lwu+KR4xeEiOgtV+Th02VYU+tcEtlv7QtKDPTXq3DSi9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257878; c=relaxed/simple;
	bh=6mcOV4Z2H7iVA1xos5dXGhlymzzh+HH/+oqm9Q+z15U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/SPpJKBa12qKLcePwjDD86uvsuGH+IuJuH5RJ30rM8WE5AlSQWTZDjfYzGdrCPKBQB7vGAs0OKy8MCXZz+B3snCE9tbNqAZyYQoAPizy0tPVbBmxmUM0UZZ9DE2KG3mFNfJVye/2cE6T5aAz67HR6+wRaCCUIPN6Y3Y1zRwaPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUX3m39M; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb806623eso56647365e9.2;
        Wed, 25 Sep 2024 02:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727257874; x=1727862674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dDln4KXF/7+F5/JQmkbmDgtFCiDcW7/b23N8sYic+uc=;
        b=QUX3m39MAumBj/R+erwYII1mX/IF1eM4mGO6RIph67JPPmlUFiKbsOgdExV+D3xCEK
         9f6+4Z5lDkBYu9sJZzxawgXXSQX1xmf6lMz+aU7IxwNDkfhtYurvRTHXKYsW9n2NuDRO
         q73XcqcxqMXEbvmg98eQDnG0ACTT7AhJ7jdBbrm3roRSaCd/CuEr4bzpoL7PAbggThaI
         gdKh8pFLICZsqt1fm2nLY7XnJA4mO1Wmn9qzCil+KD1H0UuQ+0c0vckquIo8isQ0Te7z
         hUcPDZI8bW9LVWKsxv9QRthaDgypW+I57TPQRO3fuohqSo1Pbo/Il/SSofcpH16IlJVE
         UcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727257874; x=1727862674;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDln4KXF/7+F5/JQmkbmDgtFCiDcW7/b23N8sYic+uc=;
        b=EzX36mJrmcEkSJ5bk7DQMddU9stLK8q+dGxWMtcNndipDZRGu9dYfBJU6ap8SAcNxB
         uZF7dGceSdpUKmc4p1gTCqhBEBiq3kIY0faCUWnG4lHyYjfPDWklUHnnoDFO7f8HM84m
         vf/HWOLKLOY6ctlQiQchUKRNC2XR2+E+Ovw8QMw61pito4MaTlwMZ1/b9yHxDPWqBfvo
         +3uMJsr7yx4mWTR4Bv97AoXc7cn6FmpT4xQHNnQylP2HMxufvQSZNqV6e3nF40xHdCeu
         EGTDqfJS1Z7UAw6WsYp6WG6d2twoahKjXbgpfpeDxzWGkG0UtgnKwJV1itnuEQJbaQR2
         gzdw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Eb0s2FqPYGlmJOdHb4txLjDEGIxX6WXaK528fm7F4/pAENKptwGQzznAAKAHYUt8VTzP8ZA68Ssj@vger.kernel.org, AJvYcCVH4qLOSzi0Xfqdr+BQjq8ubWbIh0iW58T2Ed3hvovfe4Wjyrm19CSd1UIY2pv296uVPQ3sL+67+858@vger.kernel.org, AJvYcCW41dT0ENRccqaEyj9HPJQf2OZprmdN9nyQoee9189aAWgDj1m/t0YN/yWZUFN29f3+fbqoXyDib5bu0w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6pMk02WSSVshV728C+TZzGJBQlf8r3yl1hsGWIf8AKqnOOHXL
	8zP3sQsjEUgU6RhWdW7jV6jIrNcRZd4EFqHcrVA06btUQwqt1ebX
X-Google-Smtp-Source: AGHT+IHDUsmFcuyEuiXMU148+jNbNpI9r1/wqGCcgHuH7haynKQZFs61GjDI7QM15qHBWVStwTWHaw==
X-Received: by 2002:a05:600c:3b29:b0:42c:bd4d:e8ba with SMTP id 5b1f17b1804b1-42e9610a6famr13626365e9.8.1727257874435;
        Wed, 25 Sep 2024 02:51:14 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc1560a7sm3576976f8f.0.2024.09.25.02.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 02:51:14 -0700 (PDT)
Message-ID: <66f3dd12.5d0a0220.8f8b6.af43@mx.google.com>
X-Google-Original-Message-ID: <ZvPdDqLlCVrf5k9R@Ansuel-XPS.>
Date: Wed, 25 Sep 2024 11:51:10 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add mfd, pinctrl and pwm support to EN7581 SoC
References: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org>
 <66f13ab0.5d0a0220.b0c27.b441@mx.google.com>
 <20240925094738.GD7545@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925094738.GD7545@google.com>

On Wed, Sep 25, 2024 at 10:47:38AM +0100, Lee Jones wrote:
> On Mon, 23 Sep 2024, Christian Marangi wrote:
> 
> > On Wed, Sep 11, 2024 at 09:50:00PM +0200, Lorenzo Bianconi wrote:
> > > Introduce airoha-mfd driver in order to load pinctrl and pwm drivers for
> > > EN7581 SoC. airoha-mfd is needed since both pinctrl and pwm drivers
> > > needs to access the same memory block (gpio memory region) to configure
> > > {gio,irq}_chip and pwm functionalities respectively, so model them as
> > > childs of a parent mfd driver.
> > > Current EN7581 pinctrl driver supports the following functionalities:
> > > - pin multiplexing via chip_scu syscon
> > > - pin pull-up, pull-down, open-drain, current strength,
> > >   {input,output}_enable, output_{low,high} via chip_scu syscon
> > > - gpio controller
> > > - irq controller
> > > 
> > > ---
> > > Changes in v4:
> > > - add 'Limitation' description in pwm driver
> > > - fix comments in pwm driver
> > > - rely on mfd->base __iomem pointer in pwm driver, modify register
> > >   offsets according to it and get rid of sgpio_cfg, flash_cfg and
> > >   cycle_cfg pointers
> > > - simplify register utility routines in pwm driver
> > > - use 'generator' instead of 'waveform' suffix for pwm routines
> > > - fix possible overflow calculating duty cycle in pwm driver
> > > - do not modify pwm state in free callback in pwm driver
> > > - cap the maximum period in pwm driver
> > > - do not allow inverse polarity in pwm driver
> > > - do not set of_xlate callback in the pwm driver and allow the stack to
> > >   do it
> > > - fix MAINTAINERS file for airoha pinctrl driver
> > > - fix undefined reference to __ffsdi2 in pinctrl driver
> > > - simplify airoha,en7581-gpio-sysctl.yam binding
> > > - Link to v3: https://lore.kernel.org/r/20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org
> > > 
> > > Changes in v3:
> > > - introduce airoha-mfd driver
> > > - add pwm driver to the same series
> > > - model pinctrl and pwm drivers as childs of a parent mfd driver.
> > > - access chip-scu memory region in pinctrl driver via syscon
> > > - introduce a single airoha,en7581-gpio-sysctl.yaml binding and get rid
> > >   of dedicated bindings for pinctrl and pwm
> > > - add airoha,en7581-chip-scu.yaml binding do the series
> > > - Link to v2: https://lore.kernel.org/r/20240822-en7581-pinctrl-v2-0-ba1559173a7f@kernel.org
> > > 
> > > Changes in v2:
> > > - Fix compilation errors
> > > - Collapse some register mappings for gpio and irq controllers
> > > - update dt-bindings according to new register mapping
> > > - fix some dt-bindings errors
> > > - Link to v1: https://lore.kernel.org/all/cover.1723392444.git.lorenzo@kernel.org/
> > > 
> > > ---
> > > Benjamin Larsson (1):
> > >       pwm: airoha: Add support for EN7581 SoC
> > > 
> > > Christian Marangi (2):
> > >       dt-bindings: mfd: Add support for Airoha EN7581 GPIO System Controller
> > >       mfd: airoha: Add support for Airoha EN7581 MFD
> > > 
> > > Lorenzo Bianconi (2):
> > >       dt-bindings: arm: airoha: Add the chip-scu node for EN7581 SoC
> > >       pinctrl: airoha: Add support for EN7581 SoC
> > > 
> > >  .../bindings/arm/airoha,en7581-chip-scu.yaml       |   42 +
> > >  .../bindings/mfd/airoha,en7581-gpio-sysctl.yaml    |  433 +++
> > >  MAINTAINERS                                        |    7 +
> > >  drivers/mfd/Kconfig                                |    8 +
> > >  drivers/mfd/Makefile                               |    2 +
> > >  drivers/mfd/airoha-en7581-gpio-mfd.c               |   72 +
> > >  drivers/pinctrl/mediatek/Kconfig                   |   16 +-
> > >  drivers/pinctrl/mediatek/Makefile                  |    1 +
> > >  drivers/pinctrl/mediatek/pinctrl-airoha.c          | 2964 ++++++++++++++++++++
> > >  drivers/pwm/Kconfig                                |   10 +
> > >  drivers/pwm/Makefile                               |    1 +
> > >  drivers/pwm/pwm-airoha.c                           |  414 +++
> > >  include/linux/mfd/airoha-en7581-mfd.h              |    9 +
> > >  13 files changed, 3978 insertions(+), 1 deletion(-)
> > > ---
> > > base-commit: 264c13114bd71ddfd7b25c7b94f6cda4587eca25
> > > change-id: 20240818-en7581-pinctrl-1bf120154be0
> > > prerequisite-change-id: 20240705-for-6-11-bpf-a349efc08df8:v2
> > > 
> > >
> > 
> > Hi,
> > 
> > any news with this? Rob reviewed the DT schemas and he is ok with them.
> > 
> > Any other comments for the MFD driver and/or the pinctrl or PWM driver?
> 
> Note that the merge-window is still open.  Some maintainers, myself
> included, use this lull to prioritise other things.  This set is on my
> list and will be dealt with shortly.
> 

Wasn't aware the merge window was still open and sorry for the noise.
Thanks for the feedback!

-- 
	Ansuel

