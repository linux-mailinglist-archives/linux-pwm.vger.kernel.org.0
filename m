Return-Path: <linux-pwm+bounces-3165-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 180E0971425
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 11:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6EC4B255C6
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 09:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CE71B3B01;
	Mon,  9 Sep 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyV2kapX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2321B1D4E;
	Mon,  9 Sep 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875109; cv=none; b=jlvdpBO5Ft6fuvC67C42Qc3awcrT8qNzcmYHcdI7Bf4ZSMAyU/VRx4bKXFydx7qDzwZthRLWgX46jw467X91WYQn7BgVLvnJ4IAlfqn5s7MFmYBt75QaXie+W4yMS5fEmEB872fxnPr2asVockEz3LWMAb+VlXWEeDm+eR/dRao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875109; c=relaxed/simple;
	bh=jhqHA0uVnwtC2Pdc0XOc7SW+3wqNA2H0J2IUl/abSxA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=eVJZJqj/Wt8Z/ScpemeFSomw3cAiae8uEwLeWwTzU1luIl8RN6ojdVYaGkGbyFMAxd+3aOkcYEKfYDi1DiKX3h30yo8Yq7dpmVGtpiKp2JmhET4tfxXNxZ4p/1Yo+10IgCMj2nloLUt6y0zuTgvqTfPBNK06/PJVmgGb3fSkUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyV2kapX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0C4C4CEC5;
	Mon,  9 Sep 2024 09:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725875108;
	bh=jhqHA0uVnwtC2Pdc0XOc7SW+3wqNA2H0J2IUl/abSxA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=DyV2kapXelG+iFIT+i6zbWTfEkFG8Q36rstlUCDkoS5HGNCKtjIrUVh83IYCNFSqu
	 GKdlY5ReQTfyrpAzuQvqVIq11h0183HbST2mNUKwsQ2bqS5LkMTx5hhXh/IJpqtPPY
	 2E5Q8fKy4VhLGMoy9t8P6qNEidtclLa5RLLvoLPVjXi50MPaagXffZoPLsf28kSb9N
	 NfcYToaXX9DgOVV5Ii6Pyq5Vjd6AV8UMedlrZm4Fd8QC3/UWoL3QTgSyF9H17ykAqQ
	 dX0ksoGv9ul7IgsH8jAb/c/MDDNRZjBME4Ezp78vHEHOCZ6K+HbGgpeK50fHJ427bt
	 cpDLXbQjWi+HA==
Date: Mon, 09 Sep 2024 04:45:07 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 linux-pwm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240909-ep93xx-v12-12-e86ab2423d4b@maquefel.me>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
 <20240909-ep93xx-v12-12-e86ab2423d4b@maquefel.me>
Message-Id: <172587509814.3289077.10746482650513855019.robh@kernel.org>
Subject: Re: [PATCH v12 12/38] dt-bindings: pwm: Add Cirrus EP93xx


On Mon, 09 Sep 2024 11:10:37 +0300, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC PWM.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pwm/cirrus,ep9301-pwm.yaml | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.example.dts:18:18: fatal error: dt-bindings/clock/cirrus,ep9301-syscon.h: No such file or directory
   18 |         #include <dt-bindings/clock/cirrus,ep9301-syscon.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:442: Documentation/devicetree/bindings/pwm/cirrus,ep9301-pwm.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1432: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240909-ep93xx-v12-12-e86ab2423d4b@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


