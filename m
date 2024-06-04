Return-Path: <linux-pwm+bounces-2332-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13478FAAA0
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 08:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D93B284D0B
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 06:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8AF13D897;
	Tue,  4 Jun 2024 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rO3ufyh7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DDB13D638
	for <linux-pwm@vger.kernel.org>; Tue,  4 Jun 2024 06:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482098; cv=none; b=iOA71X5oQEnax+vkvtd2gUBF3/puJ2d7rfbSsNn57BG47OBpHa4IRv+ytHKmYpRTHet0M/jiL0VhnU+Wx+2G57/z+GmpxLo4BfauLDZwOiKY2HaSuKcnzqU0Z5beOFV4jPyows+l9CFJCSuvWIzsipireD/QFJMLzCiADheQ/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482098; c=relaxed/simple;
	bh=J5zHaQEN6XB6maQnaeWhn5cEjh5SQBvkBxWJC/aJGK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TF/Xu84gg5r51udgRtm/RKtgEe3fsP/wPzDC4bNDGtWHExqLQuchVIK/gLyD0OioBOGAO4U8roQs9TcQaKmTCmd8n4NWfnKlzf5xs5Ql1TXE4Yynroe5XnwRedBTSK74phgeEjA/rKoGVvJC4USxb7ofoPse1ggbXh1PFjas/oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rO3ufyh7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42153115c65so1044875e9.0
        for <linux-pwm@vger.kernel.org>; Mon, 03 Jun 2024 23:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717482095; x=1718086895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B8sQahDrjoScfm+agbtuJV1P0Pe7NzGDpTACbPs++zE=;
        b=rO3ufyh7xdaD6Ombiy8IQO9Clo9bZHzwmGPddzVdFtEN0Onp6JUdiebCsvwVivQqF3
         rf1ckpeHx6vBgrqa6cCMPmzkUXvj1aJZWDG+/zKCuWTdVwz/7QNipL+4HghO5X69Qrkp
         QrTXqIER9A1R8p5q8oBXuehidIu0gm8Q/oKJdABlKl8iQcIxY4FJGzv0WDvWJB7kEJw1
         SQfT/VJFFYbGAXuYhdqSiNfAyVXz3kr7NmoxBx3GXkPuQMkLJdXLSiD4XYalzuEgLPz/
         V9umW8NpeX+igME0a9VH3GG5V90cQ3pGIwHrNCICh5ZQ7yBqIDLWwgd1rATZreHBb/9D
         +s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717482095; x=1718086895;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8sQahDrjoScfm+agbtuJV1P0Pe7NzGDpTACbPs++zE=;
        b=P2QpfOxt0lKS5zG4J15LfFq5/B5etgVkPQM9PzCzPPhyGCosovSV+pr8xTEgwS5QSE
         fNRW0nrzu3zhimKlTfhsqejBa4PCzVxMTuUS30eKYCpkkKLwpUZ1yQ912EJ7SJ/G4GuH
         FjSpOIrMNl0j7xor3H3kHlW3x0lwVMJBY4x4trq7P/f8fYRZZkTTZWC233l9ktq3BszQ
         mi7JciTasUX88WswKhM6nAk76lg9uqQd3Tw957VN9uCdokSnKQbzjfX0cKHgXK+1AFJ/
         vJ0O51EFMnhm7EuBiy19YS2wG0mDDV5W1J1FjovRYOk7H+9qgVWDRa+3Td9Ve/Zg62AB
         yC4w==
X-Forwarded-Encrypted: i=1; AJvYcCXzubuLFOZCSLLH9facaBrOrBjN//n4/vTWdY37QD6ccdRbnRS70SP6+IdClqX3GaAh1KMF+76K+8VIv/pFW1WCuUR9Zg+XqJfO
X-Gm-Message-State: AOJu0YxNIzIbciii29TTeawM/tgToV+eW+S40i3hJPBj8JUiwxF1SS9X
	gGKGAdhDP7y/Um3cIUDjj2d9ctYB4QVnm8oZKwT27w8gYMf7lJUTTTMHs9bDFdCPROdCL+5ePXK
	9BDE=
X-Google-Smtp-Source: AGHT+IGkWze3aEaY4p9PZJ0+1RmUPt4m0uQfE2go1PTOPTix1pzyVk58KjJsHEiWk1lCngpkWpdC4w==
X-Received: by 2002:a05:600c:3550:b0:420:1853:68c3 with SMTP id 5b1f17b1804b1-421417bd9aemr22587885e9.20.1717482094637;
        Mon, 03 Jun 2024 23:21:34 -0700 (PDT)
Received: from [192.168.2.24] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42139688d82sm83185485e9.3.2024.06.03.23.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 23:21:33 -0700 (PDT)
Message-ID: <1edbcf6d-92b7-4971-b8b2-a88cc96995e9@linaro.org>
Date: Tue, 4 Jun 2024 08:21:32 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: pwm: Add pwm-gpio
To: Kent Gibson <warthog618@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
 Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
 Chris Morgan <macromorgan@hotmail.com>, Stefan Wahren <wahrenst@gmx.net>,
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, Nicola Di Lieto <nicola.dilieto@gmail.com>,
 Dhruva Gole <d-gole@ti.com>
References: <20240602-pwm-gpio-v6-0-e8f6ec9cc783@linaro.org>
 <20240602-pwm-gpio-v6-1-e8f6ec9cc783@linaro.org>
 <20240604025137.GA107618@rigel>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240604025137.GA107618@rigel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/06/2024 04:51, Kent Gibson wrote:
> On Sun, Jun 02, 2024 at 10:33:08PM +0200, Linus Walleij wrote:
>> From: Nicola Di Lieto <nicola.dilieto@gmail.com>
>>
>> Add bindings for PWM modulated by GPIO.
>>
> 
> Shouldn't the bindings be added after the driver?

No. See submitting patches document.

Best regards,
Krzysztof


