Return-Path: <linux-pwm+bounces-3959-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8589B4ED3
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 17:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C084289AEE
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 16:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBD8197512;
	Tue, 29 Oct 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZOV0yQf0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD576196446
	for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217844; cv=none; b=DrvhmjqoiF5Fk+BWfQ605NqzmqIlsi9lil1CD3dQTU3O/7ukpFvTbLWF3HsbJEaLCtarhcRbE/n+zCApa4Eiy/w5r5kaNz/6tEqEJRvAuCgQMTK65JMVxIu2EBJax+/CpT43kFKmqvbKzfP2wtAu1GKdzcZlMF27oFFIM1ZYTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217844; c=relaxed/simple;
	bh=AS2Nb1W9+f0eR2gQXtFsAi2eMFnmDLfRevR2T3NHQA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtwL2i2NE4KiSl7qYfaeKJzG/xo2cE31c5BhHHw5sYlFBjsm+gFgKoxK0bWT4lqqZ51Qs/4GoetyebolA0ArhVOUEe/ZEnJrsG8Rg+VBw/ngRLi6U7+b4+6pEIL6K5Q5c1NgVLHEXH66twj9t7xlAG+eFKNsJN8n0XZqSxJ4YGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZOV0yQf0; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ebc9bda8c8so2608134eaf.0
        for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 09:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730217841; x=1730822641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NVarP6PjU9eb6xoU6oTub3mnCxBAu8wX1kKk0MQH4yQ=;
        b=ZOV0yQf04s5BZaBBP+jWz62CIfZvORsYdorWgNkvWTkigrdfA+VJUwY/JRzkytUZ58
         3YbcVa9CLToFOlZBelIos4OlWn2Xc5jbDVHP4g7ShtNSYr+LwHOBaYZn6CfYf/qADwix
         cNK+KZoHsGnDm31OgBWE2vOQsb8pjBYJb2S+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730217841; x=1730822641;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVarP6PjU9eb6xoU6oTub3mnCxBAu8wX1kKk0MQH4yQ=;
        b=u9cCZ+B49iO+D7HSSthxHM2Sk11XqmVAiPQDZtnEZuD9BzoV3cq0xfMiaVjQTVhHbs
         bSyZ+5kLzTxsrn4xtgDOZgpG4fGLvpcINIQsF7B2oOV0GFFpZlu690I1Tvx5PBp/FhFw
         SpviR+WowVvEgoeF5zauri6/RCdbAKGYDrNaD4DkRbJGaBcqTnxzDFBVncxQVET4l9EN
         U5KrGUBWQvxHnDC6wgGNzzCQ+awMmzbMBgRpWMGZMwdYI5j3qMNRQrqjRHlrJCq+wSMg
         AofGCo5MdZIdmUCab37pfCvnfCYP8y9T5Hcl2Y1da9H2VNHgXEB3fcINaxUCcdt3x06S
         H+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpc/USgrdKyhakGays4/xPfW0lg2pQv9sEuNgstYXMZY8CJnLRk2r7xGTd/isp2jSlCsqvyJ/oK+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO6RcfcObhgdJMdEjLO8Rn5tz5J58rgGPHt/N0vAUPaHCSyWd6
	iW+AhayK3QuTH2uUzRdRhmv+mFx3fJd1jKb3+sXHUvIVkaILlwJXMIs+N/E6pw==
X-Google-Smtp-Source: AGHT+IHDW02jORThNkphPVR5nYXaCzOIi29r7kEzU4Ib558j11YspqnCbtEZ+pfyDZ8Qps0FYb9L7A==
X-Received: by 2002:a05:6358:3997:b0:1c3:d00f:fffb with SMTP id e5c5f4694b2df-1c3f9f8173fmr492234355d.27.1730217840455;
        Tue, 29 Oct 2024 09:04:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a5660asm42888206d6.140.2024.10.29.09.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 09:03:59 -0700 (PDT)
Message-ID: <c623075c-fd80-4312-90ba-4f8a3c3f56f9@broadcom.com>
Date: Tue, 29 Oct 2024 09:03:57 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pwm: brcm,bcm7038: Document the
 'open-drain' property
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Florian Fainelli <f.fainelli@gmail.com>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, justin.chen@broadcom.com
References: <20241012025603.1644451-1-florian.fainelli@broadcom.com>
 <20241012025603.1644451-2-florian.fainelli@broadcom.com>
 <20241015163200.GA1220909-robh@kernel.org>
 <252b6f39-3b06-43b7-b227-1c29c1c12bd5@gmail.com>
 <7aok7zs7whxfg3bhv7koxfxq6qhgv34b7kg3mh526z2cf7e23l@ffbsxqdqjis3>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <7aok7zs7whxfg3bhv7koxfxq6qhgv34b7kg3mh526z2cf7e23l@ffbsxqdqjis3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/29/24 03:44, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Oct 15, 2024 at 10:07:10AM -0700, Florian Fainelli wrote:
>> On 10/15/24 09:32, Rob Herring wrote:
>>> Another thing to consider is for any PWM controller with more than
>>> 1 output, you might want this to be per output and therefore should be
>>> a flag in the cells.
>>
>> Yes, that is a good point, this controller has two channels, so it seems
>> like increasing the #pwm-cells might be the way to go.
> 
> So the idea is something like:
> 
> diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
> index ab9a077e3c7d..d18b006a7399 100644
> --- a/include/dt-bindings/pwm/pwm.h
> +++ b/include/dt-bindings/pwm/pwm.h
> @@ -11,5 +11,6 @@
>   #define _DT_BINDINGS_PWM_PWM_H
>   
>   #define PWM_POLARITY_INVERTED			(1 << 0)
> +#define PWM_OUTPUT_OPEN_DRAIN			(1 << 1)
>   
>   #endif
> 
> and then add support for that to the core and drivers? There is some
> intersection with pinctrl (depending on hardware). I wonder if
> abstracting this somehow using the typical pinctrl properties would be a
> saner option??

But what if the pin is not managed by a pinctrl provider? I have started 
going the route of implementing the PWM_OUTPUT_OPEN_DRAIN bit as an 
additional specifier in the #pwm-cells, but I am not sure to what extent 
this should be allowed to be changed at runtime.
-- 
Florian

