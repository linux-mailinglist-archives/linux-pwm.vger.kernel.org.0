Return-Path: <linux-pwm+bounces-4199-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A43D9E13D1
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 08:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D2E28246F
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DDE18595B;
	Tue,  3 Dec 2024 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5qqApr9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4908F2500A8;
	Tue,  3 Dec 2024 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210238; cv=none; b=WG3Vqe/puAg7w5Th0jAbCt/rO7SJLtwpTUKdvZpedvLWgvYB0RrLj4w4EjKy3m+L8PJDrSGkcJyVCTXn+3ybUqGLsfnZxJNKMcWslkE3vSRAHeDeSU3w8NiIWLYY3zNrNv0KAu1lcgbZM0liUnEr2ZBHq/GbWZQnOKeFrkRai2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210238; c=relaxed/simple;
	bh=oHoyC7GK2kz/nIjAQJxYXF9aa8lo5J4l0FqurxPxZEQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DUoN9v/y5ocbgF7WU1tlqWgRjAwXE11Is3spHDs/gVwRwcbus9VSIF3l+23ntYMcKUP9qXPVDFe0wfxR39VfvVU6nJIg/PmjeZNg/s1YskbKg9hkqO9ROye45F0yjKCcy3fYRc2ZLRBIYW5MF8yfoyxW/bQZitGPxpAZFsEHnJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5qqApr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CA3C4CECF;
	Tue,  3 Dec 2024 07:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733210237;
	bh=oHoyC7GK2kz/nIjAQJxYXF9aa8lo5J4l0FqurxPxZEQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=B5qqApr9HlCf1+hmDijd6BVI9RvJZryiJNpBpaAUzj6AaVi5CHoczEZ3sTxF+V8Tw
	 v4Y5+hzP2JE0gmKTd6b5WFnvfkCwO5zKeoigYTd7t2gg9Uk4wb2D16clHZOiQU8bfv
	 JJrtKsjzmIIe1/sxowJUSqLz2v9BtwhhpfGS1r2hMnt0V5qGMM5d8esELw3mdi6xrT
	 KvYsMmAdELsXxejc3oresj6yiamBoOgGpNTmCMTJGhwKRSOIspjTtJwfF0BU0+cwa+
	 wkottm8U/J+XWB8CxHcYcAxJRxR4yQoqnQNu9ZOr4ILSYJD6zFxEIabheKne84UO5N
	 0e545FfaYJNfg==
Message-ID: <990b0efe-0018-4910-910a-8d1431ea26d8@kernel.org>
Date: Tue, 3 Dec 2024 08:17:13 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: add atcpit100-pwm
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ukleinek@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
References: <20241202060147.1271264-1-ben717@andestech.com>
 <20241202060147.1271264-2-ben717@andestech.com>
 <qmbaftzr4ww35txfjvt6iao5g5jjikx5swgh6cdqbiu36dwo2y@74vnlk2a3ihn>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <qmbaftzr4ww35txfjvt6iao5g5jjikx5swgh6cdqbiu36dwo2y@74vnlk2a3ihn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/12/2024 08:40, Krzysztof Kozlowski wrote:
> On Mon, Dec 02, 2024 at 02:01:46PM +0800, Ben Zong-You Xie wrote:
>> Document devicetree bindings for Andes atcpit100-pwm.
>>
>> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
>> ---
>>  .../bindings/pwm/andestech,atcpit100-pwm.yaml | 51 +++++++++++++++++++
>>  MAINTAINERS                                   |  5 ++
>>  2 files changed, 56 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml b/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
>> new file mode 100644
>> index 000000000000..4b707f32ad72
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/andestech,atcpit100-pwm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Andes atcpit100 PWM
>> +
>> +maintainers:
>> +  - Ben Zong-You Xie <ben717@andestech.com>
>> +
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: andestech,atcpit100-pwm
> 
> 
> Previously, before we removed it in 2022, this was just
> andestech,atcpit100, so questions:
> 
> 1. Why are you re-introducing it? Please address all the comments or
> aspects leading to removal.
> 2. Why are you using different compatible? Is this one device?

For some reason you replied while removing most of the people from
address list. That's weird. Don't change the recipients list.

All my statements are still standing.
Best regards,
Krzysztof

