Return-Path: <linux-pwm+bounces-5336-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207EEA7C4B0
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 22:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68643BFCCE
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Apr 2025 20:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B719256C72;
	Fri,  4 Apr 2025 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEXeT+q2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0933256C6D;
	Fri,  4 Apr 2025 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795785; cv=none; b=g5xgEPhiDZHprkfiGBWLnCsIGcvcwF0IRjUCBFzI7oJTZ+HxQ+s/5dKu+Cr4957qJPiHE8eD4obnqdXINqNZ79M99BxZkrslAhAnJR6lC48FqEtC+AOOobmBbWl1DQbelZduZVFyTuOKiqC9dOp0uj+44/qQmTdlZkJ0OIGfg1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795785; c=relaxed/simple;
	bh=xjRClgk0ru5HG2bIkVaucZvG6Qpe+4PE/utI54oaEgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPr9mWA56x6AufNLQOju/Lr6MaLks7YaDMb6LzE2pbRsD+OuzyDYgZROfWDHEpW15ObBCY5Bqr4qzKwuDrc0x/o8K7XAJOT5VbXzXkz8HvMz8n5KpsCx+fIeqv2LRKLr0MBpAYIdASLYpYKJ5LmF7F0MV70g2HyFV28qtA74wYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEXeT+q2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22403cbb47fso26170385ad.0;
        Fri, 04 Apr 2025 12:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743795783; x=1744400583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aCdihjYQTCflyJxm6dwPDa7f9mrC1RNKPnkAQB9Cuvo=;
        b=MEXeT+q2YrSdSAErSjL6AimNp3RbMgaQJHOul0TGkTAyqsbrjkQHS9vC6LvvveZrAv
         c1jIyQRlYzkFEx8Or2HSRTPEOwXEZsQMUisvaBPX3EpfV655N0idvCGrvtqxGnPZ3tNY
         SO7KdNJSsCFryUlE+xE2T1GbibyHnVTew/OEMHspkTLLpYfONZ4xz5lVDnBG1/Cz4sHW
         j9g87Z25KjH1ie5/IW5s0GcvAIQIMNP/FaUTWMpypWOrC5TBK6qjzipEVhlvljb4fchx
         5lHrq36teg6qjgfUJbA1OTPs1JRHWZpi4/gK1NR4R9OgSMBtOUurtd96WWP66lDA7fPH
         HoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795783; x=1744400583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCdihjYQTCflyJxm6dwPDa7f9mrC1RNKPnkAQB9Cuvo=;
        b=ANkTr8PlaM+Bh9lKdcvLcRZQ2UYo6+RDl/thi+0p+soK6Z1lPfJnb6z8UmozmNS0JY
         0fflDJ96wClAqTPMUuWosqdXReIvb0ceEJeZ6XrXxyjoXiZXi3xo1b7l7kD6aI1C9OJW
         j+T0F5jXQ6j/G8tHRPdme7L1E7GY/awuNUNTai4iXsqNQb9YIRcNUuCHI69YzTv7HxYR
         4ZHMwNWnKW3biBB7GkcZIQYkQjDYdJk3Rn/WVG7gt19sJGtlHC5Th8weSr2KTTp0WoIE
         dIAdUsweYxf2JKsg6EJp/c30jMXjhEfrlt9nfqEGp7cRLase3U449JRBQvJxp1hbFSEL
         ypIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYDYYhSRWsW5V1XtDhuNWlToYWALBSONMz7CKdGEzx6DrjRDKFQD4AX9EJFVN2ZiHrapzu0SMs9AHE@vger.kernel.org, AJvYcCWtgc5UExuTgjww+U8h70MIu6JakOdl4CAgZj+yaGVsjyGzkeYamDwyYjmbBM7y2WiT+VA5vl/CKLKo5NTL@vger.kernel.org, AJvYcCXExxJcIySipaN0U1R13/B1wj/L+G5TzDDLWgJE5GLQos+D8cXWcZ6DIbB00RnDTQpMcGJUdvmydBhs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Uvi3r7Jg5P+lVmf8WXZqPrhyOkp9/TJw1rxwzbCovIJkmoQ0
	jok5MHhdC46svATV1eMUpt7vYhWo1s4mmf0c581j+AB/OsYgW7oOSmX2qrrn
