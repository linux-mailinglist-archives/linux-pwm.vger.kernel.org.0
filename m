Return-Path: <linux-pwm+bounces-3209-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17610975C47
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 23:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 810EFB20AE0
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 21:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD6B14EC56;
	Wed, 11 Sep 2024 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV3oa76q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8265337F;
	Wed, 11 Sep 2024 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726089155; cv=none; b=MpOXdCCDDeXChMM22avgOprcJ5YftTErmpcWXD9IrePXPvV6cpPzxzGe7ZQRuM2w8MRP4+PfG8WGFJHt/WjwHYZYvSQ0iw0LMWQUIMIW0c6M8chlmiXJ7P1Uiykp3cBKS09xCFBCNekkK5lz21wJjyjvvmK37aiFnhRrFAPX9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726089155; c=relaxed/simple;
	bh=wOVduJbjzj6PScPe3zlHFXdKTREvpbAlj2t1B+3xlWk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ORq5ArEhOU5owZUOwYaFbakDJgrUePy1E/554YRlYeILd57nBLsg6C8eh/AQRMka2SKbleOwlzq/uFDeO/qu5+jyHwTvKBXdaFvzMmYrVxjejYHfSLaNY90y/39PyvYXs9JsoeB9qalERl2xI3+5ylMo1HVGoeJcbY81ET9nFgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV3oa76q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44014C4CEC6;
	Wed, 11 Sep 2024 21:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726089155;
	bh=wOVduJbjzj6PScPe3zlHFXdKTREvpbAlj2t1B+3xlWk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=OV3oa76qOPG4Eun3JZVeDRaD4vdDNEWIcd4JOJdgYfNycJEdgGT71urNht/nt7vZ2
	 E+p2XnOLvnJ17hwlpRP+MMMmlg176R9ARJ0w3+0kdKn7NvC+tGbyhon6Of2z8x58tu
	 Hi4JLLEaYUpL1zKHbSxJn7w98ICSoNja3ygzzGfyb20PkP7i/E9UcUqWddSDuVu5qM
	 Ygm3QyGNsBzR0eS+JYgMIg2Tu9d9OF1sDzjWLakYIv6c4ZSz4nwey0dy/8+t+Xc6QI
	 v2emNEYMIFcCnmP0yGyXRzhnyNSjHhYrmxFQnn9hKu7P4sxVZ41EDDTGERoq2ux4GG
	 IJ8+IqaQooGVg==
Date: Wed, 11 Sep 2024 16:12:34 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 linux-mediatek@lists.infradead.org, benjamin.larsson@genexis.eu, 
 upstream@airoha.com, ansuelsmth@gmail.com, Sean Wang <sean.wang@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
In-Reply-To: <20240911-en7581-pinctrl-v4-2-60ac93d760bb@kernel.org>
References: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org>
 <20240911-en7581-pinctrl-v4-2-60ac93d760bb@kernel.org>
Message-Id: <172608915288.1388772.4934918553914498433.robh@kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: mfd: Add support for Airoha EN7581
 GPIO System Controller


On Wed, 11 Sep 2024 21:50:02 +0200, Lorenzo Bianconi wrote:
> From: Christian Marangi <ansuelsmth@gmail.com>
> 
> Add support for Airoha EN7581 GPIO System Controller which provide a
> register map for controlling the GPIO, pinctrl and PWM of the SoC.
> 
> Schema define cells for both gpio/interrupt controller and PWM.
> Moreover it provides a dedicated pinctrl node for pins and config
> definitions.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/mfd/airoha,en7581-gpio-sysctl.yaml    | 433 +++++++++++++++++++++
>  1 file changed, 433 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240911-en7581-pinctrl-v4-2-60ac93d760bb@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


