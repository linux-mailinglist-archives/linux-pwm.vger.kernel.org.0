Return-Path: <linux-pwm+bounces-3342-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3097797EBC3
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 14:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2968B21726
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 12:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C7B198A10;
	Mon, 23 Sep 2024 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MLwI3aGe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92A80C0C
	for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2024 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096174; cv=none; b=gc3ZuFcuHeoBRizVDqBKSLRapDY6cgSVyBe5is3R4TxyIMSZdBTYUD4yfFEwNRhda650TFxt/VBC3zKwNGypHre/IgVlwf5Y8Bv6BIsU+hHROkH040iBSK7y/kgjAbsCAoV/E5PF7serjMToQvI2NQxr7senTiF1WzYqz4HTTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096174; c=relaxed/simple;
	bh=jzDvSBKwkVdUMQsiJmF4oYStGUS15nrVohM7flKGoIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Th/EHM6S9rSrzHq76mThIoxy/cp3CF/V4e4t37N6xggPJZjMI8QfGILlH4zUE9AZwLMaLcbfJiQSwWlyWfIbnPB/ak65arX1GyVnU3ofQxIATqomYF/hYEqRKpmE4NyT6p3NVMcXtcGjMLtNbWJ5nbaS7JJEVhtaxgapaAOOavg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MLwI3aGe; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a99e8c32c0so465111885a.3
        for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2024 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727096171; x=1727700971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YpmRGiuRj02me6ExvTdqms1rXFpbM5Yb2+jVrF4wto4=;
        b=MLwI3aGeGhahlWSdb/o2DoDC6g+/WMa4OMnFMteCKQdNa5a808p0IuQ8USd4s3Ch8I
         DBe60fLIuYFxW+WY3Oa9DMk+2Z31QdjG3bRFrDBqcktfcc/TpByNgAkey+DzOing3Z+x
         oMW3rIeTqHd9DwTWfkjUggK6MrLuLFeVXu5YAnjMLQRq+kb5jbgsnVkZiy9+qIQI7kBc
         p2EINJY2aFUhpO9rXpWRHLJ47xNCECwIEULSdKjzhNjGbsYuSH5QyTCFn8ldSBR0ywYN
         t+S2d9xZg+Ms8U0J67gfbuAIL6n2p35iwDWzpXKyf7BjqybXiDPYekeD0yCY2p//gLZR
         RIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727096171; x=1727700971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpmRGiuRj02me6ExvTdqms1rXFpbM5Yb2+jVrF4wto4=;
        b=hyrjFjhEafISTJY6yH1ZVDAxcTEE4jqc8xhB5Ma+yttrX1AY1efBcLTE+7tDPGiUuF
         AaS1JovIvJT+egVSqw6whRVsAkr8Exd8IT+08ISBVsgokstKcfZtzWjJTmS6jSHl0xCs
         Kax5qam+pxPymV53aH93ToI08lcwQbc26blwDzcp7Hp0R8VPWlSP7rZwruGTUouAYtSS
         EarXJtgDGrJTUBH1ayZ9pWI7y+S37F8P4yZd8JxDhQVrdZd8OcG0loO2/JKALch5tzz4
         0wcuipvgqVN4cvk/JuDqw8S/qarBfn51xylPL1m28iI3i+VXTfVmTmO4yji6d89S9w+d
         Ev1Q==
X-Gm-Message-State: AOJu0Ywj+xCAsnTP7/s4pLQ6UGVha1DAXRKcsC4QzIMZdVQIdP1Ju2VT
	JV5GMeD+ICN+Wt9PY2TEPBUA7g+h/G815WmzgQJWMWOMnDgzCrP3H5kPaKo4ZxM=
X-Google-Smtp-Source: AGHT+IHn0Nex/Wcq7aiun9zy74wgMKQmhjhE+Mgi+BNC3lHnVS9nR+dfKFkg/SPBaXhqf3+a+kszoA==
X-Received: by 2002:a05:620a:2688:b0:7a9:b8d1:a1d with SMTP id af79cd13be357-7acb8d99ef1mr1720582985a.38.1727096171572;
        Mon, 23 Sep 2024 05:56:11 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08eba0csm475168585a.131.2024.09.23.05.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 05:56:11 -0700 (PDT)
Message-ID: <95e372fc-5656-4c11-9e84-0df624fca0ad@baylibre.com>
Date: Mon, 23 Sep 2024 08:56:09 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: axi-pwmgen: Create a dedicated function for getting
 driver data from a chip
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240923125418.16558-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20240923125418.16558-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-09-23 08:54, Uwe Kleine-König wrote:
> Compared to direct calls to pwmchip_get_drvdata() a dedicated function
> has two upsides: A better name and the right type. So the code becomes
> easier to read and the new function is harder to use wrongly.
>
> Another side effect (which is the secret motivation for this patch, but
> shhh) is that the driver becomes a bit easier to backport to kernel
> versions that don't have devm_pwmchip_alloc() yet.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   drivers/pwm/pwm-axi-pwmgen.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index b5477659ba18..e5162f3e511e 100644
> --- a/drivers/pwm/pwm-axi-pwmgen.c
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -53,10 +53,15 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
>   	.max_register = 0xFC,
>   };
>   
> +static struct axi_pwmgen_ddata axi_pwmgen_ddata_from_chip(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
>   static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   			    const struct pwm_state *state)
>   {
> -	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
> +	struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
>   	unsigned int ch = pwm->hwpwm;
>   	struct regmap *regmap = ddata->regmap;
>   	u64 period_cnt, duty_cnt;
> @@ -100,7 +105,7 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>   				struct pwm_state *state)
>   {
> -	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
> +	struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
>   	struct regmap *regmap = ddata->regmap;
>   	unsigned int ch = pwm->hwpwm;
>   	u32 cnt;
>
> base-commit: 62f92d634458a1e308bb699986b9147a6d670457

