Return-Path: <linux-pwm+bounces-5335-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25871A7C3F4
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 21:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96614189F725
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 19:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D792B21D3ED;
	Fri,  4 Apr 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hgsx9n2/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA511E1DE9;
	Fri,  4 Apr 2025 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795548; cv=none; b=It3sMTa8pME0vkVCQ1jdPlppMka3HCFAvX2hNV/YVQS4WNBl+i/KAnphSEOazUGSMUIe7d1d0ObMNiKqGzz1N5s8h14ooYJu+WT+WpD8Zdr9HwrWc12ifHhyGyRuTuSEg43BaSzTyytFMESGDVONU7PqJUyMGez6Hcc0wRR8tjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795548; c=relaxed/simple;
	bh=VpfAjJAGyn2iFrsTDI2qa/oAK+7uNraImYwiQTOK1X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=feV7EVtlYsQJVxXJZ0T1QfriqfC0cmRUzq7cMjVoUR2Vkgq0Peo7c4nx2OSUamaMZQ0pCao+GrAwIVy5KO9r11P5fWmcpQT3t3HU/dj9anJ5GcXAL9uHzjSIfwV5jV0SkUpk0joFFsWNnhOBdw4DSnfOCJ+qy33eLSkOYGbdxLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hgsx9n2/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22580c9ee0aso28234295ad.2;
        Fri, 04 Apr 2025 12:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743795546; x=1744400346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQGNgVHxDhs7mBk3RqbeX6683p63yLHOISx5dQxLR50=;
        b=Hgsx9n2/C17rlqum5/A4dc6mhszR+2cT+f4YbN93mqI/EhoE9043xB5QedBmxdJFFG
         jMIqcLhWHk3q0xwti9aC1WRsjX98Ju6LC1gi1gEoxXyaOnVaLa/kEnDHogD/MuB5T532
         NigoFE7VCAGRN3m1PH8q5yTFUeDF9ovT+ox6S9Ln4x31z9OskoOnKFvvbUu4TljnPiqv
         ZuxNkd7/Xt7gWoqP72fGQrYfmiMlS38RujDr9dNoujcsrDztFnFQyGS32RVuxLpAMHpO
         LZk8W8ktJgur1JLxaHYesMNqiW4ZGSu+y+mlPppbLfkxqQXTXoGERIM2SAJ5cJNuRRwF
         pH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795546; x=1744400346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQGNgVHxDhs7mBk3RqbeX6683p63yLHOISx5dQxLR50=;
        b=ORUNrFChe6OF+PbWktXV69fQiovjNYjIRQ93IzABNR1zofGCkhvFc96CHpMSnpuA4I
         uDEaTngE5ig16GY2d5jJLyNzAndDJ7QNrRj7SzsN1HqSC7g0WQOMuf4OB0WGb+0Cjk+4
         eUrvMn0kS9MdQ5Rm1PLS+4NXmFn260oJr7KlECsKXVEZqmxuAPUIw8UgP6tM/lRkzIaQ
         GyhlNRGtQFufTgwmbIrbcZ8yE9hr00wJOH4rUsN1og/wrejpGhr9r9tUVH9CEQueVL+S
         IDrtZRk4xpVXCWX2aRtUrDPplsmENCEQ1SwlK2JxkJtWX3MFKP+CiWzkvJl1Yw015WHj
         tS9w==
X-Forwarded-Encrypted: i=1; AJvYcCVHRlUbvoPhiQFs4bm0f42lM0w3zoMiE5vWw8/tk6SkjcO0n1u4c3vW9Br5fGKszm8W24hYWcVsbnlJzPKv@vger.kernel.org, AJvYcCXJErSbt4d889Os9T9zs0EQ5zmng1zaHXG/bOrBQNIFLfwNty2ti6MdKl+yqq5xRZAIBf4fnsoy//tR@vger.kernel.org
X-Gm-Message-State: AOJu0YwQY+CN5C5b6BIr4dVqyxKgHdR277p9ZwKyUgJQeBW1L/awCeLz
	jLAq3WoQOP121af6UnWFBuJMDIRkWtdkOo+6vCOjirbcX6R/wVZr
