Return-Path: <linux-pwm+bounces-3793-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54529AD964
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 03:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61714282E61
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 01:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6DC2AD00;
	Thu, 24 Oct 2024 01:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLKK8fDA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C87EAF9;
	Thu, 24 Oct 2024 01:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729734361; cv=none; b=iJWljv2YN8MLR5HZrW7cuUnglnh4brmQOlQPUtt+vXFtBg0m5g5QdiJwlu1pKT9OXZ4TZl5EbGWUFr85VzzwWPMi7KxfYXVbTr94h3Ekwe5doBKKKSEkxT+RK4YC29qkNBrEbfWqsQVbYeMfwIU9gnveNq5qzLO2MOHR3bZS3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729734361; c=relaxed/simple;
	bh=ZZC8vUXOYoxYSD8ql/VS5TkPDqQ3x1C1NI6GDMzH0Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKDLntmcETmO+18Wy/bax2I8rnoaxtA1bw8t249mVNpN26EYxyJ/Kmu20QC9f7E2DrEUmV9zJFQfT4kcygfpaeunqM38QK2emmrkw7czSR+tnl+5dbUv0b9K2U33afBfUaSGpKeTWTAMQU1LsiJv8PUWsF5sGS47USqIo1jNl2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLKK8fDA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71ec997ad06so287646b3a.3;
        Wed, 23 Oct 2024 18:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729734358; x=1730339158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZC8vUXOYoxYSD8ql/VS5TkPDqQ3x1C1NI6GDMzH0Y8=;
        b=NLKK8fDA2+33Kjcez/rhMvjnrNk+ft4xfr6HtpTgVPLk/fHwpfiqxmN7pbTwxz2IzF
         5lgpO5GI3mlnEX8jNujpm3Wl6VK6lyC0DuVPDTiemPJAEvISsO0PNTTUx828Q5AX7Zb8
         AFwKb6WyHSUu4LE39q1mtzq0bsSsBY90vefQvwdDVLYeN46p8NcvyU15fxRq1gpnNEhS
         8A00/KRqX6Ki0AZu852XTae8llzHTsmVEhJCYp16Oq8SjzEH9Ict+SEf2vju0ekclEW8
         IrETz9AhFHGz5rWgmxCouAmHShZULWGqC0G09ZT1OkxUxOqIvzjuOWUOFmwq1/xktMwd
         Dmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729734358; x=1730339158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZC8vUXOYoxYSD8ql/VS5TkPDqQ3x1C1NI6GDMzH0Y8=;
        b=rZiYno3MzDunp8wKTYwXft0QsEtS/IEUcH0K7qhSE6FTqG3kZ2nTn0Jc4xCjOFABKb
         gvATujPft6p01Hoe5LBvzRFR6OAAyAlDTINVdbSc5PwMwNMi9tjr3o+1nzPHQo4Ng45L
         0GMrjn0pIPfRf7pkLjNNWKDBFtoZrRRdIXV5UsZ4sNozo8DXIT3dZCUYFVkVezMEZSeN
         8auI1LPBVjYUkQtYiND+kKBCO/HCyjqM3P8B/Fr52GVw87n1E4kjAllrgQ9jtqnPZHbB
         QRUyEa3JSOFItpg0LaHb+ObeYxN/fE1+sypT2U/agH5bMwyFYILlgqkik2T1i+yJJ7Mi
         vB6g==
X-Forwarded-Encrypted: i=1; AJvYcCVJoWR8GWKPClMDweC1jUS7GySs/N3Z4IVMf9UsuIEIc42RdmJ6Im1H8Bv58LLD3JzbntrEG7C8ssYv@vger.kernel.org, AJvYcCXUTaQ+co41tKqxvAL4uAMqKx3AVuniXa3yLYu7mT/NtFYFrZHsgtMc1+n6pR5FJ9xKwPw/4O7hyf6f@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Yw0QDCODEDnTVGizyeXRVQ0LT8rJxAhpSAQfQ7J5sNOtmBFQ
	vS5HecS9XML0TomVpQ5aXZJMZrJFAtIeva6G5W1KXZJ/mleZrAFN
X-Google-Smtp-Source: AGHT+IFuF/ZAZGdrP1VRNS25yOA7DLUuOv79sCOHXxqnBKQDPz7B4xhiqqXElobnlwzEGljImyp9Bw==
X-Received: by 2002:a05:6a00:190e:b0:71e:4c86:6594 with SMTP id d2e1a72fcca58-72030a51d13mr6901623b3a.10.1729734358479;
        Wed, 23 Oct 2024 18:45:58 -0700 (PDT)
Received: from [172.19.1.42] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13ea1aesm6944900b3a.155.2024.10.23.18.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 18:45:58 -0700 (PDT)
Message-ID: <c4f16a03-6f4d-4aba-939e-14a406bde723@gmail.com>
Date: Thu, 24 Oct 2024 09:45:56 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pwm: Add Nuvoton MA35D1 PWM controller support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com,
 cwweng@nuvoton.com, Sean Young <sean@mess.org>
References: <20241023111841.158049-1-cwweng.linux@gmail.com>
 <20241023111841.158049-3-cwweng.linux@gmail.com>
 <1087f21b-d56b-4ab0-bb56-96096c23f0d8@linaro.org>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <1087f21b-d56b-4ab0-bb56-96096c23f0d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Thank you for your reply.

On 2024/10/23 下午 08:02, Krzysztof Kozlowski wrote:
> On 23/10/2024 13:18, Chi-Wen Weng wrote:
>> This commit adds a generic PWM framework driver for Nuvoton MA35D1
>> PWM controller.
>>
>> Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: Sean Young <sean@mess.org>
>> Reviewed-by: "Uwe Kleine-Konig" <ukleinek@kernel.org>
> NAK.
>
> Stop adding fake tags.

OK. Sorry again.

I will resend patch v2.


> Best regards,
> Krzysztof

Thanks.

Chi-Wen Weng


