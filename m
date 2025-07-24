Return-Path: <linux-pwm+bounces-6878-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 653F4B10AC9
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jul 2025 14:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383991CC33F8
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jul 2025 13:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA42A2D4B6E;
	Thu, 24 Jul 2025 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6fhnPsQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22A2274B24;
	Thu, 24 Jul 2025 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361968; cv=none; b=SwTtSl+LiAhuIE2r1BAOFRpB0/asMJjWqTAbykwr9MmeONJ/oQ5F9Vg7mv7zxCrFPuzeRrT30dWq3CbP/KvfS79lm3D9pDlDMjCFGo6ZrIb6HwDQgQN5s343+IjI5mGmxaDG4yc9nxqkL+yHzF2FllupqbyqWOPVy8WIgcg2Fu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361968; c=relaxed/simple;
	bh=ILeH+vPbG9zBvb1xqLYvczaaRyxSAcMEUH4gLkrZiGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecma8NwoOrECpFuJxaD/qahKB1XhXpXHSjKafjekIKvhdUfOBEoPLSa6yJeZ0x6ihga2mUw+s1qyj/4SmIp4rVuoWlKnj+7LsMViHT14FjNedADYDg3XM1v0vDvY5kVSrWaFmh6/hfwHTM5IySl+WLYyL0+aERwHAVXhm+4g63o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6fhnPsQ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b271f3ae786so783038a12.3;
        Thu, 24 Jul 2025 05:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753361966; x=1753966766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EhWB6aHdu+jk0Yh+Qo51X79+m8Mn+rAsGd/F5ZyKOlo=;
        b=m6fhnPsQxZVEiOKQ7rBeRYAxza4tYsIBX7HbPfAT7/VtLesV8Nxmn4QNEcY0W28rR1
         ApTg+85O6Z4+0WIEYbRQFs/FAf4ZHgJgo2fEOmvO6l+240blhxdOUnz1WCdP+3wLRD0D
         ABUGHTG1WKbY5pCqm82IBHrOQR7BUuCRZg4cDe0as3y/VgwLeZDF1N+z/f5SfVI8OFbK
         1XpDR6zT73zMNG+7rb5oJlWl5NRiMFjIuaD8nGBNxy6tVaUpD0H1mjOiJ/P2IjTEZ++z
         4GtBb+z+1EFGc1Z2joFlsnQPeUg/6YB6de9cjQ+hOnPyiUMuvGfQG7bL7/g5t6QeTowp
         1R6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753361966; x=1753966766;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhWB6aHdu+jk0Yh+Qo51X79+m8Mn+rAsGd/F5ZyKOlo=;
        b=S0cRo4AQMhXPBYFTLbj2byXZHnKjXHfLpZq9L//w45Oak23odnqsyCIDWSYjyurV17
         08w7x9yxeZRxuiDNnJCl7ZcgdkdyrSu3wy+y1Kb/gX9FlwawWlIDyEVUleTnDKPcmHoc
         3/ROEdgrATnURC3VaEt/fqOG1RnObdSihQBILdTiNWoIZDQge1sXcyhySiJzgglANRVB
         CuwzHZSlGvGkgjJLcmlizl1OuXaQ0nsPYgSjfwTherC8DLKzuaQWcG/Zb8+nvIPu/UNF
         VEjb4Ne17xbUPDv7j76ifeS7Zl4u9YCPredV8EHSZWtotEXhnA3Dx19uEJV9ku+S/XnK
         Smew==
X-Forwarded-Encrypted: i=1; AJvYcCULf8xoKuFqx7wW51z95Xxy7784bHEGbX/GrtcV9drSLMJXyjdfDhpf2GF60IiKApxMA4Wz0C5IXgg=@vger.kernel.org, AJvYcCUzsG5PMlAFYcyg5Id6yke02UT8cBezQI9M1IJ2e8c3KqTsvn72GwLz4V8lOJHGeONG1GLAXIDsPdAPEn++@vger.kernel.org, AJvYcCW+ZjBu7QdAH6jesKBtjSxKLAK4MZzBAVxff/G2i9dq6RToTnLNVgKVFvuATyh2DByaURBaJALNY2os@vger.kernel.org, AJvYcCX0W6vle1QIzcSqczGvMyF0LN/ziKiZvDX/8ySJ5KCNXxyjAdnFzDL0+BHN0zTbKU7xVpUUCYWvyx6oqlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBolFfY25K3zQToBvnNDmbel8ywgiBOMTMDjKFW+CljwDjowK
	QhvwH/iEaQ0CEldWRZY8MZ/a9z033BhS80fNZgJ8BuaDsapenJ9ce9eV
