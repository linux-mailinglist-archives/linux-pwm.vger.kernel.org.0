Return-Path: <linux-pwm+bounces-4871-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC0FA329EA
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 16:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DD9166311
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200C22116FF;
	Wed, 12 Feb 2025 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Juf8u0DI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA751D5176;
	Wed, 12 Feb 2025 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374029; cv=none; b=RhlSlIrUGZ3mxhU7Y/1y4IOqLsYf+4qJNflDy/tgTVmpBBVjqoQ+lUJ3/HR23nvr5uaiFQYrG8HPF6Mcro+x8aTsqtKAbj59KNnbexAv5aUg7d1yF9jY5drEFNy37aWQYi8zwdYl2agNgzNJlQ6AxDMpavpZX8IBoeQHBiBGYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374029; c=relaxed/simple;
	bh=vXb91Ul9iBMWPquG3+W+4DcTajC2yLwY7ZGjkG3818w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM39tMqt9gpofymrYKEoA24VD/9csHWE9a/cUln4llfHNsEAJVlqFXAU2JRCfXdNHV2a22+tYVL8koGGoOBrUqFdTEXm3pDsDUgV7D1cdC2b7qTgc6FvO3MDdY70hTu6R4lb+oLKilmmBAydBdYl4KribN0ujEw2211rR2h2gU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Juf8u0DI; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f3ac0c8053so1704322b6e.1;
        Wed, 12 Feb 2025 07:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739374026; x=1739978826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6lBUw25J3aG4YuuDsQwkeYgRv1vrc7t3xa9HzM9MOvw=;
        b=Juf8u0DIvRCGzSEhI+VaN06b4x+LwrVMNofbK5cAwI7W69fOwAKs8q8Jt5/bymEYsZ
         l1t24XObwzvhBGSzPv8m0/2dV/xeB2HiGqbqAjaFCHlMNOyW1XGW9mjOqY50UCUY08Xz
         zGzDdJ7aLL8HtL7Yy/wIwgMr9iwL9BhebJHPXwjoXatuIdV+nVtUsjzdCv6ykWg+u5bi
         lMN/zTMn3QctVl2v80/NaddlFRULYl14WriIXvGayJQGqNS6P8shif5gei7SZ9GTz/vc
         0SZ+tBBc3W3iwN2v3DiNo1l40XhFdzuDp80ut6Ecdd0zRNfTEUVS2sUkskqeIAb59Xdf
         myNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374026; x=1739978826;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lBUw25J3aG4YuuDsQwkeYgRv1vrc7t3xa9HzM9MOvw=;
        b=neX+mLoShP08WfsseCW4zNnu9hxgCmq1z1OcXTi5rVNrF5+tA1ikEloUACrNcaEqbe
         C/M+7Hc+zGZul0d0a5kSv57xtXU5hcELzJ0aeWB4AAyJ5xBB0ZwyYdIE2gVi/Y8iRm9t
         rXVCeg+GhNcC8fiQyeOeVCKjma0q1HrA5ppLyrrIPEkmsZm9Mc+DZNWmV19WtdHo4KYk
         YuETbmGojj17mzPKfKBYtJzVwYMMdxAC4oU22LLc+spnUKmmYyFE/1tc8JpejsQT+LJ+
         5oo/0uU1r18W1l0KKROMAk8qtTPSijDp2T7JLc9FyBxELe/+20NjIQuKVhgUWNdhdvDE
         NLtA==
X-Forwarded-Encrypted: i=1; AJvYcCVq+kfCFOULTs6Z3v7e/4LBCjZBZl3NR1RB5WoMACyS5/rjuEHlmwQwzHqxL1LR2LfHa8a7ZO932178@vger.kernel.org, AJvYcCXWMPj+9QnZ6cML9n0lBFDrLi6UWoo1FW0zsvOr3CBNN/dQWH4gYXZMrSi/7SLjK4lCk1cmG9OfbRdx@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUhqnopv9v3G6vdXONwic6tjgjqmku9ww5a2Mr3UCkhs/9YcC
	ptxWzs5HasGrd0+nXziBNjKEhmks6p0dLvpsavbUxNV1w0yG5lh0