X-Gm-Gg: ASbGncs3Sis8aVhlYqgIqRzkzBwWSD3GCDBJ+2jibC/kmTwSv4qoHPbeFV0fSlNvsvr
	Zapxle6G1hvEpkZn5ujMgazqxyRllNAFC6YwhdV06wKZwJBLt8BYdvnMiMKhOpoHPVCPnntr6I7
	/amm+rn97OWVaW2pZJcfEivkFGJIxWgVf9XWTvux8dRGVb7hRMcG+ky4PdOPcZmudEBgn2sOVWt
	/iJ45/DMdPQez28sFhoXKs56BvkufQBKLDQA8fanSSxOfrC9iLMXmrYKhq/BhzPojgR00yIV+5P
	gOMET4ObLLtKjNBdsTOhWEklfWkKWxw0eQoddE43OWQ8RN8IyRychvwXaFrXsgSyTpglUOgPyLV
	DoVIxiXR0wVjHHTs707S5M5hV
X-Google-Smtp-Source: AGHT+IFe4mjpRg7zowmOKrRZGt9tbXvtfVX38ovvOh6lKYhx4xIePXLNWeuaoRutkTmWr1rWPnCrtw==
X-Received: by 2002:a17:902:d4c7:b0:220:ec62:7dc8 with SMTP id d9443c01a7336-22a8a85a18dmr57542845ad.2.1743795546267;
        Fri, 04 Apr 2025 12:39:06 -0700 (PDT)
Received: from ?IPV6:2409:4080:1197:5c59:9640:d38a:951e:d202? ([2409:4080:1197:5c59:9640:d38a:951e:d202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e242sm36279755ad.164.2025.04.04.12.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 12:39:05 -0700 (PDT)
Message-ID: <b493166b-5d1b-4228-82a0-ee7efcdd03e6@gmail.com>
Date: Sat, 5 Apr 2025 01:08:59 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: pwm: Convert lpc32xx-pwm.txt to YAML
To: Krzysztof Kozlowski <krzk@kernel.org>, ukleinek@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vz@mleia.com,
 piotr.wojtaszczyk@timesys.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250312122750.6391-1-purvayeshi550@gmail.com>
 <b2f6a357-a468-4526-a1b6-69ab2c643b2c@kernel.org>
 <61b1e302-98ad-4dda-8c03-18315d432512@gmail.com>
 <023b7e98-58ef-4752-9ef4-6fe699188b2f@kernel.org>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <023b7e98-58ef-4752-9ef4-6fe699188b2f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/04/25 12:03, Krzysztof Kozlowski wrote:
> On 01/04/2025 19:32, Purva Yeshi wrote:
>> On 13/03/25 16:34, Krzysztof Kozlowski wrote:
>>> On 12/03/2025 13:27, Purva Yeshi wrote:
>>>> Convert the existing `lpc32xx-pwm.txt` bindings documentation into a
>>>> YAML schema (`nxp,lpc3220-pwm.yaml`).
>>>>
>>>> Set `"#pwm-cells"` to `const: 3` for expected PWM cell properties.
>>>>
>>>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>>>> ---
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>>
>>> ---
>>>
>>> <form letter>
>>> This is an automated instruction, just in case, because many review tags
>>> are being ignored. If you know the process, you can skip it (please do
>>> not feel offended by me posting it here - no bad intentions intended).
>>> If you do not know the process, here is a short explanation:
>>>
>>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new versions
>>> of patchset, under or above your Signed-off-by tag, unless patch changed
>>> significantly (e.g. new properties added to the DT bindings). Tag is
>>> "received", when provided in a message replied to you on the mailing
>>> list. Tools like b4 can help here. However, there's no need to repost
>>> patches *only* to add the tags. The upstream maintainer will do that for
>>> tags received on the version they apply.
>>>
>>> Full context and explanation:
>>> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
>>> </form letter>
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Hello!
>>
>> I wanted to follow up on the patch I submitted. I was wondering if you
>> had a chance to review it and if there are any comments or feedback.
> 
> And what did you quote? What's there? Did you read it before replying?
> 
> Please avoid pinging during the merge window.
> 
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

Apologies for the unnecessary follow-up. I’ll avoid pinging during the 
merge window.

