Return-Path: <linux-pwm+bounces-3914-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124C09B190B
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 17:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49A1282B0F
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79FA22F1C;
	Sat, 26 Oct 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2D4qkcG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D1B12E7F;
	Sat, 26 Oct 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729955995; cv=none; b=VR5ltiK/aqixTU6V6NInGrpHEel079+OkztcieXtp6aWlekj/LMZJWA2KAG83dtc6zNwQQV2n8dbp3TI3mtOVLwb4KZKfXW2dxPpjxg9BRGP2RJ3LQz4IkqW+jbIYBZJc6XguMNStD3oJCJEEqM2bmJE4tcKT9g4zx9Rat4NINg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729955995; c=relaxed/simple;
	bh=NzKfnfNUq7LxMXaNFY1FkRKF3N1QaE2lzKNoomMBt1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1lQWI86TjKPdyNZ4ZGz33JTo2jW7ZKqSXf0ViS8HCbFyOA7Vh8/XPVC8RT8GzeKWVHwp9DEEVCdB2/4HEwIp7MURZEl3Saygjhnr24u1YePGSbFDLyf6PWG4wz+4XRbH6K+5JrPchgi2pI8vHNmhqZXdItSlu3WdpRMQ/SDm4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2D4qkcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E62DC4CEC6;
	Sat, 26 Oct 2024 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729955995;
	bh=NzKfnfNUq7LxMXaNFY1FkRKF3N1QaE2lzKNoomMBt1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l2D4qkcG9+dnelrY0m9lsqwXI1yyOSAO8cKXKAGlPPsJ96gmyNEX3nelrWb+J5siz
	 Rz+QG73FqLTUHfvbNvDbJ1XO5RxEYnd4J7M86XjMcqakEIkjpxmBrU4oIYbG/LnbDk
	 skcobTcjif5MS3CTgsjF64S8GA62nKTIDcIiA/R1TWMsizmEp0tDyGfJqSIDPawpwv
	 Y+JiEmwCIJ1vGZ/ywRdqFcEqkiPcYkpgqrcP5MXpBLv+nptEWfDc0if00Rqep9PUbX
	 e4grkPcSmdXa2/04QxWt4KgZMBa7JU7GvWOlw7yaAPDTxhfdF4+LwVj0ScZfoNwFQi
	 UcvBjsCB/W+jA==
Date: Sat, 26 Oct 2024 16:18:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH RFC v4 05/15] spi: dt-bindings: add PWM SPI offload
 trigger
Message-ID: <20241026161837.30a56ae1@jic23-huawei>
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-5-f8125b99f5a1@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	<20241023-dlech-mainline-spi-engine-offload-2-v4-5-f8125b99f5a1@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 15:59:12 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add a new binding for using a PWM signal as a trigger for SPI offloads.

I don't have a better suggestion for this, but it does smell rather like
other bridge binding (iio-hwmon for example) where we have had push back on
representing something that doesn't really exist but is just a way to
tie two bits of hardware together. Those kind of exist because we snuck
them in a long time back when no one was paying attention.

So this one may need more explanation and justification and I'd definitely
like some DT maintainer review on this at a fairly early stage!
(might have happened in earlier reviews but it has been a while so I've
forgotten if it did)

Jonathan


> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v4 changes: new patch in v4
> ---
>  .../devicetree/bindings/spi/trigger-pwm.yaml       | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/trigger-pwm.yaml b/Documentation/devicetree/bindings/spi/trigger-pwm.yaml
> new file mode 100644
> index 000000000000..987638aa4732
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/trigger-pwm.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/trigger-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic SPI offload trigger using PWM
> +
> +description: Remaps a PWM channel as a trigger source.
> +
> +maintainers:
> +  - David Lechner <dlechner@baylibre.com>
> +
> +$ref: /schemas/spi/trigger-source.yaml#
> +
> +properties:
> +  compatible:
> +    const: trigger-pwm
> +
> +  '#trigger-source-cells':
> +    const: 0
> +
> +  pwms:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - '#trigger-source-cells'
> +  - pwms
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    trigger {
> +        compatible = "trigger-pwm";
> +        #trigger-source-cells = <0>;
> +        pwms = <&pwm 0 1000000 0>;
> +    };
> 


