Return-Path: <linux-pwm+bounces-2775-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E345792F4A9
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 06:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986492839B7
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 04:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C73D15AC4;
	Fri, 12 Jul 2024 04:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+0MML+J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25357FC12;
	Fri, 12 Jul 2024 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720759055; cv=none; b=Bv98ae5iwvyrByD3KNWhtyhJZuA8/Vj58Y8gBx/fG3s55WD21mxtHdwvZeST3ta2I5iulpGYtCAXUcryE+HWVVfAehgHPsEV9tRw1P/0di1qNDUACBLGRqQl5CfSghxWyH0Kg1oOD4A9koZs6+OEAk/eiNrQR0M+U5qwV667Mbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720759055; c=relaxed/simple;
	bh=ZiOb4XKxmj69m7TkeWc9YshNXGSgOaA3C03oONlgOUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uC5hwXXxZWlDO6E8jMHH/N8ErIF2rVajSmw4zxoBhv2s5oVT8Hu6XYnWkabZLUvV0j++pILROVFh9gqr4kZuFzVGtVMlQHdEnrqJ2D5UrVni8hSmXKDmp8v0qqr8VpzVMZ1qMBPTYwhIROjRsv7axmUXh8LjQbvLL/13z5b5zVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+0MML+J; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-75ee39f1ffbso1055550a12.2;
        Thu, 11 Jul 2024 21:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720759052; x=1721363852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TAjZg+vTUEcNv7S645aMMZdQOkRXCutrQSpVCFWpVE8=;
        b=a+0MML+JUdOFJw/vgSeM9TWsEnFb+xNjGzkXxQPWcLwz8lLFKiqb55iKjndTmRhfag
         Eu2PWNczwytDZm1yIimoA+0T5wjg+vnUY0ZdkA03KLsTAH3bQpy1D1GAh613zRg7iUIH
         1qfuWPgO3hwZEvTWWyQmn5OMUgDTMm86LrMDNKOZl/6Lnz9m/oddDqqELTC4Vaco+Y03
         nkDjwk7qnw0k1eCUX4n9UDVU2HUMlgYVFBHAKQe+dEpeDwTuC9kPpnHOE5pudjtyJLiC
         LVNLxckGFR0nduCa/xLmsiq1O+/oC9GMeoTtq5GlynesNlMN5xEzNpp0mmyhSXCO4J41
         ZNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720759052; x=1721363852;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAjZg+vTUEcNv7S645aMMZdQOkRXCutrQSpVCFWpVE8=;
        b=XI0L7E/Ntf5eHg2SbLBb/pXLPnOJKjYjnIknQzOZ43oD3icnA1wrQKUZf5nTBOujO8
         i8cIPf2j66wM9KGddYjavCFIQmWch02wiPtD4Q0UQhg99IyTZw5ySGmSFDrnsse2y/4m
         Xt7Y6jHVYidR0Roe10k97JNIzStXnCqiZwX/wfx+weTRUz/DJtbZ7LtsYB51/l+j+4rL
         tIkNpAkKQYuyN9UcLqjKDSGkAaILQoKEIicZfnQqo+Zos4aEFKJ0JPoYFsBCh+iYrQWS
         fqJE4QiMtqgJ0cM/fZJHUnNize/sQ1HNjWD08HDvxTp1OieALwsv0xsvou6jmsBhWBwq
         VzJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKzrAcXMCysU3togxcs/mapRznKfFTm5wxQcqu3/cfoPaPGi0jWlrM/6MQ3Q6Rl7s+HM2vbxZJtmfND72iYroAGhsHmts5py+hSucTRaPPslStWbAOs+8YAA6Un/wzXQkqW02Thp9AuBfhMfiMh+HzVZ8sjbRFDYoL0feYZ1pPEgRzaQ==
X-Gm-Message-State: AOJu0Yy0dr6Zx7q8oLV48wI7xPaaUuc/4MzUAFOXZZCigh9HmDA37D2F
	ZYQqlKZshVBlty6x8o6SDwEMbag75GsQMfO6WaXT3BKddLDmEcWlLyWY0Q==
X-Google-Smtp-Source: AGHT+IG4wqCfTQCbbKc1GPfak05aMDbsnagwGrCgJ1tlYiwZxqFlXGXJeBU59AKdgFYRjOP4UCinKw==
X-Received: by 2002:a05:6a20:7491:b0:1c0:e54b:5651 with SMTP id adf61e73a8af0-1c29822ced0mr13779944637.24.1720759052152;
        Thu, 11 Jul 2024 21:37:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac0c47sm58085995ad.192.2024.07.11.21.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 21:37:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bd2b256b-5149-491a-a482-6e4488467fa5@roeck-us.net>
Date: Thu, 11 Jul 2024 21:37:29 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] hwmon: (adt7475) Add support for configuring
 initial PWM state
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, jdelvare@suse.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, ukleinek@kernel.org
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20240711234614.3104839-1-chris.packham@alliedtelesis.co.nz>
 <20240711234614.3104839-4-chris.packham@alliedtelesis.co.nz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240711234614.3104839-4-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/24 16:46, Chris Packham wrote:
> By default the PWM duty cycle in hardware is 100%. On some systems this
> can cause unwanted fan noise. Add the ability to specify the fan
> connections and initial state of the PWMs via device properties.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
...
> +static int adt7475_pwm_properties_parse_reference_args(struct fwnode_handle *fwnode,
> +						       struct adt7475_pwm_config *cfg)
> +{
> +	int ret;
> +	struct fwnode_reference_args args = {};
> +	int freq_hz;
> +	int duty;
> +
> +	ret = fwnode_property_get_reference_args(fwnode, "pwms", "#pwm-cells", 0, 0, &args);
> +	if (ret)
> +		return ret;
> +
> +	if (args.nargs != 4) {
> +		fwnode_handle_put(args.fwnode);
> +		return -EINVAL;
> +	}
> +
> +	freq_hz = 1000000000UL / args.args[1];
> +	duty = 255 / (args.args[1] / args.args[3]);
> +
You'll need to validate args.args[1] and args.args[3] to ensure that there are no
divide by 0 errors.

On a side note,
	a = b / (c / d) == b / c * d (at least for d != 0)
Since the result is defined for d == 0, you'd only have to make sure
that args.args[1] > 0 and that the result for the duty cycle is <= 255.

> +	cfg->index = args.args[0];
> +	cfg->freq = find_closest(freq_hz, pwmfreq_table, ARRAY_SIZE(pwmfreq_table));
> +	cfg->flags = args.args[2];
> +	cfg->duty = clamp_val(duty, 0, 0xFF);
> +
> +	fwnode_handle_put(args.fwnode);
> +
> +	return 0;
> +}
> +
> +static int adt7475_pwm_properties_parse_args(struct fwnode_handle *fwnode,
> +					     struct adt7475_pwm_config *cfg)
> +{
> +	int ret;
> +	u32 args[4] = {};
> +	int freq_hz;
> +	int duty;
> +
> +	ret = fwnode_property_read_u32_array(fwnode, "pwms", args, ARRAY_SIZE(args));
> +	if (ret)
> +		return ret;
> +
> +	freq_hz = 1000000000UL / args[1];
> +	duty = 255 / (args[1] / args[3]);
> +
> +	cfg->index = args[0];
> +	cfg->freq = find_closest(freq_hz, pwmfreq_table, ARRAY_SIZE(pwmfreq_table));
> +	cfg->flags = args[2];
> +	cfg->duty = clamp_val(duty, 0, 0xFF);
> +

The code above is duplicate; please combine into a single function
(I don't mind if it has four parameters).

Thanks,
Guenter