X-Gm-Gg: ASbGncvVRUgc/Z3sEzcSAJMcnsCdYBv6b00uhRa7q80DAYi6UkBaj77RBO/EsvvbSL9
	MyVVAY0MwiuU3NyeDNf0RNOCsDNB8a2su2l60dH0qJAV2U4x8yJs1gt11/b3UD8GDo/b5lGQpiM
	/hVm3F3gwht/+F/a6i5OUyXEwg6rRdE/dhrka8zOubZMiueCpe5GW9T5Xg6qhMibImnjmXISfkZ
	HzvQYb++DYk+dqWESkbTeZJltTA9gEhaO2QvkbxdkiMK3ey+tJu8kqq9zlQlY6hDpDMufI1vOCD
	Px9OPhDIHGRh97uT0dNEHA==
X-Google-Smtp-Source: AGHT+IHo4moDm0XlC/zbhfkvivNmDn6gThhjx1PDMEofy79uK89Vl0WpOwwZ4GUyPbza40pljwyLmQ==
X-Received: by 2002:a05:6808:2518:b0:3f3:bb75:1706 with SMTP id 5614622812f47-3f3cd5cbae2mr3016870b6e.9.1739374026359;
        Wed, 12 Feb 2025 07:27:06 -0800 (PST)
Received: from neuromancer. ([2600:1700:fb0:1bcf:511b:97aa:dc6:7ad4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f392481cbfsm4066579b6e.39.2025.02.12.07.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:27:05 -0800 (PST)
Message-ID: <67acbdc9.050a0220.11fcb1.a43a@mx.google.com>
X-Google-Original-Message-ID: <Z6y9yNpdsVUZ1Q4k@neuromancer.>
Date: Wed, 12 Feb 2025 09:27:04 -0600
From: Chris Morgan <macroalpha82@gmail.com>
To: Aleksandr Shubin <privatesub2@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Cheo Fusi <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 0/3] Add support for Allwinner PWM on D1/T113s/R329
 SoCs
References: <20241011102751.153248-1-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011102751.153248-1-privatesub2@gmail.com>

On Fri, Oct 11, 2024 at 01:27:31PM +0300, Aleksandr Shubin wrote:
> v2:
>  - fix dt-bindings
>  - fix a remark in the driver
> 
> v3:
>  - fix dt-bindings
>  - fix sunxi-d1s-t113.dtsi
> 
> v4:
>  - fix a remark in the driver
> 
> v5:
>  - dropped unused varibale in the driver
>  - fix dt-bindings
> 
> v6:
>  - add apb0 clock
> 
> v7:
>  - fix a remark in the driver
>  - add maintainer
> 
> v8:
>  - fix compile driver for 6.8-rc
> 
> v9:
>  - fix a remark in the driver
>  - fix dt-bindings
>  - rename apb0 -> apb
> 
> v10:
>  - fix a remark in the driver
>  - fix compile driver for 6.12-rc2
> 
> Aleksandr Shubin (3):
>   dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
>     controller
>   pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
>   riscv: dts: allwinner: d1: Add pwm node
> 
>  .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  84 ++++
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  12 +
>  drivers/pwm/Kconfig                           |  10 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-sun20i.c                      | 379 ++++++++++++++++++
>  5 files changed, 486 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
>  create mode 100644 drivers/pwm/pwm-sun20i.c
> 
> -- 
> 2.25.1
> 

This patch has been idle for a few months, would you mind if I took
over shepherding it to mainline? While I don't have *this* hardware
to test it with I have an H616 which has a similar pwm controller (and
for which I was going to add support for once this made it to
mainline). Otherwise, I can just wait patiently and then tack on my
additions once this has been accepted.

Thank you,
Chris

