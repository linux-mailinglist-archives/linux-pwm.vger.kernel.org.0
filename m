Return-Path: <linux-pwm+bounces-6067-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76119ABF693
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C121BC492B
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBDC137930;
	Wed, 21 May 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vnxx3Nzl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183BB1519BA
	for <linux-pwm@vger.kernel.org>; Wed, 21 May 2025 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835418; cv=none; b=QhItlsRkh1yq9sRet1HhfsJFB5uDy6MYLiGyz8rSF50hNKHuPwO2pmnwy4phWc/e0dX+/4ow+E2mS5NoXteXyrlg2FodhbR2qaLuZPCPUvmBdWZV1UCC2F2gHmI6UaN4uW2/K/WE+mny78OHlkAkw1jUtYwp3QbtrO5R3XhkHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835418; c=relaxed/simple;
	bh=xxclzynvG9qMLSJo82MFRje7H/LgVEU3hKXBTA0+0Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cvnEfVBFtXWxO/cNEkNSvA9xuUfJiNnlFFwnZHav+smFUFMhPIxhEvbfbKxv0wPatmx074FuWqofRw81cUWwhpXLXwKai8l19cP0KTDkvOuw4dsZdzhmzWzf159dOezXuj1OO321+/ub5f/3MrujgJnC8++/9+QVrnKj3LS/SCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vnxx3Nzl; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7300069c447so4606100a34.2
        for <linux-pwm@vger.kernel.org>; Wed, 21 May 2025 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747835415; x=1748440215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JgaHRKYUX+zfvNTXojTA2fHNWkJMHbiON31ak/TWz4=;
        b=vnxx3Nzl9Zs/QThNC7uSMbC+7jIZ/4ZlrZFyy1DREeRLzAr5DJ2aSJSDoVcJqnffyt
         52s6VCcy35PC115wGq3Z2mPtoOkRnq5aPaCWdCvV5xIoJnV1ZodseK290BYrHxty9BJJ
         7hTzvMUF4HVt5LFN++QYE+dfzadV/G0c3kmXkT/4qjVBTs0zAIv/YUMFSU98sx8KeKcM
         K0yZsdnmUzofu+L2pO8bKG576piP1QFZAgf3ue9bXkdMx8uRPs5ZwNzSr1KTLkHdbr9D
         Jd2slWIl1EQ5GCQlx28ZC2oWy6s2O8VdSnDys5O5skM5XT8DwQUiIVWookOfjRDMiXPn
         B0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747835415; x=1748440215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JgaHRKYUX+zfvNTXojTA2fHNWkJMHbiON31ak/TWz4=;
        b=b9eeuJ4Iiiq96pB8jPbJiVBTBv9YCH68WdKtwCTev8mEsFMfrIyC/+z+Gq4VxCKssL
         YRHkWIWCG3VkIc0M2v7NwjYA0Rky6f734tItjHdhnRUPaSEY2aI9cERzO/DPKyxle8hl
         8kCSPqQsjAs7ZMwEJfw126EWz0wysX4GjbhBNgYK+mgB2axm5k/DVDfdteCiAUpNpsHa
         BdEvYUXSyNhr5CvXaNR6+2DGeK7hPurW98W2nYlakIAZ/GmqCcHazHC1jgDKnx1S7lqY
         NYIbP9j2OjTk0vJlB776oIHV9kwNGB0ZgH8m++LzHUY+GQF7kkE7e5gdkYikvV4F90C7
         rjrg==
X-Forwarded-Encrypted: i=1; AJvYcCWdQKWt2j42SL38N3nWaCjkRznHpCOWx6EI50WE7ZSNVBh6GtFYbXuxAXIPDdwCb3JnC6KYP+XPG9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhxFSUvtJwxPJtUosXg4gQ+PEc8Cbv0+zraoVjVUBBTz8fRjJG
	EeumWHWUjZC/Y70rKWBQekqiiQSdRTZaDl7msbqmCknPMeErDQflO4HRGotJ3FQxCJU=
X-Gm-Gg: ASbGncureEkSrbSX5ikSMfynFCKuAvgCqIxnLldAzJr4ntvdU9BKju4ccXyVYU2ZMpN
	GuyS/odAKC4eVSBwXJMM1nsvy+QVOXolykYW5LGgi2OAWnQnH7MJqSpCUtGRrlq2af+CAP1UMS8
	5g3bpBSu1S+mDxz+adhNzxbhwsOuQggGfjlbzmbEiM+MdmgtPanMmv7Kr8C2knZJWMLOU3lFBWe
	ewxNxINhimf2h6IK4l9GbPlq+xZ9ZdHdKx1nwISrb2gYpCfg6FvV6pLC1lc/u3rztlXhDKHXBCS
	P4Gq1pNgKuRPwvjGR9EiCd+TpCQUoaZXnnpyFzXtYCDXFXKHZ3IBqiSU0TXhJ2yO0HsV+cbkVR9
	u2Acy0ZtEU8MmhY/WpwQal9D8rQ==
X-Google-Smtp-Source: AGHT+IGNsrBJay16uQjz7d1c9S8nrIXHASYHEtAmfjAXqpv6/iE+yKrM1c1mCMLDvMzkQkx9FSohfQ==
X-Received: by 2002:a05:6830:6206:b0:727:3664:ca28 with SMTP id 46e09a7af769-734f69d3e89mr14202278a34.0.1747835414904;
        Wed, 21 May 2025 06:50:14 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d77b:6acc:2ad1:8ff? ([2600:8803:e7e4:1d00:d77b:6acc:2ad1:8ff])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-734f6a9a7adsm2152904a34.30.2025.05.21.06.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 06:50:13 -0700 (PDT)
