Return-Path: <linux-pwm+bounces-2884-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03519387D7
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 05:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FCC6B20F5F
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 03:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B9F13FFC;
	Mon, 22 Jul 2024 03:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJiL7/61"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177DA10979;
	Mon, 22 Jul 2024 03:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721620417; cv=none; b=GZk0tO0THbOn9lRS2yqoG2RW/LoQivmyIWUqOvmVkdfgXUl0Nx1R7IgzyT3TVVjIudbN6QmZ501bBRElQCqVw5KIec9SXqB6yc9Kt2c+DMLKurE1kLnC0S6KoQsrnfneRuaJiQ81Iaue8xA9vKc+N2wg9Urnq8GuKmLtSRqCw7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721620417; c=relaxed/simple;
	bh=v5ej+QHAYRtzwvwyNZuFnJwqbwaB/QFI5GNYhKWRc3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saUG8oJAEWtiQIxICyJYHZiCZ0Q27z6zTV6KqwpkBFdkLA5JTfgmihEuOSk0fwgVf7/Z22BvPaPAl8AXxUyzgLQI7MKBqn+DwCzT/2JeMKlq9hZ1RIPNYEVQaujTo0Bb6b5or6VfPsPo+ypgqPVL86H8bu/PsW+Ik7t+yQljF78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJiL7/61; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-260e5b2dfb5so2235386fac.3;
        Sun, 21 Jul 2024 20:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721620415; x=1722225215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1iD8loJCEK8S+S3SAkzQSxIdWLCgBghxXkHptXFwg0g=;
        b=SJiL7/613ghvmmN93kaDuPScC+91ARfJWsUGIM6pWJRB7BJ5j8K6CWryiTVoPTEWha
         xcdFv3XNPZoegTP/nSjw+z+wIga6Xfq/0UlUFXWQ1qh+ERZGh16o5ZgPTZWdGM5DV/Tx
         C3oyjBeHko3q2ZRNx6z4q2XgZ9r7Az1j/Qlg5dRdnFJNdnyKenEYI0b9TDLiMfdVlAAd
         WXnjnY2aXRKyeQKXUomsFVyB7d40NXdi7lI+CemBQQjTcwBTAmHNvN1M3RzTOhbwrbx5
         qw/qxLyeOj4Ssg/EE/20hmhOwHYSN3rzSI3dMXfI1oauHm5W6Fsn003uk7zWLH2+7BD/
         uidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721620415; x=1722225215;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iD8loJCEK8S+S3SAkzQSxIdWLCgBghxXkHptXFwg0g=;
        b=rBm9suQ1oD0s+sYWTqpHCFEUjVSTUDCjZr4SGojHxUDKF3TFYjg9wy5W52bCHtxByF
         wKwmJcpvj/5cT5anZon3c/DnovC475KkIDfBY5IYlvnqwvIe1aLCoEd7sbDbOng0ipq+
         DBPhtqL7DA4P9YBA3FQrGIYlnf4lTBN1XJJMZsO8h54caI1AEWWd4IbaCPS+1QnM7hkE
         VrIJ6Qz0nEVK+YdT3NLw2ts/ECxR8ZLf3ojFZfnwxoRS+ze4HNwym33Kpdi78qysHJKT
         brUMbK+iwrMHPw8sIqLsXrl8mfWpJ2uZzy7G65+RrI9wJrZB/ONsCm7aw6iyPo4HnGo4
         gkNg==
X-Forwarded-Encrypted: i=1; AJvYcCU5pP5sZVl9TfYvORcnr1yAp9GQ1eUQT0rAtcQEu6qGIwaxiiyBYAPDYofAxGzA1n/Bm0VJpBVd2yc6f0V/4zkBSP/0yXLp+spnBiVx30WTEH3hOOAaEnJVvInP4k6T7396U7tnE1jg+Ey63oyJqE/rpZ1Mkoj0yWhySKiIeQ70STo0wA==
X-Gm-Message-State: AOJu0YzQIHMzVR9sVDsmBK2ntsiCDnuuEp/c8STA6LnMGqPL+46uhFVJ
	J40xopymEZEVk1CjdWLuS4NRpIBjF2TpJE5td91/MnwotcdygD+x
X-Google-Smtp-Source: AGHT+IHZijDAM2ucUD2gE3ulZWZMetR+HHznBRaBWoqS0qs44a/XCCWbKW4MnlXinzoO6Qa/XwHbtA==
X-Received: by 2002:a05:6870:71c3:b0:260:ffaf:811a with SMTP id 586e51a60fabf-2638de5ba01mr5240250fac.8.1721620415145;
        Sun, 21 Jul 2024 20:53:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff4b2f6esm4488837b3a.67.2024.07.21.20.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 20:53:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <15f4c51c-3f7d-4e93-9c3a-71ac1d626463@roeck-us.net>
Date: Sun, 21 Jul 2024 20:53:32 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] hwmon: (adt7475) Add support for configuring
 initial PWM state
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, jdelvare@suse.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, ukleinek@kernel.org
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20240722005825.1800403-1-chris.packham@alliedtelesis.co.nz>
 <20240722005825.1800403-4-chris.packham@alliedtelesis.co.nz>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240722005825.1800403-4-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/21/24 17:58, Chris Packham wrote:
> By default the PWM duty cycle in hardware is 100%. On some systems this
> can cause unwanted fan noise. Add the ability to specify the fan
> connections and initial state of the PWMs via device properties.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>      Changes in v6:
>      - Use do_div() instead of plain /
>      - Use a helper function to avoid repetition between the of and non-of
>        code paths.
>      Changes in v5:
>      - Deal with PWM frequency and duty cycle being specified in nanoseconds
>      Changes in v4:
>      - Support DT and ACPI fwnodes
>      - Put PWM into manual mode
>      Changes in v3:
>      - Use the pwm provider/consumer bindings
>      Changes in v2:
>      - Use correct device property string for frequency
>      - Allow -EINVAL and only warn on error
>      - Use a frequency of 0 to indicate that the hardware should be left as-is
> 
>   drivers/hwmon/adt7475.c | 130 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 130 insertions(+)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 4224ffb30483..fc5605d34f36 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -21,6 +21,8 @@
>   #include <linux/of.h>
>   #include <linux/util_macros.h>
>   
> +#include <dt-bindings/pwm/pwm.h>
> +
>   /* Indexes for the sysfs hooks */
>   
>   #define INPUT		0
> @@ -1662,6 +1664,130 @@ static int adt7475_set_pwm_polarity(struct i2c_client *client)
>   	return 0;
>   }
>   
> +struct adt7475_pwm_config {
> +	int index;
> +	int freq;
> +	int flags;
> +	int duty;
> +};
> +
> +static int _adt7475_pwm_properties_parse_args(u32 args[4], struct adt7475_pwm_config *cfg)
> +{
> +	unsigned long freq_hz;
> +	unsigned long duty;
> +
> +	if (args[1] == 0)
> +		return -EINVAL;
> +
> +	freq_hz = 1000000000UL;
> +	do_div(freq_hz, args[1]);
> +	duty = 255 * args[3];
> +	do_div(duty, args[1]);
> +

Gues I am a bit at loss here, just as 0-day. Why use do_div ? It is only needed
for 64-bit divide operations.

Thanks,
Guenter