X-Gm-Gg: ASbGncu4LetNZ7601eRJXV4kU33lOad0N1RbLNOXB7mSb31aDFjOBlOwkLjPbo4FCOh
	DF566bWvnmCHEI5WPIcpbMpVMANjLruYACrC38boAQgdRyXhuI8hQL+VAaiYL3wSW765KNZn7ok
	yp58D/swq1AG9TiJiObH1Y7p26XAHIJKjZSVWABtU4LaZvDa7JEioovftcf/Qpt/Al9uGgF/nEe
	+yAzaztAn82eVKKppecKwyy8FAszr75F3lrLFXCAZj7vFkI/0as3xH3jHeGEcLtL1GKyd7LVvKg
	ic7y3cYMPghDGJclCpfCQWLiIq9p66a9GT3k/syUCTB+R3f9o2zQl1YNviPuZnOBIhd5KQuR+qk
	+WQATbpvW2vAxuYQQwT/jo5fEmEVg3lKSDIZvUKiLTDmSM7pAI+QSAysS0LG9T0/EH1XDK3o=
X-Google-Smtp-Source: AGHT+IEyz0Ff6ha/aES/VyZFD9tPaplBcuO4Ns0mTI5dlRQR4aWCiYbR/b5l2KzTJRez7bC5yNwnww==
X-Received: by 2002:a17:90b:1c8c:b0:316:e77:e2cf with SMTP id 98e67ed59e1d1-31e508171c4mr9383643a91.35.1753361965936;
        Thu, 24 Jul 2025 05:59:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e662f635dsm1361059a91.33.2025.07.24.05.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 05:59:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8115ef31-52f8-40aa-9494-55acd0c691d1@roeck-us.net>
Date: Thu, 24 Jul 2025 05:59:24 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] pwm: mc33xs2410: add hwmon support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 dimitri.fedrau@liebherr.com
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 Dimitri Fedrau <dima.fedrau@gmail.com>
References: <20250723-mc33xs2410-hwmon-v5-0-f62aab71cd59@liebherr.com>
 <20250723-mc33xs2410-hwmon-v5-1-f62aab71cd59@liebherr.com>
 <5fblcb3bbwclh4w4dm3s5ue6eplahka5idqz6z4g6ttmhqb24p@jaqznheusac5>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <5fblcb3bbwclh4w4dm3s5ue6eplahka5idqz6z4g6ttmhqb24p@jaqznheusac5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/24/25 00:30, Uwe Kleine-König wrote:
> Hello Dimitri,
> 
> On Wed, Jul 23, 2025 at 07:34:56PM +0200, Dimitri Fedrau via B4 Relay wrote:
>> @@ -361,6 +373,10 @@ static int mc33xs2410_probe(struct spi_device *spi)
>>   	if (ret < 0)
>>   		return dev_err_probe(dev, ret, "Failed to add pwm chip\n");
>>   
>> +	adev = devm_auxiliary_device_create(dev, "hwmon", NULL);
>> +	if (!adev)
>> +		return dev_err_probe(dev, -ENODEV, "Failed to register hwmon device\n");
> 
> Not so nice that you have to make up an error code here. But that's not
> your fault but devm_auxiliary_device_create()'s which returns NULL on
> error instead of an error pointer.
> 
>> +
>>   	return 0;
>>   }
> 
> I applied the patch for the upcoming merge window to
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next
> 
> . Expecting the merge window to open on Sunday that's a bit tight
> because I like drivers to be in next for a bit before they enter the
> mainline. The major code change is in drivers/hwmon and I assume Guenter
> is ok with me taking it for 6.17-rc1. If not, please object, then I'll
> not send it to Linus and wait for the 6.18-rc1 PR.
> 

Please go ahead and apply both patches.

Thanks,
Guenter


