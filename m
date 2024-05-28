Return-Path: <linux-pwm+bounces-2268-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6288D2613
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 22:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1FFD1C24792
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 20:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB13179647;
	Tue, 28 May 2024 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jE+OxMmI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B81791EB;
	Tue, 28 May 2024 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928910; cv=none; b=AyLmVyPrvpAlZwQy3GkkVVSC3igXBilCpgp2ujkeMHJjNGU3miKkAxXN0GlWNl2PtGVUen9WEUtGdcu5cE7merpFwNNlLg1exLGjwvFdg5F4tQTUo3SjjaafxBzha8C2infTtENVNq4X5y5Yv5D9r05Z4aV4xc+6LA144+Uh4I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928910; c=relaxed/simple;
	bh=oHDsS7/SGOfx0D4SNMQMfUpizLGghGPyB1oIhOCz2SE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=QFTWGXxHZ+B0WUWJFFWvnHeJkpq5/b39J0OCwYiCKtNRfShDTZrbqokLrYgkoltIdVRMnXBMbdp/eSGaIjkAQd89zqFeZvAVrL3gPnoy4VlHnWiurmbvJ3Sn3gFEoZ/xcPlkGf5PRsS5xDwfP2nUQn6HVpxye1QIaFudlXeHiiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jE+OxMmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3307C3277B;
	Tue, 28 May 2024 20:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716928910;
	bh=oHDsS7/SGOfx0D4SNMQMfUpizLGghGPyB1oIhOCz2SE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=jE+OxMmIFlwyutsWl+n07qx4A7Yf7kbwkP0OB9fIoKEgTEgDjQ/41FPZgUK90jBEU
	 9Bg5rhV59vSZPIs82QDNoQcJrqrR9urq8J+tEHHZ0+ZwQ0k8V4BlgcQkcbY6hchQte
	 w7No7a0fP5jWUrtiIdWIR46Uq7kDSEnvMchfB3OJ2zZEaVmAIGHdMBDgFCpiB9m0Vs
	 7z4NBvPOIt7Fxqus/KmB9WkC+oxfGpGyu2X7xu24Tyr8oD5LlP0S8sZTUwUct/kUqY
	 ZHQAjcaSzueaQ5QVJt8IcyVaAflGtEttwCWFmIB7lkWwSlbJ5MSlIY2HYWhrTNBK/m
	 Av6GaYW1GrE6A==
Date: Tue, 28 May 2024 15:41:48 -0500
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
Cc: linux-pwm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
In-Reply-To: <20240528190315.3865-2-laurent.pinchart@ideasonboard.com>
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-2-laurent.pinchart@ideasonboard.com>
Message-Id: <171692890886.1957549.3597242516268327909.robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: Add bindings for the Analog
 Devices ADP5585


On Tue, 28 May 2024 22:03:11 +0300, Laurent Pinchart wrote:
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
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> I've limited the bindings to GPIO and PWM as I lack hardware to design,
> implement and test the rest of the features the chip supports.
> 
> Changes since v1:
> 
> - Squash "dt-bindings: trivial-devices: Drop adi,adp5585 and
>   adi,adp5585-02" into this patch
> - Merge child nodes into parent node
> ---
>  .../devicetree/bindings/mfd/adi,adp5585.yaml  | 107 ++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |   4 -
>  MAINTAINERS                                   |   7 ++
>  3 files changed, 114 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,adp5585.example.dtb: mfd@34: 'gpio' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/adi,adp5585.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,adp5585.example.dtb: mfd@34: 'gpio' is a required property
	from schema $id: http://devicetree.org/schemas/mfd/adi,adp5585.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240528190315.3865-2-laurent.pinchart@ideasonboard.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


