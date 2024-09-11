Return-Path: <linux-pwm+bounces-3208-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B58E975C42
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 23:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BD21C21C83
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Sep 2024 21:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C0D143C6C;
	Wed, 11 Sep 2024 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsFpgDS2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1F5337F;
	Wed, 11 Sep 2024 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726089154; cv=none; b=QRm965JlALV57n5cXjYOMbowMxtjOUNYvTkx1FA6OHhzftgerXfFg5Ww7HFI2sPDEc2wEMTtN3fi+/dz3bDJgovEj6H7OrqgV9mZMbXWOkpQMbdPinBfEuJJATqhTWcTD1YxEo+gidnAJLzclsYrtLAJ9j8sVq/rVPax+0Ji7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726089154; c=relaxed/simple;
	bh=5a0w8ihru5qeC1bAlX8IIJJGmmGbilmT8scRcWg0ahA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=SFNs72Ykxbi1cI1OVXyVYkpTC+BGBr/FQ7D1zx1WabVoTYUFHB318ozwJxylwm98Bb0hvfJM+kzGfFcGJ1VBcVq27W5XnKpDPp6rsiZhU14QIPfqFujnBODSdkh0e7U3BZ4Q4mFKbQqjRZ7VqmfnWs919x/h8fd3RxdGHvh9CGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsFpgDS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C7CC4CEC0;
	Wed, 11 Sep 2024 21:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726089154;
	bh=5a0w8ihru5qeC1bAlX8IIJJGmmGbilmT8scRcWg0ahA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=WsFpgDS29CG1HpRsl8+NLTApWl4Sk5Z/UdIDjxFdJPrjYnA7mL4/Cgl1of/aGeLJg
	 0+HpcQ0YpWeT5UQQbj8qoFVi6G/aQtjztE+rGqMXZl2NDzCBeeP6mN/kLZSyMvMWEJ
	 Xabm1tkV1Lc1X9kUMUtiP3H38wvx2mBXjsvO+HqdDXYC9R9Uf/BfC1iCE09iSg0Tv1
	 jFiw7YzttU262N25tdo9BKYSIUY/QPMqXHlo9M48FrMjP2nK8g/isrVQ5UmDHaLJ0G
	 yoH+xzzMXtfXY/9ioTlhjq46IOH61Pu8wRsp+dGcVgUU3EXcM1Jj3OzQ1Ez3CvfSCZ
	 5B+Ys6fXPvFeA==
Date: Wed, 11 Sep 2024 16:12:32 -0500
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
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-gpio@vger.kernel.org, 
 Sean Wang <sean.wang@kernel.org>, upstream@airoha.com, ansuelsmth@gmail.com, 
 linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>, 
 devicetree@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 benjamin.larsson@genexis.eu
In-Reply-To: <20240911-en7581-pinctrl-v4-1-60ac93d760bb@kernel.org>
References: <20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org>
 <20240911-en7581-pinctrl-v4-1-60ac93d760bb@kernel.org>
Message-Id: <172608915149.1388705.7137335166206916411.robh@kernel.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: arm: airoha: Add the chip-scu node
 for EN7581 SoC


On Wed, 11 Sep 2024 21:50:01 +0200, Lorenzo Bianconi wrote:
> This patch adds the chip-scu document bindings for EN7581 SoC.
> The airoha chip-scu block provides a configuration interface for clock,
> io-muxing and other functionalities used by multiple controllers (e.g.
> clock, pinctrl, ecc.) on EN7581 SoC.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/arm/airoha,en7581-chip-scu.yaml       | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240911-en7581-pinctrl-v4-1-60ac93d760bb@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


