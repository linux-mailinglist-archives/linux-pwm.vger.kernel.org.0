Return-Path: <linux-pwm+bounces-4454-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECA29FADCB
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 12:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757551883770
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 11:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE4119D062;
	Mon, 23 Dec 2024 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4oWJt14"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D6198A32;
	Mon, 23 Dec 2024 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734954017; cv=none; b=d6FGMZaIWVHFwPKsegXKTHkFdvivItQkkEB0eoK/ASxvHjxx0nA35bSOaszPMlo0Up8P6T/XyhSOBxG/6H+OonOswZe3olKzYXXnCFW2CmmFj3L2DQP6seoKqAWCl3Vwa6tV0532aJM53a1tA/NZi/I4TvDjqEafVUYJUzElSDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734954017; c=relaxed/simple;
	bh=V/rsj8Uig8i64mxEasJC+tWmHc0irmVmzCE867blUeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CA34T96UBAz/qH6WyrvsNrv5d9AyRZoNkWIghu/V8EetklZ3lQGI6E/gALPbPZNq614TahA7+EFiFh/Tn05sFWkes1khXAfw9bgbRryid0IyW7/6PYhhGmuahyJM3+DJF6VCyQBacVTKMcXVkNcwMAvCbIZjh+gopZn/RmAQnUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4oWJt14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724EDC4CED3;
	Mon, 23 Dec 2024 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734954016;
	bh=V/rsj8Uig8i64mxEasJC+tWmHc0irmVmzCE867blUeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W4oWJt14jqrfVsP8reOZf1HaCJkaKngXY8ZalP3+wShrlEpHOJ9VM3TVgHR81Rpm8
	 5YC1HmZn73QWOfC8Ll5OjS3zjZHFTTwkqvU+41LyZZAN2X6vE/ONhE9kocQZ4GHgrw
	 s4Qz0FeO0fvP8WuDIeIdRad5iRf0KOUbRdBmnc6EKJUa9OY2+cBrC5z6e5MnNCpkfy
	 UgEjUS3RrL6gs7k2GZ7jmXoq8/ucf6Xb/E7vZFpqZwgGYHXZzwMgnzyDy0T84DTwSV
	 wMIELrDOTwbio4L987dRSwHRuOlwR7+q3w0on6F43wkJdyIBYsAxuGLu+mvpeFrPbB
	 oGVFD9lygEVBg==
Date: Mon, 23 Dec 2024 11:40:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v9 7/8] dt-bindings: iio: adc: add ad4851
Message-ID: <20241223114008.71e00bee@jic23-huawei>
In-Reply-To: <20241220120134.42760-7-antoniu.miclaus@analog.com>
References: <20241220120134.42760-1-antoniu.miclaus@analog.com>
	<20241220120134.42760-7-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 14:01:33 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add devicetree bindings for ad485x family.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Mixed single end and differential channel devices that have per channel
child nodes need a more complex description to avoid reg have different
and possibly clashing meanings for the two types of channel.

See inline.

Thanks,

Jonathan

> ---
> changes in v9:
>  - add back diff-channels property.
>  .../bindings/iio/adc/adi,ad4851.yaml          | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
> new file mode 100644
> index 000000000000..5911f1cfc39d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
> @@ -0,0 +1,142 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2024 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad4851.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD485X family
> +
> +maintainers:
> +  - Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> +  - Dragos Bogdan <dragos.bogdan@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  Analog Devices AD485X fully buffered, 8-channel simultaneous sampling,
> +  16/20-bit, 1 MSPS data acquisition system (DAS) with differential, wide
> +  common-mode range inputs.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4855.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4856.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4857.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad4858.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad4851
> +      - adi,ad4852
> +      - adi,ad4853
> +      - adi,ad4854
> +      - adi,ad4855
> +      - adi,ad4856
> +      - adi,ad4857
> +      - adi,ad4858
> +      - adi,ad4858i
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply: true
> +
> +  vee-supply: true
> +
> +  vdd-supply: true
> +
> +  vddh-supply: true
> +
> +  vddl-supply: true
> +
> +  vio-supply: true
> +
> +  vrefbuf-supply: true
> +
> +  vrefio-supply: true
> +
> +  pwms:
> +    description: PWM connected to the CNV pin.
> +    maxItems: 1
> +
> +  io-backends:
> +    maxItems: 1
> +
> +  pd-gpios:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 25000000
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel(@[0-7])?$":
> +    $ref: adc.yaml
> +    type: object
> +    description: Represents the channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: The channel number in single-ended mode.

And what is it in differential mode?  (usually just an index).
Which is a problem if you have a mix.  That's why we added
single-channel.

So for devices where reg isn't enough, you can use:
reg: index of channel, not real meaning just makes them unique.
single-channel: The channel number for single ended.
diff-channels: The channel numbers for differential channels.

> +        minimum: 0
> +        maximum: 7
> +
> +      diff-channels: true

Should be constraints / information on the values possible.
I've no idea what the 8 is in your example for instance.

> +
> +      bipolar: true
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - vcc-supply
> +  - vee-supply
> +  - vdd-supply
> +  - vio-supply
> +  - pwms
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0{
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "adi,ad4858";
> +            reg = <0>;
> +            spi-max-frequency = <10000000>;
> +            vcc-supply = <&vcc>;
> +            vdd-supply = <&vdd>;
> +            vee-supply = <&vee>;
> +            vddh-supply = <&vddh>;
> +            vddl-supply = <&vddl>;
> +            vio-supply = <&vio>;
> +            pwms = <&pwm_gen 0 0>;
> +            io-backends = <&iio_backend>;
> +
> +            channel@0 {
> +              reg = <0>;
> +              diff-channels = <0 8>;
> +              bipolar;
> +            };
> +
> +            channel@1 {
> +              reg = <1>;
> +            };
> +        };
> +    };
> +...


