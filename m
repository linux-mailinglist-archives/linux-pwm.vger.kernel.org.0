Return-Path: <linux-pwm+bounces-485-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705E480BADF
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Dec 2023 14:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27961280CAB
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Dec 2023 13:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F087CC2C1;
	Sun, 10 Dec 2023 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rlMqV6R7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A35100
	for <linux-pwm@vger.kernel.org>; Sun, 10 Dec 2023 05:23:59 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1f8510883aso136506066b.3
        for <linux-pwm@vger.kernel.org>; Sun, 10 Dec 2023 05:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702214638; x=1702819438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=feTBq8ea0MP1f0PJr+qcMtxTJzfWaPKszGCsMhkLcss=;
        b=rlMqV6R7FYnD0Dx7hJjk5EAeJMCaJUdAPJfmQGP2ufpF4rCDbJEare2AaBX58uHaiV
         6ZeF/Dy2LQui8eG7WTbRtDnZAZC7+b/p34zyRSM01NBlX6LPANe1GmyPd2CHff296K6I
         nrPzfdyQP25ifpvNtXJxfseKLvi/0mT5ofwfDxxhUlH4g2QSUxbKIS0FrCtjLE+5Cbe7
         zgQoq0b+sylM1ma+B/wfH2jXMtaRmH3GtHrILRRCtGlfRFI6+BIEge7PO5myXBvwA40D
         pET5Q4IG+EHH0wJmCqjEsJlb5l+wWgTL7Rau2X3rqyONLtAs7u86vseq3IlaLG6D4f81
         GNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702214638; x=1702819438;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=feTBq8ea0MP1f0PJr+qcMtxTJzfWaPKszGCsMhkLcss=;
        b=Fcqp+88F6SVsvXAzuE9YcRXwHOEcwGOs53l2HXUhrvXaIqpMJpVlneMKdHrto8iFTn
         hKiEisD4uIX7umxAt0d4v35IomGwjCF7SdpZkBLQxEA+3AGKpRv/8TqSPw/okuzGXfwD
         cCeK6OU3ZbeYkpPwlR5tA2TWXuuV/ed875Eg8tMVvsmSxEqcsupIBK3RfH7W3mGNUY2j
         It2SiMXs6OwQxSV6Sl76ZkgTEfVOCUf5w1EjvumJOOgJLUCcdgV7DFCc9+BlOkLUX+rW
         a7Oz/MZf7Mn75P2BFMleNI6JklCTgfORawUj8XV6qp6zquouXLmHvPk5AT3oMzCfP8kb
         JiJg==
X-Gm-Message-State: AOJu0YyKPHrsXDcU5Qn9kr858yNrxlykvp+Si+y9w7OTS1qZyXfo7YqA
	GFeQiDStfjkVsAXdceEvNtjzfQ==
X-Google-Smtp-Source: AGHT+IGvchB3mT4gsXs6pxP47GOeNOg0vAlTs2z27yD6zP1XlUf0h0MzPBkcJpMKK8R/L+BlH5pxHA==
X-Received: by 2002:a17:906:3289:b0:a1c:cd0d:67c with SMTP id 9-20020a170906328900b00a1ccd0d067cmr756959ejw.25.1702214638105;
        Sun, 10 Dec 2023 05:23:58 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id n2-20020a05640205c200b0055122551f98sm167656edx.6.2023.12.10.05.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 05:23:57 -0800 (PST)
Message-ID: <a695f62f-5d08-49d6-a0b9-9f023ad7f586@linaro.org>
Date: Sun, 10 Dec 2023 14:23:56 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] pinctrl: samsung: add exynosautov920 pinctrl
Content-Language: en-US
To: Jaewon Kim <jaewon02.kim@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20231208074527.50840-1-jaewon02.kim@samsung.com>
 <CGME20231208075020epcas2p414c85e03d18327665eeff54082314b56@epcas2p4.samsung.com>
 <20231208074527.50840-5-jaewon02.kim@samsung.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231208074527.50840-5-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/12/2023 08:45, Jaewon Kim wrote:
> Add pinctrl data for ExynosAutov920 SoC.
> 
> Pinctrl data for ExynosAutoV920 SoC.
>  - GPA0,GPA1 (10): External wake up interrupt
>  - GPQ0 (2): SPMI (PMIC I/F)
>  - GPB0,GPB1,GPB2,GPB3,GPB4,GPB5,GPB6 (47): I2S Audio
>  - GPH0,GPH1,GPH2,GPH3,GPH4,GPH5,GPH6,GPH8 (49): PCIE, UFS, Ethernet
>  - GPG0,GPG1,GPG2,GPG3,GPG4,GPG5 (29): General purpose
>  - GPP0,GPP1,GPP2,GPP3,GPP4,GPP5,GPP6,GPP7,GPP8,GPP9,GPP10 (77): USI
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---

...


>  /**
>   * struct exynos_weint_data: irq specific data for all the wakeup interrupts
>   * generated by the external wakeup interrupt controller.
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index 362e99566919..800a2f0a026a 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -1324,6 +1324,8 @@ static const struct of_device_id samsung_pinctrl_dt_match[] = {
>  		.data = &exynosautov9_of_data },
>  	{ .compatible = "tesla,fsd-pinctrl",
>  		.data = &fsd_of_data },
> +	{ .compatible = "samsung,exynosautov920-pinctrl",
> +		.data = &exynosautov920_of_data },

Please put it after autov9.

Best regards,
Krzysztof


