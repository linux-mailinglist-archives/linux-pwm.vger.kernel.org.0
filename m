Return-Path: <linux-pwm+bounces-2368-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2768FF384
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Jun 2024 19:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD1DB24D58
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Jun 2024 17:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824A1198E6A;
	Thu,  6 Jun 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zHZEqHMb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39DE224D1
	for <linux-pwm@vger.kernel.org>; Thu,  6 Jun 2024 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693789; cv=none; b=Abl2wG/vecH/tqQJ71tah7tY12tSTZ+3GD/zPmeewqo0fKtbK90b6uf9Lo4pLhFWc4QajmS9caU0dLA638v27tdETCzN3kAXgnGFudr1Jz+m5m9tPteTd9DS2wi1sYDqVpvnGSHGEfd8E64Y3fWRIunpdUiTvRn85zkZZF1oSyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693789; c=relaxed/simple;
	bh=SjmCuPMf9Ovb7OZsLcCBto4veYJNH3OWd2txadP38pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzYTV4aGSEYId4SwgVyVhNDhTQwGHexfIZwj73BvMwaG693cixmMZ96pT3VnnW0HROsGyPN6VwOGYiUFwakfbqjR3lPxtLbID3lwegox04wNBMrnVQ+bY89V2ZAKBDvD5fiJlHDk6wgk4jVMm2f9kUBU8lwY4MVu5nKmE5pWGuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zHZEqHMb; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4401a1ee681so5855971cf.1
        for <linux-pwm@vger.kernel.org>; Thu, 06 Jun 2024 10:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717693785; x=1718298585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KE5MQgAxJw3nNYDHR1OcEfaGIHXnByOurKhTaXYNnP4=;
        b=zHZEqHMbp+KyRog/Hais+ZoQ0cq2DB2PEQrMavsw6ADK4LVlh7u0L30409JKstYfuv
         h4PYmzgQlyMXwpiAV7HbB3+xtFGt2J/QHW8OMAlUH442ryoSHe/hfrnY/7DRbE5ednXe
         voJ5JTNyucLVn8P2SDUL6bvwetdTNelYOFMvsph9U8QG64tHe01S1CnOEUZLciJGBq4D
         M8rZEtmOdJtYaeOxcjOr7XvihHAk42KmQ01o+VgZQB9g4ATYBvAaX4zVcz55VGwN+f57
         t0eWW5OOqlG5CsBZiDkk8FQIA4RTxm+X4D1yTRSFr0sLbeISIcR74AZx0RDrFEr7uxTD
         Pwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717693785; x=1718298585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KE5MQgAxJw3nNYDHR1OcEfaGIHXnByOurKhTaXYNnP4=;
        b=YVneRGIwlA3AgSmYkvhwyimJVZdYK6uPIoNfG3VdnlZTbKoiQSaRZuCXULeDCwkuxJ
         8BGtYc313ZMJwVtYe7D5NZppymLy24uuZxTXxhr/piItzgYM2NubvQW/+/xEtTqpXEv/
         vWsl+sqOmt7HPHFtko14gKE6F9g3n4uj3RnrwWXMlSJxeAd0W7p0E3SU6qFgNOiSqe9M
         iLSPXn3Prcd/8ah5g7StkdFBGY24s4FzctRJggQ8/7M0r7c98U+/GnfVyopnyn5XfLnZ
         Psb5u2YIjoEQsV18ZzOUIPdxCMwYfUnV+Wkgms5+ZtYNMnDDkX+KhKlF1NHBpJ8jBJ0T
         +hOg==
X-Forwarded-Encrypted: i=1; AJvYcCUijbVBZc2bRNuOfxDFE+Rd8dSqF/FQRguXCgjvwBcYVcldnAQ0C85yF7RZc7jlTybupDioWTA1eQ52l+zqtaQ7tRwM34vrzt3X
X-Gm-Message-State: AOJu0YxISy64pGRzuFRyTUkzveMcQ9G4NTHwC4u9/2IpSVGJrsTiFKxt
	JUL3IoR0uPbUHVIi5ZD2eNX6icqBM3fauX/BCkUFr8C0YmV6mUgLYfwMs9jXCJg=
X-Google-Smtp-Source: AGHT+IFXb2yr+tFoCtJnET20SfUGu9/NSPOYrX9nlowydkgqMo++TWQKOUmS+uSNYmkbaMZVYUeUKA==
X-Received: by 2002:a05:6214:5c43:b0:6ab:9619:a811 with SMTP id 6a1803df08f44-6b059bd6993mr1778146d6.33.1717693784678;
        Thu, 06 Jun 2024 10:09:44 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04f6a369esm7975606d6.45.2024.06.06.10.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 10:09:44 -0700 (PDT)
Message-ID: <21cdad72-dfa0-4f5c-a763-dcd427c65544@baylibre.com>
Date: Thu, 6 Jun 2024 13:09:43 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: axi-pwmgen: Make use of regmap_clear_bits()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-pwm@vger.kernel.org
References: <20240606164047.534741-4-u.kleine-koenig@baylibre.com>
 <20240606164047.534741-6-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20240606164047.534741-6-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-06-06 12:40 p.m., Uwe Kleine-König wrote:
> Instead of using regmap_update_bits() and passing val=0, better use
> regmap_clear_bits().
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Acked-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   drivers/pwm/pwm-axi-pwmgen.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index 1bd4150e0158..aac4f395497b 100644
> --- a/drivers/pwm/pwm-axi-pwmgen.c
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -156,7 +156,7 @@ static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
>   	}
>   
>   	/* Enable the core */
> -	ret = regmap_update_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_REG_CONFIG_RESET, 0);
> +	ret = regmap_clear_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_REG_CONFIG_RESET);
>   	if (ret)
>   		return ret;
>   

