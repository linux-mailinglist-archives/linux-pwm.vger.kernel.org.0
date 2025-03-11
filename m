Return-Path: <linux-pwm+bounces-5132-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0DCA5C445
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Mar 2025 15:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9E53B04B6
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Mar 2025 14:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ABF25D8EF;
	Tue, 11 Mar 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aguadu7H"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295B25C6FE;
	Tue, 11 Mar 2025 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704950; cv=none; b=Y1AuWOSCuL2lMB7NK73rqKxQTsq93j3/Xn4RpDGSv33oIF/U5pJil2w5R7nzBTTnaOgWuMhmpvsl4l+sSLBnoVkseHuLP9/ILTN2xl9iHkJQbOYdc81qwvZjElmNaS4IarfuxUC7Qv99FgyonCJ0zbbH+9Gi3dAxM4YDHw4lO7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704950; c=relaxed/simple;
	bh=He3HFZQWH20+sm4Cq8+Xh8xxtSusgrwlCGQncmt4d3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rF/Df+FqY9lmhfCm5U4HTztYgZhyIQn5fePOpvTU6kQ0hhYb2mrcy0Ex31Dpj+LeINSmFzrGztNVyFeIGDG+lpoy+r6QNcZJwQUPhZhu62w1BuknHlnbfjbCRvqjAHX9ZAbZPKY3uFArH6rqtR2Izq07coTeFI67LwTaN8kZfDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aguadu7H; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22409077c06so14962625ad.1;
        Tue, 11 Mar 2025 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741704948; x=1742309748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hzo6Koa6NINZprXYYSZB+aJdwboisxt85bCqIMCOfvY=;
        b=Aguadu7H7//24/2NTSPKF25YnPASvsPOqYtDZ9CQBa7sx9dKL8DehxbxAcgE5qWSxi
         dUou+zUoOGof7MwicIJshgAkR3pzwiSdb2QQxdAHFTnCgbP94zBGxeSBl5smf56qgh2q
         LFuYVHoP4cI8iPFlgYwW+i4m7A7ocomNve/Xsy+dhziaYUOm19m1wQSisgc+k5kHQ5be
         1qHSxJGjNdDDxd3u8cZMchhTw20VpdOvc+KeVcsQq8cTEUZI02LvhQfn1/gK8xrTEbuE
         yM6gSClutZMyzUSTontSxc4HkV/Jlv1lhAilpOGifoXA/xS3Im73kHbuQKiwruGNLXoj
         zicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704948; x=1742309748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hzo6Koa6NINZprXYYSZB+aJdwboisxt85bCqIMCOfvY=;
        b=hDoY7ogjIloC37udOFBwkYIbwb3OeNsBCyAu6O0tlRpVSZFCzB0U5CAZc1msUvxsL+
         ABl8I2/9FPfYaYHn8YVIqaGyo8o+ZbNy74RlOCmlU22EZDhk+LCkkJBRmsW6HVkBZCdP
         IQAcCAKYm99KZur/OAjD8Her/fIBeC7N+K/cth7DsizP5xmrndbRUwUyynqnESwjV2VX
         CjIJ0EyvZ1U+JG10eKfhJgFHx0bsI0fGuBMdg+PqQ6/nBuifshPK6GbJGjsDh7KqfSkj
         HiOCYjbzYW+2aDdf4zxOVU9aAorChw/VvfTHxAcAnAUTy3eUAPCdPoJa3Jnc5l/LlmKS
         x/5g==
X-Forwarded-Encrypted: i=1; AJvYcCUstknf6dA9MtTA2tItiafp2fxSu4XuNCh1ttHrh8Wsqt8AUg6Zp6O0mVhuPhOVHvGRnT/7952nDKPl@vger.kernel.org, AJvYcCVcDyqdtfphHFId0zALnEkF6VUKnPEkvHGhoAGUhejF26nU+zGvaALNL/h9NDNbOerJ7cIawCtW7mDklfW/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywda9qx9LleMad7MsGxOj6y6nX2iYxPf7Cq1It/wnF7zshoeRZr
	pT3STTWUYfZCB+rPyr+1+UpRim/okhoJpf0hu6Xlg2jv+J9JxpYK
X-Gm-Gg: ASbGncsNrmYMpC4Jy4JkIeTXTdZtyyDdU/fSsDAbWKDvIxxFutwgQGfwblUn5hQECne
	4+NGSJOsGOpp5qUcx+PG+fcgj9zXS06jrTrDYgCQXO3mBvF+j+OwgydX7tqPQh8fGAJSBiGN+CU
	7BeKoJBM/95B+IqcR++IrYbv9zH5LlQwIvQE4FrJMu9EY7uK+GoYZGzvUV34ghLhsiqUiSsrA3G
	Gpti4pFDmaWhDLb8876UJbyhWvwDeZauIWcHlhrbNpRK9e4HVe5mV4ZJ5Sr2TS3vPVQKKJHHmBT
	gYmnOlPu1vabdCjI7XRRbHz6ljgRLMY3vpBRL6vQuIF3+bO3/mNIWwEtX7W+dhr3YoiLw/tZ3A6
	or20dSFcqwDJlTesnid+LU73B0j8+ufHIy6M=
