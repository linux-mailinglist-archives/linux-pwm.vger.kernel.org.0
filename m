Return-Path: <linux-pwm+bounces-127-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7E47F4059
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 09:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1201C20949
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Nov 2023 08:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB8D2BAEE;
	Wed, 22 Nov 2023 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0U6T8uj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302FD19D
	for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 00:39:43 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a013d22effcso254713966b.2
        for <linux-pwm@vger.kernel.org>; Wed, 22 Nov 2023 00:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700642381; x=1701247181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aS+XXhwuzroVSKVuFdZ7dXAQSJNNm0caeZbcLLCsivU=;
        b=T0U6T8ujw0DLzCZGRMMTAgWZ9GrwaYqhFi7XK8ftDSi6ncTbQldX+8kQ0o6qXaTO4O
         Sj+tFmj40aGY9aS2Aml1hLz0UdzReRrxw27VDmwthiYaujBcp06hKlxj6vKHSHHgKi1H
         1TTU0DPUGm3RZM3Axixfl6vwXGmCFdMqO849k2lcqoiSBkiae3Lk5+XDlUclnCNb1Az/
         7XMVrNR9zYz8BUTPKDU8K4Zp4tMf661WWI3xYzr9wso5qzB/6uXVQ0xihy3x/ECbdJ5N
         ugoHlulXUkN6Kbr13hTy2hJja11RYxjCOhWCzF6jl2dzUhfJ4EadWVS8SznHrspQne3P
         AsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700642381; x=1701247181;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aS+XXhwuzroVSKVuFdZ7dXAQSJNNm0caeZbcLLCsivU=;
        b=GnoYmOhFzedezaQibd5CgqJ50MLuP0/v9jA+gvb5MUEP9vhvQD4pSfqBlnaMFU8YIX
         VrTr73WV65xnHTjifKrbobyNyuOp0jUgn5OIyoOHDGjY3Oi2ThugeSb0KsydOtx/08DL
         E2RmHcKlDH0eIiUn/UqzkqhsbXtpcYOIBeebiPGudMzqobvOsIy0nc/YLO2ceuCsa05e
         2XUVJktpeAVfUeK9u1Gj0Yz9aquCGYq8uiw4eeCKzW9hyn+Otvppf3Dj0dPdOch3HHRr
         KRiPT/H8EKxrwz+5OGZDNUqQr56Da3cu0RFy1FIY6TVm79Eg9lYwhVgVtr9+mwsXZxkL
         1j8w==
X-Gm-Message-State: AOJu0YwWqpIILji7dhZm5ACQaCbONhx4YW58vXzsPNqRKji2bagP9yFi
	qxzTLL21Dwpa0+bxNLCm7wG18A==
X-Google-Smtp-Source: AGHT+IF2CSCjDTEXm1SkcZqwuxmoDKpLN1XjBfvcVi12yyNS4bJa/vqnjuwCRcnZsj7/ysSkGHEnvA==
X-Received: by 2002:a17:906:7105:b0:9c6:8190:359f with SMTP id x5-20020a170906710500b009c68190359fmr935327ejj.33.1700642381688;
        Wed, 22 Nov 2023 00:39:41 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id a1-20020a170906190100b009a19701e7b5sm6321163eje.96.2023.11.22.00.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 00:39:41 -0800 (PST)
Message-ID: <f04d8ad1-4411-4334-8d22-0aa757bf227c@linaro.org>
Date: Wed, 22 Nov 2023 09:39:39 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm: dts: amlogic: migrate pwms to new meson8 v2
 binding
Content-Language: en-US
To: Jerome Brunet <jbrunet@baylibre.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-pwm@vger.kernel.org, JunYi Zhao <junyi.zhao@amlogic.com>
References: <20231117125919.1696980-1-jbrunet@baylibre.com>
 <20231117125919.1696980-6-jbrunet@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231117125919.1696980-6-jbrunet@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2023 13:59, Jerome Brunet wrote:
> Update Amlogic based SoC PWMs to meson8-pwm-v2 compatible

Why? Your commit msg must explain this. You break users of this DTS on
older kernels and also this makes it impossible to apply via different
branches in the same cycle. All this needs explanation and proper
justification. Your message tells here nothing, because "what" is quite
obvious.

> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm/boot/dts/amlogic/meson.dtsi           |  4 ++--
>  arch/arm/boot/dts/amlogic/meson8.dtsi          | 16 +++++++++++++---
>  arch/arm/boot/dts/amlogic/meson8b-ec100.dts    |  2 --
>  arch/arm/boot/dts/amlogic/meson8b-mxq.dts      |  2 --
>  arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts |  2 --
>  arch/arm/boot/dts/amlogic/meson8b.dtsi         | 16 +++++++++++++---
>  6 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/amlogic/meson.dtsi b/arch/arm/boot/dts/amlogic/meson.dtsi
> index 8e3860d5d916..80cc004ad5fe 100644
> --- a/arch/arm/boot/dts/amlogic/meson.dtsi
> +++ b/arch/arm/boot/dts/amlogic/meson.dtsi
> @@ -83,14 +83,14 @@ i2c_A: i2c@8500 {
>  			};
>  
>  			pwm_ab: pwm@8550 {
> -				compatible = "amlogic,meson-pwm";
> +				compatible = "amlogic,meson8-pwm-v2";

That's breaking users of this DTS (old kernel, out of tree, other
projects) for no real reasons without explanation.

Best regards,
Krzysztof


