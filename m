Return-Path: <linux-pwm+bounces-6063-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A25FABF5DF
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3EB4E2E60
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE73267B1F;
	Wed, 21 May 2025 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uNQGANQn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE50A263F47
	for <linux-pwm@vger.kernel.org>; Wed, 21 May 2025 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833597; cv=none; b=ZcNpjHIGYT5WSWmesXfilfJgSVRhfFZ+DuZhiWLHgybuc1zxM3cmadj6C7kAtJZBfCDMi3aJkmxbogAyjaBYV6jiUnHP0BJ2MiLMOcnO8FhSSONSBvi7EWGiGNZCFpKu/an0yq1BbjkFn/yG5RVH1hzIcPUZB+SVMFiiH9ylCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833597; c=relaxed/simple;
	bh=zxb4XuRb5OL7RbkFWFx6WphiL7nedhvIK2jhu21lh1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhemizBRX2SPp2yChUeZ8M8EmriTv15C6siXPbCbqPikIM9IXfFz+wK83BlA9Ita/Dn+gjYCuiHD4cEyjTEe3rBW6tjYfbgTjgY4Gm+Rc/vWG/OdJTYrfWvTN2pnBCZkA6oU2/LIX0or+B+fHuRtvLMFSaP3hXEEBCYa+SySC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uNQGANQn; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-605fda00c30so3713313eaf.1
        for <linux-pwm@vger.kernel.org>; Wed, 21 May 2025 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747833595; x=1748438395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqHAwKXGDB470rizfijZUWFboiXZOZHB3mYiVWRIm+0=;
        b=uNQGANQn+VcDbM9bqffpTG/ZuvCWHNtmKHJ8PdQ4CXUf1++5OoJ6C4ce1a0RRZHgZw
         URkZ+y1nud19ploFIgfyTh+52NsP/YKRS7rKpTF7AiEqG0YBRSBfZ2H5QRWZgPCREfrN
         6925zM+OSo9zLJ2dz1ZLm9ReFhxDorM55vw75nBdDMi/RW+Zmgs/D4ogaXVZUoXYZsf3
         NkIRiR/r5FKmNLXOKVRXL2rmtHMwjQqi7B4HuUftB1xxYTvbBEE2ic7Iv8kweIQEPxHl
         Q2J8lf/w7azDV6v45/cEo2/oqRaGIg12FJi3hgJYQPqh/yqyj6/Cet/+XZUygoqe+7fo
         51Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747833595; x=1748438395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqHAwKXGDB470rizfijZUWFboiXZOZHB3mYiVWRIm+0=;
        b=jlUSGbjfQ6UgLgvJDwwtXE67Of4W7hJ/T8kvYWwzeyL88b68SdIv8UtXwmES6vgxIn
         S41Xt0c0TODh/hqTTUbGjwVO1AdoU4cSvqnmD9cQzlvTncf9p5UP90LaFcKHoXYkplNh
         c6UF/oTGxm4QBH3Uw/UX2NxRbetOcyloU4svs3Jw7XZ3JsY4X/2Vj6Jqj1Aj+2QCa3ht
         6HkI/evCR+uIyM6RezwbRIdZvivAghGiSiAI/QuHfOpNEc7CTLOfuYWv/0sCCw83Zizp
         DPA+iQRxZqJt4nBkGkLJE7pigw6dvttJfiyhHQwZK/D6HUgYRI7DVSNiaGsubEMz1Wqc
         hiPg==
X-Forwarded-Encrypted: i=1; AJvYcCUdF6jvgnksbodDKfr8wRVcdX2CbkU9ykx30qL3SStQZrFW2lSyRiJkfuwF4Z0msHnCaumTLfIgK9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX/C7v4x2Og3hvK/abJX/1/lMXzFv5XhosgbOQC0v3IeTaYn54
	a7JFTL3dH3qz6HZK8EZGW1+oVAcBxl8dkXWnz5mwjImGO1yKDwmlF1nlos/iPNhrBU0=
X-Gm-Gg: ASbGnctBsjmhGBMJMxdykM4Nw+8zoU1hWFh3ATE1laxmtCfb76Jl4TY6qhOOkC+B2Ve
	QcO9uUb4l976jlmgx08f2JuU4nk0zth7+dHThASAaDCknK4Kl8Qad/wq1+crZLCfU1eONUyqzn6
	5H3cKnvMZ58J6ecukH6z895OPEAnJUZYYYkPZD4YWCEoTrVgjwO7Rq5gLiqxkhZ6aBy+zd5qRJq
	TX1EwNVy8RVZ/mBP1KKhUBp570oNB6/z1GUchULTfHmpLsRxNaotndHgi2nea1PE6+EM7x6/Dbr
	8OJgBWg1TdWzTZvVInpOrvlxofjxoMF47rXwkaHKggdhejkUXAB186TkhvVpAb6xB4WZgJVdgOA
	NxBZOEwxyYj+JFEyi4LaDUqwQkQ==