X-Google-Smtp-Source: AGHT+IG12pcP/IsHswOoDOYsHQYJiPWDj9HXG8bOa2WH0Yl93cwpD4niPBh9L7Y6old776/q/7HTmg==
X-Received: by 2002:a05:6a00:194b:b0:736:5e6f:295b with SMTP id d2e1a72fcca58-736aaa5d6c4mr27328562b3a.12.1741704948033;
        Tue, 11 Mar 2025 07:55:48 -0700 (PDT)
Received: from ?IPV6:2409:4080:1188:3708:6163:78f8:b3ac:ec7c? ([2409:4080:1188:3708:6163:78f8:b3ac:ec7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698246387sm10404620b3a.72.2025.03.11.07.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 07:55:47 -0700 (PDT)
Message-ID: <47f6713b-b751-4791-9059-a128dd1fc71d@gmail.com>
Date: Tue, 11 Mar 2025 20:25:37 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: pwm: Convert lpc32xx-pwm.txt to YAML schema
To: Krzysztof Kozlowski <krzk@kernel.org>, ukleinek@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vz@mleia.com,
 piotr.wojtaszczyk@timesys.com
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250311125756.24064-1-purvayeshi550@gmail.com>
 <af6ebce2-7256-48bd-94d4-dc81e2944966@kernel.org>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <af6ebce2-7256-48bd-94d4-dc81e2944966@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/03/25 18:52, Krzysztof Kozlowski wrote:
> On 11/03/2025 13:57, Purva Yeshi wrote:
>> Convert the existing `lpc32xx-pwm.txt` bindings documentation into a
>> YAML schema (`lpc32xx-pwm.yaml`).
>>
>> Changes:
>>
>> Add SPDX license identifier `(GPL-2.0-only OR BSD-2-Clause)`.
> 
> That's not a change in the binding.
> 
>> Define `$id` and `$schema` fields for proper schema validation.
>> Set `title` to describe the LPC32XX PWM controller.
> 
> Neither these.
> 
>> Add maintainers as per `scripts/get_maintainer.pl` output.
> 
> These should not be subsystem maintainers.

I have removed the subsystem maintainers and included only relevant ones:
      Vladimir Zapolskiy <vz@mleia.com>
      Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>

> 
>> Reference `pwm.yaml#` in `allOf` to inherit common PWM properties.
> 
> Not a change to the binding.
> 
>>
>> Define properties:
>> Restrict `compatible` to `"nxp,lpc3220-pwm"` using `const`.
>> Limit `reg` to `maxItems: 1` to ensure a single register range.
>> Set `"#pwm-cells"` to `const: 3` for expected PWM cell properties.
>>
>> Mark `compatible` and `reg` as required properties.
> 
> So it wasn't before? What are you implying here?

The compatible and reg properties were already present in the .txt file, 
but in a different format. I initially kept the commit message for them 
but have now removed it.

> 
>> Set `unevaluatedProperties: false` to enforce strict validation.
>>
>> Validate the YAML schema using dt-validate and yamllint.
> 
> None of above is suitable for commit msg.

I have removed all commit message parts you mentioned.

> 
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>>   .../devicetree/bindings/pwm/lpc32xx-pwm.yaml  | 45 +++++++++++++++++++
>>   1 file changed, 45 insertions(+)
> 
> Where is the conversion?

Apologies for the confusion. I missed removing lpc32xx-pwm.txt. I'll 
delete it in the next version to properly reflect the conversion.

> 
>>   create mode 100644 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.yaml b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.yaml
>> new file mode 100644
>> index 000000000..3e41cd291
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/lpc32xx-pwm.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/nxp,lpc32xx-pwm.yaml#
> 
> Filename matching compatible.

In the lpc32xx-pwm.txt file, the compatible property was defined as 
"nxp,lpc3220-pwm", so I have kept it the same. To ensure consistency 
between the filename and compatible, should I rename the file to 
nxp,lpc3220-pwm.yaml?

> 
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: LPC32XX PWM controller
>> +
>> +maintainers:
>> +  - "Uwe Kleine-König <ukleinek@kernel.org>"
>> +  - "Vladimir Zapolskiy <vz@mleia.com>"
>> +  - "Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>"
> 
> Look at other bindings - none of them use quotes.
> 
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
>> +
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
>> +  - |
>> +    pwm@4005c004 {
>> +        compatible = "nxp,lpc3220-pwm";
> 
> One example is enough.

Okay. I'll remove the second example and keep only one in the next version.

> 
> 
> 
> Best regards,
> Krzysztof

Best regards,
Purva Yeshi

