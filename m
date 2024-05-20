Return-Path: <linux-pwm+bounces-2189-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E088CA27E
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 21:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43F9FB2260D
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 19:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2801386C0;
	Mon, 20 May 2024 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpu/tnuE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C118139583;
	Mon, 20 May 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231828; cv=none; b=YW7rSV2XH77169vB/nsz46Y7w45Y+mYs49lqKjtpC+TKpUVOw+fODZCFrymLQws3wCsDYRniuc9+F0HRIH11ck4WrRbzTgRg9T3CoRc3MumEZpg2vLMfuSozm3cn/0hqsB0gXE6fXHpqN9a0sCt3tfilVgBqCjLhKEwRO4QBztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231828; c=relaxed/simple;
	bh=FKntkkbYYZ9ZHATyyYQ+blVdaP0O0rJ03bqWwtKxkVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCTLj432qrl7etPObW/sBdZngq2DdejfohGPefGYvM5QqF+0sl1jJ1ZNp2MshGZVt1dsLuItQa7iF6OZvTS0n7+NbaZMiYMOca+6qPgEmcbs4LdXU9M3v8FP1hFxRooDK0ekYdDtDTOUJarayBKcFX67S19SjWDs6chUM7Om4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpu/tnuE; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so1127138a12.2;
        Mon, 20 May 2024 12:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716231826; x=1716836626; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=t2/96V3wSIhdDejra9CO6NuVR50EXeIz3BQZGvTA8A4=;
        b=fpu/tnuEltav9Qz3ApdAhCYHFeUAk/yD/PyWEmsITLDSTtXrPtgVx3hZceHoyLT/HX
         Gntr/5NYI8ErcPxYkIT5ckzG55fUMFWM0NKvQTof8IU9bZKTg7Ou7IDj/IIK2xpYbELX
         BiOylpQrPstX96I+9HO+rdUec0ZViNdH4t77W1OdqXnZbWFxxRN40mIGlluG/vjJMDt4
         IZKtbto6ob+bO0ns3Guou4rQUENZIad7NIj6pfRy2lNgvcaDowsMLNebi3CnBbBCD+Qu
         ZurucKt0rHek9caO69dJkHnsjHAnFQ/3SWFQDUXPT2REGfvJoZbPji+EtW+8YlJaYceK
         oPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716231826; x=1716836626;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2/96V3wSIhdDejra9CO6NuVR50EXeIz3BQZGvTA8A4=;
        b=bilgMyB042mk/FH3YwLFntHJT2zE9AafIfxKt93G8cP7rB8MRM/QBi8IwWzcBrmDDQ
         Mn+xJBuaPv3F2QEMzgOYHFkwLJdynCrDOEFEHTHYSZjTnsmwCjV2OMD+ECqqGGIhXrN9
         XeNGXwA7m8X+9P+ADeHbREarklsg7XYhd4PMHrfQz3ADRfJgToIrRzooQutIO04wFTFg
         t1249a4PIMrUnNbeSXvzW98Aew1yny0PF4Hcg2dWDwjDPBf74JD+g7D6EgQSzby7cxF5
         hE19d4otvr8i55el8M2xZiRgvzadMU0ar8HYMYooI/45EC2m4v4HzqztmOAs55uKFCjq
         N+PQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7jk4udk3sCXfv85I9ut2J1HNTP9jnRRv9BAzFineAf9ZW8AJk6SAH7xSRMnqIWG29Orv0La+y/XS3N5yUiTqw2ULSmh1nUnMXEGAtSCNd8LvZM8T94XsOSb52kQERF7B6VgWx0eMWlry4IaguBERxnct7KlVWxBC1Gor162oG9I+HGNJylj/IcfKKD41ldDnhtAH2DwAOvavLgBpPiWZN
X-Gm-Message-State: AOJu0YwIqL/QUVCj6NSpd6ONkmDRNpMJr2Fg8KXtIQMmUiF0tsVdFHXT
	Prfiun5DoVDuBwS6STa8dL9EKjaeH02Auq9+Asvw85ZdL4S3WkV8
X-Google-Smtp-Source: AGHT+IFujHmcfeiRGxXw43eHC518yF31+5hwtHkctoleyve3gAxwLumD2yluKP8R85qJA+hBLHvSlA==
X-Received: by 2002:a05:6a00:3c91:b0:6e9:38d0:5019 with SMTP id d2e1a72fcca58-6f4e01b927amr34053364b3a.0.1716231825392;
        Mon, 20 May 2024 12:03:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4fcb6e14asm14615194b3a.185.2024.05.20.12.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 12:03:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <62c3c546-5172-4417-a15a-d13419d42be3@roeck-us.net>
Date: Mon, 20 May 2024 12:03:42 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
To: Conor Dooley <conor@kernel.org>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ukleinek@kernel.org, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20240520030321.3756604-1-chris.packham@alliedtelesis.co.nz>
 <20240520030321.3756604-2-chris.packham@alliedtelesis.co.nz>
 <20240520-pendant-charity-a66a8d738690@spud>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240520-pendant-charity-a66a8d738690@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/24 09:49, Conor Dooley wrote:
> On Mon, May 20, 2024 at 03:03:19PM +1200, Chris Packham wrote:
>> Add fan child nodes that allow describing the connections for the
>> ADT7475 to the fans it controls. This also allows setting some
>> initial values for the pwm duty cycle and frequency.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>>
>> Notes:
>>      Changes in v3:
>>      - Use the pwm provider/consumer bindings
>>      Changes in v2:
>>      - Document 0 as a valid value (leaves hardware as-is)
>>
>>   .../devicetree/bindings/hwmon/adt7475.yaml    | 25 ++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
>> index 051c976ab711..99bd689ae0cd 100644
>> --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
>> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
>> @@ -51,6 +51,15 @@ properties:
>>         enum: [0, 1]
>>         default: 1
>>   
>> +  "#pwm-cells":
>> +    const: 4
>> +    description: |
>> +      Number of cells in a PWM specifier.
>> +      - 0: The pwm channel
>> +      - 1: The pwm frequency in hertz - 0, 11, 14, 22, 29, 35, 44, 58, 88, 22500
> 
> The standard binding is period in nanoseconds, not frequency in Hz.
> What's gained from deviating from that?
> 

I'd strongly suspect that Chris didn't know and didn't expect it,
just like me.

>> +      - 2: PWM flags 0 or PWM_POLARITY_INVERTED
>> +      - 3: The default pwm duty cycle - 0-255
> 
> Same here I guess, why not match the units used for the period for the
> duty cycle?
> 

Same here. I am used to pwm frequency in Hz and duty cycle as percentage.
Using the period instead is somewhat unusual, and I must admit that I
have never encountered it while dealing with a variety of fan controllers.

Just to make sure I understand this correctly - duty cycles would
be (rounded):

Hz	ns
11	90,909,091
14	71,428,571
22	45,454,545
29:	34,482,759
35:	28,571,429
44:	22,727,273
58:	17,241,379
88:	11,363,636
22500	44,444

Examples for duty cycles would be

20%: 0,2s or 200,000,000
50%: 0.5s or 500,000,000
80%: 0.8s or 800,000,000

Is that correct ?

Thanks,
Guenter


