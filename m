Return-Path: <linux-pwm+bounces-2533-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3050A90D9F9
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 18:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC1C1C22220
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1293213C807;
	Tue, 18 Jun 2024 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jcf4SG2w"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEE713BC30;
	Tue, 18 Jun 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729640; cv=none; b=fEVr8/2YbfZ2uIkyuaFRc766/cP/dmH1y14hcGQAQ8WmcD0Al9nyWJO3Bz0XdBzkuqZCmWxOfvI3eRfpsMOzsHpLqnmKvPCjzA9ZxaNeFrhfyDQeKcgIC2DKKDlEPXIZbigHwBhXZ/CoEe7Ggz2FiaZToODJ7heRYQkngB4qmdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729640; c=relaxed/simple;
	bh=H7FPRpyPtpISrnLWRcwsipNmbS7NjzQABnkUys2YiRk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=FvEXBsOk3EagUA+rfA4O9w1o3WCSnmkMc5EhWE6ms9L3kVWG7kIjoU6D53ss4/QmEvXuHyMD5H6QVWMYGMN0Xj37JsKPa06B9KrLmQm3xD5vlD7pegARZTH/Z1BQ5ErbvMri6avuusvPAXGfnws1n1USbr5GUYMuSxR18UpsinY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jcf4SG2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32A7C4AF64;
	Tue, 18 Jun 2024 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718729639;
	bh=H7FPRpyPtpISrnLWRcwsipNmbS7NjzQABnkUys2YiRk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Jcf4SG2wpiXbX7ZM1bKI/pPElEHtipY1v8Cb54B2m3NijSvBdmuunGJwin8OCu2dA
	 bD1brFL2KB6Ghin0KMDFNdh73Dnuxf4Z4q++7oOgJJd1MaooJqeU0oNAY/bKjFfJdv
	 7+9/aC3KSrwVJZ0FJh+bWki77yjbi1RWEkmuVGMLulLW15fS4s2JT3um70LzR8C+BA
	 I+vHj5MXo4A8PXjMMweS249CK1TuUuHHKqXVtYCYp0u6lNPeLLkdy9I+Q8KXJ/pagx
	 evgrZATFvdIweX08+dr13+9LZpy7RpD2fqljrMzoyXzBb73sBgygFcMf5W7E5/U0DS
	 MtyU9rkE1gkLw==
Date: Tue, 18 Jun 2024 10:53:58 -0600
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
Cc: linux-input@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Daniel Vetter <daniel@ffwll.ch>, linux-pm@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 linux-arm-msm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, 
 Krzysztof Kozlowski <krzk@kernel.org>, David Airlie <airlied@gmail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Conor Dooley <conor+dt@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
 phone-devel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sam Ravnborg <sam@ravnborg.org>, Lee Jones <lee@kernel.org>, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-samsung-soc@vger.kernel.org, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-leds@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, linux-clk@vger.kernel.org
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-7-e3f6662017ac@gmail.com>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
 <20240618-starqltechn_integration_upstream-v3-7-e3f6662017ac@gmail.com>
Message-Id: <171872963469.3062613.11658948111775206928.robh@kernel.org>
Subject: Re: [PATCH v3 07/23] dt-bindings: power: supply: add
 maxim,max77705


On Tue, 18 Jun 2024 16:59:41 +0300, Dzmitry Sankouski wrote:
> add maxim,max77705 fuel gauge binding part
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  .../bindings/power/supply/maxim,max77705-fg.yaml   | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: pmic@66: fuelgauge: 'monitored-battery', 'power-supplies' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/maxim,max77705.example.dtb: fuelgauge: 'monitored-battery', 'power-supplies' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/power/supply/maxim,max77705-fg.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240618-starqltechn_integration_upstream-v3-7-e3f6662017ac@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


