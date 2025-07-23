Return-Path: <linux-pwm+bounces-6875-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD742B0FCFE
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jul 2025 00:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 934347A0305
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Jul 2025 22:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F618270575;
	Wed, 23 Jul 2025 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0WB83ER"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AC31D54D8;
	Wed, 23 Jul 2025 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753310328; cv=none; b=GTZ8l2qRkH6tJjZvKkD3opy1ZveQWYhOJFZDlrVjcaS+cWb9ZQk5Qu8LZ2f5E1crb/cnBRGR/4qVzRFQtIKmQVEgExlnLb4o1R+Y0y8iGYfT3OMmiA5MykIVmHOgJiSh3psE2laA+gLGkQdlSQWDaE2Fay/MfnHn57PNCmUstJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753310328; c=relaxed/simple;
	bh=rllKm6oEcsaGEQDno4+nOwkZcdrVP5eCwS1QXpejhk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPmmIwmFdOJUV1s+KGs3M/1nf8wr6rRB+OBfOM3KSfssMNWusXDRF9tnsUm0kjJJ4i0FS/tuHDfoSZkJQgkb6B9uIi2lIYZhHWeuRsEJNTtWRg+xpwUlCTCQBkZDDU85tqfJl195lAku1qIg2bPLugBKA15F1gv2nhz0a4RWXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0WB83ER; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b34ab678931so376771a12.0;
        Wed, 23 Jul 2025 15:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753310326; x=1753915126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=httEGtEqD2JKhBONVOlAdsuEcxaTZjP6OdJ8FhoZGUc=;
        b=d0WB83ER+trZWLbQAbCMJ73d3AIWjRklUJLD9IyBQTiBKo1hoh4gOqk7AGar6LjuKe
         Im6QJUj7obENSmH7IuJoodEd0YyG7FDyt0Dfx5qudlbzoXBRVm/Wu07eNQ7fkcmnBjCa
         yzOssOvWUQeKfc3ypn6dzp/5yfW0jiULW6zaL1neo1WuIibs64E69IYqxAl0xLg2QnLs
         kJPRhHnOkg+UdxR+EmrsR6gfPFnSPUuQDv4vzP+8WO2By6p/CxE0LvKgaYhT7lO/91KF
         UD9tgq/iY/06m7DEVsMuneT1sNeymcxUcG4Rd/VFc0wTBxoE0VixdkiTn7BcISOVJpAD
         tu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753310326; x=1753915126;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=httEGtEqD2JKhBONVOlAdsuEcxaTZjP6OdJ8FhoZGUc=;
        b=XsO6LM5TdN5y0HvuVpIPrJmogjqxtpOY2t6s0VkpaoiT5oVj7hsYMypWeuIj6gn8Yr
         KE5uIm/2QcZoptFBriNi6rEdhJY5/lait0ZZNbrpYiH5BHDr0bRSLQcdD6GUAhMNUXpd
         +dKhfAimBTQ1dbp70ih15B31WmLl2Q+oblH3kehQSb8CHgAxbxvG95oOlJv8P8QB1rQ1
         AKvDIklNCGDlM13iVevYz7ES9t6hQoBb63WY5FlhMFSEWd5i/cfLLCXZqq7MI4LDDPBv
         dnyOw1p/z9wKybrdwlgVZheJT0IvA5YU5O2BYmuzS6zysCA4AVJP38UZC4zElGGJe+Y4
         +s0g==
X-Forwarded-Encrypted: i=1; AJvYcCUM5AG0MG04+88PssDIGl/+yiJfnIS5QMMt05PybJch0mvJOBvG0waamdXh0pEOqGtOSSuGMsl/z3r6mSM=@vger.kernel.org, AJvYcCUog1EZFO3osS5iOWHS5lAw9SwrxnTHikvjxju9qAOfEbWxHLocjh5faZezJbGrtbpZ7xaMAoPO+b3Ivrz/@vger.kernel.org, AJvYcCXOwHWEkgScHbIj3NxsO6+6yiuJP/dU3SBXMN4K/W5dcck0hRxXGNI4E+zV/6x2+L4JdiOU2lK67fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlT/NAy2IDPCZm+6yx27sxatBrp0+6PBwPeSRu/VUIIzW7S1dv
	T2MtRq+vWmdbCuS3Qj9JVKgs7FfQXjXRIBc2IH8KCg3aMIxynqVPgBf2cfJ8Gw==
X-Gm-Gg: ASbGncssx/jSN++Em8U07erLJ9l4vZTr5DL3D2N8mWZTh2OqnwI+FI5hraWpx68BdZV
	58xffDLnb8vlRi6UV0TZIjQLIJV3Zlm60sTpDn84dtQQ6dOuIF3huTxQEzIXo4QayM/YiRY2t4J
	rbQU1y97VSVv3yHJmX1rpRgiRpDYAEqXdR+tInEoKM2D0xb8KwfB5SMsYJwaKhdbkzXGCE9Y6MW
	RPvTBUzS22EcYYb5uiCH5cyX0etc3maq6kXYOCkVsM4o+mu6E355F6SeK3PW1nd875DbB+SW1Ak
	mDziACWbeSWIpwnqnXL50RtGTLHYOAi44FHH+US+Onr23l78mJx8/YiEHU5gGJQcGAJrpkRir1I
	mCKEWn65mtCZ1lApFN8NEYe2pM4yAfpBPzevHY2GiMiuGCjxm9guvLcGYZbn3Ku+G25dl3kAIng
	aOWoy2lw==
X-Google-Smtp-Source: AGHT+IHakvZZ3TUObRGKro7UVd2Yr8Ej1rtAPvox7bw0ZmXr5fCcKBn4M0OqVIvJGwFyJ7+j8EsOoQ==
X-Received: by 2002:a05:6a20:430f:b0:225:7617:66ff with SMTP id adf61e73a8af0-23d4905c6fdmr6898282637.20.1753310325853;
        Wed, 23 Jul 2025 15:38:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c09baecsm73443a12.24.2025.07.23.15.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 15:38:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <039cc421-eac2-4fc3-ac51-b1e5d5faa54b@roeck-us.net>
Date: Wed, 23 Jul 2025 15:38:44 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] hwmon: add support for MC33XS2410 hardware
 monitoring
To: dimitri.fedrau@liebherr.com, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 Dimitri Fedrau <dima.fedrau@gmail.com>
References: <20250723-mc33xs2410-hwmon-v5-0-f62aab71cd59@liebherr.com>
 <20250723-mc33xs2410-hwmon-v5-2-f62aab71cd59@liebherr.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250723-mc33xs2410-hwmon-v5-2-f62aab71cd59@liebherr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/25 10:34, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> The device is able to monitor temperature, voltage and current of each of
> the four outputs. Add basic support for monitoring the temperature of the
> four outputs and the die temperature.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

I am not sure what the plan is, but for now I'll assume that
the series will be applied through the pwm subsystem.

Thanks,
Guenter


