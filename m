Return-Path: <linux-pwm+bounces-3794-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2A59AD96A
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 03:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8955D1C2099D
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 01:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFDA50276;
	Thu, 24 Oct 2024 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbsnQzg4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F311BDDF;
	Thu, 24 Oct 2024 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729734642; cv=none; b=AnRgtlspBFXJqPtnMsw6qsp6C6AjIlwM3eGGFaV62sry1IWujFyYkB3FmJWLeeUZOjjpm88Q3fhnMiFcXSpqMHYTxMrr1C/3un9opPzntXOp11YXUIxThYXfd4C4NYIIWv31/poWC7ns9TV4+9LfBOtTB992kQWIfj7zyC6FGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729734642; c=relaxed/simple;
	bh=3BGN/wG5mPauv/lMeMUM0L+kgPwg/L3mUNouI7PoR+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDDVpy+CXgTVM3hIXAOJMriv+QeJgKW4mKZ7Gxn1BMDaExzqk+1qIUIXIlFb4iZONn7oWgHIFs+kVNlM1hpGkV5Blgc6TL/D8kP+JAE0b5iLO92tJAb0atRycGZOoYmId2CJvqgvBPZdpy0k1FBJVsecBdWSjNtGUbdtWTOVAmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbsnQzg4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso325986a91.2;
        Wed, 23 Oct 2024 18:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729734640; x=1730339440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BGN/wG5mPauv/lMeMUM0L+kgPwg/L3mUNouI7PoR+w=;
        b=KbsnQzg446nEtlXCX9nkeekUbK9HS22vVck0p0lxO46sYbBLSSr7JbzcKKA2b1KiHX
         0Zir5buxi+5B1LekpNUID/I1WQUY+9FTI/JMZRdZ6OSES5P+kZj+dDIXl9kIUr/ccUXy
         PO6QIjT8jA1/bk39RYps8m5W36tsWi0CAsNfcKi0hy8Cq6NvtbzVXpzW1xS2vPQRCkXz
         cpTd7FyqFC3zae4br5pMU3T6odtm6pkrrnGGPwo8yr34v98f0jO9c0NlSSmTaA2+avRI
         HFGYYa/eX5UgS1E5VTsTQIq0WXZmvTNb5+BCXXQ8mbDOwEuA7mI1N4TlH03shGBEB3iV
         R+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729734640; x=1730339440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BGN/wG5mPauv/lMeMUM0L+kgPwg/L3mUNouI7PoR+w=;
        b=FK39kM4HxLcXUnFlWqB2t+jCywkxuUuPbYtXGsgvX1I686QvSEvXfx2RDXufVvuZx/
         NIbSi+Yxldnw95LgnPcq+Ord0jGKYe4m7JuAGBhbNtKtE0S0NDBJHtGMVg3rY7XlbJZz
         ipDSaRRLBD+jLaXd+4BB39qPYG1JFtyXcoiB0BYQl9/1hXtPfLsLiichAuajin1mjhoz
         4kpxSYDcj2IV817olqwDcOD12bqUt/UcxmDRoGPhRqJ4Z0PdityXTai86WIib++a/8NB
         qG1rkKhgOfUWSGfF+2nJh87eldls12CUGuYQ29LMj2PkrfgtP/r4G84NcN8T628A4Cdf
         nVMg==
X-Forwarded-Encrypted: i=1; AJvYcCV/uspCFKUzX9WeOzRLppKCkuqyfeO/6YSLlveqC9fjxB3NUZAEXzFLKXzdkWn17wIqQ5nLJkB0Iiny@vger.kernel.org, AJvYcCV7/N2InEmSyp+KTTWD2d09fZCpHqfTOfJoR5H0vvOw8996w4n6OyuZyAOGGfiquBHJWTt18HCohoCc@vger.kernel.org
X-Gm-Message-State: AOJu0YxcS9KT57OrC5eNVMOiuQmhjfenBT8oo7SItyb0vaMJeZ0zJxUZ
	YH/OTmW+0wONS3GodsOJLXK+xMmywlZv8cJ5fUfHFgpZw4/JP9uq
X-Google-Smtp-Source: AGHT+IFzf+/5m94efCTT5fJp3X8/qjsyvdbonIYb2YgutuSqnskEo4jYjgWg+CZKCmEbgIhIH1sObg==
X-Received: by 2002:a17:90a:8c08:b0:2e2:d181:6809 with SMTP id 98e67ed59e1d1-2e76b70b2d4mr5006884a91.39.1729734640447;
        Wed, 23 Oct 2024 18:50:40 -0700 (PDT)
Received: from [172.19.1.42] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e534efesm184312a91.33.2024.10.23.18.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 18:50:40 -0700 (PDT)
Message-ID: <c32fee1b-3961-4cf1-92fd-14b17a0caf40@gmail.com>
Date: Thu, 24 Oct 2024 09:50:38 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
To: Sean Young <sean@mess.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, ychuang3@nuvoton.com,
 schung@nuvoton.com, cwweng@nuvoton.com
References: <20241023111841.158049-1-cwweng.linux@gmail.com>
 <20241023111841.158049-3-cwweng.linux@gmail.com>
 <1087f21b-d56b-4ab0-bb56-96096c23f0d8@linaro.org>
 <Zxj8C46QeSt3sboN@gofer.mess.org>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <Zxj8C46QeSt3sboN@gofer.mess.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sean,

Thank you for your reply.


On 2024/10/23 下午 09:37, Sean Young wrote:
> On Wed, Oct 23, 2024 at 02:02:14PM +0200, Krzysztof Kozlowski wrote:
>> On 23/10/2024 13:18, Chi-Wen Weng wrote:
>>> This commit adds a generic PWM framework driver for Nuvoton MA35D1
>>> PWM controller.
>>>
>>> Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Reviewed-by: Sean Young <sean@mess.org>
>>> Reviewed-by: "Uwe Kleine-Konig" <ukleinek@kernel.org>
>> NAK.
>>
>> Stop adding fake tags.
> I never sent a Reviewed-by either.
>
> Please re-send without those tags.
>
>
> Sean
Sorry. I will re-send without those tags.

Thanks.
Chi-Wen Weng


