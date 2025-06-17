Return-Path: <linux-pwm+bounces-6401-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1B6ADCB8B
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 14:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B93317399A
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 12:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE202EA464;
	Tue, 17 Jun 2025 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJZwMlxF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38182E92DE;
	Tue, 17 Jun 2025 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163183; cv=none; b=oC4WrCK+dOSHzcNLLLAkbcSZuMbc9IG3j0A0Smu8Aj4M1oST8o5x9HcpLKXKAEAkbenQlr4t/apPn4TOQSygMEm7/K0tT6ItQHBmtELDdMmeFOppH9RoFPb9Z1vy4hCHXzKXYn57QtJBD7Her9P7Rp2WqaxceNPz0cSjgbLaLb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163183; c=relaxed/simple;
	bh=MnYggXt1DmzLw3znPdMFXwZLsZaCNbYxq0l13Lkdwdo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=DLuaWBYRVSbCnO+yzxU09vWdqb4KHe4kcaWpfpWtMvd7MUiTf0WqQijzS47AjPRbnGVIRegZ8WJ/nt9uZZ1ZfZPWJyiG+1Hk19xPU0KWXf9PDY+sNThkGRKWsKQOaTU+YobkRbp5mmKNEXcbE5b/yfQc9ilITrkDzKkg0Nd2qcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJZwMlxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F980C4CEF1;
	Tue, 17 Jun 2025 12:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750163182;
	bh=MnYggXt1DmzLw3znPdMFXwZLsZaCNbYxq0l13Lkdwdo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=rJZwMlxF15g7P/9eloPAfeyGiCDn3VVYajFxR+h/dmOcDu8bhNF/vS3tp8Bf/mRcC
	 2dd3V+zCVThyg1mev/V5TnvnxpgFzNsLM2y5xmXVYAkppKh1MaNgGW1VbAN1JPeB6S
	 Cix8Hv/tKS0tMNN8wfqGMdTLxBTzA4avPtmBWNZ9pD/xAqldwLMZrCEgrkznr2lyhK
	 QNZUj92+y/UNDepMEmXBmEOQyZYc6I61DAeAvxAaBZ3ibTn0a9s4RvWmTNP5SqrV/z
	 3EwFQ0z5CwfwqUV7DzbPbptuWC3JVe1WonJv4RY8v4K5+fwS/ZxPznLSApl9VoWWAX
	 ZYQJr0GAmWI+Q==
Date: Tue, 17 Jun 2025 07:26:21 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-pwm@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250617092037.37229-2-marek.vasut+renesas@mailbox.org>
References: <20250617092037.37229-1-marek.vasut+renesas@mailbox.org>
 <20250617092037.37229-2-marek.vasut+renesas@mailbox.org>
Message-Id: <175016318163.1418393.10980265892327260592.robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: pwm: argon40,fan-hat: Document
 Argon40 Fan HAT


On Tue, 17 Jun 2025 11:19:35 +0200, Marek Vasut wrote:
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/argon40,fan-hat.example.dtb: pwm@1a (argon40,fan-hat): #pwm-cells: 3 was expected
	from schema $id: http://devicetree.org/schemas/pwm/argon40,fan-hat.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250617092037.37229-2-marek.vasut+renesas@mailbox.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