X-Gm-Gg: ASbGnctAhAL6ikhozniO2w/7yMyfy2TF8vwq8ltrLqA+xaP36XE0pu7FB6HyFYcwtSX
	NhO/GZ5pcCgHGOQYgf8Ya+FiDJ6ebJF422+t2YMJTHrjF0nyhNRdVWTXZXokjgvoRU+h0XR4Bf0
	IhtCzkOY0TrG644UrJA43r0fBokguVgIsDzFZZRRVDLcA70OdyddStV1/cbcqn3rSMv1yNgOdQn
	V5L2xXMewONxfIrVzk5gAuU3RIH6hywo/PeuIZvYCV0aZ7AvsldrKG6dwEeatltk6bEP9o2iVsN
	071V78roDgWe3xDk9W7vtWN3LROuEFKe/jgST6C8wmZPWaXBnsl8as+kB2VqkR81+V5G4exjqrH
	4PJmbL43/VNfw5NXw9mCesBlI
X-Google-Smtp-Source: AGHT+IGmSZQUmzN4kMPir1/3DwusZurNYkOuuU+RMXFG9BLfGYFc6j2Dj8c8UT3R/eHzPGq0z3D8Xw==
X-Received: by 2002:a17:903:3baf:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-22a8a85a244mr65443215ad.5.1743795782746;
        Fri, 04 Apr 2025 12:43:02 -0700 (PDT)
Received: from ?IPV6:2409:4080:1197:5c59:9640:d38a:951e:d202? ([2409:4080:1197:5c59:9640:d38a:951e:d202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e1b4sm36482985ad.181.2025.04.04.12.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 12:43:02 -0700 (PDT)
Message-ID: <299e033b-05d6-4d85-8d01-2d7d0167432f@gmail.com>
Date: Sat, 5 Apr 2025 01:12:56 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: pwm: Convert lpc32xx-pwm.txt to YAML
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vz@mleia.com,
 piotr.wojtaszczyk@timesys.com, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250312122750.6391-1-purvayeshi550@gmail.com>
 <76ovkshf4dr6egh72uiigsugdqsin6zwy3skksldhhh2goer6x@gsp3qkhqdtev>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <76ovkshf4dr6egh72uiigsugdqsin6zwy3skksldhhh2goer6x@gsp3qkhqdtev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/04/25 16:11, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Mar 12, 2025 at 05:57:50PM +0530, Purva Yeshi wrote:
>> Convert the existing `lpc32xx-pwm.txt` bindings documentation into a
>> YAML schema (`nxp,lpc3220-pwm.yaml`).
>>
>> Set `"#pwm-cells"` to `const: 3` for expected PWM cell properties.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> 
> I suggest the following commit log:
> 
>      dt-bindings: pwm: Convert lpc32xx-pwm.txt to yaml format
> 
>      Convert the existing plain text binding documentation for
>      nxp,lpc3220-pwm devices to a YAML schema.
> 
>      The value #pwm-cells wasn't specified before, set it to 3 to match the
>      usual value for PWMs.
> 

Hello,

Thank you for the suggestion. I'll update the commit log accordingly in 
the next revision.

>> diff --git a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
>> new file mode 100644
>> index 000000000..432a5e9d4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
>> @@ -0,0 +1,38 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/nxp,lpc3220-pwm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: LPC32XX PWM controller
>> +
>> +maintainers:
>> +  - Vladimir Zapolskiy <vz@mleia.com>
>> +  - Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
>> +
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: nxp,lpc3220-pwm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#pwm-cells":
>> +    const: 3
> 
> The PWMs defined in arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi also have a
> clocks property and in the driver it's not optional. Can you please add
> it (here, in the list of required properties and the commit log)?

Thank you for the review. I’ll add the clocks property, update the list 
of required properties, and adjust the commit log accordingly in the 
next revision.

> 
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    pwm@4005c000 {
>> +        compatible = "nxp,lpc3220-pwm";
>> +        reg = <0x4005c000 0x4>;
>> +        #pwm-cells = <3>;
>> +    };
> 
> Best regards
> Uwe

Best regards,
Purva Yeshi




