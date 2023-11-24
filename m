Return-Path: <linux-pwm+bounces-182-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE3E7F72D1
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 12:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FE22817BA
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 11:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323DD1DDD9;
	Fri, 24 Nov 2023 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CuyAjz5n"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9F610E0
	for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 03:34:51 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a02c48a0420so254299766b.2
        for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 03:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700825690; x=1701430490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yLGESbCFc50J+147aJNRVMMBSaHYgnNxVeCdiwumeiM=;
        b=CuyAjz5nHi+uv5nCltgJwq2mrRrJmpoPTFOwUr/YSnQS9i8rE5cQmYqzkyOb/PKtC7
         9KKkkvdmYAt0SwYTZ/84DSquu7nVPK1XQkPk/0QBgEBO4R2d0ydvPNQAmDpuCQz6zTtN
         tAQmZ8d84UA4jKIjxbnyDFD/ftjKBczQaKdjJXJrwVdOi9UKpyqRxmvTnICc4PqAGm/T
         xt2+8/cc/lgTlSZQ3E0XRfWRYP3rFbjA1D6sAGFFHsfrGMHrSuxOlJO+uHhhRsCOtOx1
         okFmzvxx+E75nbV+UC3G3AhuDLnYH2OEMCJLzk9AKfSAvGquaQK4cOXpydjj7gFaV83P
         +lOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700825690; x=1701430490;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLGESbCFc50J+147aJNRVMMBSaHYgnNxVeCdiwumeiM=;
        b=lNNShcroYHa4Wli/CgpgwIJncYNfu4VwJJC7CH6lR9V6v4kQXxqKgn9PlmsXjiq09R
         CrG1ibVl3Q8yrzD28U/4dvUMj/ieZUIDDDBZNSd6U4RDfabiP7i8PLr19MRakBAY+j5o
         8+nwKp52Nx3bGsW/U1+NLSox4ZErERWx5G1/SUQ7/wphksBpG2vunTQ+we0y92vNKboe
         cp7/3vEbwPcc3cGu01OPdIlIdNwuxo1Ruf0Os3g/tNqFmMUJvDzROQi7TYYzfCIxVmfK
         ChFyC0vxp91+Mb2jZ2G9IL9qPhCeDOd693L3kVaRHx1vAuBtfUkKgGCV4RgtvOoJ6hf9
         hTog==
X-Gm-Message-State: AOJu0Yy/yCCTP7Sxpd8k7Q/LO4sp25t4Efh5grD/k6pWsWml7cP3qZOP
	ZrW/jCzcl7fDwTpVR+hEY+0GTA==
X-Google-Smtp-Source: AGHT+IHvkn9imfLXJr4obpg2rJD4Teu7AqvSqgkuYbZiQnmPDrN6wzAmp05SXIECdntD6XHt18LnUA==
X-Received: by 2002:a17:906:fa90:b0:9b2:be5e:7545 with SMTP id lt16-20020a170906fa9000b009b2be5e7545mr1792162ejb.36.1700825690024;
        Fri, 24 Nov 2023 03:34:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id w24-20020a170906b19800b00992e14af9c3sm1985516ejy.143.2023.11.24.03.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 03:34:49 -0800 (PST)
Message-ID: <98044f53-7c9c-4e3b-a6f4-c65516e3738d@linaro.org>
Date: Fri, 24 Nov 2023 12:34:47 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LINUX PATCH v2 3/3] pwm: pwm-cadence: Add support for TTC PWM
Content-Language: en-US
To: Mubin Sayyed <mubin.sayyed@amd.com>, krzysztof.kozlowski+dt@linaro.org,
 u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
 robh+dt@kernel.org, conor+dt@kernel.org, tglx@linutronix.de,
 daniel.lezcano@linaro.org, michal.simek@amd.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, git@amd.com,
 mubin10@gmail.com
References: <20231114124748.581850-1-mubin.sayyed@amd.com>
 <20231114124748.581850-4-mubin.sayyed@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231114124748.581850-4-mubin.sayyed@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/11/2023 13:47, Mubin Sayyed wrote:
> Cadence TTC timer can be configured as clocksource/clockevent
> or PWM device. Specific TTC device would be configured as PWM
> device, if pwm-cells property is present in the device tree
> node.
> 

...

> +
> +static struct platform_driver ttc_pwm_driver = {
> +	.probe = ttc_pwm_probe,
> +	.remove_new = ttc_pwm_remove,
> +	.driver = {
> +		.name = "ttc-pwm",
> +		.of_match_table = of_match_ptr(ttc_pwm_of_match),

Drop of_match_ptr(), you will have here warnings.

Best regards,
Krzysztof


