Return-Path: <linux-pwm+bounces-3440-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DA598E62B
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2024 00:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23621C216AF
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 22:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB6E199934;
	Wed,  2 Oct 2024 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqyYenck"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C2512B63;
	Wed,  2 Oct 2024 22:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908967; cv=none; b=c4TM2irC0MFYQrd9wPoU+1E6U59PdA7tKX3JwzE71LV7paKoPzcoQBAQb6lNMnof9kAJ4udLquKFkmkAPYqClU+VUivoM6ISnlU5nra36dH3Y5ZZBkMbEC3IUWESIU81GOXWyhLc40r5VgIYYlp/O1OptiIQ/qW59Sxx82C6yRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908967; c=relaxed/simple;
	bh=gtvN60JxUU+oPzyRigM/mR6Z7ienkrBpP7+1WtznRZM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcGlOsGTNrezWBxxqdtpqjUyWyn3vEyT4GYjzLJPFnurRDx55/LW2deryiNFyRb0mcu8saacjgm8u2g1A3b1yOJyjEGoXjPSJa4WEhsqZIrAwbWAJWBJKegFp48MgytE3uenCwmS4Rf/qKX/aQ2guDgrWg6ZqvB195ezDK2tdVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqyYenck; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so2443135e9.1;
        Wed, 02 Oct 2024 15:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727908964; x=1728513764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2p0RBsu7N/ikXAXwnKT3iU6dfYBdSsewWojsryZ8yU8=;
        b=aqyYenckN1kIRO3/nNbWjl64Q2cK58tWrPDIP1BaU6rhvAQISaSh3xenn4WwbGj9nZ
         cVSu8MmOK/9F6cbW3/HQ5YXEJAmPOhhWwx4hHaOUmHbgpTvsQGcxAejPZRWQvqiToZZn
         qKD9eOgz446LwPGwuGnQyikXETEmTB7zVmmyxoMd2kg0unarnU9Lx9SknXyZOQcAuO8F
         6b2xQ0+mVoLy9MFLaEQ8qUa28wMcbOQoW272rHmIAv37pCYGn00VPS1F6L+iOpxRXAw/
         h77Jldc24duXJzzqxdwPNkgbFh4Pgel2TRLgXnF6kcAFDCZZeAfaGDEuQPrJZVmrqxGd
         ZUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727908964; x=1728513764;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p0RBsu7N/ikXAXwnKT3iU6dfYBdSsewWojsryZ8yU8=;
        b=l7KbKkdH1Y+pzAzDB3tbafwpgnyD2EYHQLfKP/t6EudHj1Of4nQ8Uonpuo20w+ZzPr
         geRx5/oDEBHlgaimB/ZNwBGdpLEPdeWXX0bPlnEpBJbBoOTGjoCng1uMBTOx9Wxl2We4
         n9/NZM3xy4qEVOwymZtTDJ+DMPQ3VAl37+Ee5W+Aqp2LEp6NPzs+SIl7ye51FTvnwiKO
         DPwVqdZqCiKHfuyhiRI+dhyNH22OtBsJegSU1k3h9AMmsaDUCuqxC5lC7F0DAekMFgYR
         2AHVmRAkckaL3okbG8o0qM47m60KSqcVcm79M7Of5sOJb3atH7fqj995R2zwQrXcFyMF
         pQqw==
X-Forwarded-Encrypted: i=1; AJvYcCU3evMZhxmvhbWFos74exG8Dxf0j5/tJYqs/BfGqp6txAyW8v6dka0UZWET2D9opfMVvJWUvW+oIce6@vger.kernel.org, AJvYcCWkBFiXAfjrXQ5cRpDsAfmOkSE5Jgn6GSbTm0qeUYCagElSYVpPClkoqC/aQbDa1LNIfLlVj29qO0ww@vger.kernel.org, AJvYcCWtO+O3uuUDrG890RV3Qwbjflz9ovBH4UeQbmergxC6WY/jyCl6Hb2IvUXs60jBX2IrGg4ufU/ipkyecg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNuNXi10iBd3LRfjlTOjlH2Zj6gacovcJg3yDt7FnubxG9xf8h
	dD4HtzD/gFAWn5HCQu8H88FcnuW6LAKpD800j8uEd7SjuNx12oCO
X-Google-Smtp-Source: AGHT+IGuS5mbK7XVp3K4dA2IOkM9MUozkblHFQyW/rtCI15UZMMVWwioBkHnlLQdNZX3oeUM5mifCA==
X-Received: by 2002:a05:6000:50f:b0:37c:d49c:3ac7 with SMTP id ffacd0b85a97d-37cfba16a65mr3033353f8f.48.1727908964057;
        Wed, 02 Oct 2024 15:42:44 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5742602sm14778829f8f.94.2024.10.02.15.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:42:42 -0700 (PDT)
Message-ID: <66fdcc62.df0a0220.15bce8.4398@mx.google.com>
X-Google-Original-Message-ID: <Zv3MX0046FvdpeYU@Ansuel-XPS.>
Date: Thu, 3 Oct 2024 00:42:39 +0200
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
Subject: Re: [PATCH v5 3/5] mfd: airoha: Add support for Airoha EN7581 MFD
References: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
 <20241001-en7581-pinctrl-v5-3-dc1ce542b6c6@kernel.org>
 <20241002132518.GD7504@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002132518.GD7504@google.com>

