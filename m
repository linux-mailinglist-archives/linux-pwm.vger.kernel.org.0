Return-Path: <linux-pwm+bounces-5488-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47813A89D32
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD4317A56D
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 12:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3752951C5;
	Tue, 15 Apr 2025 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="foF0AWta"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8B294A1D
	for <linux-pwm@vger.kernel.org>; Tue, 15 Apr 2025 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719071; cv=none; b=BCNZmc1l7HbxcqPhowhLEBursqvGxkDx/Jy/2EebIjU5S+S8X2Su+AvCnkvnp0XUMQYq3s65VfL3p20FyBghzvYSCvJiv4eE2OVZ3GUrOx7nz2DZ5XamSHCdQweMORcFOC0fNGWum5/YyLq2YeQqx8T9oiHpZJUXYJL99J4pFIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719071; c=relaxed/simple;
	bh=eIVl937PhzBBGlKlkh8kLTfnaLkiCL+to/VPTSqs/hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7h6GCRicqfEhhbYpXvtNsmvcIl72eWpLGrXfywDFI6NK8NRhggLMuovBnXHK/FuJsen+vEhyK9FlHeHz+vE41N0mJsmdbXongQyjj3rD1Ia6GNWzRo8/XspipxBRk8wobrGoiKR9vYJ99NFbnVADPL1YBtl8N35du3UwpqU+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=foF0AWta; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d589ed2b47so16976835ab.2
        for <linux-pwm@vger.kernel.org>; Tue, 15 Apr 2025 05:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744719068; x=1745323868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CmptmweS7lJ6GHE2wFUYE+JWDVLKYqz8ucpeUP/DcRA=;
        b=foF0AWta9tfFoYvlXwPRsYlzEtFiE1wAxYRLdrIaOocqk0X9rmsolngwB6B1WzUH4n
         CEou3ewTgItZZLBxlELUecQzKEfb1cQZJx4JyLpjbZC+9Ete6y9RAP0HKgORUTKY3Wzq
         4B0gb+tQSIc6Q6WW/DD/G8y8q2DPHOgzo5BHVnN/KWC5WvECkI0n3C0C1HTyGsE2QXRj
         FN0D+IFkdDBbu/YRXRwgKNyTguQHeegIu8G14BgZIQutRh0aACULqJK7gNU0CeUMHIFI
         mEQNkRNRCLzx90smS29OwN5//BQLQsofCHqlJ7TgIkk6ieR+1zJjo4NAJ0MiRwlJbF/M
         twsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744719068; x=1745323868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmptmweS7lJ6GHE2wFUYE+JWDVLKYqz8ucpeUP/DcRA=;
        b=NJT6gkuHn+w20miLc4bqlU/FGOJaUjdoFPEl045tOsYGREVVhlJOvP8uaUtBvxMDFT
         2tYi8EBxk/2oM8hZ/kwXSVrEPsTky6Q+vhueqNrduhYRiXsC8fwgQv4wAwcCrqvNTJHX
         1WmlWRs5K54ngSgvkmEmH1R4tpQEHAe61MAUXCMOYVIu6dzxNXYwzmXtW0DiWKzwr04S
         uamkO2/D7qKFICuKI0bRCGRs2MLSH1z8aGIn1yUEgcY03JsJI/MhJMytRwGGXvKK3eCZ
         e7Kqvyqg+JOZ/aPjg9HJJoeOCvkRKNssr4QegYv4mhTbwYFCjvP38VOOYWAVYwRR5VTa
         JnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTOZHHjecDOVkauQE2Q8fUK+03kcFz5U95vKbdgR//uqzRsQb243ZZPihCwXX5z04MYwkaVNUOxzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5wmegIbnBYn4D7/eTXcbRADtVdAWtxUNiVZmJ1UAhP91kBIM
	V/UxOZnHqb5m8sAMuKl4GdkEPowYicD6Lp1qOty6GPU0cLtFqyYwMFP/7fffFys=
