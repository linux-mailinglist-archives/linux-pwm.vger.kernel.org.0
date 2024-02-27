Return-Path: <linux-pwm+bounces-1649-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6AB869F95
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Feb 2024 19:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C786B273D5
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Feb 2024 18:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC0C50A68;
	Tue, 27 Feb 2024 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O4gvcejA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5350A73
	for <linux-pwm@vger.kernel.org>; Tue, 27 Feb 2024 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060062; cv=none; b=as95pOWASjxXerl5tEWZV71rSv+rJiV/rHDn9QwCUoY0U2W0UcxYypFSEvR9b94LNUSTF8tsaAki02FyErnQUV+l0bPgwKfHab3F0lj9S7K6NqZU2OGz2hpW3NviMG3+pE4XLEqqfnFbUvZXI6s2r4CkuhEECeDzZKe928Wlx04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060062; c=relaxed/simple;
	bh=ZnI48ubHsefbyzSAZ4911OEz8jkN68Nek0eK9LS0hEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWjJyU4ziOtkUNTm7Pj7dZ/YwI13Dq8JIMlS8/MyM2NLaoPu8SVEAvHuypeZN9J6JGxssccrOr+4sCeg9Phh1378G9DS/yGnpxL3BtwhRHMsUpucYVhTUhWA+nKXhVpqQhtLGbcFs8AHIJCeY7U1ia1SHibYfC3QiKeLmSiPj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O4gvcejA; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-787edfea5adso16147885a.2
        for <linux-pwm@vger.kernel.org>; Tue, 27 Feb 2024 10:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709060058; x=1709664858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywsnLKB7BEe46reW+QJdS4Mwg9WjBgwPIt+XbFLSN60=;
        b=O4gvcejA2Ar2Aro/TWMIw9JUFFjsE2JOC4I1G7qN92LKtSHgbGbcUPPAzAP3/ggrQP
         J6GK6eIV4+tHuZokaaBcY8RvyFmlaxDifgbE/idDXG9FFa+F824Yeoc63XOoJ/Xu334V
         F2DPyZAUslMHxoIi7VbQERkwBptCu32LJXD5KbthpJyt01gXWxL2W56h6uAa39xijq52
         0LHL4xgUro2GzoGBWPFoclH50to8PLJTdZ254jSMDngA9cvJ61OHnmwhE0mprZia9SVI
         fDCENwzDc6aYxz6YMvy9zr/Wj3QSR9Dt2+dmioLLUrf36bMg+ogLnvzKKFHlA+slqzr+
         iJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060058; x=1709664858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywsnLKB7BEe46reW+QJdS4Mwg9WjBgwPIt+XbFLSN60=;
        b=knVE7CezHCFmJ9WPJWZm1GsItvkbKCaTdcNOzPRYfWHSx938tZNffiD/iAaR8KmcMo
         b1xdvpfbK1ZN5ZPj3pR2WVIZAyEHx1kopDtc0CytJrRElnjuVGscRTw4oWjU+YT6jgai
         n6IFDw0hQo5MuwQJVuF7cLUMaxKClSsjQ5SLSElfvX9RWBl90A2CfE1VZ3nJSI6vzLGH
         JU8lf7/7rwl86DX7m+Sb5uabQzezbCAg+TAE6Mmm+W2Klrg/lxqXDzkrH8Adg+aeq4+x
         qqKvUI7iDSLV68m30xJhm1LLpKZGa9FWJbywEy36eFEdsIzlwQ3JPSEaW2ek6Og4at3K
         J50A==
X-Gm-Message-State: AOJu0Yxe4XbjWvwO5jmKe7mu6/saRw9eFmQ/Zrc4LIWYB6bG3knlhwaW
	YD4SAd4Xsvr1eGGYK65lQNTE+WxQ7FA58VZJKYJ2cAzLd3pxKvWD5I/7EIK0i1s=
X-Google-Smtp-Source: AGHT+IEw469s3jdtp6qu9djiOLhMJTphxENeGkv5keDBulsZbt6HyqpLNItLJ91QcVcpdX6Tt2tdVQ==
X-Received: by 2002:a05:620a:15a3:b0:787:6fc4:cc8e with SMTP id f3-20020a05620a15a300b007876fc4cc8emr2939177qkk.40.1709060057897;
        Tue, 27 Feb 2024 10:54:17 -0800 (PST)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id vz2-20020a05620a494200b00787af8b5c02sm3844489qkn.39.2024.02.27.10.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 10:54:17 -0800 (PST)
