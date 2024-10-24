Return-Path: <linux-pwm+bounces-3841-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 346799AEB7D
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 18:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46F51F22269
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 16:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AEB1F7086;
	Thu, 24 Oct 2024 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULBWwOiZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B41F5825;
	Thu, 24 Oct 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786056; cv=none; b=EO8LKn6mew7MftA9F+jraHZdEz+01JVaMF9OicChu98Iu8z8wJkyb0zB9w868D81VJp6+sJ+9glvEHg70NyGsiTzaoR7JE9fjd2Dg0T/csIddIZe9ENvZO7Xp/aVJHxWaeG3oFjO0VQ/79yhfOO32gOhGXQdL7jFEuo2W4jKwOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786056; c=relaxed/simple;
	bh=X47LvEUOYBsfuM8RCuYBTE/Z0gX5Arf97tZXmkRXBJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXV6cPzCJq3lc0ZV6XL/u0GlFpc5EedCNYRRYHDec12ZO+QmmYFDhtUbVOHlX7x2AgPPPnZm19IlyVfjkcIvrATOezWrAQIwKUH9pIy083A5jKMwfb5wUdqLYgiO+KBLYN0AkdZ9Z1i65WJagnHkk14rxIW4bd/7DyFwXmvyeiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULBWwOiZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cceb8d8b4so5904355ad.1;
        Thu, 24 Oct 2024 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729786054; x=1730390854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2TNe2Ym34csTaEuiRW1/O4gceO7dqGqww+esQnWO0lg=;
        b=ULBWwOiZiAiccnCWR6ux2n53fWo5KVL7IONFagcus/pOzujT14z05FJAGe7bCk+Vv9
         JDbx7I/fV25KMv1DA4yjQCaENt4dwZSjGpE3X0EOpC3wwEoX3FB25p/p9WFAiNd69jII
         2Nusji///ZWQKttN03I0V/gSEXedjGCaWKGDgbV1CzAjGzZJAugFprdl4vYFPoFanwrD
         m9J82kqovM6Jx2s03RkAamo34vq/A3vIXwUFqj+XvSYFrdQ+99wmu6aoqTplG9hUWuyz
         NGV8Txbea69lniintwpELm/o8PQMKh4dYkB8sA+0DgEcmRmhwB05iMJutbG+78NKRpt5
         pW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729786054; x=1730390854;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2TNe2Ym34csTaEuiRW1/O4gceO7dqGqww+esQnWO0lg=;
        b=T/QdiGKuH1upnMF5n12leuIsUqJ1P+eH5JFi9S2TChgDgIYamATLsVgUJbM9JMQekq
         t89arHyE7VF2j6aKTzZlyqCJvp8l9hYw5wYHXwC/FwS9djCblO40UtgwzSQ3JzoabQ4z
         IcTSs+fQiWjE/JyCzJM6qYmwnj3qag/CeBAQMRflY0eeAvxnH9GEMetbvtBkDydgcz7e
         OdsnEuFajXJuGnSgvt7F1WQzqi734hxdKoIJxLBQANYDS36x065MyO8F6IH5q6UAW7KW
         yY2xwzrgeFx0TxOydMA4s8kjkulmpJVNcLIYii88E0hMO0JCPvSQSwo6jzhskUynoShq
         ODBA==
X-Forwarded-Encrypted: i=1; AJvYcCVAkO+ozLWhhCyMiowUkSKaiazNQAE5x26b/3BYJy9IpgjnUtHikMz5XemVXw7pLLHBfd9WGAKvphC8uYvB@vger.kernel.org, AJvYcCWfaFs+sThsGKOocwL0ha4UpVzfU9PnpVX5SZuSg7h7/HV0GhufHGQpAKP/7rtszooNZvSaI+lRCSL/@vger.kernel.org, AJvYcCWymSHq+QfQhFsm/lQL0qxCRH5EJPdYG+hveEnxBuwF7RXCWB9FRSyDsPQXwX0Zoxv9KzCZjHW2ekr8@vger.kernel.org, AJvYcCXcvGocF6b3Y0ZLGS65WjOgxJvvLdx3vFvYabi0Yy4AWPRYMA9yrmuLFKv90nzWkgowMWlCwLjP8H6Mluc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcRjbnQxlGQtUMsho2pvzeR78lgW57tquvzRdEN1LbCkGF9cE8
	1LAOWKkR5QIbVWT6uJJ2NkCFsu1m/2xqTw3BJfqgat01+khb/ohwuPnNKw==
X-Google-Smtp-Source: AGHT+IHelvnAnzzyZFpgXYdYPCQlFtmHXCy4JGArTTYWPneli64ZPa28QteTqe35EW6LYZvcNZOMTw==
X-Received: by 2002:a17:902:fc4f:b0:20b:a41f:6e4d with SMTP id d9443c01a7336-20fb89650ffmr43374945ad.15.1729786053504;
        Thu, 24 Oct 2024 09:07:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef0cbe5sm74037925ad.96.2024.10.24.09.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 09:07:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ea1be8af-0948-46b1-a1f4-fe572861cde4@roeck-us.net>
Date: Thu, 24 Oct 2024 09:07:30 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Enable WDT reload feature
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 BMC-SW@aspeedtech.com
References: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
 <nm4ckxv6swajr6hnqlkq5uoo6ncjzlg6yfxroftat6dubiefyi@xbhi4dvqacxm>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <nm4ckxv6swajr6hnqlkq5uoo6ncjzlg6yfxroftat6dubiefyi@xbhi4dvqacxm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/24/24 08:40, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Oct 24, 2024 at 03:15:46PM +0800, Billy Tsai wrote:
>> Aspeed PWM controller has the WDT reload feature, which changes the duty
>> cycle to a preprogrammed value after a WDT/EXTRST#.
>>
>> Billy Tsai (2):
>>    hwmon: (aspeed-g6-pwm-tacho): Extend the #pwm-cells to 4
>>    hwmon: (aspeed-g6-pwm-tacho): Support the WDT reload
> 
> Huh, I'm not convinced that extending #pwm-cells for that feature is a
> good idea. Unless I'm missing something none of the other supported PWM
> chips can do that, so I hesitate to change a standard for it. I suggest
> to make this a separate property instead.
> 

Agreed.
Guenter


