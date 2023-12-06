Return-Path: <linux-pwm+bounces-427-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5025B80771C
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 18:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000CF281B5E
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 17:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28F46DCF8;
	Wed,  6 Dec 2023 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fm/2MJO3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429B3D4D
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 09:56:41 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c09ba723eso701425e9.2
        for <linux-pwm@vger.kernel.org>; Wed, 06 Dec 2023 09:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701885400; x=1702490200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TaIhvHz9yCo8CyoMAQ11L7EAilHwdFmwm4E4mbWRlrs=;
        b=Fm/2MJO3eDR+G2SWeI+vi/UKeFbHzwSBSpPYEU+RF3Q9Z7PeWhzGp2lkJtbyug0ZbI
         TFeXrMH9J7167bA/0DxlT/Zt43VMqMFJeqdlcYP63eME8hJjP9WwIohviBahbd4XXwKh
         suca3aYmar1YQfPBsrnDp6Syp7vuSJHcIsrt7/1EA72V98Utifopk4Eot6w5QpC1Izvb
         z/H49wU4x7Su8mZengTZ6V96NjtraWFj3f/v0zRvJLuLuUNulYnUUPppqzlPVkRhP29F
         g23SDA5QL0b5Y1zdLPfwRH4OmqfFCoLYtVGQ70jca9ZkHlZmEOJNnESgC08UWJK29q+J
         e40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701885400; x=1702490200;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TaIhvHz9yCo8CyoMAQ11L7EAilHwdFmwm4E4mbWRlrs=;
        b=CAv396S5X+eVR7ZR0XkNY0tv9G7Vp2Vyy472mHzdP6NVkjXM8etHV2nSyvq41Ihnpy
         Q/cYFD1a+d9pyK9aTGhh345kj8NuLKy0Ba3aU9YvMsgpeT54A+lgjcJQghHfjDhn63B+
         SytJ7g6s5mYDykgogmmQJkQA8YDoKWRqyPSI4hSnpaQtvNrLXRjS72hI7GIbnXipVw1h
         wMtyLSYDUWMeTqpe1GVJmBy8JwVNzvPiEQ+XXWYaaFfGjiT4f3qGARflmg6gDIti/ZOS
         5rWndaEIzFnrfYXQApjEEKAtM+L1wRC+TxcqwGfxuUxj2dpIedBTlH9jOy1l8tG95dB3
         zuuw==
X-Gm-Message-State: AOJu0YyE7/sm1aZUOcWWFhmesHZM2utsYD56F2ajeLzkv+qZa/lrZxjD
	mMMbRUb3Kxhoh4UKvC0VyTSUrg==
X-Google-Smtp-Source: AGHT+IGv6NYFQb9FHQR5aUi137tDn3sb+TKXGhvXnNfclmTDByVaf//DxhTizcfJR0pLjN6K7lcA9g==
X-Received: by 2002:a05:600c:2986:b0:40b:5e4a:406c with SMTP id r6-20020a05600c298600b0040b5e4a406cmr802901wmd.140.1701885399676;
        Wed, 06 Dec 2023 09:56:39 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id z20-20020a05600c0a1400b0040b34409d43sm327750wmp.11.2023.12.06.09.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 09:56:39 -0800 (PST)
Message-ID: <ed9d28e0-f879-41f3-8679-7ed5e0eec7ce@linaro.org>
Date: Wed, 6 Dec 2023 18:56:35 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v10 0/3] Support pwm/tach driver for aspeed ast26xx
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Guenter Roeck <linux@roeck-us.net>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au,
 andrew@aj.id.au, corbet@lwn.net, thierry.reding@gmail.com,
 p.zabel@pengutronix.de, naresh.solanki@9elements.com,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com, patrick@stwcx.xyz
References: <20231107105025.1480561-1-billy_tsai@aspeedtech.com>
 <3ea9ef0c-27c0-4304-8bf7-26710224c3b1@roeck-us.net>
 <20231206174823.ok6rrufhez33rte5@pengutronix.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231206174823.ok6rrufhez33rte5@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/12/2023 18:48, Uwe Kleine-König wrote:
> On Tue, Nov 07, 2023 at 11:02:43AM -0800, Guenter Roeck wrote:
>> On 11/7/23 02:50, Billy Tsai wrote:
>>> Unlike the old design that the register setting of the TACH should based
>>> on the configure of the PWM. In ast26xx, the dependency between pwm and
>>> tach controller is eliminated and becomes a separate hardware block. One
>>> is used to provide pwm output and another is used to monitor the frequency
>>> of the input. This driver implements them by exposing two kernel
>>> subsystems: PWM and HWMON. The PWM subsystem can be utilized alongside
>>> existing drivers for controlling elements such as fans (pwm-fan.c),
>>> beepers (pwm-beeper.c) and so on. Through the HWMON subsystem, the driver
>>> provides sysfs interfaces for fan.
>>>
>>> Changes since v9:
>>> Change the type of fan-driving-mode to string
>>> Fix some typos and formatting issues.
>>>
>>
>> What is the resend about ?
> 
> And to the original v10 there is a reply by Krzysztof;
> see https://lore.kernel.org/linux-pwm/3d9e50db-19f0-43b3-8042-2f80a1e7b79e@linaro.org/ .
> 
> I'll mark the original and this resend as "changes-requested" in our
> patchwork. Probably the most cooperative way to object is to send a v11
> and point out the changes compared to v10.

The resend might be fixing issues from v10, but who knows which and how
many. In any case it should be v11, not a resend.

Best regards,
Krzysztof


