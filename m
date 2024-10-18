Return-Path: <linux-pwm+bounces-3705-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114DB9A3B87
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 12:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69B8284724
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 10:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEC22010E6;
	Fri, 18 Oct 2024 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ4RhNRA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C862C1FF7C2;
	Fri, 18 Oct 2024 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247352; cv=none; b=Ni3muy/UOei7ftn1rAFzBKMwCiQQGCQKtjpmAv5efHt61Cq4v94cyTToOQLy4l+Brbpyhwv762O2PL07jikVSxxZW+YvlbwT3KyjSvGvGrbOEliTokhZm8V3PPeHuVkFTDYBa7lRcexyO/rfmv5NFgkSelfEDCReF9+GE7pPDHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247352; c=relaxed/simple;
	bh=j+JweKJCABr+qOQMvnIYUslicV8qVgTOOvIvcKKqEfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfSqnHS7kdlfAXo+2Mp5PdHsC7iP8F3rPusepatNSNlWxUSGxtRSWLZ8x0KC6tbZnpK6+0m8gd6iY5hHpZfrTfPpHtG9DCJVdW0lQhkvwytbndc3P5NV5mZC1LE47IvEfTUEqNxtgLgmZlIizJTq4FSJzL62VzQZocO9SViFiso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ4RhNRA; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-287b8444ff3so810373fac.1;
        Fri, 18 Oct 2024 03:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729247350; x=1729852150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PH9bp5sNFtvJ03nSGmYK7jlqGxQcOJRnLBqL8n4Zt3o=;
        b=fZ4RhNRAV+eGB/5njUDOuta1HZXwVhgnXRLLhAJfm0wjNSf9UXiYrVq8mJI1UuKbtS
         fbLPGx1DFhKJTZ696Oifuwf5uXcX09gd7MPa+R5tDOoZCFnOAkra48azhBspMqWVuukZ
         JnuNxsvuUgozYOZqMYtSx+qIdN2s/GarO2mo1tnPNcVmw8LfbwTN018YAfVW+30PrNKt
         IZQ4uN0QzAGZigTFJQVqRUokaq8J1NTcqryLdYWHaUHA78rRKGqR2UvR0ZFXHsKpgBVU
         r55n8PJEbdv+/pE6iIoAha1jqr7fcv/pYSrvwnXt/C5mzf/RJBOboycWNeW+KSKQVYUR
         1JdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729247350; x=1729852150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PH9bp5sNFtvJ03nSGmYK7jlqGxQcOJRnLBqL8n4Zt3o=;
        b=m7MPDi/qBprFioTJE8vKzwsA0U6/1NU3Avr3F2kMzlwADTk0T5idKv6JZODTGQwryo
         f/hrtdocZWP+181brFMMG5nUDriDRuJdjzOExhGnIvzxD4EFfD9LBA9Y7keLVhQSKeJF
         78R/aCpAsqlvruL4NMYZsAQONJ/Fdj42pUf5RgkSlaQticGXSOuXgkl6iKtaS0Q+JEbw
         ctvwkHcWG+xGHbVHQbFYgEuQvH7cjm5cjN0WhHA2ZopL9jDfRszo9WCnW62soDMvuLm0
         z03aiXuetZmLPH/4QXSHeZZQTMWmVRuE7tqIoL62YSF2c0pWb/GIdDj4jx1yx+h0wyHe
         x1iA==
X-Forwarded-Encrypted: i=1; AJvYcCWR72By+zifBVNoETl0dvc9xNsfPkn33KMjD6icpvwvySddk9aPKviwenh8k63Zs6QYxrwGKwgdN4ib@vger.kernel.org, AJvYcCWXxa5e4a4z7niE3S5LTlA68iPD4/7PIbtRf44g8ga5ZBJJ7RfYtiH3pXd7UD55gj0wXQwxrhc06oAM@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+mqjYN8H8x+uoXyDCtgiBa3WCj+LpsQlyg2LFdXc7bmZ2VCF
	8nhoLMFJNkzYqo7cWc7U5tKBLK/jzaTJ8/LZbe23EMWAQunEKb/c
X-Google-Smtp-Source: AGHT+IHNd8wmIx/CgFPccgVlfZMrtbBMtRSiLFrPa8bpNp7QhCV6M1rvCM/3DYVBVI592Ii0RrnVDw==
X-Received: by 2002:a05:6870:d0c9:b0:288:e7f2:e9db with SMTP id 586e51a60fabf-2892c543485mr1669456fac.41.1729247349626;
        Fri, 18 Oct 2024 03:29:09 -0700 (PDT)
Received: from [172.19.1.42] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc233431sm1049934a12.35.2024.10.18.03.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 03:29:09 -0700 (PDT)
Message-ID: <95606f94-979b-4277-a13c-312fb12dd0e0@gmail.com>
Date: Fri, 18 Oct 2024 18:29:07 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: Add Nuvoton PWM controller support
To: Krzysztof Kozlowski <krzk@kernel.org>, ukleinek@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com
References: <20241018034857.568-1-cwweng.linux@gmail.com>
 <20241018034857.568-3-cwweng.linux@gmail.com>
 <57f9093e-9f45-413a-bfd7-68f10e960fa3@kernel.org>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <57f9093e-9f45-413a-bfd7-68f10e960fa3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Thank you for your reply.


On 2024/10/18 下午 02:01, Krzysztof Kozlowski wrote:
> On 18/10/2024 05:48, Chi-Wen Weng wrote:
>> This commit adds a generic PWM framework driver for Nuvoton MA35D1
>> PWM controller.
>>
>> Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
>
> ...
>
>
>> +
>> +static const struct of_device_id nuvoton_pwm_of_match[] = {
>> +	{ .compatible = "nuvoton,ma35d1-pwm" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, nuvoton_pwm_of_match);
>> +
>> +static struct platform_driver nuvoton_pwm_driver = {
>> +	.probe = nuvoton_pwm_probe,
>> +	.driver = {
>> +		.name = "nuvoton-pwm",
>> +		.of_match_table = nuvoton_pwm_of_match,
>> +	},
>> +};
>> +module_platform_driver(nuvoton_pwm_driver);
>> +
>> +MODULE_ALIAS("platform:nuvoton-pwm");
> Drop, not needed and not correct either. If you need platform alias for
> non-OF binds, this is supposed to match OF ID table.
Ok. I will drop it.
>> +MODULE_AUTHOR("Chi-Wen Weng <cwweng@nuvoton.com>");
>> +MODULE_DESCRIPTION("Nuvoton MA35D1 PWM driver");
>> +MODULE_LICENSE("GPL");
> Best regards,
> Krzysztof

Thanks.

Chi-Wen Weng


