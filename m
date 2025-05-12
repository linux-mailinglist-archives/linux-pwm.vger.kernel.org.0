Return-Path: <linux-pwm+bounces-5921-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F227CAB39B3
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 15:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7ED3A416B
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DF91CF5C0;
	Mon, 12 May 2025 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHDV/5qx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8C1D5AB5;
	Mon, 12 May 2025 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058005; cv=none; b=ZCRT6X6ZdTDf/FDhzhq9ndnVMyhDDfVKzLtFkoSNB0rwWXdS1Q+a6+gYCNSORyCoX2sZIbUP9LjMo7XNuY/MWBrh7KpwMk3iJmj8RjClR+MqRVjB/76I2XdE754HOteK9ukIgaNq7RM0LUE+JFFB7kFKaLztX3puvXsMHGuAnb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058005; c=relaxed/simple;
	bh=lvsYJSXqb60BAPqXPM1u1J9tq4X1c4s6rvU2ztnDsd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9Scy/W7rxNr7HeTnIISy82tbtnGAs5Mh8fzKVa+UB2RFDo9IUq3axMDeEn5QKJhQFsHTR7mFgvi/lvnBj4SOownq8vKWTB62QzFQ8krJ272bg9qzbATZNjH5clBTLSeXhag7AEKVWTHE6Rz4YYDEKQqLxQzHSa/GMK6tYsWVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHDV/5qx; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b13e0471a2dso3072433a12.2;
        Mon, 12 May 2025 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747058003; x=1747662803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cnmwp28GVHdo2cvf2bRtl0sYQfkO+XMPcFATxv9hQkM=;
        b=hHDV/5qxJL5rmptT33hSJu/f0B22lrCRxi6tSRYWLQqXrAp2d0HWQr+4rboa8g9clJ
         ZsaoRPBGQCPQ/ymgLgp+ZAfRdsUCFFy6oXQTR9dcsEvSrXgT5Y89b78pk3oaXdsIr7Iu
         zAi8n4+/fpG5WoUBoF1tK85J96666sH2ewMnIps1fSLYFVfOt+Esaw1czbRKOytW0EFB
         j+C67ajAQ+JqEVhpeznxZDPbY5Gz5zBhtIvocr+BYcyBiiZkoyLiOyKI8Bk7edaP+fSm
         YlEN9toCJqGWLA+ZlnMgUaQOZHWXjqSDGCJwncZHUuggUQuOB+ggYy/NRuZlLRg9bmIp
         uwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747058003; x=1747662803;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnmwp28GVHdo2cvf2bRtl0sYQfkO+XMPcFATxv9hQkM=;
        b=Ec2tax9Zu6pOTficukIlXRJ+zKjXsK0gdm/U+i5ky4uGmXD6UN9ov6cnpCb9d6ysVw
         nX31vXrEx0RMiYVFut18cE2/O9v6/OiZmii1X5DmoGTdU/MgVHtrTEzUG+XOifTpFPph
         XEvOv9DNcovr+AT40Q51PqBHXwiqFSTayevb46LK3pSze9G6ZVta02ZS/o1zZEGU0/6r
         +dCtaCozBvCvRPoKzj0gJIsQ3s/kt946KYfuFZQEj4aetAWWnBxRF2Xz8K94ltiyzXMc
         yTg1EVlbJ5Bq12GnWpiPIMPCI+CulWE7eCF1XBzkzSfNubAjyhr/5TqUfRrkeo0OOOjH
         mhqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsfjjwQuRk15u5mjM3oQ5aKU7y9ZDP5bStFPL+3zxKRhzXrZb0fdy2agbmazUKi66C9EwKjnd/8MkCgI3W@vger.kernel.org, AJvYcCVJxsVG3d4Jnb02Cr/sUANFhGMcH8e4PHsWoHzysRHJwcwDGLkKC3xOxg0wrL7HWV1nKjNp+4HwGN3H@vger.kernel.org, AJvYcCVsv7d6NjcXvkEbNFcpyPjGQqqHhWkaaLZoaJRWVXUZ5URo/ZtDcAeRh6y6u1Ip7UerkfjN+x9uHfeUwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpmLpCG1kcFu+9JDdNjbNiwdwlB4+Zhx8F0L72JjU9BIXtLtdz
	5PN0t9hmB/uYZFaBcYi5bj+LFNr5iSJ23kD+ljwmwF2zgnKaCK3ViV/9bA==