Message-ID: <1424236a-eee7-4343-b73f-42cd416b594c@baylibre.com>
Date: Wed, 21 May 2025 08:50:12 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: pwm: adi,axi-pwmgen: add external clock
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250520-pwm-axi-pwmgen-add-external-clock-v1-0-6cd63cc001c8@baylibre.com>
 <20250520-pwm-axi-pwmgen-add-external-clock-v1-2-6cd63cc001c8@baylibre.com>
 <20250521-tidy-heron-of-genius-4dc9a1@kuoka>
 <be02b9cd-803c-4aae-9420-ff3bf445efc1@baylibre.com>
 <499207c7-aa40-470c-801f-a8154a253276@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <499207c7-aa40-470c-801f-a8154a253276@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 8:28 AM, Krzysztof Kozlowski wrote:
> On 21/05/2025 15:14, David Lechner wrote:
>> On 5/21/25 5:09 AM, Krzysztof Kozlowski wrote:
>>> On Tue, May 20, 2025 at 04:00:45PM GMT, David Lechner wrote:
>>>> Add external clock to the schema.
>>>>
>>>> The AXI PWMGEN IP block has a compile option ASYNC_CLK_EN that allows
>>>> the use of an external clock for the PWM output separate from the AXI
>>>> clock that runs the peripheral.
>>>>
>>>> In these cases, we should specify both clocks in the device tree. The
>>>> intention here is that if you specify both clocks, then you include the
>>>> clock-names property and if you don't have an external clock, then you
>>>> omit the clock-names property.
>>>>
>>>> There can't be more than one allOf: in the top level of the schema, so
>>>> it is stolen from $ref since it isn't needed there and used for the
>>>> more typical case of the if statement (even though technically it isn't
>>>> needed there either at this time).
>>>>
>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>> ---
>>>>  .../devicetree/bindings/pwm/adi,axi-pwmgen.yaml    | 26 ++++++++++++++++++----
>>>>  1 file changed, 22 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>>>> index bc44381692054f647a160a6573dae4cff2ee3f31..90f702a5cd80bd7d62e2436b2eed44314ab4fd53 100644
>>>> --- a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>>>> +++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>>>> @@ -16,8 +16,7 @@ description:
>>>>  
>>>>    https://analogdevicesinc.github.io/hdl/library/axi_pwm_gen/index.html
>>>>  
>>>> -allOf:
>>>> -  - $ref: pwm.yaml#
>>>> +$ref: pwm.yaml#
>>>>  
>>>>  properties:
>>>>    compatible:
>>>> @@ -30,7 +29,13 @@ properties:
>>>>      const: 3
>>>>  
>>>>    clocks:
>>>> -    maxItems: 1
>>>> +    minItems: 1
>>>> +    maxItems: 2
>>>> +
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: axi
>>>> +      - const: ext
>>>>  
>>>>  required:
>>>>    - reg
>>>> @@ -38,11 +43,24 @@ required:
>>>>  
>>>>  unevaluatedProperties: false
>>>>  
>>>> +allOf:
>>>> +  - if:
>>>> +      required: [clock-names]
>>>
>>>
>>> No, don't do that. If you want clock-names, just add them for both
>>> cases. Otherwise, just describe items in clocks and no need for
>>> clock-names.
>>
>> Would it be OK then to make clock-names required and just let the
>> driver still handle one clocks, no clock-names for backwards compatibility?
> 
> So just don't make it required.
> 
>>
>>>
>>>
>>>
>>>> +    then:
>>>> +      properties:
>>>> +        clocks:
>>>> +          minItems: 2
>>>> +    else:
>>>> +      properties:
>>>> +        clocks:
>>>> +          maxItems: 1
>>>> +
>>>>  examples:
>>>>    - |
>>>>      pwm@44b00000 {
>>>>          compatible = "adi,axi-pwmgen-2.00.a";
>>>>          reg = <0x44b00000 0x1000>;
>>>> -        clocks = <&spi_clk>;
>>>> +        clocks = <&fpga_clk>, <&spi_clk>;
>>>
>>> What was the clock[0] before? Axi, right, so SPI_CLK. Now FPGA is the
>>> AXI_CLK? This feels like clock order reversed.
>>
>> The problem being fixed here is that since there was only one clock in
>> the binding, existing .dts files have either have the spi_clock or
>> the FPGA/AXI clock. So the one clock could be either and there are
>> existing .dtbs out in the world with both cases.
> 
> No problem like that was explained in commit msg. Nevertheless driver

You are right. I explained it in the cover letter, but failed to repeat
that in this commit message.

> assumed the first clock is the SPI, didn't it? So that's your ABI, even
> if binding was not conclusive here.

Not quite. The driver (before this series) assumes that the clock
is the SPI clock ("ext") if the HDL was compiled with ASYNC_CLK_EN=1
or the AXI clock if the HDL was compiled with ASYNC_CLK_EN=0 (in this
case, there is no "ext"/SPI clock).

>>
>> But we could consider reversing this so that if someone uses the new
>> bindings with an old kernel, then it would still work.
> 
> You cannot use new bindings with old kernel. How would that work? Put
> YAML file there? Nothing would change.
> 
> Binding is supposed to be complete for exactly this reason. You cannot
> change it afterwards without breaking users.
> 
> Best regards,
> Krzysztof


