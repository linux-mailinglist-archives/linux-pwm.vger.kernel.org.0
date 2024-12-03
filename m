Return-Path: <linux-pwm+bounces-4198-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A28319E13CC
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 08:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B543282BC8
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 07:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1A918A6D7;
	Tue,  3 Dec 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFM9PcSd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314FA189BB1;
	Tue,  3 Dec 2024 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210160; cv=none; b=QXGZdHfrbovAygTX0DagTw4t8upe3tyVkHZ6hQLSorRqjGGI/FEMKKryMYWl65NwcSsqWEhck1J0FwB5mfyrfCVGYk+hrb+AM6YY75FrPU8jEJ7HnUSZxh0HmE3RvZlH1lPumEmohEy3J1z/AZxQa3gVcH4FGLw5wacwzLpowOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210160; c=relaxed/simple;
	bh=9cdeYvGRRZaoupWz8GhL2CIn4C7oIUb/89bDb1lkVd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uI8xLErSGpZdCEjIQYxn66L4uMvNr7KCDTlXurpUfPTvxyXRTmG5cm0j2jcx7fbi8bJH9d2AubRRE6BTWnqiurH3bGOWJBOv1WyiFeboqz2HD8xcdvmgBZBlZY2T8mRCakgMRTqKTw3enyGCSwxh0aZK2XNTWClDFjugxKtRzeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFM9PcSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F33C4CED6;
	Tue,  3 Dec 2024 07:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733210159;
	bh=9cdeYvGRRZaoupWz8GhL2CIn4C7oIUb/89bDb1lkVd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EFM9PcSd06qOO+jPe3sdFPHr1/+y5XSegljptNX8lCuXiARxIfEELyxCS4agabDmU
	 v27P9lxlK8pQJduRQOzfo3hA6NA8NJ9LTKrVgSEVr6PKJP/IbNllsQ9kR4OhHh0PfF
	 Z4ehvBFKDNVyBNcvDKq9tNnt61MOkG4reBkuuEEnb5lGEzkH83ZLZbt8Pb8Xoe7yP+
	 Kn1ra3Ca+3Alss8GkgY7pIOYEGFOEEfFP5f5wWYHZwym6cp4bLlDio4faUjJI2L6Oe
	 Ao+K9gaOzs/MD7XTw6Kcz6wVjAPKS5DFYk/WUCEBLWB6xdfYa2CdV6s7pVwv/aQIOM
	 VwUhPIDbkdZyg==
Message-ID: <2d822343-1ba7-4130-af1b-f987f2d009b3@kernel.org>
Date: Tue, 3 Dec 2024 08:15:55 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: add atcpit100-pwm
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
References: <20241202060147.1271264-1-ben717@andestech.com>
 <20241202060147.1271264-2-ben717@andestech.com>
 <qmbaftzr4ww35txfjvt6iao5g5jjikx5swgh6cdqbiu36dwo2y@74vnlk2a3ihn>
 <Z06aAEsCHxSmDDtT@atctrx.andestech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z06aAEsCHxSmDDtT@atctrx.andestech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/12/2024 06:41, Ben Zong-You Xie wrote:
> On Mon, Dec 02, 2024 at 08:40:22AM +0100, Krzysztof Kozlowski wrote:
>> [EXTERNAL MAIL]
>>
>> On Mon, Dec 02, 2024 at 02:01:46PM +0800, Ben Zong-You Xie wrote:
>>> Document devicetree bindings for Andes atcpit100-pwm.
>>>
>>> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
>>> ---
>>>  .../bindings/pwm/andestech,atcpit100-pwm.yaml | 51 +++++++++++++++++++
>>>  MAINTAINERS                                   |  5 ++
>>>  2 files changed, 56 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml b/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
>>> new file mode 100644
>>> index 000000000000..4b707f32ad72
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
>>> @@ -0,0 +1,51 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pwm/andestech,atcpit100-pwm.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Andes atcpit100 PWM
>>> +
>>> +maintainers:
>>> +  - Ben Zong-You Xie <ben717@andestech.com>
>>> +
>>> +allOf:
>>> +  - $ref: pwm.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: andestech,atcpit100-pwm
>>
>>
>> Previously, before we removed it in 2022, this was just
>> andestech,atcpit100, so questions:
>>
>> 1. Why are you re-introducing it? Please address all the comments or
>> aspects leading to removal.
>> 2. Why are you using different compatible? Is this one device?
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hi Krzysztof,
> 
> 1. You can first refer to the patch[1].
>    The patch not only removes the support to nds32, but also removes
>    Andes device driver. Though Andes now dedicates our effort on RISC-V,
>    ATCPIT100 is still one of peripheral platform IPs, and that's why we are
>    re-introducing it now.


This should be explained in cover letter and commit msg.

> 
> 2. Yes, they are the same device. ATCPIT100 is a set of compact
>    multi-function timers, which can be used as PWMs or simple timers.
>    I think the example in the YAML file is a little confusing because
>    there are two ATCPIT100 nodes in our DTS file now:

You did not explain it, either...

> 
> 	pit: timer@f0400000 {
> 		compatible = "andestech,atcpit100";
> 		...
> 		...
> 	};
> 	pwm: pwm@f0400000 {
> 		compatible = "andestech,atcpit100-pwm";
> 		...
> 		...
> 	};
> 
>    Is it better to modify our DTS file and the example in the YAML file
>    like below?
> 	
> 	pit: pit@f0400000 {
> 		compatible = "andestech,atcpit100";
> 		reg = <0xf0400000, 0x1000>;
> 		clocks = <&smu 1>, <&smu 7>;
> 		clock-names = "ext", "apb";

One node above.

> 		pwm: pwm {
> 			compatible = "andestech,atcpit100-pwm";

This is not needed.

> 			#pwm-cells = <3>;

And this goes to parent node.



Best regards,
Krzysztof

