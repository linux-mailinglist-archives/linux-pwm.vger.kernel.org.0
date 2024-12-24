Return-Path: <linux-pwm+bounces-4486-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845729FBAF8
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 10:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956E816178B
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 09:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7571719D8A9;
	Tue, 24 Dec 2024 09:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtB3pvrX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA086250;
	Tue, 24 Dec 2024 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735031549; cv=none; b=oyH0boZS8iZbxrChg6m6WepqohnNb0f+pqJO47dviHZ+egE3Ur+k9x61lbtTssugzAs0WwBjI6QKprZ+Z2/PwIzZ3JW6gP8qzEHcPkMN3eawHt2JeDVzUqBCHhKJHdijZLyIoTvGIa17ZM1uPBCObME8ugeFRBZkdVO0VPI3CQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735031549; c=relaxed/simple;
	bh=w2Rz6T1DjD4uRX9x6ya0uLC+En8EZKqEy9BW1RqMoWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/uE3bZfk6VTWtUrwxdoQigsKA+jWlNPk+E6YOGKGTB9GmAaOvytx2OcYixFABI2KETv5CyfJGFYcCVoFJ6AwHeddqqvGvNQjeHu52hGttl2el/O/7dpDTRo3I1m2T1WXWhZ5prg5k8iD3Rd/5P36X+XUWHCMGWKhYN0YVnDkJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtB3pvrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97675C4CED0;
	Tue, 24 Dec 2024 09:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735031548;
	bh=w2Rz6T1DjD4uRX9x6ya0uLC+En8EZKqEy9BW1RqMoWY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DtB3pvrXqYxX+gHAmDKGrji/lTTHS2kF8cPhIC1S8D5PnvW7A+q4AAxW4svfOKIpz
	 ASdwqgyJI02i6onNiIKgYpEP3Efo1ULvLyaqwxY7i4LFlqs1PUoUCOht5Wf3Lqnq7S
	 1xyTBb5kwJABgq6ETztm5s99aliKgz04WSgXyhaR4D21oNHll4hdt7UBId9ipL6WzL
	 VVieW5X3O0zYlrnSrNFiFFtLgEjAjcgYQi+wkNBPWpvZmh3TMIXYvYkQ1JPeX9fFax
	 5/p/yqc11mxinJGnYYoqKq+3ezMxDT3WbLhbARqOpA2g1jtSf6pTPyuwQI6ExIIreP
	 DYW1rnQUkiiPg==
Message-ID: <93295e50-aa16-42a1-b489-fb4c3312f05b@kernel.org>
Date: Tue, 24 Dec 2024 10:12:22 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: mfd: gpio: Add MAX7360
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kamel Bouhara <kamel.bouhara@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-pwm@vger.kernel.org, =?UTF-8?Q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
 <20241223-mdb-max7360-support-v2-1-37a8d22c36ed@bootlin.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20241223-mdb-max7360-support-v2-1-37a8d22c36ed@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/12/2024 17:42, Mathieu Dubois-Briand wrote:
> Add device tree bindings for Maxim Integrated MAX7360 device with
> support for keypad, rotary, gpios and pwm functionalities.
> 
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  .../bindings/gpio/maxim,max7360-gpio.yaml          |  80 +++++++++++++++
>  .../devicetree/bindings/mfd/maxim,max7360.yaml     | 107 +++++++++++++++++++++
>  2 files changed, 187 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
> new file mode 100644
> index 000000000000..6e6133ce6e68
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/maxim,max7360-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX7360 GPIO controller
> +
> +maintainers:
> +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> +
> +description: |
> +  Maxim MAX7360 GPIO controller, in MAX7360 chipset
> +  https://www.analog.com/en/products/max7360.html

Don't send new versions so fast, especially for larger patchsets, so we
can finish previous discussion.

You gave me yesterday around 1 hour to respond to your last email and
then you sent v2.

Please implement my last comments on v1.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max7360-gpio
> +      - maxim,max7360-gpo


...

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gpio {
> +      compatible = "maxim,max7360-gpio";
> +
> +      gpio-controller;
> +      #gpio-cells = <0x2>;

Not a hex, <2>

> +      ngpios = <8>;
> +      maxim,constant-current-disable = <0x06>;
> +
> +      interrupt-controller;
> +      #interrupt-cells = <0x2>;

Not a hex, <2>

> +      };
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml b/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
> new file mode 100644
> index 000000000000..1f761707070a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/maxim,max7360.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX7360 Keypad, Rotary encoder, PWM and GPIO controller
> +
> +maintainers:
> +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> +
> +description: |
> +  Maxim MAX7360 device, with following functions:
> +    - keypad controller
> +    - rotary controller
> +    - GPIO and GPO controller
> +    - PWM controller
> +
> +  https://www.analog.com/en/products/max7360.html
> +
> +allOf:
> +  - $ref: /schemas/input/matrix-keymap.yaml#
> +  - $ref: /schemas/input/input.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max7360
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 2

You can drop minItems.

> +    maxItems: 2
> +> +  interrupt-names:
> +    items:
> +      - const: inti
> +      - const: intk
> +
> +  keypad-debounce-delay-ms:
> +    description: Keypad debounce delay in ms
> +    minimum: 9
> +    maximum: 40
> +    default: 9
> +
> +  autorepeat: true
> +
> +  rotary-debounce-delay-ms:
> +    description: Rotary encoder debounce delay in ms
> +    minimum: 0
> +    maximum: 15
> +    default: 0
> +
> +  linux,axis:
> +    description: The input subsystem axis to map to this rotary encoder.
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - linux,keymap
> +  - linux,axis
> +  - "#pwm-cells"
> +
> +unevaluatedProperties: false
> +

Well, I still see it incomplete... and to prove it, please post your DTS
for entire max7360 and validate it against bindings.

There is no way this works, unless GPIO is not part of this device but
then it is obviously incorrect design.


Best regards,
Krzysztof

