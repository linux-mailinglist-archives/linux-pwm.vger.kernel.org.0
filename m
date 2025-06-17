Return-Path: <linux-pwm+bounces-6402-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0343DADCD94
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 15:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFB81737D7
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 13:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F982E2665;
	Tue, 17 Jun 2025 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDQKdZb/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A342E265C;
	Tue, 17 Jun 2025 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167466; cv=none; b=sGx7roOKapYVwGS/I+gKS5XFD3erklqnFLEIw7Ad/4qpiiOQhv9NzOurb3OF/JwlwFXh+byzSoKaxlbATul2kX74nZFwZgin9xmOi++N99RNl25A4BvstPFuGGAPbzpUzL8a8Cjm5cmQTHf5XCQEFJ7/Rdf/SdfsvRjy6Qti0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167466; c=relaxed/simple;
	bh=VikTIZp4AfgSesWbDPBebzVoysMDPcHm2POYFhTcWfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vo9anM2D05LjqoQhUlxpxtKLOPgNILhtkLQv6idj+IZ7ukAXjdtM+1U6n9Un3cUBZD+7BeXBr0HhxR0XElwABn36MdMG5u6qRjJMsL0zftgLTs1v+DA8bLyyzZEvHZhEcWkNoYekOaf29/LJBtOl9Br2TKZ75YvuQPThfN4iiZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDQKdZb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BADC4CEE3;
	Tue, 17 Jun 2025 13:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750167465;
	bh=VikTIZp4AfgSesWbDPBebzVoysMDPcHm2POYFhTcWfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDQKdZb/AR6HKApzBCrjPXDtLFgYKqB229c4RkdzSd4buLbCB1qKaLP07wiqc2ot9
	 JHbheS4b85tHeZSE5GbQRCAjU0S4EOQFcFGy0Oa4z5LTSNmkdGOVcCdZlCzxZ/EQSi
	 U0ArArk7E5YCMbATZF2RvXX/UzbATgdxikhpmgSUa/MFs29ifvIfKnVkeDWFRU92tw
	 FwEdPOpJ8entGbpMP9akPkiCegR0PLBjAgdb9eFs2tepOz5ROa+1q+RVESVAILW9uI
	 HmiBYdmi+E/Uc1NRNyJmx7aHYuuM5xE5c7QB5h/bcvKTK/jI5onMU4zYvfUfSwRN6k
	 KgR/5iyamKehQ==
Date: Tue, 17 Jun 2025 08:37:44 -0500
From: Rob Herring <robh@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: pwm: argon40,fan-hat: Document
 Argon40 Fan HAT
Message-ID: <20250617133744.GA1888765-robh@kernel.org>
References: <20250617092037.37229-1-marek.vasut+renesas@mailbox.org>
 <20250617092037.37229-2-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617092037.37229-2-marek.vasut+renesas@mailbox.org>

On Tue, Jun 17, 2025 at 11:19:35AM +0200, Marek Vasut wrote:
> Document trivial PWM on Argon40 Fan HAT, which is a RaspberryPi
> blower fan hat which can be controlled over I2C.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Uwe Kleine-König" <ukleinek@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: Implement dedicated binding document
> V3: Update the description and pwm-cells
> ---
>  .../bindings/pwm/argon40,fan-hat.yaml         | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml b/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
> new file mode 100644
> index 000000000000..a0010700ab12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/argon40,fan-hat.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/argon40,fan-hat.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Argon40 Fan HAT PWM controller
> +
> +maintainers:
> +  - Marek Vasut <marek.vasut+renesas@mailbox.org>
> +
> +description: |

Don't need '|'.

> +  The trivial PWM on Argon40 Fan HAT, which is a RaspberryPi blower fan
> +  hat which can be controlled over I2C, generates a fixed 30 kHz period
> +  PWM signal with configurable 0..100% duty cycle to control the fan
> +  speed.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: argon40,fan-hat
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pwm@1a {
> +        compatible = "argon40,fan-hat";
> +        reg = <0x1a>;
> +        #pwm-cells = <2>;
> +      };
> +    };
> -- 
> 2.47.2
> 

