Return-Path: <linux-pwm+bounces-2867-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D79E9937DC3
	for <lists+linux-pwm@lfdr.de>; Sat, 20 Jul 2024 00:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60ABFB218A9
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 22:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D111494A4;
	Fri, 19 Jul 2024 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf6eC2U1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501B4149016;
	Fri, 19 Jul 2024 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721427029; cv=none; b=SL0PsPW7uHAM3Vx8q58eal5JMP7GV3bInaufkADIfaicXm7nMnYneQ0Z4KdApIFtlDT1YCzEXnaOEnAuDthhyM806xafji6xPu0t9q5q9EuNOoq2rKe+9Xy0beMKm6RCQzoxkv9JM3eGhNX0eot0cSJd83N31gYpCG6Z88/wf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721427029; c=relaxed/simple;
	bh=vTjMiFQfyVHQT/yYv0TdChoqj7HCoOMoJpWNHja3V/o=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=NnYJWaInHnpva/j1clBEyDQfPJ1lhq/Qr1uXzTOf2ePLEvW1dp3h3TQhIyv3uaVgVQU89WxmQD1rm9jWcxItvCimg66m7yDJbQlvTL0bPlRmSSXujqTYKb24SXBSh9g8Nmr4cwdcDsTdefBlOuKTKDPKvjFfDbI7dKXIEXERvIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf6eC2U1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F21C4AF0A;
	Fri, 19 Jul 2024 22:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721427029;
	bh=vTjMiFQfyVHQT/yYv0TdChoqj7HCoOMoJpWNHja3V/o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=nf6eC2U1IG4CEBBOLHaVjnD4B3W3Uz4nAw+SHYHWR19aYl5X6fTYA5bAMjL9mUQXv
	 8eh9BygrP8XRqaUZ1w8XeOfPbiO6UG8lKTaFmI+XMRJve4cBSbXi0DVnzgDPCH2tcA
	 JpCrD65MoAlb8eyDN6qQdiqY4scfyvRStELfh8qVycNKaAbY10NdBhpX82DjnjO2Ku
	 0vckF4JLitsWMZSRdkuImSv01ufFUkM/tduAA97u3VCS0vyuBr3lbXuOM/52NmwAhi
	 yBYshcV/sqZDVUX2XFJjg7+Wx8woTxjaCwOIxyLDK2B+IDDPLm0BOKL7/wWlnPW0Au
	 z2dN7O/I5pEDw==
Date: Fri, 19 Jul 2024 16:10:27 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-pwm@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 Haibo Chen <haibo.chen@nxp.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-gpio@vger.kernel.org, Clark Wang <xiaoning.wang@nxp.com>, 
 devicetree@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.li@nxp.com>, 
 Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20240719203946.22909-2-laurent.pinchart@ideasonboard.com>
References: <20240719203946.22909-1-laurent.pinchart@ideasonboard.com>
 <20240719203946.22909-2-laurent.pinchart@ideasonboard.com>
Message-Id: <172142702368.154266.4410503233021312988.robh@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: mfd: Add Analog Devices ADP5585


On Fri, 19 Jul 2024 23:39:43 +0300, Laurent Pinchart wrote:
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> These bindings model the device as an MFD, and support the GPIO expander
> and PWM functions.
> 
> These bindings support the GPIO and PWM functions.
> 
> Drop the existing adi,adp5585 and adi,adp5585-02 compatible strings from
> trivial-devices.yaml. They have been added there by mistake as the
> driver that was submitted at the same time used different compatible
> strings. We can take them over safely.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> I've limited the bindings to GPIO and PWM as I lack hardware to design,
> implement and test the rest of the features the chip supports.
> 
> Changes since v4:
> 
> - Drop the right comment in trivial-devices.yaml
> 
> Changes since v3:
> 
> - Fix prefix and drop redundant text in subject line
> - Rename node in example from mfd@ to io-expander@
> 
> Changes since v2:
> 
> - Drop gpio property from required
> - Drop second example
> 
> Changes since v1:
> 
> - Squash "dt-bindings: trivial-devices: Drop adi,adp5585 and
>   adi,adp5585-02" into this patch
> - Merge child nodes into parent node
> ---
>  .../devicetree/bindings/mfd/adi,adp5585.yaml  | 90 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  4 -
>  MAINTAINERS                                   |  7 ++
>  3 files changed, 97 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,adp5585.example.dtb: io-expander@34: gpio-reserved-ranges:0: 5 was expected
	from schema $id: http://devicetree.org/schemas/mfd/adi,adp5585.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,adp5585.example.dtb: io-expander@34: gpio-reserved-ranges: [[5, 1]] is too short
	from schema $id: http://devicetree.org/schemas/mfd/adi,adp5585.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240719203946.22909-2-laurent.pinchart@ideasonboard.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


