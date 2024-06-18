Return-Path: <linux-pwm+bounces-2532-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B4C90DA20
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 18:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17636B22F59
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0DF13A3F6;
	Tue, 18 Jun 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGn76P3i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB6C45BE6;
	Tue, 18 Jun 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729638; cv=none; b=U5i+K4FVKC5FOBzlb4VXOwqcWLwLW9opvxwl/+MlaoucMC49Wk1+3TKCI+SUcg99RuM4JbplBPHf5coTDCXINP8XsIMetTZwIKMh2xFIaI0mMv8GlG+YzfSjEKc3px52Mr/GiiffF2OHFxKKxIOj5+wumrGfYeN9znyzobagNh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729638; c=relaxed/simple;
	bh=gVRTf/IytGfnTahbvcX22LWVmgHV0CjJyuZCT03dLm8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=TEToBIKCVDCTR2QBUSOgLbFiPp+UiQHWVE+35KxY7N1vxegv8b0wV/oIzA4E23YgLgbOaN+PZhI5DEHlqgh5J2ocSE0/j7iLunV93afWMmUlfLzqoHt9xlxzWPmvaanVDKsJLYq5IgaZqxznQd6egNnpnFSV1XFdcXjyrsOi7BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGn76P3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C9AC3277B;
	Tue, 18 Jun 2024 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718729637;
	bh=gVRTf/IytGfnTahbvcX22LWVmgHV0CjJyuZCT03dLm8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rGn76P3inYALIrqOuHRyp3qYpyXdlDP1LcM8JfnRExzzdlHzNBsO7zK+jimOqoHxj
	 l7OqtMzpIALi6Iw+RfB8UrV02NKx6DFHaG7o0E3rr6O1FwkcQTcaww9wUfkrNiBaCf
	 Bdp97xroVof7T5P4o4PAzrN00GwtOOBDX9Q3a9rFKw+XhYgvb0OIyPaE9PFKPDkoDS
	 rqOsRk4cxHy+pwtQuji0+mTqcOrWexRnDJuM2O9cfGerjwHXBgUMWjsWcLZYGRIeSZ
	 pGKo/KKoTCZauyQHlh+5oLDCw/3WTnQ1F2GvNnzdQPykTCLfSvbcj39q2eV749C53d
	 vhBPR5mRggmeA==
Date: Tue, 18 Jun 2024 10:53:56 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>, linux-pwm@vger.kernel.org, 
 phone-devel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, 
 Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org, 
 Bjorn Andersson <andersson@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, 
 Pavel Machek <pavel@ucw.cz>, David Airlie <airlied@gmail.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, linux-leds@vger.kernel.org, 
 linux-input@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-4-e3f6662017ac@gmail.com>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-4-e3f6662017ac@gmail.com>
Message-Id: <171872963372.3062561.18354991193259441972.robh@kernel.org>
Subject: Re: [PATCH v3 04/23] dt-bindings: mfd: add maxim,max77705


On Tue, 18 Jun 2024 16:59:38 +0300, Dzmitry Sankouski wrote:
> maxim,max77705 is MAX77705 pmic binding part
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  .../devicetree/bindings/mfd/maxim,max77705.yaml    | 112 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 113 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: pmic@66: charger: False schema does not allow {'compatible': ['maxim,max77705-charger'], 'monitored-battery': [[4294967295]], 'phandle': [[2]]}
	from schema $id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: pmic@66: fuelgauge: False schema does not allow {'compatible': ['maxim,max77705-fg'], 'monitored-battery': [[4294967295]], 'power-supplies': [[2]], 'rsense': [[5]]}
	from schema $id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: pmic@66: haptic: False schema does not allow {'compatible': ['maxim,max77705-haptic'], 'haptic-supply': [[4294967295]], 'pwms': [[4294967295, 0, 50000]]}
	from schema $id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: pmic@66: leds: False schema does not allow {'compatible': ['maxim,max77705-led'], '#address-cells': [[1]], '#size-cells': [[0]], 'led@1': {'reg': [[1]], 'label': ['red:usr1']}, 'led@2': {'reg': [[2]], 'label': ['green:usr2']}, 'led@3': {'reg': [[3]], 'label': ['blue:usr3']}}
	from schema $id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: /example-0/i2c14/pmic@66/leds: failed to match any schema with compatible: ['maxim,max77705-led']
Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: /example-0/i2c14/pmic@66/charger: failed to match any schema with compatible: ['maxim,max77705-charger']
Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: /example-0/i2c14/pmic@66/fuelgauge: failed to match any schema with compatible: ['maxim,max77705-fg']
Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: /example-0/i2c14/pmic@66/haptic: failed to match any schema with compatible: ['maxim,max77705-haptic']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240618-starqltechn_integration_upstream-v3-4-e3f6662017ac@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