X-Google-Smtp-Source: AGHT+IFlO2y1ouZt315gbUk3Y6YIYIDNy5KFOP0whnds4skxAXxnCCpG1q9rhgZvtK70Het4S+QSwQ==
X-Received: by 2002:a05:6820:1806:b0:606:5531:d903 with SMTP id 006d021491bc7-609f36b742bmr12050006eaf.2.1747833594667;
        Wed, 21 May 2025 06:19:54 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d77b:6acc:2ad1:8ff? ([2600:8803:e7e4:1d00:d77b:6acc:2ad1:8ff])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60a03f5bcbasm1675485eaf.19.2025.05.21.06.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 06:19:53 -0700 (PDT)
Message-ID: <0dd1a97e-ff7c-4d09-b18e-5df9944488c6@baylibre.com>
Date: Wed, 21 May 2025 08:19:51 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pwm: axi-pwmgen: add support for external clock
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250520-pwm-axi-pwmgen-add-external-clock-v1-0-6cd63cc001c8@baylibre.com>
 <20250520-pwm-axi-pwmgen-add-external-clock-v1-3-6cd63cc001c8@baylibre.com>
 <zdltaexty6pzbqesoluuyluygyt6w7nq7r2wccmtfktppwuw3e@qb36fsu3jq4k>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <zdltaexty6pzbqesoluuyluygyt6w7nq7r2wccmtfktppwuw3e@qb36fsu3jq4k>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/21/25 4:22 AM, Uwe Kleine-König wrote:
> On Tue, May 20, 2025 at 04:00:46PM -0500, David Lechner wrote:
>> Add support for external clock to the AXI PWM generator driver.
>>
>> In most cases, there is a separate external clock that drives the PWM
>> output separate from the peripheral clock. This allows enabling both
>> clocks.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/pwm/pwm-axi-pwmgen.c | 23 ++++++++++++++++++++---
>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
>> index 4337c8f5acf055fc87dc134f2a70b99b0cb5ede6..67992a7561ec0440b1c1fa327f844a0602872771 100644
>> --- a/drivers/pwm/pwm-axi-pwmgen.c
>> +++ b/drivers/pwm/pwm-axi-pwmgen.c
>> @@ -280,9 +280,26 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
>>  	ddata = pwmchip_get_drvdata(chip);
>>  	ddata->regmap = regmap;
>>  
>> -	clk = devm_clk_get_enabled(dev, NULL);
>> -	if (IS_ERR(clk))
>> -		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
>> +	/* When clock-names is present, there is a separate ext clock. */
>> +	if (device_property_present(dev, "clock-names")) {
>> +		struct clk *axi_clk;
>> +
>> +		axi_clk = devm_clk_get_enabled(dev, "axi");
>> +		if (IS_ERR(axi_clk))
>> +			return dev_err_probe(dev, PTR_ERR(axi_clk),
>> +					     "failed to get axi clock\n");
>> +
>> +		clk = devm_clk_get_enabled(dev, "ext");
>> +		if (IS_ERR(clk))
>> +			return dev_err_probe(dev, PTR_ERR(clk),
>> +					     "failed to get ext clock\n");
>> +	} else {
>> +		/* Otherwise, a single clock does everything. */
>> +		clk = devm_clk_get_enabled(dev, NULL);
>> +		if (IS_ERR(clk))
>> +			return dev_err_probe(dev, PTR_ERR(clk),
>> +					     "failed to get clock\n");
>> +	}
> 
> Can you achieve the same effect with the (IMHO slightly nicer but
> hand-crafted) following patch:
> 
>  	ddata = pwmchip_get_drvdata(chip);
>  	ddata->regmap = regmap;
>  
> -	clk = devm_clk_get_enabled(dev, NULL);
> -	if (IS_ERR(clk))
> -		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
> +	axi_clk = devm_clk_get_enabled(dev, "axi");
> +	if (IS_ERR(axi_clk))
> +		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to get axi clock\n");
> 
> +	clk = devm_clk_get_enabled_optional(dev, "ext");
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get ext clock\n");
> +	}

The trouble with this is that it would not work with existing .dtbs
that don't have clock-names set. I think it would need to be more like this:


	axi_clk = devm_clk_get_enabled(dev, NULL);
	if (IS_ERR(axi_clk))
		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to get axi clock\n");

	clk = devm_clk_get_enabled_optional(dev, "ext");
	if (IS_ERR(clk))
		return dev_err_probe(dev, PTR_ERR(clk), "failed to get ext clock\n");

	if (!clk)
		clk = axi_clk


> 
>  	ret = devm_clk_rate_exclusive_get(dev, clk);
>  	if (ret)
> 
> with the only side effect that for machines with a single clk we get
> axi_clk == clk and it's enabled twice.
> 
> Another upside is that
> 
> 	clock-names = "axi";
> 	clocks = <...>;
> 
> still works.
> 
> Best regards
> Uwe


