Return-Path: <linux-pwm+bounces-4268-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 725B09E6712
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 06:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5907D165EDF
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 05:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0554E198E71;
	Fri,  6 Dec 2024 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA7koiEo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80344198840;
	Fri,  6 Dec 2024 05:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464729; cv=none; b=obS8cXAztf9SEXnAwYsIioV1CbaQKOQxSaUYKsmLEuY9yswQg3zQEnOYOFt3yCr6w4t3I9DZg0WyDZEbHccuVR3cvkTOZcNnhw0Vq3a0W42qBh2GdoEtwRueiQx/S8SdDKVI+HmAVX5ImvYtmS4x1rSdV6r4NFwQ6kUSEAR/j+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464729; c=relaxed/simple;
	bh=x4S3iAhnAFj8GBNk3CQKE5jmKknNggmxCeSbl6PFhO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezcs/MmjEOWp7bVp3YFi7a4+CNQJ6vpFyHyHHoOyTZjad7itsD7hblGPCUfMfEX1XL/SqWwh1Eqwd5uUETKhry9VurjAwz/b7KbnbPHOo+botYZXIz5dx5Q1PlLkeu6nSuumeppw4SQwPsXMkIQ0yMX7+JXx96jEOr0g0+sOK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA7koiEo; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2eb1433958dso1215815a91.2;
        Thu, 05 Dec 2024 21:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733464728; x=1734069528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMffPOBou4ApM/oKbk7Jpz+gd/smlJwjIwPuRVUfC5s=;
        b=GA7koiEokqI8MZVVCEjBy+E2Uccct1AwVw2bHtB7AAPh7fiKM82niBfjoFDJggvdDb
         E3ysP/8o8hmiBzVYRlvXJUMR0yk4t3OYlfXIULm7KFjp7JRvk6dpAioFKe52aVMnSnL+
         8Cm0XLhsLpP0sc8BkhGCWvYBFckLOmSePzMVu6teXJy2N1aPhmWwTBt+LAPJ1/vERVpo
         qyBoPW+gcpmy+4yz33N3oTXi4+6OZA4D3BYv2+KZ2d4x/H8AqVvKIAtuD252RK1p1FuX
         0828YBvEcZOOIV2b7AnrKn5F3wyOZA8usPnVkVcsP0iOB6gv5LKluaYDN/52gNvVzQy3
         xmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733464728; x=1734069528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMffPOBou4ApM/oKbk7Jpz+gd/smlJwjIwPuRVUfC5s=;
        b=GZ+Fax35zi49u0ShXqDBdivSK4q+o/XB/Vd5k1iF+FXLMkM3e1kT/kaItVZ0yZb7oD
         9FXANT3/TPz5pkSfi3CW1k7vGlRpbKWD/Q88pvcGLcIBf/EOJKK+st9u6iFN5ExXAInL
         dbkV3QigFWRfbjj7RKC2VCODrT1hFeukCyeCfewFjDqsXHIghP0eCGlNbVfPxSYngj4y
         7uf6YvG+Yo7RGyvOC3AXaIT0ysiPCrCgwejWHBUVB3COKUOKk4HwgWMoSIywzq7DowcO
         fpiu3cj8i+7FQjtko0m+YKoNTdN1hl8l21YWwirjFeIVcheNKw58j/0oYXbnOTM2n82t
         CxxA==
X-Forwarded-Encrypted: i=1; AJvYcCXW6EGORvpNcU+nRXw+z3yZ56/xjJm8mmzV/rjRfKDpab/fJ/pQWQ3SKRit2H1sj5A6WR2/uTDEMXmc@vger.kernel.org, AJvYcCXtLVElIZrr1OyUekjSz807nbi8vzyvDEn/lhbHbnWM1oY6hGkuPmFUqjotrrzycBcEtW/R/aVSG1zk@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/t899WzVJCw6krBSLF4p/D4/O6czdNgJwpZ5eAtK+8RrOFwR
	11NWzK6T45I8PlJXI3cQz1loxa4shjO9ezo4kmuhpGguzAGqmp2B
X-Gm-Gg: ASbGncuiR2F/WGVdLDEXwKvYD/Qw+8XRhE5NUJRe4yCakx2Hp6IHjeXsD/AyxgmrUV7
	QGFh5LBcx0v+hZ1qCyMBBq3t3BWd/YgxvqRfNeC2se0jsQc862JLVrkZs5tZWPa9ViIZoiEln5t
	tD+8iLjMD6fI1zs5830KQ5YeM17uR+WBZ+K5uKUcAgkK/XuzU/r7dYM43XQplTE2wX8WjxNEAsX
	uDm3koYuY7Y8WampBffrs9o43WEKJScsKAnry+ZzMiz7hy7sv1HJdPAHF6EYhqtTpJXJ1Ai/BLS
	738LzAJHz3HY1KFYQgCWS5wKQnI=
X-Google-Smtp-Source: AGHT+IHPfPT9xNQNvD9xypuyp32gyiz193e3lLstgaForyQc7I6KAvgXXUi+e6BBqDK4LtBmwvD8/w==
X-Received: by 2002:a17:90b:558e:b0:2ea:4c4f:bd20 with SMTP id 98e67ed59e1d1-2ef6ab293a0mr2793171a91.32.1733464727811;
        Thu, 05 Dec 2024 21:58:47 -0800 (PST)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef6ef14312sm451774a91.46.2024.12.05.21.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 21:58:47 -0800 (PST)
Message-ID: <57648ce7-7c43-4ac5-81d9-35e8a624df22@gmail.com>
Date: Fri, 6 Dec 2024 13:58:45 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 2/2] pwm: Add Nuvoton MA35D1 PWM controller
 support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Trevor Gamblin <tgamblin@baylibre.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com,
 cwweng@nuvoton.com
References: <20241024104309.169510-1-cwweng.linux@gmail.com>
 <20241024104309.169510-3-cwweng.linux@gmail.com>
 <5a6ad0dc-f777-4129-962f-e10a0f7d6ee1@baylibre.com>
 <fllw3dv6juj2vepsnrb4lajh2j7b42jl6rzncmvt57gfaalgiv@sypw55h54oag>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <fllw3dv6juj2vepsnrb4lajh2j7b42jl6rzncmvt57gfaalgiv@sypw55h54oag>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Uwe,

Thanks for your comments.


On 2024/11/21 上午 06:03, Uwe Kleine-König wrote:
> hello,
>
> On Wed, Nov 20, 2024 at 11:49:48AM -0500, Trevor Gamblin wrote:
>> On 2024-10-24 06:43, Chi-Wen Weng wrote:
>>> +#include <linux/mod_devicetable.h>
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pwm.h>
>>> +#include <linux/io.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/math64.h>
>> These should be organized alphabetically.
>>> +
>>> +/* The following are registers for PWM controller */
>>> +#define REG_PWM_CTL0            (0x00)
>>> +#define REG_PWM_CNTEN           (0x20)
>>> +#define REG_PWM_PERIOD0         (0x30)
>>> +#define REG_PWM_CMPDAT0         (0x50)
>>> +#define REG_PWM_WGCTL0          (0xB0)
>>> +#define REG_PWM_POLCTL          (0xD4)
>>> +#define REG_PWM_POEN            (0xD8)
>> These too, I think - it will make it more readable for others.
> Keeping the registers in address order is the usual thing to do, so
> please keep the order of these.
>
> Otherwise I agree to Trevor's comments. Thanks for taking the time to
> look at this patch.
>
> Best regards
> Uwe


I will keep the registers in address order.

Otherwise I will modify per Trevor's suggestions .


Thanks.

Chi-Wen Weng


