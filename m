Return-Path: <linux-pwm+bounces-3657-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE2B99F3AE
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 19:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F73281B68
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 17:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C11F76CB;
	Tue, 15 Oct 2024 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkC+k9uq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DB917335C;
	Tue, 15 Oct 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012035; cv=none; b=jXW8plNxvOO2MF/uLirM5mnJo0EnJ2PQEAku+fdGRPwia6WpQkU5fH+sRkcxVA+f0X98CS7D/NBJpgOQBLDgKr7yYalYOFy7XFOW2hpAx4hYnPVadkHxCTie3Spz0qc8Ifni/duL5jp3boNss6W4ztTkAZN0K4SrrjjDSAk5ch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012035; c=relaxed/simple;
	bh=qcq/rvCa9ShxceXAFb9QBI9i1jtRZKM8SsSEeUXc+lM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHWa8wdtqm4lL0ExE+0vJxzdr+UFFlq8FyHS4Rd2ZH/PhJjboEtAoYsQqVl6iFmncL0LNBkH+YPSFbL0mT/T/3SjwNpBXtPQqDkAhURw9RQAAqo6sH9AeuWtOrmekYZV/lvGOKdLI1g1FYF5UneS8uQ0PDJ/FDVyA+ta59W1uio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkC+k9uq; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e31af47681so2513262a91.2;
        Tue, 15 Oct 2024 10:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729012033; x=1729616833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cQKM6nVwyS8z3SFk80uIogjm3pGg/gI+D3YqnpYk8q0=;
        b=MkC+k9uqZuPiKzQehhDSF3mI5MUO0UmeSSF7d6Kfz5DLOAebfnBFgBXRQ0oFee96+t
         ewUt5d7MYsEs436DD6OTt0VD+9CSD+H8CZtsb0sbj0xh5J2MnoAUM/1/TlrUXd+BWbUA
         wgffQJb+MuxC87e0lUYPeznPh8bA+Eztqj8KIo8DBLGZhQlPAt/Ky+bnmVVBV/XFrmdS
         xpWNOkr9IzLrLEuZcsRrPjfgihPp+luBd4oL5GS+Z0sXiusfiXf3lCm1d2B7mHDunBsm
         7eC36FmuqgME0g5S3xcbNGVLAXk1f/decdx/SDrCesnUFaf4PoYA9AxhIY5g6uNtOsho
         2gbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729012033; x=1729616833;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQKM6nVwyS8z3SFk80uIogjm3pGg/gI+D3YqnpYk8q0=;
        b=U81qSvV3h6fUtm1Pf6uh8YIxHYiKrZjrPvI6HHNHs3Yfnz+iZHnAX8yL5rT3Sky+ui
         5c668GONfDS+iTSCr08WurMYf2OM9TuBOV+xMZ27AY/65/ni8zbU+qYmYbuSWSM86lgx
         wMuMSF9iDSndFr4C1yt9P+KvugxPrubSJ8p9yAm9DvCpiz9E8SWa3bPFXh+KjMSln2He
         0q/AKjIF9pWpv0T6a8Vlza369odcHQbv+hEfBrxI7DvTFDhh2BBJHUPCAz4px0zdpbpE
         NE23HLldQ2lLwEaOx3YIJnDQoLnXYmh5tivCWlb0+IilcflNCafJIgcwBtTAhyWlbz7S
         RDsw==
X-Forwarded-Encrypted: i=1; AJvYcCWLgvq+RdzTV/w1tPOj9FBLNqYfnqb3VRIzXdrkD4YVR0T8SVcgGBNk8J0HWGcE6BDsZwQZkKpCdKeu@vger.kernel.org, AJvYcCXjJaZTZHb1/l7uCgmtWwUDPKReqKrNB2Lbng1CZIZ8Ijvr+CoNB8qvKnRiulkvKJOp04VKaSPs8gBP@vger.kernel.org
X-Gm-Message-State: AOJu0YzNfPm/uQqwzc/d8rxlf7OEJ1uTeVpC/KNB5bmCyipk8ZFg1B38
	MdBVrtp5w0Lel/77Ol/fOezjTDgBD/zoTfbFFfy+70ZhaJHj8UAa
X-Google-Smtp-Source: AGHT+IGnPABvSajSpCL717SKAE3k2ctBYLENX0qV60hNDN58W7VYbywBenz2iOXbgBy0dyGBhQU2Xg==
X-Received: by 2002:a17:90a:2dcc:b0:2e2:e597:6cdc with SMTP id 98e67ed59e1d1-2e2f0b01eb9mr16571356a91.22.1729012032757;
        Tue, 15 Oct 2024 10:07:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f03837sm2087928a91.30.2024.10.15.10.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 10:07:12 -0700 (PDT)
Message-ID: <252b6f39-3b06-43b7-b227-1c29c1c12bd5@gmail.com>
Date: Tue, 15 Oct 2024 10:07:10 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: pwm: brcm,bcm7038: Document the
 'open-drain' property
To: Rob Herring <robh@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, justin.chen@broadcom.com
References: <20241012025603.1644451-1-florian.fainelli@broadcom.com>
 <20241012025603.1644451-2-florian.fainelli@broadcom.com>
 <20241015163200.GA1220909-robh@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20241015163200.GA1220909-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 09:32, Rob Herring wrote:
> On Fri, Oct 11, 2024 at 07:56:02PM -0700, Florian Fainelli wrote:
>> Document the 'open-drain' property that allows configuring the PWM
>> controller outputs in open drain versus totem pole.
>>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
>> index 119de3d7f9dd..12851c43a612 100644
>> --- a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
>> @@ -25,6 +25,12 @@ properties:
>>     clocks:
>>       maxItems: 1
>>   
>> +  open-drain:
>> +    type: boolean
>> +    description:
>> +      Configure the outputs with open-drain structure, if omitted totem pole
>> +      structure is used.
>> +
> 
> There's one other PWM with 'open-drain' so move the definition to
> pwm.yaml.

Ah indeed, there is one now, great.

> 
> Alternatively, 'drive-open-drain' is a much more commonly used
> variation.

That name works just as well.

> 
> Another thing to consider is for any PWM controller with more than
> 1 output, you might want this to be per output and therefore should be
> a flag in the cells.

Yes, that is a good point, this controller has two channels, so it seems 
like increasing the #pwm-cells might be the way to go.

Thanks!
-- 
Florian

