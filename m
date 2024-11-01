Return-Path: <linux-pwm+bounces-4010-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94309B9909
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 20:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81DB3B21C9D
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 19:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4CF1D9A57;
	Fri,  1 Nov 2024 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cXMnX946"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C8C1D2B11
	for <linux-pwm@vger.kernel.org>; Fri,  1 Nov 2024 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490777; cv=none; b=AA82aEJ5EjsokUq3qNeVGIyru121rmXBIQDOaeF2m9oT/PmG5w+MWVJdNILiEaIUp7mnPTyeOwUPW4V9ngvvvCDVS3oeT9Enbg6PZD/Wk+CshCP67Nwc7wkoNhVl4yiGkModU7betHGm++F3K2HVOTH6SyCGkKGlsMQhho7K2BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490777; c=relaxed/simple;
	bh=1fQRD6HlseoWDCYFnVt7JdBQcw7mXEZmvqF4gDLC8Bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Va5kEc3Tb42pPxXyH3nhxyM792tKgXRywPYyNtjwmvCpwaoqk2hdYPRe+Dlhj47aExMdbc/HmfxJaH1axYCLdBQLdt6/mtYpY8d5mi9Jkf69lugjSANQvi+fyvpqgPlBTOgz5UdnHSpW8KR4tbXchYUjog1qjchNPzCjTIMNGQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cXMnX946; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e5ffbc6acbso1426393b6e.3
        for <linux-pwm@vger.kernel.org>; Fri, 01 Nov 2024 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730490773; x=1731095573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Y5RFN1Yg682nc4388GjuL13yMU/0zuz4gK5UIWaEMc=;
        b=cXMnX9468zQDiWCCuEovtrMO+km8qV34ZuY5GdoHJ5YXV6ouhD1OfGecHhvzS/uw4K
         iVF7ds2Z740xyVKQMO94iJ0gmo+Vy91SmHzZGdpJ+bUogQLH63mzZ+5fPcgr1jbADTt4
         2OoEboeQ4uJFUnc2x2MGF1gfGQWwalfqLRyIxWM6TBVn+0nJBvXT8bp02+5Iq/85NCT8
         oiMgMjEX3eeMIg5WMCS4wzKFvsQdlelPLSV76DfcXub3SVxo42LrLaTxx/ZCZDqG9OUa
         1LNE8uP15Q4iG1j5NgAWjWLPY68cv9lRcICHenNevoTh2+IICWW3SFUm4dh2ygFNFc1A
         43Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730490773; x=1731095573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y5RFN1Yg682nc4388GjuL13yMU/0zuz4gK5UIWaEMc=;
        b=XCJSum/BkXnugdoJWRcNz0li5QAsVa38W6K9we+u2HbJKpUfmf+auMp+Qm5DXySXi7
         RcSxyjzfmI6yLVUMr2m/JkBzrqb5xDCtSfazd9gmQqsE9/LTVNwedgzwVi0AEbulsaB1
         qWrKebQKVJawnztqVH90w3qwAYdvnQHAciKW0sHGQkfkJbmj2sbQxrU2KfJbEyoe47a1
         hoIXqPAzRBAzamr0ntZGc5penuJqCyOkEx/zbug2tl/C9B0qMujwPcUmisto3Go7E12x
         e5i0El/bGHUekgY411E7cXSgi5QsKF265BUIw+XV1OhiBp6eQodL1Fpf3BCuuHo8PUl/
         x4kg==
X-Forwarded-Encrypted: i=1; AJvYcCUgJO6XajS3wd4w6JeDePsgEQn39RVAIi5+Q+SPyAmMPLGrPlGW4zw/iKM4KRJVvmMgcG10xs6Mr3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0mEeVUPT9lljLkMhzGS0zqJJrkCG656q3JL+OMwvo6RoAK0zq
	PFC5PLEjI1VFJON34lAnwKltl5CKQE9eH2vpPAdRNqvGzd2mrE5axOK3So5HJW8=
X-Google-Smtp-Source: AGHT+IHt7K5eAUn3WyZOQ4QBBFiXCbww8ZLgyOPtLtHxzPx/IPAKsRfVjpSk8qxn1mTyET7jUJ75IQ==
X-Received: by 2002:a05:6808:d50:b0:3e6:580e:f12c with SMTP id 5614622812f47-3e758bfe42amr5242236b6e.10.1730490773671;
        Fri, 01 Nov 2024 12:52:53 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e66119120dsm940758b6e.12.2024.11.01.12.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 12:52:52 -0700 (PDT)
Message-ID: <0f4a6e40-a7c8-43e4-8596-4fa495159378@baylibre.com>
Date: Fri, 1 Nov 2024 14:52:50 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] iio: adc: adi-axi-adc: set data format
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241101112358.22996-1-antoniu.miclaus@analog.com>
 <20241101112358.22996-5-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241101112358.22996-5-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/24 6:23 AM, Antoniu Miclaus wrote:
> Add support for selecting the data format within the AXI ADC ip.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v5.
>  drivers/iio/adc/adi-axi-adc.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index f6475bc93796..6f658d9b4c9d 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -45,6 +45,9 @@
>  #define ADI_AXI_ADC_REG_CTRL			0x0044
>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
>  
> +#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> +#define   ADI_AXI_ADC_CNTRL_3_CUSTOM_CTRL_MSK	GENMASK(7, 0)
> +
>  #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
>  #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
>  
> @@ -312,6 +315,24 @@ static int axi_adc_interface_type_get(struct iio_backend *back,
>  	return 0;
>  }
>  
> +static int axi_adc_data_size_set(struct iio_backend *back, ssize_t size)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	unsigned int val;
> +
> +	if (size <= 20)
> +		val = 0;
> +	else if (size <= 24)
> +		val = 1;
> +	else if (size <= 32)
> +		val = 3;

Should these be exact matches instead of "<="?

Also, what would val = 2 mean? Perhaps we need some macros to explain
the meanings of these values. The docs linked below give the meaning
for a different chip, but not AD485x.

> +	else
> +		return -EINVAL;
> +
> +	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
> +				  ADI_AXI_ADC_CNTRL_3_CUSTOM_CONTROL_MSK, val);

My understanding is that the use of REG_CHAN_CNTRL_3 is different
for every HDL project depending on what (frontend) chip is is being
used with. In the AXI DAC, we added a new compatible string for this
(and other reasons). Not sure if we need to go that far here, but I
would at least put a comment here explaining that this use of the
register is highly specific to the AXI AD485x variant [1] of the
AXI ADC IP core.

Ideally though, there should be an ID register that we can read
to get this info or use a different DT compatible string.

[1]: http://analogdevicesinc.github.io/hdl/library/axi_ad485x/index.html

> +}
> +
>  static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>  						 struct iio_dev *indio_dev)
>  {
> @@ -360,6 +381,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
>  	.test_pattern_set = axi_adc_test_pattern_set,
>  	.chan_status = axi_adc_chan_status,
>  	.interface_type_get = axi_adc_interface_type_get,
> +	.data_size_set = axi_adc_data_size_set,
>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
>  	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
>  };