X-Gm-Gg: ASbGncuREoKTkQPsJIQCAJw7QGMGNBMFrsZZNQUAPQqwcIhHySEMbOJZfCVA/iOFV1G
	gD/n0zdkJb3fgrc6sd3Z1n9264IyLC25k4mjXy6rVMDtV2mMeMPjTgchiDcL7N/nbzpvPqO+DLj
	6WXS3anBjA1rm8fFHJVGy7Vywy4IRsIfrXjPqqMGve2pPkIjU6BX/lzF0tG0SyGW7wEqXGZbWuv
	cZe7ApM8yF6u0c0J+MFd9K9SylZA8lVuYNGxPrI50D305GgxQ2fxNrZsSiUAq/QvbtezO2n4Mln
	v1qSAShPbYExjaUXphZ2185YZRA2lzb0ps1pjayYqw+F/cmzgpDISxkjctFsGTil6XUo/tSRWuM
	XWuEL
X-Google-Smtp-Source: AGHT+IHJ1Ly5q6h/cItnEzYwsEqY15X2cujDF4x9G+IO1L2NReprTYetKPX12tqvaoe5ju58AuPTaw==
X-Received: by 2002:a05:6e02:441c:10b0:3d8:975:b808 with SMTP id e9e14a558f8ab-3d80975bb69mr22117655ab.5.1744719067875;
        Tue, 15 Apr 2025 05:11:07 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dba66fcbsm33384565ab.9.2025.04.15.05.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 05:11:07 -0700 (PDT)
Message-ID: <0bbd2842-72bc-47a7-832a-fc8833163e32@riscstar.com>
Date: Tue, 15 Apr 2025 07:11:05 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] dt-bindings: pwm: marvell,pxa: add optional property
 resets
To: Yixun Lan <dlan@gentoo.org>, Guodong Xu <guodong@riscstar.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Conor Dooley <conor@kernel.org>,
 ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, drew@pdp7.com, inochiama@gmail.com,
 geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de,
 hal.feng@starfivetech.com, unicorn_wang@outlook.com,
 duje.mihanovic@skole.hr, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-2-guodong@riscstar.com>
 <20250411-confider-spinster-35f23040d188@spud>
 <89b6142bacecd4a7742341b88dc1e28c4454527a.camel@pengutronix.de>
 <CAH1PCMZnJDcYKJR35WirQT95hte0NWvGBe4fjDuyZEgagvunAA@mail.gmail.com>
 <20250415101249-GYA30674@gentoo>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250415101249-GYA30674@gentoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/15/25 5:12 AM, Yixun Lan wrote:
> Hi Philipp,
> 
> On 17:54 Tue 15 Apr     , Guodong Xu wrote:
>> On Tue, Apr 15, 2025 at 4:53 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
>>>
>>> On Fr, 2025-04-11 at 17:44 +0100, Conor Dooley wrote:
>>>> On Fri, Apr 11, 2025 at 09:14:15PM +0800, Guodong Xu wrote:
>>>>> Add an optional resets property for the Marvell PWM PXA binding.
>>>>>
>>>>> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>>>>> ---
>>>>>   Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml | 3 +++
>>>>>   1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
>>>>> index 9ee1946dc2e1..9640d4b627c2 100644
>>>>> --- a/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
>>>>> +++ b/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml
>>>>> @@ -31,6 +31,9 @@ properties:
>>>>>     clocks:
>>>>>       maxItems: 1
>>>>>
>>>>> +  resets:
>>>>> +    maxItems: 1
>>>>
>>>> Do any of the currently supported devices use a reset? If not, then add
>>>> this in tandem with the new compatible and only allow it there please.
>>>
>>> Also, if spacemit,k1-pwm can not work without the reset being
>>> deasserted, mark it as required.
> 
> If I inerpret correctly, only reset requires explicitly being de-asserted,
> need to mark as required? that's being said, if reset comes out as de-asserted
>   by default after power reset, then not necessary?
> (in other cases, some device block is in asserted state by default)

We can often benefit from the state that the boot loader has left
things in, but I think it's better not to assume it if possible.
I suppose it might not be required though.

Anyway, the reset line is available to use; why not require it?

					-Alex

> thanks
>>>
>>
>> Thank you Philipp. spacemit,k1-pwm can not work without the reset.
>> I will add that in the next version.
>>
>> -Guodong
>>
>>> The driver can still use reset_control_get_optional.
>>>
>>> regards
>>> Philipp
> 