Message-ID: <6aca1272-8a39-4b8a-b09a-79bc085362dc@baylibre.com>
Date: Tue, 27 Feb 2024 13:54:15 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v3] pwm: Add driver for AXI PWM generator
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.hennerich@analog.com, nuno.sa@analog.com,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Drew Fustini <dfustini@baylibre.com>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 David Lechner <dlechner@baylibre.com>
References: <20240131214042.1335251-1-tgamblin@baylibre.com>
 <20240131214042.1335251-3-tgamblin@baylibre.com>
 <rqozm7c4xixq3mb7sod7uslceieme7jrtdj2yelrekrqnttch2@vpsbe2nqmdsd>
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <rqozm7c4xixq3mb7sod7uslceieme7jrtdj2yelrekrqnttch2@vpsbe2nqmdsd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-02-26 05:13, Uwe Kleine-König wrote:
> On Wed, Jan 31, 2024 at 04:40:41PM -0500, Trevor Gamblin wrote:
>> From: Drew Fustini <dfustini@baylibre.com>
>>
>> Add support for the Analog Devices AXI PWM Generator. This device is an
>> FPGA-implemented peripheral used as PWM signal generator and can be
>> interfaced with AXI4. The register map of this peripheral makes it
>> possible to configure the period and duty cycle of the output signal.
>>
>> Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
>> Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>> Co-developed-by: David Lechner <dlechner@baylibre.com>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
>> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
>> Acked-by: Nuno Sa <nuno.sa@analog.com>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> ---
>> v3 changes:
>> * Address feedback for driver in v2:
>>    * Remove unnecessary blank line in axi_pwmgen_apply
>>    * Use macros already defined in <linux/fpga/adi-axi-common.h> for
>>      version checking
>>
>> v2 changes:
>> * Address feedback for driver and device tree in v1:
>>    * Use more reasonable Kconfig approach
>>    * Use common prefixes for all functions
>>    * Rename axi_pwmgen struct to axi_pwmgen_ddata
>>    * Change use of "pwm" to "ddata"
>>    * Set and check state->polarity
>>    * Multiply safely with mul_u64_u64_div_u64()
>>    * Improve handling of max and zero periods
>>    * Error if clk_rate_hz > NSEC_PER_SEC
>>    * Add "Limitations" section at top of pwm-axi-pwmgen.c
>>    * Don't disable outputs by default
>>    * Remove unnecessary macros for period, duty, offset
>>    * Fix axi_pwmgen_ddata alignment
>>    * Don't artificially limit npwm to four
>>    * Use clk_rate_exclusive_get(), balance with clk_rate_exclusive_put()
>>    * Cache clk rate in axi_pwmgen_ddata
>>    * Don't assign pwm->chip.base, do assign pwm->chip.atomic
>> * Remove redundant calls to clk_get_rate
>> * Test contents of AXI_PWMGEN_REG_CORE_MAGIC instead of
>>    arbitrary AXI_PWMGEN_TEST_DATA in AXI_PWMGEN_REG_SCRATCHPAD
>> * Remove redundant clk struct from axi_pwmgen_ddata
>> * Add self as module author
>> * Add major version check for IP core
>>
>> ---
>>   MAINTAINERS                  |   1 +
>>   drivers/pwm/Kconfig          |  13 ++
>>   drivers/pwm/Makefile         |   1 +
>>   drivers/pwm/pwm-axi-pwmgen.c | 242 +++++++++++++++++++++++++++++++++++
>>   4 files changed, 257 insertions(+)
>>   create mode 100644 drivers/pwm/pwm-axi-pwmgen.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8a4ed5545680..2baa7a0a1c8c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3438,6 +3438,7 @@ L:	linux-pwm@vger.kernel.org
>>   S:	Supported
>>   W:	https://ez.analog.com/linux-software-drivers
>>   F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>> +F:	drivers/pwm/pwm-axi-pwmgen.c
>>   
>>   AXXIA I2C CONTROLLER
>>   M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 4b956d661755..d44b0e86adee 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -98,6 +98,19 @@ config PWM_ATMEL_TCB
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called pwm-atmel-tcb.
>>   
>> +config PWM_AXI_PWMGEN
>> +	tristate "Analog Devices AXI PWM generator"
>> +	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
>> +	select REGMAP_MMIO
>> +	help
>> +	  This enables support for the Analog Devices AXI PWM generator.
>> +
>> +	  This is a configurable PWM generator with variable pulse width and
>> +	  period.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called pwm-axi-pwmgen.
>> +
>>   config PWM_BCM_IPROC
>>   	tristate "iProc PWM support"
>>   	depends on ARCH_BCM_IPROC || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index c5ec9e168ee7..8322089954e9 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -6,6 +6,7 @@ obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
>>   obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
>>   obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
>>   obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
>> +obj-$(CONFIG_PWM_AXI_PWMGEN)	+= pwm-axi-pwmgen.o
>>   obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
>>   obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
>>   obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
>> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
>> new file mode 100644
>> index 000000000000..44e62e90b227
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-axi-pwmgen.c
>> @@ -0,0 +1,242 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Analog Devices AXI PWM generator
>> + *
>> + * Copyright 2024 Analog Devices Inc.
>> + * Copyright 2024 Baylibre SAS
>> + *
>> + * Limitations:
>> + * - The writes to registers for period and duty are shadowed until
>> + *   LOAD_CONFIG is written to AXI_PWMGEN_REG_CONFIG at the end of the
>> + *   current period.
>> + * - Writing LOAD_CONFIG also has the effect of re-synchronizing all
>> + *   enabled channels, which could cause glitching on other channels. It
>> + *   is therefore expected that channels are assigned harmonic periods
>> + *   and all have a single user coordinating this.
> That means that when I reconfigure pwm2 the currently running period of
> pwm2 is completed and then all pwmX's counters are reset to zero?
Right.
>
> The patch looks good to me now. It needs a rework to use
> pwmchip_alloc(). If you could care for that, that would be great.
> Otherwise I'd pick up your patch later and add the conversion myself.
Will do. Working on the change now. Once I've done some testing I'll 
submit the v4.
>
> Best regards
> Uwe
>