X-Gm-Gg: ASbGnctvWopvSPwLYfIsDMFAxkkqA0vMDENJw5vZKrtsA7Dk8ZLZFhwI+jcNVYc4NL2
	I0o8I4FMYf+7R6Qlgj3BHDlWp2Czzd9gsneZga40eaq0sv5XJlBh62/Oizrzt1Njdb+HeLJ9DRd
	MpE937XGf7zZ5ZqU0BYiFEb51tw9ZkNO7oEgKVBzemUUJPEmy4emm0KCtUA85Ybo8nETyl/iE+q
	ZiTneebquSPHjUtp1H3YxAeZb/OqTHyqsdS3WuzvNDsctHRuuU9PO7xInP9w4atr3lsCUXwWIPj
	sQCPkIMoPfnHu+9hK2dMoH37LgYR66OGm7bUy4udcg9wtULSO0Tr78sS7kdKAaD7b9oLZ9EmP0F
	AoLX2z2QRzzdqMD+1Vo9PSgHg
X-Google-Smtp-Source: AGHT+IHzx07XVe7gqTpQfz5qoZruYP2L5AVH5/tVInM2ZAqDnqexOrsMl0t71UTgXW5i2nWhPdhX/g==
X-Received: by 2002:a17:902:f78e:b0:22e:8354:dc8a with SMTP id d9443c01a7336-22fc8e99da3mr197824195ad.37.1747058002993;
        Mon, 12 May 2025 06:53:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82a0d9bsm63217235ad.219.2025.05.12.06.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 06:53:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a7a71408-c01d-4e0c-bd44-73ffbd79f716@roeck-us.net>
Date: Mon, 12 May 2025 06:53:21 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: mc33xs2410: add support for temperature sensors
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: dimitri.fedrau@liebherr.com, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20250512-mc33xs2410-hwmon-v1-1-addba77c78f9@liebherr.com>
 <1bd48694-9760-4e6b-9138-4651d42ff032@roeck-us.net>
 <20250512133114.GA6440@legfed1>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250512133114.GA6440@legfed1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/25 06:31, Dimitri Fedrau wrote:
> Hi Guenter,
> 
> Am Mon, May 12, 2025 at 06:04:33AM -0700 schrieb Guenter Roeck:
>> On 5/12/25 04:26, Dimitri Fedrau via B4 Relay wrote:
>>> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>>>
>>> The MC33XS2410 provides temperature sensors for the central die temperature
>>> and the four outputs. Additionally a common temperature warning threshold
>>> can be configured for the outputs. Add hwmon support for the sensors.
>>>
>>> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
>>> ---
>>
>>> +
>>> +static int mc33xs2410_hwmon_read_out_status(struct spi_device *spi,
>>> +					    int channel, u16 *val)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = mc33xs2410_read_reg_diag(spi, MC33XS2410_OUT_STA(channel), val);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	/* Bits latches high */
>>> +	return mc33xs2410_read_reg_diag(spi, MC33XS2410_OUT_STA(channel), val);
>>
>> Is that double read of the same register needed ? If so, you'll probably
>> need a lock to prevent it from being executed from multiple threads at the
>> same time.
>>
>> The comment "Bit latches high" doesn't really mean anything to me and doesn't
>> explain why the register needs to be read twice.
>>
>>
> 
> All bits of the output status registers are latched high. In case there
> was overtemperature detected, the bit stays set until read once and cleared
> afterwards. So I need a second read to get the "realtime" status.
> Otherwise I might end up returning an false positive overtemperature
> warning. I don't think a lock is really necessary, since I'm only
> interested in the "realtime" status but not if there was a warning in
> the past. What do you think ?
> 

Hardware monitoring is _expected_ to report the last latched status and clear
it afterwards, to ensure that historic alarms are reported at least once.
This isn't about "false positive", it is about "report at least once if
possible".

Given that, the second read is unnecessary from hwmon ABI perspective. If you
don't want to do that, you should explicitly document that latched (historic)
over-temperature alarms are not reported.

Guenter


