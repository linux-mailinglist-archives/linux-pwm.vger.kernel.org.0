Return-Path: <linux-pwm+bounces-268-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BED7FEBD7
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 10:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC3BB21084
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 09:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D699138F9A;
	Thu, 30 Nov 2023 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cbh7YlMg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0C4DC
	for <linux-pwm@vger.kernel.org>; Thu, 30 Nov 2023 01:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701336517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySuzbDisGMAL1F3X1MppJj42eTwMBXfb4UyiBKCa3QA=;
	b=Cbh7YlMgjUZolQcX2FF+WSNNeFEfB9DxuxgM805LsyKkmhiXlWHYisOmndcJeaDWnut2BS
	xq0It+Lhjo+m7S3/7qJQeDNkrmrqwEX6VJlH2VPSzkt+TvHo13yb7FXSuDAygV5ONvghoN
	FrVCnrxIMmNL/kh5QcEx6MDkau1/CCs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-Wl2OEMmDPOiUsQBMVX3u9g-1; Thu, 30 Nov 2023 04:28:35 -0500
X-MC-Unique: Wl2OEMmDPOiUsQBMVX3u9g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b443d698eso5423055e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 30 Nov 2023 01:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336514; x=1701941314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySuzbDisGMAL1F3X1MppJj42eTwMBXfb4UyiBKCa3QA=;
        b=j5bOvPOmSgO7qWaRg2W5TjypWMFKXM9gDRYYbzAa2EtnrWZV9Cj5QNg0WGUWLEu01B
         Yu412UKhwXYDsvB43xdvdn2zcOFEpfuDUafvSMpsc/i6ymxscCEO5a0h7w8nsdcJCRUh
         VzraeLiqc/Wx0m/Hs+ITZSj3fgu5HxwmzLUOUr5ssZ1oGx+lkrdMRDh29Tnfuz+Ay2h8
         5lhYLLFvSaNzzPrV3ftb1DRVx3p85K/HJHvA2Qo2gqwGlEmEEXQGLexFpUcR8t6UvoXj
         FB1LuPdiEYZnyDwv8k/VUDmAiPArKkmil5K13mLIc9TRNpbAQXfxl9dQXXw/VsTazou/
         3KEg==
X-Gm-Message-State: AOJu0YxAr0o6NuVLqIRdoKywEPlcOe/1K1A7Sc+oj8/Wr9xGScjs9mWs
	Et38MDSptoPkOJDlmujwgmd0e/fUfN5q86g1K96yNXnnjHuE5n1bJbf2EtB6OJjsG2IiM/J3rBF
	S61HaLlJayzX1T+15d1zzoi63bC81
X-Received: by 2002:a05:600c:1d97:b0:40b:2979:b787 with SMTP id p23-20020a05600c1d9700b0040b2979b787mr15296525wms.10.1701336513980;
        Thu, 30 Nov 2023 01:28:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFyK7hjTnvI9m5X05KAXNk+hnTKwlkPJxwIvdhKxfg4uj/Rcw8ymHZ+mOx7NFGqyFQ9tlxyJQ==
X-Received: by 2002:a05:600c:1d97:b0:40b:2979:b787 with SMTP id p23-20020a05600c1d9700b0040b2979b787mr15296509wms.10.1701336513629;
        Thu, 30 Nov 2023 01:28:33 -0800 (PST)
Received: from ?IPV6:2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029? (2001-1c00-2a07-3a01-06c4-9fb2-0fbc-7029.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:6c4:9fb2:fbc:7029])
        by smtp.gmail.com with ESMTPSA id ay10-20020a05600c1e0a00b0040b397787d3sm5064419wmb.24.2023.11.30.01.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:28:33 -0800 (PST)
Message-ID: <b05d041e-c734-4a94-ab46-18e5235eb208@redhat.com>
Date: Thu, 30 Nov 2023 10:28:31 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: crc: Use consistent variable naming for driver data
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de, linux-pwm@vger.kernel.org
References: <20231130074133.969806-1-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231130074133.969806-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 11/30/23 08:41, Uwe Kleine-König wrote:
> All but one local variable of type pointer to struct crystalcove_pwm are
> called "crc_pwm", the one outlier is called "pwm" which is usually
> reserved for variables of type pointer to struct pwm_device.
> 
> So rename that one "pwm" to "crc_pwm" for consistency.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/pwm/pwm-crc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
> index 2b0b659eee97..e09358901ab5 100644
> --- a/drivers/pwm/pwm-crc.c
> +++ b/drivers/pwm/pwm-crc.c
> @@ -160,22 +160,22 @@ static const struct pwm_ops crc_pwm_ops = {
>  
>  static int crystalcove_pwm_probe(struct platform_device *pdev)
>  {
> -	struct crystalcove_pwm *pwm;
> +	struct crystalcove_pwm *crc_pwm;
>  	struct device *dev = pdev->dev.parent;
>  	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
>  
> -	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> -	if (!pwm)
> +	crc_pwm = devm_kzalloc(&pdev->dev, sizeof(*crc_pwm), GFP_KERNEL);
> +	if (!crc_pwm)
>  		return -ENOMEM;
>  
> -	pwm->chip.dev = &pdev->dev;
> -	pwm->chip.ops = &crc_pwm_ops;
> -	pwm->chip.npwm = 1;
> +	crc_pwm->chip.dev = &pdev->dev;
> +	crc_pwm->chip.ops = &crc_pwm_ops;
> +	crc_pwm->chip.npwm = 1;
>  
>  	/* get the PMIC regmap */
> -	pwm->regmap = pmic->regmap;
> +	crc_pwm->regmap = pmic->regmap;
>  
> -	return devm_pwmchip_add(&pdev->dev, &pwm->chip);
> +	return devm_pwmchip_add(&pdev->dev, &crc_pwm->chip);
>  }
>  
>  static struct platform_driver crystalcove_pwm_driver = {
> 
> base-commit: 53a2eaaf19c4e652ac53b5b2441582a555768516


