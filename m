Return-Path: <linux-pwm+bounces-2534-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0784790DA5C
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 19:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80F7DB2761C
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E3F143C7A;
	Tue, 18 Jun 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GK8Nog0G"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183BD13F016;
	Tue, 18 Jun 2024 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729641; cv=none; b=koqm17h8Fly4si+SRye455z139zLAwaJpBwCMTgnZokR/kXDoUBKKfQ6wAl9W1fLiFM8QFySvcasmr4ooQ0l1ux3MVfz2BlB14/KgpQMOLOhAlufeI0LuRjoYvDrE008CtlJaLdggmT8N6rS2vYSjkPA6EcfE2zCgnRpcII4JsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729641; c=relaxed/simple;
	bh=pi1s9JzXbV/imk2EIUojuF6yHVD4/lluGwnh58k352E=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=gCQ0w1s2Ni8Dqk0At1ERc36we477n7n5kAbq8gq+OKVOeCqNQOdFOTjopiFYSTGoT0o4ZprAmlqxoNkDYIScWfDNCPGAwAf8FdvNyfw1HC//bDPlvCHp7pjegp1sP+JZHchv9BlPZD2iVfBT3hM2FDEu3az20hcaY6wgAmXOq+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GK8Nog0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA0FC4AF64;
	Tue, 18 Jun 2024 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718729640;
	bh=pi1s9JzXbV/imk2EIUojuF6yHVD4/lluGwnh58k352E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GK8Nog0GRPQFKv4Bfioz4q801P9MX5gLhJJ5Kjvcl1VR+0ZUukb2CL1FMiKZ5ye4r
	 tYXSTjDQYOiJOtY944SglSxxtZvRN02hIWk1OEcECVDiur5hjXLkDnsDg6L+/uS0na
	 hd9XmxrIBipeGMozPvpqkTU3RK3i55zNrvwmJdaeR7Q5SI+JGIlLgVLd3KLNDIfqt9
	 LRRmFZujT8xd2Zm1tOXonz63uJY/zky0jeF4IVtlPgnUBRzOnRx6jOc5nKBwh4kz5P
	 pbt6GWIviEmxO2JLnOuX9LGWIuB57pxCgbZnH5riGuw6MU+FSw6J6JcRBEwJFWllb0
	 4yeYwmEW89tDw==
Date: Tue, 18 Jun 2024 10:53:59 -0600
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
 Neil Armstrong <neil.armstrong@linaro.org>, Pavel Machek <pavel@ucw.cz>, 
 linux-input@vger.kernel.org, Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, 
 Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>, 
 linux-samsung-soc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-clk@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 linux-leds@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 phone-devel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, 
 David Airlie <airlied@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-9-e3f6662017ac@gmail.com>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-9-e3f6662017ac@gmail.com>
Message-Id: <171872963565.3062659.8558146217368306841.robh@kernel.org>
Subject: Re: [PATCH v3 09/23] dt-bindings: mfd: add samsung,s2dos05


On Tue, 18 Jun 2024 16:59:43 +0300, Dzmitry Sankouski wrote:
> add samsung,s2dos05 core MFD module binding
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  .../devicetree/bindings/mfd/samsung,s2dos05.yaml   | 89 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 90 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mfd/samsung,s2dos05.example.dtb: /example-0/i2c/pmic@60: failed to match any schema with compatible: ['samsung,s2dos05']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240618-starqltechn_integration_upstream-v3-9-e3f6662017ac@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


