Return-Path: <linux-pwm+bounces-5432-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACEEA832E4
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 22:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2684A880374
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 20:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA724213E90;
	Wed,  9 Apr 2025 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwyy8DdU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAA81E5018;
	Wed,  9 Apr 2025 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744232302; cv=none; b=lOs3m1FFP9K1C7FUPfeCtRRHyTRwSD8X4Zc8XRwSJ8x3vrbCmRUqEYORzx+s05i16fNadTyctC93nXBpz6u3HC1GhcWIjuZsDrXI/MzhweQ80A7MlyfKxbbcg8A8o8KD1Y9IuH3zfd1bMeIHLhMUIBk0ceBgUr69kJlVe3FGB70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744232302; c=relaxed/simple;
	bh=6ec0alS8XiULM/vgWxWgwfHpG7Je0oApq0VdXu9F0v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN0ZWi7qTMQSzlh0yu/4cX42feD/wZzLZnOwfAIg1/LeuvlrJM632V8rJ/LRTGI7krlHUwuhWbbVS4j+CpLqLZmlVyO40WDYgCD/VLTqONUSNaYvNuf2LSfMWTjk35qeOy8GrtMx2e7bOblNe6gkYBgKorVZm5Kog6jJSIn5k8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwyy8DdU; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b03bc416962so35332a12.0;
        Wed, 09 Apr 2025 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744232300; x=1744837100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0anQ+IpqWVzDF/uK9u1Pq2W1Y/RyglC7ZuUoWh/6VYc=;
        b=mwyy8DdUym2PNXB10h67fTadWN5VgDr4mhCoJJNNZ4s5FflNklIzbw95RZVFVSMhLt
         2MLBQMgaXWjVbCpzlxI7aCrbdJjL4bAghLqCN7q+w9F7iGNM4mz135O0mPwDUpoN1v4b
         qrfGockCdOiGVXfQLxryNGGuCAmvYvKRHWIPIg1BNsxaxefNdS5tx/M5eAKfakiWWXp7
         qrfOSU3+1d/nCKIkRyeilRS7irC8XN0p/dpfg3i6+YFQ1tdLOc8QIeaG9hIUq6WYlZ1j
         rZOLZvmfYE9/ZZXiyqgvsHL9f09rHhM6MxIYquZYayZfUDFpVYzljjv2yxZ/CVCM1v9B
         cIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744232300; x=1744837100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0anQ+IpqWVzDF/uK9u1Pq2W1Y/RyglC7ZuUoWh/6VYc=;
        b=nGYhDfEnsky7RKNmTwyFkB/21rLXy1PTg5jUG8xDPr80bSjue+2keOFa1n70bNLQhZ
         vOTBdAMtnQqncPH4L0++xt4E9z46+OL387OInED5Sf8JvHOOlOqicTORFgI7RONM2zuj
         dB3xVINDqd1AffmkEzf31C7hAlmR+MIxZuZcb+evgfXMwHa2XF3Lsdp6Kf9S0hltRuEr
         bUHtuj9WZDh7b84hORDvCOS0Pgan+NJy/Qk8S3yKu6SesrUS12wybDF/q8/KFv3IZETf
         LWMx3cnWxs0IVZEDSSPFWerpyt5aZBEnOJbTyyuOKxsjzdyEt/W3DKtqYaQHLnL2RVZf
         mAFw==
