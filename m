Return-Path: <linux-pwm+bounces-3704-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD4C9A3B78
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 12:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DF79B2097D
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0321FF7C2;
	Fri, 18 Oct 2024 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIZm/1eG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374FA168C3F;
	Fri, 18 Oct 2024 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247272; cv=none; b=sVF+zRf6GQk7iT8kFvBxmQnBvwIAp/SNh+pnDLkRGbYj40j1GUJyaJ9gRpH/5mTZZj6kJ0vnTPzaxWR0YvmyLpNUW8d1Duu8Uv2etMoeXwoyytc6Hr9BHJUeoaw+srsAmQ+roKR9iiL9WKEVPeQFe7C4FjFO5mK175Onc/viZSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247272; c=relaxed/simple;
	bh=D+k61GlGmp9xnyeEweCLRQhF29NqI4DCRl0Dei3Ft/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+EQp1fmIlVGbe6DS5keUTDNud1+MSsbw9isWSazUwqLLRNNKlealvb7kh3dQymEFNv9bOCTmbP61UObOOord9YaDN08cy03UPzDNTwsoWPYFNw+4cqgPaLxZBO0vt42gpzicyYuAUUPaIeWGepGbZvB0A1wZEfCtucZoNARYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIZm/1eG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e72db7bb1so1432335b3a.0;
        Fri, 18 Oct 2024 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729247271; x=1729852071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzGrat2AIxNp3RzAvcvun8G0SGCMp1qpX1sAcp7NBo0=;
        b=cIZm/1eGqLP2tKm4N6T/azaZL+SZ69tQTxnFyZmqW+iuFKqaSDsTh5K8qCsNCEK9vu
         yZLMsZXUKVSfd8DcFNlPjYo4PrwbpvWsAtsZCW7lmOEcnfAT/QXvM41T8+kDUhaN31Te
         0GgXj4QnYqjj4kKrKJUICn3vFDYYgI/cRsIp5GPiFHT49WaEDgRQrfli4m3bHolo3Yqr
         iSEcf5mZKiOSfXiKJJGWIF1uV071sKaWwjKZZYQHGFiUD/rXcHgtF/oU+ENO22eecfxB
         DAQ/nrrEq8Ox6Z9FKzgMrSchW7HKVgNpNxGXhZpbxCf9DR2Z41RikjAeoGkCZ9bjBOvz
         B77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729247271; x=1729852071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzGrat2AIxNp3RzAvcvun8G0SGCMp1qpX1sAcp7NBo0=;
        b=LWbfFg0bfzkYexCk33eSjoheg7MxpNjjNw+oPKARcxqDwp9mI0MwLkepAD+m/geqgZ
         U7tUR5wchzTHmfIu8IuVS4MK+rNYMMGVugUj3QzgMhh7PVSX/A1mE1jgVCHyoiwTZDTO
         fM7cZCIFKAmjCs8i2ba/fkBlYzw31b6oBLx2A9ZsyfGGaeLD+559wpeT8UdZbp/3cRSd
         hC38vZM2/JWYBHOvGFTp9Ecr7/RkPoQIcOQfY4pEjPStpIhN4iUqMCAZYTHLksLr+jfV
         L5Y4jxHml97zysSFhWe+Wqnv18TWJ/dmklzYj3J30pTHYyE59Pj+p72Pivf9p2Ld2lPq
         qD1w==
X-Forwarded-Encrypted: i=1; AJvYcCUDWWs0arL7cAyXIBDd1JalJqtFT/d4eVIQDMY20auNtwh2Sk8MyMuhYxaJhr++mzPjfczM/V6D3ILj@vger.kernel.org, AJvYcCWQc6oRZZkd1MdPcYe0pYV1J6C5ug61UAGIhl1ddSdjKtaNO5cupAGo3eN5hmsdFEYTzkYVMWrENgLr@vger.kernel.org
X-Gm-Message-State: AOJu0YzJG0dH3mxdMbtXLrMaBrwtuEomAQ9RmojfdLm1KiRXV66p3nQY
	sQEkBV6glfcLwvgR2f+G5/NSU5lojHbn4rVrQ1upvHXrDAWRHGbX9C/wixvi
X-Google-Smtp-Source: AGHT+IHJFKH8VgX2jlAj3LDOHGle4eJKxnJIYbP1K/0wx6aabQpq0puQdRE4PgDjKb9NaNz+F1B6Og==
X-Received: by 2002:a05:6a00:1a8a:b0:71e:60fc:ad11 with SMTP id d2e1a72fcca58-71ea325b1acmr2619040b3a.16.1729247270448;
        Fri, 18 Oct 2024 03:27:50 -0700 (PDT)
Received: from [172.19.1.42] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea34098f9sm1114907b3a.112.2024.10.18.03.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 03:27:50 -0700 (PDT)
Message-ID: <3a3f5c78-f85c-4dd1-a559-3ce2dd8dcb25@gmail.com>
Date: Fri, 18 Oct 2024 18:27:48 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pwm: Add dt-bindings for Nuvoton MA35D1
 SoC PWM Controller
To: Krzysztof Kozlowski <krzk@kernel.org>, ukleinek@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com
References: <20241018034857.568-1-cwweng.linux@gmail.com>
 <20241018034857.568-2-cwweng.linux@gmail.com>
 <a06afa20-8f69-45dd-8dce-272ae7da6d39@kernel.org>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <a06afa20-8f69-45dd-8dce-272ae7da6d39@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Thank you for your reply.

On 2024/10/18 下午 02:02, Krzysztof Kozlowski wrote:
> On 18/10/2024 05:48, Chi-Wen Weng wrote:
>> Add documentation to describe nuvoton ma35d1 PWM controller.
> A nit, subject: drop second/last, redundant "dt-bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
Ok. I will fix it.
>> Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
>> ---
>>   .../bindings/pwm/nuvoton,ma35d1-pwm.yaml      | 45 +++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml b/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
>> new file mode 100644
>> index 000000000000..95f0a0819f53
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/nuvoton,ma35d1-pwm.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/nuvoton,ma35d1-pwm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 PWM controller
>> +
>> +maintainers:
>> +  - Chi-Wen Weng <cwweng@nuvoton.com>
>> +
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nuvoton,ma35d1-pwm
>> +
>> +  reg:
>> +    maxItems: 2
> Instead list and describe the items.
Sorry, it should be 1. I will fix it.
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  "#pwm-cells":
>> +    const: 2
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +    pwm0: pwm@40580000 {
> Drop unused label.
Ok. I will drop it.
>> +      compatible = "nuvoton,ma35d1-pwm";
>> +      reg = <0 0x40580000 0 0x400>;
> But you have only one item here? No, that's just incorrect.
>
Ok. I will fix it.
>> +      clocks = <&clk EPWM0_GATE>;
> Best regards,
> Krzysztof

Thanks.

Chi-Wen Weng


