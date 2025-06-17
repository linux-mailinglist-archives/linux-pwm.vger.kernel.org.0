Return-Path: <linux-pwm+bounces-6422-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2F4ADDDAF
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 23:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8CB17D2E3
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 21:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20922F0034;
	Tue, 17 Jun 2025 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yb3NEH+Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9DB2EAB62;
	Tue, 17 Jun 2025 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194640; cv=none; b=PEXFgWegeN6VKqvPZJPCqEVlk4bJiUKE01BXeROzNHsAqiDsTadzaaf3rNmEmuWLU1MMY/ouJ2DnB+6PwX6/G5Ew+PWCMGB4z4bAxWDcAsfyLowU8OLiz9k/X6NG6Aj8ahcPQgo3lYNg4yoNJMw3bI86Iw/C9VaOC1/OInfZaIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194640; c=relaxed/simple;
	bh=sApRyw/83FX0mHOukxosCTIJQnSPeVEGxB42AaW+5to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7cTsCk3bXXBAEfdJDvM/m8M1ZCBIrANrdA1c+GCl6ke8riS13jkxzLDgGyeqbMEoxXZU7qIFxaapqHQFKf+6v0cYfRlNQyAH08R6/DoNzJMOX0KV62Angrm4W/yY6PQQwOrSjsgmJ5s7zEoE3+qWfq4Xf7n1SOqro23Mcz5JDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yb3NEH+Y; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af51596da56so5606076a12.0;
        Tue, 17 Jun 2025 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750194638; x=1750799438; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pacpGAeIB8vccBmUPzGNrrDXKDk1i4FugJTPtb8YCUI=;
        b=Yb3NEH+YVgz3Ke/N/wpfuFtfg0oQnw5eA2ArM6VhyzuSmK3y0RNVrzG0DcOEgKBDUM
         JuYl5uRTgUkmEYDBzpGWAhoPgoNzhAZ89lpkyGJ2aQ1XQtbuD0RgGDTkQuC4ZVkYyUWM
         KjPHGa3lPLIju0ywPPvowFFGv50LbuLg+bIQN29GH302a3YCJiNOTiUCpE2b72Yx6tUF
         KD5ZZGJ0PbEAK51MA2ClHPKenuqT7CmrpdQpVc3rRa9WGfmEXr58C72wF7Z+FZ2ci69D
         41G8UD2jHWA+muNbrYI0QS80drbuXzfECnbybmbnYNJdsirNZxi14xpvWKnDt/Pf8ryK
         PeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750194638; x=1750799438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pacpGAeIB8vccBmUPzGNrrDXKDk1i4FugJTPtb8YCUI=;
        b=QTPEUpG8SHsyDP6zKE3cUo3vMkP3PKh2rOrEDTqSKY50HQjuwYJ4MYRhu7IzxO5wtB
         k4FGoElSSlTJmd/0FReK4+w8dn6i9OvCH0lMt+gEAXHTANM7q76tS10p3mfqtrJ0VbMv
         Jzx2C8ZqFTh0UfaVCoZ2eZpdOTdN8u0QD1Hxk5ag/ZnaY13IVPbgrqvsloDpd+7K4C4t
         JPh5a2z71cwY3ww0bOmpfN6+F4yiV7yv31XwoVkQkLGAtah4VKSKJeDhY9U9kBADBoY+
         h/F385Pa1NgGR00l4GAnWE6Lu9KLCzuNHC8Ic6joE3lfqVeHxPIiNgVD6HWpwjJLCq9+
         Lpdw==
X-Forwarded-Encrypted: i=1; AJvYcCUpOvmGPBXZwbe40cv2lEm4IB18jyJZBMz/TiD8mb/UQHM+XzLIw2Qh13cIteC1n5+vBPLKW6rLSRxiXDA=@vger.kernel.org, AJvYcCXUnRRp5ajK5dGRYHNJrnPPnPwsISVVTUZiQTl9FEW9rbLqUH/gxPMln15dc6Ci6iGBwtvvgobErZ2w@vger.kernel.org, AJvYcCXYJZPgEbSzrgzzgya9Rc7eKdbnhNTXDqU3Th6BRH88NNXPACuikrWE38zI4Q/CCVi4Ufv6igrwATS6@vger.kernel.org
X-Gm-Message-State: AOJu0YxCUvQtaPd0K1ssHcGfgyAL9I9eADGESSONdOmJ2vWSCs/nf99k
	YPgHcp6qgs6MXo3rJINUa1Q0lZJh/rmdrCJYeKyYJL5jlgEYLgMwz0ga
X-Gm-Gg: ASbGnctBEHzLt28yBJeY6sj3AeD2Ql9T3Xvid18y6uWhZdZuk+r4H5QQlz8IVlIi9KQ
	Mzhf7AOxK8r3bJ2yIYW1jq/d3k0uQV+R0zz6B9if4d6/zQ7NoiFaRsRS0eazOtBs9zzqtpAakhq
	YJfXeUvS52/bilVeAzbcEp/ocfP6eSlTSg2ACbyl1jIJKY5n4IqBm3gXkIDbLvSABpHOlAtlqbb
	ct9bUWBFXO49n8orCDGX5MKULXBD43aJDH4szw3gAM7Z2dAokZjDvy3TvdZzlIIFjc+pvZ/Hj0B
	ZynQuN9Q0Sv1qWb2w/sjdREDdMv/tjcR/flTnkKZqkp6Td8bd8aSrZOEkTBk5RI=
X-Google-Smtp-Source: AGHT+IHeZPR21+uN+iM3V0TWJomLWQgMoI4gIh8EmsTejpP79DYSaVKbQxz9iI5Kblcxysbl6x4XOQ==
X-Received: by 2002:a05:6a21:62c9:b0:218:9b3e:e8bd with SMTP id adf61e73a8af0-21fbd4d5553mr20905329637.10.1750194638536;
        Tue, 17 Jun 2025 14:10:38 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:8d7d:9cdc:2836:83cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecd29sm9395962b3a.31.2025.06.17.14.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 14:10:38 -0700 (PDT)
Date: Tue, 17 Jun 2025 14:10:35 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v5 16/20] Input: adp5585: Add Analog Devices ADP5585/89
 support
Message-ID: <bq4dj2ptdp2mahc3gekgy6lxwljv7p3frpohtmjp7kaif63sqm@n7hvwsf43wpb>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
 <20250614-dev-adp5589-fw-v5-16-7e9d84906268@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250614-dev-adp5589-fw-v5-16-7e9d84906268@analog.com>

Hi Nuno,

On Sat, Jun 14, 2025 at 03:36:07PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> This driver supports the keyboard function using the platform device
> registered by the core MFD driver.
> 
> The ADP5589 has 19 pins and also features an unlock function.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

with a small nit:

>  
> +config KEYBOARD_ADP5585
> +	tristate "ADP5585 and similar  I2C QWERTY Keypad and IO Expanders"

I think this should say "ADP558x keypad support" because this sub-driver
does not provide GPIOs anymore. If you decide to keep the original title
then please remove double space.

> +	depends on MFD_ADP5585
> +	select INPUT_MATRIXKMAP
> +	help
> +	  This option enables support for the KEYMAP function found in the Analog

s/KEYMAP/KEYPAD maybe?

> +	  Devices ADP5585 and similar devices.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adp5585-keys.
> +

Thanks.

-- 
Dmitry

