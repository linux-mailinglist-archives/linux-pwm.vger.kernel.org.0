Return-Path: <linux-pwm+bounces-7794-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F512CB828D
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Dec 2025 08:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E14A30146EB
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Dec 2025 07:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103A030F807;
	Fri, 12 Dec 2025 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i61QUMSp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB930F7EA;
	Fri, 12 Dec 2025 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765525840; cv=none; b=EtN8sJq9fQiNbUU453TW65u6iOdAYTu6Ds/XkWh4pGKkas5GUSIZjP7YmmV5wbK5Pg+WaXR2RbWD31bgliKlqOzMiJAPsAyOVeu/53+TmSE4317ZRJlUK+U0e5DzepZtqFeSyQrIiivN0/yAYFetxUDVlzALL8SonkoXooZjG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765525840; c=relaxed/simple;
	bh=+2bbw/KsVrEgb/z+PSRCnvFocrRg0rPa/Cvl155WVls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2LougUfGPdK7psU26DupntsbSlMhIJt6Ro3NhhfcH3S+PRV/E6XGjmqARquN4ifgQ562ajpWcFbySISqgdtGwZ+NBqyP6cyo+s6DgIlro+qDo+wh1kcrb+me3zKIYrxTKGgL0T6YZvySIRzHE1WOcY/s8GjsWlVr/hg+XhXiUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i61QUMSp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 722851A2118;
	Fri, 12 Dec 2025 07:50:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3839D606DF;
	Fri, 12 Dec 2025 07:50:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20F8D103C8DF7;
	Fri, 12 Dec 2025 08:50:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765525836; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=WDRM+Mcm+eaOgrPszSVJn6wMYj7R2OASXJPVQeqhico=;
	b=i61QUMSpjF3ehPjvtdhLBXiDK+nSX9ISYyXEt0WWu741UGA1f79yxdE7Sa6i/LvuOIEZlY
	Z7Qcc5tyZimRoBVA6HyoftzOZCv2JsQcYrZLOeyAFoar93NxsEe6VfjoHuEjvNbzlG4u60
	QBu1frPhcvkKZvDS375pi6bIof5vcVnbZeAvgZD3C4C97ciJV+Q02OiUSrdD7HXCW36In4
	amlB8XE/6uOMpylphGGF4VMDORIM49r+C06J9ZrfNWT/DZ1Y8jPatGIeTlrif5cizSaO3U
	ICx40/SR70zz0cHGx+hVpt/POSwEKUmlskokjb/3qWx+F/2lhqJpxrvtswNz0g==
Message-ID: <4d34658b-874d-4681-95c1-616f5b385550@bootlin.com>
Date: Fri, 12 Dec 2025 08:50:31 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: pwm: sunxi: add PWM controller for
 Allwinner H616
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251205100239.1563353-1-richard.genoud@bootlin.com>
 <20251205100239.1563353-2-richard.genoud@bootlin.com>
 <20251208-gorgeous-capuchin-of-protection-4ad0c2@quoll>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20251208-gorgeous-capuchin-of-protection-4ad0c2@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Krzysztof,

Le 08/12/2025 à 07:52, Krzysztof Kozlowski a écrit :
> On Fri, Dec 05, 2025 at 11:02:36AM +0100, Richard Genoud wrote:
>> Allwinner H616 SoC contains a PWM controller quite different from the A10.
>> It has 6 channels than can generate PWM waveforms or clocks if bypass is
>> enabled.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
>>   .../pwm/allwinner,sun50i-h616-pwm.yaml        | 67 +++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun50i-h616-pwm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun50i-h616-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun50i-h616-pwm.yaml
>> new file mode 100644
>> index 000000000000..b89735ad3a43
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun50i-h616-pwm.yaml
>> @@ -0,0 +1,67 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/allwinner,sun50i-h616-pwm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Allwinner H616 PWM
>> +
>> +maintainers:
>> +  - Richard Genoud <richard.genoud@bootlin.com>
>> +
>> +description: |
> 
> Do not need '|' unless you need to preserve formatting.
Ok, I was thinking that it was nicer with the formatting.

> 
>> +  Allwinner H616 PWM can generate standard PWM signals with variable pulse width
>> +  and period.
>> +  Also, instead of a PWM signal, a channel can be used to provide a clock.
>> +
>> +properties:
>> +  compatible:
>> +    const: allwinner,sun50i-h616-pwm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Bus Clock
>> +
> 
> Are you sure there is no first clock? Really, really sure? If you add it
> later, I would be pretty sad, because that's unnecessary duplication of
> binidngs....
I surely don't want to make you sad :)

Having a second look at the sun4i binding, I think there's a way to use it.
The sun4i, as you said, has a module clock (OSC24M) and an optional bus 
clock.
Here, the bus clock is mandatory, but the H616 PWM uses OSC24M and APB1 
as clock sources.

So, I guess that if we add something like that:
    clocks:
      minItems: 1
      items:
        - description: Module Clock
        - description: Bus Clock
+      - description: APB Clock

    clock-names:
      minItems: 1
      items:
        - const: mod
        - const: bus
+      - const: apb

    resets:
      maxItems: 1

In the sun4i pwm binding, we could re-use it for the H616 pwm right?
(APB clock is maybe not the best name, could be secondary module clock)

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> Best regards,
> Krzysztof
> 
Thanks for your review!

Regards,
Richard


