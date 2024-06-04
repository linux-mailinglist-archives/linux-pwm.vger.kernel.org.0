Return-Path: <linux-pwm+bounces-2336-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 953078FAD8A
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 10:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A707B2362B
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C65142E82;
	Tue,  4 Jun 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3NdYkn6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C81142E76
	for <linux-pwm@vger.kernel.org>; Tue,  4 Jun 2024 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489577; cv=none; b=MWSSYTMogi/lOr/4bJGPrcgH7iUBEO3xpqoXK/7yEfYDdwS36bs88TibiYiwloTC8WKPFGOQf6AAHtd9DaUk/vEM19rXXFXqCzqA/UMzBzmjcpnYpU39G3glya+M0XzZUWHAfm3+UJshMr3Qof2yVobAIagSu0T6GfADCglhx28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489577; c=relaxed/simple;
	bh=C0NttUi7bk+qnq6tjHZ3W69g1kZG9ZqBS+YTOPy5s8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaeOg8LIDceI+5ErB+WUFiB8jCE3zmPzITcFkublVIEcOdWVbVrrFfRy9/zOQbynrNyodX1mEQWdz5+Zgqkkyqel8D+dK42x09NBsWQO8vtPxMsiNUwRHYhlqWmZcBiHVkB21aVvx9wFVzXTVUSQjdTHqPQcUugr+92RA4QIWik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C3NdYkn6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4214fe0067fso2994785e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 04 Jun 2024 01:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717489574; x=1718094374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wlKZ403FDWNGF/aP6AfR2xSYQMCc2kz5Co6V9DrQwhI=;
        b=C3NdYkn6EY6LLvu4tsoie+ncdbMp+KVlfpXB6MnLJ5W2y4pYHbiOMSa2qQdrf4HGjo
         7mK7KQkP3qF5BG05T8lKfppzLlO2Nfgmxn4yhZ8v0m4dVH/j4fZM1kmp0uKCBmsxydWv
         XqgPuh72Y/rHhfNXsGYjxceMOEKwWsRrOQdgzrO0dwkbPbI9Jkl6PApvfZRU4o/Xwo12
         rA6k0ub1iv3V5NvsGLZnCKv3XaEu1HChSCpblSTtYsYBGffofGIrDoF/8SSvGFjyPB2o
         U4NMQMh2yNx8XKtcaShwjyiG97B6OOPAEp/o6oVkUgYYaeWkBRfk87b/bxjvt/v07/IY
         iriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717489574; x=1718094374;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlKZ403FDWNGF/aP6AfR2xSYQMCc2kz5Co6V9DrQwhI=;
        b=mvVM8PmnIdMJ3S2OZpTf4hG3/GzdoJGqljSrGBvDLklUdZ4BB8/i+1JzcqoBx+BDxk
         CijKti0t/eOz8LXjDyYwKYX7jgjHnhOA6MZ3ac2PDeEAy92S2l64ziW6fSMGqVXNi9q7
         z890xcMT8mJlWOiiESQIhNJ/KhNdXZEt4v91V7PQzksPlhmDmAQA65trW/43h2TqdGTR
         qqmKy8HGNZrUd80W/uqHXLMC4/ivRrKwYIaXY8TBqs7JVTesFH10UbKvwzH7U7HIiwWR
         HtHAaURF0yox3mNkCEEM87gXFjHGLx2lra/LO7Bj364pt3n8cChYptNyvn7+Idbkwc4u
         SBNw==
X-Forwarded-Encrypted: i=1; AJvYcCU5OOJXzxPNhHyFem4A/BadSGuugY2AvwmGzOfZlEByh1Flr54v5FreJnNlBvSSlYwNLPaFke0DqFuHpETl/fHgD6aSMZ2DGWVR
X-Gm-Message-State: AOJu0YxYiD270UY48Gpu52TVBbXI4hrVH/8atw4usQPZEST1hfBT41JH
	qlIAlmsGA/z14IiE1mzTEYLj5Ckn0m1oWomd92Nlfyh3c+Afrr7WA/8vdVLPraU=
X-Google-Smtp-Source: AGHT+IF3q/rSSBJYgi5/GHq+1ec4MdDY2wrRXpjAhUx6h40+LiYqbHtT/peszUz53CUMLnHpTv0ECg==
X-Received: by 2002:a05:600c:3547:b0:421:276d:a0df with SMTP id 5b1f17b1804b1-4212e0c191amr74807615e9.41.1717489573998;
        Tue, 04 Jun 2024 01:26:13 -0700 (PDT)
Received: from [192.168.2.24] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127062f0dsm173211795e9.17.2024.06.04.01.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 01:26:13 -0700 (PDT)
Message-ID: <73dee17b-b2ae-4e43-9bad-28cbbf4a978b@linaro.org>
Date: Tue, 4 Jun 2024 10:26:11 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: pwm: Add pwm-gpio
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
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
 <1edbcf6d-92b7-4971-b8b2-a88cc96995e9@linaro.org>
 <20240604073413.GA137333@rigel>
 <7679dd6f-c952-44de-8863-2f0fd12f372a@linaro.org>
 <20240604081632.GA147954@rigel>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240604081632.GA147954@rigel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/06/2024 10:16, Kent Gibson wrote:
> On Tue, Jun 04, 2024 at 09:42:25AM +0200, Krzysztof Kozlowski wrote:
>> On 04/06/2024 09:34, Kent Gibson wrote:
>>> On Tue, Jun 04, 2024 at 08:21:32AM +0200, Krzysztof Kozlowski wrote:
>>>> On 04/06/2024 04:51, Kent Gibson wrote:
>>>>> On Sun, Jun 02, 2024 at 10:33:08PM +0200, Linus Walleij wrote:
>>>>>> From: Nicola Di Lieto <nicola.dilieto@gmail.com>
>>>>>>
>>>>>> Add bindings for PWM modulated by GPIO.
>>>>>>
>>>>>
>>>>> Shouldn't the bindings be added after the driver?
>>>>
>>>> No. See submitting patches document.
>>>>
>>>
>>> Hmmm, ok, so "5. The Documentation/ portion of the patch should come in
>>> the series before the code implementing the binding."[1]?
>>>
>>> It just seems odd that you document something that doesn't exist yet.
>>
>> It's logical. First you define the ABI for every user, then you
>> implement the ABI. Do you first implement software and then design? Or
>> first implement then write interface (API) for it?
>>
> 
> I don't see the relevance of your analogy.
> This isn't design, this is roll out, i.e. publishing.
>
> Not publishing the ABI until the implementation is available seems more
> logical to me. But as long as it is all in the same series then whatever.

Anyway, that's how Bindings and kernel development works. First you
document the ABI, then you implement it. Not the other way around.


Best regards,
Krzysztof