X-Forwarded-Encrypted: i=1; AJvYcCVCYhxoe5EHqHp2WZoI9vkMk32pmFll3aBPMCMV2IPKfuUsc2MWIDcJinUQo8bvmbs21wfmeQUyGz92Jw==@vger.kernel.org, AJvYcCVWD36u5hxYWPSTC8aDqblTveZR/QmkjnCgko8XEsIP7ej1Np4kQm7R6lwLgtnWN8DN8XMWRY2MuEfEnn+G@vger.kernel.org, AJvYcCVzaUIRo6+8u3dHBuoCvfpmohqE+jP71bMHj2r7vWJL376iYIp2Tdmv5BYWxTmwOPEmQoquGMzh3irA@vger.kernel.org, AJvYcCWEBAYghVCr/gZCdahZlwcV1s4ghAHxmwjXYt7w6uyJgGH2xrfOKlnrcBQAqqTBI4URslzf1pWngoczXZA=@vger.kernel.org, AJvYcCX3PXCEjeIUDZ2Ag/GVKb4S7mjlHeXAjnLb6bdbRzUByHLk/q7GasPBIm1KPV/vGv5J93Fz1bSaq3d8@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqwrDNodHemZHSabqWdPiSq59WgiKTQ717fxMPe6I8m1vm3+f
	0HXLlbDqoxSC7VsDotjXx3g3EvD9gR2MUDL92idJwb5tLJpFm/yE
X-Gm-Gg: ASbGncvvdOqd3BHZcnXBoGPIpSW2T9V57FSAe/aoMXujNUp4K8nJIsVBWFizN4R8FFG
	XXL5/5S1+7uYSXvAoro+YRdK8RncqkUWEPR+JVxOQsZ+zaaUm8uIMAZtftnBVLXXCFtD5z6mr/d
	33zAMh3CoAdYmB8/TD81/57ojol37M57Tt9Bm7FAN43BqvVaxFg39fhCL6rS3eouAVxb2+OHMSG
	S656+l8jqhEwCvzFxBVehmSPLG0bev1W1/q4+0UWlvNsp/xH9YFZD4FnrfmaQhDBrBucQ/Ii8fy
	uYxKxHMk2Q1LgMYIe4tOH0ITfAIhrc1MQzykqv+W+g==
X-Google-Smtp-Source: AGHT+IFpzhH7we9mCqBfCUsctssS5nONXoCjPZ/7FgmxJonyD7BwRkw3BofxA9xAGU2028ValekKbA==
X-Received: by 2002:a17:90b:4a81:b0:2ff:6fc3:79c4 with SMTP id 98e67ed59e1d1-3072ba14733mr497341a91.27.1744232300372;
        Wed, 09 Apr 2025 13:58:20 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:cff4:8871:54bb:4c97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df08f63bsm1990940a91.24.2025.04.09.13.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 13:58:19 -0700 (PDT)
Date: Wed, 9 Apr 2025 13:58:16 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	andriy.shevchenko@intel.com, =?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 01/12] dt-bindings: mfd: gpio: Add MAX7360
Message-ID: <triuq2rqofk4psfauemu6uikizvphnqg7om5x4b6sjc3tjg2a4@5fvv5l4kollo>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-1-7a2535876e39@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-mdb-max7360-support-v6-1-7a2535876e39@bootlin.com>

Hi Mathieu,

On Wed, Apr 09, 2025 at 04:55:48PM +0200, Mathieu Dubois-Briand wrote:
> Add device tree bindings for Maxim Integrated MAX7360 device with
> support for keypad, rotary, gpios and pwm functionalities.
> 
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      io-expander@38 {
> +        compatible = "maxim,max7360";
> +        reg = <0x38>;
> +
> +        interrupt-parent = <&gpio1>;
> +        interrupts = <23 IRQ_TYPE_LEVEL_LOW>,
> +                     <24 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-names = "inti", "intk";
> +
> +        keypad,num-rows = <8>;
> +        keypad,num-columns = <4>;
> +        linux,keymap = <
> +          MATRIX_KEY(0x00, 0x00, KEY_F5)
> +          MATRIX_KEY(0x01, 0x00, KEY_F4)
> +          MATRIX_KEY(0x02, 0x01, KEY_F6)
> +          >;
> +        keypad-debounce-delay-ms = <10>;
> +        autorepeat;
> +
> +        rotary-debounce-delay-ms = <2>;
> +        linux,axis = <0>; /* REL_X */

Probably this has been already discussed, but shouldn't keyboard and
rotary encoder be represented as sub-nodes here, similar to how GPIO
block is represented?

Thanks.

-- 
Dmitry