On Wed, Oct 02, 2024 at 02:25:18PM +0100, Lee Jones wrote:
> On Tue, 01 Oct 2024, Lorenzo Bianconi wrote:
> 
> > From: Christian Marangi <ansuelsmth@gmail.com>
> > 
> > Support for Airoha EN7581 Multi Function Device that
> > expose PINCTRL functionality and PWM functionality.
> 
> The device is a jumble of pinctrl registers, some of which can oscillate.
> 
> This is *still* not an MFD.
> 
> If you wish to spread this functionality over 2 drivers, use syscon to
> obtain the registers and simple-mfd to automatically probe the drivers.
>

Hi Lee,

let me summarize the situation so it's more clear why
this additional mfd driver.

There were various iteration for these 2 driver (pinctrl and PWM).
Due to the fact that these 2 are placed in the same register block
with the PWM register in the middle, we proposed various .yaml schema
that could better model it.

The first idea was to map the single register used by the 2 driver.

        pio: pinctrl@1fa20214 {
                compatible = "airoha,en7581-pinctrl";
                reg = <0x0 0x1fa20214 0x0 0x30>,
                        <0x0 0x1fa2027c 0x0 0x8>,
                        <0x0 0x1fbf0234 0x0 0x4>,
                        <0x0 0x1fbf0268 0x0 0x4>,
                        <0x0 0x1fa2001c 0x0 0x50>,
                        <0x0 0x1fa2018c 0x0 0x4>,
                        <0x0 0x1fbf0204 0x0 0x4>,
                        <0x0 0x1fbf0270 0x0 0x4>,
                        <0x0 0x1fbf0200 0x0 0x4>,
                        <0x0 0x1fbf0220 0x0 0x4>,
                        <0x0 0x1fbf0260 0x0 0x4>,
                        <0x0 0x1fbf0264 0x0 0x4>,
                        <0x0 0x1fbf0214 0x0 0x4>,
                        <0x0 0x1fbf0278 0x0 0x4>,
                        <0x0 0x1fbf0208 0x0 0x4>,
                        <0x0 0x1fbf027c 0x0 0x4>,
                        <0x0 0x1fbf0210 0x0 0x4>,
                        <0x0 0x1fbf028c 0x0 0x4>,
                        <0x0 0x1fbf0290 0x0 0x4>,
                        <0x0 0x1fbf0294 0x0 0x4>,
                        <0x0 0x1fbf020c 0x0 0x4>,
                        <0x0 0x1fbf0280 0x0 0x4>,
                        <0x0 0x1fbf0284 0x0 0x4>,
                        <0x0 0x1fbf0288 0x0 0x4>;

                gpio-controller;
                #gpio-cells = <2>;
                gpio-ranges = <&pio 0 13 47>;

                ...

        };

        pwm@1fbf0224 {
                compatible = "airoha,en7581-pwm";
                reg = <0x1fbf0224 0x10>,
                      <0x1fbf0238 0x28>,
                      <0x1fbf0298 0x8>;
                #pwm-cells = <3>;
        };

This was quickly rejected as it introduced way more complication
to workaround the overlapping addresses. (the device should map the
entire register space)

The second proposal was a parent+child implementation with the
pinctrl parent and the PWM child by referencing a syscon from
the parent.

        pio: pinctrl@1fbf0200 {
                compatible = "airoha,en7581-pinctrl", "simple-mfd", "syscon";
                reg = <0x1fbf0200 0x0 0xbc>;
                airoha,chip-scu = <&chip_scu>;
                ....

                pwm {
                        compatible = "airoha,en7581-pwm";
                        ...
                };
        };

Also this second proposal was rejected by device tree folks
as the device implement both pinctrl and PWM in the register
space and they are not actually separate devices.

There was also an additional proposal with the entire register
map in a dedicated node with syscon and pwm + pinctrl using it.
This was also rejected by device tree folks. (node that have only
a syscon are a nono)

It was suggested that this is a case of MFD (multi-functional-device)

As suggested we proposed a simple-mfd implementation following
common pattern. Parent node with simple-mfd and syscon compatible
and 2 child nodes, one with pinctrl and the other with PWM with each
his own compatible.

        mfd@1fbf0200 {
                compatible = "airoha,en7581-gpio-mfd";
                reg = <0x0 0x1fbf0200 0x0 0xc0>;

                interrupt-parent = <&gic>;
                interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;

                pio: pinctrl {
                        compatible = "airoha,en7581-pinctrl";

                        gpio-controller;
                        #gpio-cells = <2>;

                        interrupt-controller;
                        #interrupt-cells = <2>;
                };

                pwm: pwm {
                        compatible = "airoha,en7581-pwm";

                        #pwm-cells = <3>;
                        status = "disabled";
                };
        };

Also this was rejected by device tree folks as the property for
pinctrl and pwm needed to be in the MFD node and there should't
be child node with single compatible.
This comes from the fact that DT needs to describe how the HW is
modelled and not how the drivers are implemented.

Finally Rob agreed and added the Reviwed-by on the current
implementation with single MFD node with pinctrl and pwm.
Also Conor and Krzysztof agreed on this solution for the task.

    mfd@1fbf0200 {
        compatible = "airoha,en7581-gpio-sysctl";
        reg = <0x1fbf0200 0xc0>;

        interrupt-parent = <&gic>;
        interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;

        gpio-controller;
        #gpio-cells = <2>;

        interrupt-controller;
        #interrupt-cells = <2>;

        #pwm-cells = <3>;

        pinctrl {
                ...
        };
    };

With the following implementation, the only way to probe the
additional driver is with a specialized mfd driver that probe the
2 driver by name and we can't really use a simple-mfd implementation
as that requires child nodes with compatibles.

Sorry for the long message and I honestly hope we can find together
a common path for this between driver and Documentation.

Is it clear now why we had to ultimely had to implement and model things
this way?

--
        Ansuel


