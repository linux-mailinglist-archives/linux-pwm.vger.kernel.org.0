Return-Path: <linux-pwm+bounces-5318-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1BDA78189
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Apr 2025 19:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634273ADC9E
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Apr 2025 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2383E20CCE9;
	Tue,  1 Apr 2025 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdYLByVb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C437FBA2;
	Tue,  1 Apr 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743528771; cv=none; b=pxNnZFni8zqo2rIZJ2g3aOAC5MyLFmoigha9lZ7h/0ZyYldXm+SWks6DOjZFuD55oIUKSVxXgtcCbBZhEAc/zf7diy+E6Z7FTTOcWUMUQpYIkCGqW0yLj7OyPCO0RGFK6XuSOeWlnHZeJ2HZKTAFqBEGiJ2B59glmmOeoiiTQQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743528771; c=relaxed/simple;
	bh=4HBehSn3B+g3auftMF4wZeyzN5E7LdH11EcjSe1YyUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGD6Iuc6s5R4/yLd3WQGZS3kblcGH2Ox8E/y75q0pskH4Cw93mB89pJsZKOyOcdrigZwbQDd7zjfi/j/TVZ0J9GfKgxRIfPmgyackSfnuUziSzq2IUTrXx+Xi2NEiehxc12Wg8pa4dL3XKyOUKgfi5+FGsQWQNIxyVc7v/oVvcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdYLByVb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223fb0f619dso110693005ad.1;
        Tue, 01 Apr 2025 10:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743528769; x=1744133569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8RVUmA+m1kGChPMpcQ+PaepE65DTzRvMV0W66iG5TU=;
        b=hdYLByVbyiwr1Tab3hzdM7nFQRUSAI8/YZbj8KJKDeqHE181AobBA7D9c4A5iVNApr
         TPlRuPKvV6qi9c1oAuOnCBYQdPomUW4agn5qUnONL+xtLo9ToU5BgVjjhVu5ARD4apQY
         2YFPJRE+b7PFcPFjKCZGhH0NIkX2CGwVRxaVDpyWFwf6W3gBV1QkXp6uclovMozxWV68
         LhkPKNxfrAMrLcJPF77wkorTBqO7eis7YuokQZAjfTIpT63SPVBZ8TA62n/kZijAmzFM
         3NcXEVhjKAHMgWya+Za8gSPaQ9DaBmFmWx9z2V0OxJYx4uhVXuOUyqaezVEBJXWZjVgt
         f9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743528769; x=1744133569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8RVUmA+m1kGChPMpcQ+PaepE65DTzRvMV0W66iG5TU=;
        b=lpHC+sPhbYHl2+RvHl6ylBf3+5DlVsYQdINj0jA2oe4P/3VMwGadRIvwk0pLQoNXR9
         zx+hVwMa09jKQn/JBdi9tXycG3tZLjiOUISETDMTUOWidMDi+4XhbW+Ovtecw/2NhOBb
         MTGcPyeluHcPQFgP+fSfUVa/vM5ocgeF6mP+rmhsxA5KKveWv6iR8OzJzKcwgw11Irb7
         sKpaFBLdTCd+7BJ9U8lVKX8HeZd27mMX9ZuidhvYGKtwVbN1ha8r7HDq+dk9fw7mfvz1
         qhCakzHgtCQc9Bu4ftSg7oVrWyTf2+Oef+1saFKxpdtr4U9kSF7hl0ffCaUvrzlAsNPK
         kzfw==
X-Forwarded-Encrypted: i=1; AJvYcCU35M3TPuhrEXFAcIjl67ux/GKStPoO/Z5WWAVbQpiJXEaeVd7TdwrSchncjvJ0SfdgnPgc1MBRD64L@vger.kernel.org, AJvYcCWNhoLkqcs2hq8ejCrk9x4aqWxqkyj64cLUBjcqg+l0RTl0h8f2zq7ku5CP011rptP0fvNCNariJA7k8V2F@vger.kernel.org
X-Gm-Message-State: AOJu0YwVPEX65vl8HvRNfLAahlH76X1Mcehs6QZquMMJyIgU9COORK3g
	/od7Ubzjc2JNqP5a6qrD9evZTAys6203KDOFn+qLSCRq+HUX0+uV
X-Gm-Gg: ASbGnct9hJnsyIc09IvEnP2+2HIhf5iLWMsLwiH0YU4TiUbcgwHctDZ215EMFHI3tmT
	9+bI6piVCQoOudz9wzN6H0gHOMqHHJGZvVFSXbUc0UZ9XpYIMcdBmdxlyvy6d2XURw4Bs3mBnCM
	eEM1QCN1ClmBShlg23198eUNQBlcJxmVAdW/gBWRYTigtFpN5YFkjtgUL9Yr4rSr/bEmlqkNeRq
	+FeZF8NQkZzxNuqkBYrCPAdvYVeJrN0lvIMMoAHqGx9nGz/DMf06d04MTKQKI2EdPXJOyiLs6/m
	b1Mkj2wjjznutPBT/Vqg/zx3yP94BBnenbmEAqU4rsJnCjb9+N4gtrRMQ9rZKPqhDJ12bQXXGzw
	8M7bAF8KyJ1p7SmYej7+VvhpfkNGzDFuptXw=
X-Google-Smtp-Source: AGHT+IH95w/LAWi9XB3yjcdglXPFnSGj8XWtvL857JlmhI7fKhJECGlgQFhZrN0iisUbnhGnnnDRUg==
X-Received: by 2002:a17:903:11c8:b0:224:24d3:60f4 with SMTP id d9443c01a7336-2295be6601bmr58932595ad.15.1743528768618;
        Tue, 01 Apr 2025 10:32:48 -0700 (PDT)
Received: from ?IPV6:2409:4080:109b:c762:5821:556c:83c9:d1d7? ([2409:4080:109b:c762:5821:556c:83c9:d1d7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73971068576sm9187137b3a.119.2025.04.01.10.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 10:32:48 -0700 (PDT)
Message-ID: <61b1e302-98ad-4dda-8c03-18315d432512@gmail.com>
Date: Tue, 1 Apr 2025 23:02:41 +0530
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
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <b2f6a357-a468-4526-a1b6-69ab2c643b2c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/03/25 16:34, Krzysztof Kozlowski wrote:
> On 12/03/2025 13:27, Purva Yeshi wrote:
>> Convert the existing `lpc32xx-pwm.txt` bindings documentation into a
>> YAML schema (`nxp,lpc3220-pwm.yaml`).
>>
>> Set `"#pwm-cells"` to `const: 3` for expected PWM cell properties.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> ---
> 
> <form letter>
> This is an automated instruction, just in case, because many review tags
> are being ignored. If you know the process, you can skip it (please do
> not feel offended by me posting it here - no bad intentions intended).
> If you do not know the process, here is a short explanation:
> 
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new versions
> of patchset, under or above your Signed-off-by tag, unless patch changed
> significantly (e.g. new properties added to the DT bindings). Tag is
> "received", when provided in a message replied to you on the mailing
> list. Tools like b4 can help here. However, there's no need to repost
> patches *only* to add the tags. The upstream maintainer will do that for
> tags received on the version they apply.
> 
> Full context and explanation:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
> </form letter>
> 
> Best regards,
> Krzysztof

Hello!

I wanted to follow up on the patch I submitted. I was wondering if you
had a chance to review it and if there are any comments or feedback.

Thank you for your time and consideration. I look forward to your response.

Best regards,
Purva Yeshi

