Return-Path: <linux-pwm+bounces-5481-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A097A888CA
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Apr 2025 18:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44ADD17ADB7
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Apr 2025 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3BD27B4E2;
	Mon, 14 Apr 2025 16:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hX8TYN1P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D051B3929
	for <linux-pwm@vger.kernel.org>; Mon, 14 Apr 2025 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744648934; cv=none; b=hbKyWq3odzeUKpwVRHYU49LhsoPuNJfnyMwtXVWeYRewj4Dw8TmnHZhc1OOoQgMIQGimQ24hOkVXh8VAFpqPjLeafEeGEkOoYf/JqYycBdLUrxi1vBpOq2c22Q2nxYttqDnAe1/yweSjniGkCkTkrRhDiBdlAXIUiR/keNLHAl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744648934; c=relaxed/simple;
	bh=/66OOPt3HW87DIGt0O3zeDKL07onErJWuovRqfFxozI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbUuB/1DhunT9+xTk53Qlm2F9snh2ggNFQTfunXsHkFd0tMPkrh2/CAdOz4CA0bk+Jps2Xy3ztszVD8NWRxjFM+zpHG45dHh3TtFd74FC1W1O+NICW3U6KY92lk6TSZ7gC15LrAPvX43ifAnoGIguxF/uB+N7zOC/ysRifzO2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=hX8TYN1P; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d6d6d82633so14986205ab.0
        for <linux-pwm@vger.kernel.org>; Mon, 14 Apr 2025 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1744648932; x=1745253732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Nkt4V2QTjnSapTTILkS8+oLHV4hk8aXAHawaxgiQGU=;
        b=hX8TYN1PYNy/nmPF/II5MiG+V8PfyrF+NkeYDgiX+Yc+bjR9Q3d74Eso8mtqQ6FHeN
         0c+nulRxKECsUzPCFrSpRfYhBcY/Nf1Ft/8EkFh9EwExgspoplikFdCB5FKGVWbx3Gmr
         mr6BbyX9jm8UUOVDlSPv06fU2CI1G+yvYhfPLNiZnNDv+dqBw24rH1gHyrkPcEqx6ZKF
         odUJG2kHQyRESc08O8EKti8rnQdtwH2+o5Ha+UFJj7Y2ACdaT0IXfnVTJEJtSfmsjm0h
         bKilJZI4/vmxycBxsmDXqudtUVfgQVN07LUXSZXdN/vlQUwksZsehlbK/pLOZIj/T3uO
         tSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744648932; x=1745253732;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Nkt4V2QTjnSapTTILkS8+oLHV4hk8aXAHawaxgiQGU=;
        b=Ga/qRvUNibq3TopcsWM2+7ddLJ1mTIhGR7hk6Bz5a5b6ThurhCh/epuSxOtIpbBIcm
         0EZ3EQx68uuXsI8EKbuemHwOiADsdA8AkDCPSeJVodkWjtouhGJDkmD4jAKR2yQaxT0R
         yRJ0lea38gCJmOvqAttr+bGb4jzUMvX6Y1g6MwlIfyNDqbMsGCJmlgFaz23h7IcYh0oB
         NcDoU9ZjKUMl/RsQESWzFRiLntDa+RPG8DS+MVVNNFV0GCzOwRVM3SMcBJN6BFCm8tfr
         JrvcjOeBnnJFkPY5oZo4y4Mh/492tZxAn43ydHwCoYIxuu76Ohtwx2MP7VTzk0s6+jgF
         ZJKA==
X-Forwarded-Encrypted: i=1; AJvYcCUkblv9RLvrkkjLqIvOby361RZJDm2prgWKxlk4u8PhzvJKYou7ULMRF0h/19fj5NcvLNMnfmRiWhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypSvKRbarbcHoJTSXI4ZlKU7aZrEuHJk2xvHevZqLc43opwgrx
	enbMP8yfBjjoagfTSecvNGKFsDerudn//pFOTRb81DdtVfDW0z6EygTfO0L15ek=
X-Gm-Gg: ASbGnctLvM8+5WYoRgeUw66G+7hPtlP45lUoTuOav1o+/YgnW33Uz1+Qp3HysLIPrpE
	Roc8T1YisLMZ3Th5gG/KEe+jeF2d6zCn31ree/AEmPguFQieCyl2JRwwYx/fsA/vcDBQUIFNI2q
	oA0gWGPEPPt6w444xw6ZuutFpFUy0vsQOMt+hIEre+uwuwLLVyruAyo+VQTyAZyvl9Co+eIAaQw
	dpzBkmW41WVw5IV5ruCOzmFne1/nFICfSEUodoMhhoIlYkrF3kPR4daHC6ZdencwZMnKAmBhxqP
	StBB6OKcG3Y53DJq8YOnr6beEJsN9P3bsfiCmADvGA7Pj6XQ17htkNYObw==
X-Google-Smtp-Source: AGHT+IHXcv1gAGtPs5um9SWMJJd18WOJ6IiYOGvEA56wWlYHbTbN9OhrdEHa3Nng5MJO18XCSyHZBw==
X-Received: by 2002:a05:6e02:338b:b0:3d5:bdac:c927 with SMTP id e9e14a558f8ab-3d7ec27c9eemr148288925ab.18.1744648932034;
        Mon, 14 Apr 2025 09:42:12 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.166])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dba9bb63sm27527735ab.38.2025.04.14.09.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 09:42:11 -0700 (PDT)
Message-ID: <9a51fbfb-cd06-489d-8deb-4323eca496fe@sifive.com>
Date: Mon, 14 Apr 2025 11:42:09 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] riscv: dts: spacemit: Add pinctrl configurations for
 PWM0-PWM19
To: Inochi Amaoto <inochiama@gmail.com>, Guodong Xu <guodong@riscstar.com>,
 ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, dlan@gentoo.org,
 p.zabel@pengutronix.de, drew@pdp7.com, geert+renesas@glider.be,
 heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com,
 unicorn_wang@outlook.com, duje.mihanovic@skole.hr
Cc: elder@riscstar.com, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-7-guodong@riscstar.com>
 <ujkfb3ajvoebrkvoepztgh3afzw5dq7djefvdddiboo5gxu63x@dlflpzwpv26u>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <ujkfb3ajvoebrkvoepztgh3afzw5dq7djefvdddiboo5gxu63x@dlflpzwpv26u>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Inochi,

On 2025-04-11 5:50 PM, Inochi Amaoto wrote:
> On Fri, Apr 11, 2025 at 09:14:20PM +0800, Guodong Xu wrote:
>> Add pinctrl configurations for PWM0 to PWM19 in the SpacemiT K1
>> device tree source file. Each PWM instance is assigned multiple
>> pinmux configurations corresponding to different GPIOs and
>> function modes.
>>
>> Configurations include:
>> - Mapping GPIOs to appropriate pinctrl nodes for PWM functionality
>> - Specifying bias-pull-up and drive-strength attributes
>>
>> These updates ensure proper pin multiplexing and drive strength
>> settings for PWM signals on the SpacemiT K1 SoC when selected.
>>
>> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>> ---
>>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 315 +++++++++++++++++++
>>  1 file changed, 315 insertions(+)
>>
> 
> I think this is too much, I think it is necessary to leave
> already used one.

If your concern is about compiled DTB size, you can use /omit-if-no-ref/ for
each of these nodes, so only the pinmux nodes actually referenced by a
controller are included in the DTB.

Regards,
Samuel


