Return-Path: <linux-pwm+bounces-6098-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D0EAC10FB
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 18:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FE03B5A66
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 16:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A511228CB7;
	Thu, 22 May 2025 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxC29PAs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104BE13C8EA;
	Thu, 22 May 2025 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931283; cv=none; b=IjnpJxmo8sgKyIBdFx1fjOy36o6lcqabXzVLRNKQ0Q5VIely8gq3dVi6B4ZIRDI3YkS0cht6HdqfWd6MTmpc7O/wUnA7b54xauu5fyrOLjdwTAK1ukvyrTlIiJDkHQwxm7OVNUz8WghiXe4miXk8YhXGvoHODBH2yTZlFd53V+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931283; c=relaxed/simple;
	bh=Oo7katdjAPrApiDFIg790a/KcGz4l2Mds8fE4FckuV8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=aOQTeGGRPRznZVTGFMpGo3p5PdunImbiFmVuYOwKwuOwstDuelUKTdICIBd4UYxzocVlSm3X6Y07XgkQhr4LS9jMYKAD5gIYwD5N+1MLtUNqD6V1mmv92v5ceKCyB88vgNhFR7ZheA6JG1ozFK0P8YhJOBc64SfhEOspYW+bvPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxC29PAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490CEC4CEF7;
	Thu, 22 May 2025 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747931282;
	bh=Oo7katdjAPrApiDFIg790a/KcGz4l2Mds8fE4FckuV8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=CxC29PAs+c3XS6Oxq47coqmerR9OpS6uOjJeBKKliXtMm8/JN48qZAYyZXQq6+kPJ
	 ym/96qY9dGvJiis1WclAIXcutRsoofW6mbl34ge6a0gBYjgLW8nlMJo6133x2XX9+f
	 lUrg7iJFp3L6HCsE1A3dmgh7oAgJoWPjXU4hqR+KKnLZdGyd0V/S0uVSAe9UE5AsoH
	 AaI3WC917CEnmWxe/+vazeaO0+1nbA+ONxri0DSMjMPsIuGtmlIqqDIou1dayKARq9
	 hB7tlYjgXImV3wG4oX9KKsXR7MKNeFVf1mKiFqk/yqrF1JU79KfniLLGoolrDiZYTU
	 HbMlZe9+KcMcw==
Date: Thu, 22 May 2025 11:28:00 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, devicetree@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>
To: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250522-pwm-axi-pwmgen-add-external-clock-v2-2-086ea9e6ecf0@baylibre.com>
References: <20250522-pwm-axi-pwmgen-add-external-clock-v2-0-086ea9e6ecf0@baylibre.com>
 <20250522-pwm-axi-pwmgen-add-external-clock-v2-2-086ea9e6ecf0@baylibre.com>
Message-Id: <174793127939.2927580.11316141266712516597.robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: pwm: adi,axi-pwmgen: fix clocks


On Thu, 22 May 2025 09:49:40 -0500, David Lechner wrote:
> Fix a shortcoming in the bindings that doesn't allow for a separate
> external clock.
> 
> The AXI PWMGEN IP block has a compile option ASYNC_CLK_EN that allows
> the use of an external clock for the PWM output separate from the AXI
> clock that runs the peripheral.
> 
> This was missed in the original bindings and so users were writing dts
> files where the one and only clock specified would be the external
> clock, if there was one, incorrectly missing the separate AXI clock.
> 
> The correct bindings are that the AXI clock is always required and the
> external clock is optional (must be given only when HDL compile option
> ASYNC_CLK_EN=1).
> 
> Fixes: 1edf2c2a2841 ("dt-bindings: pwm: Add AXI PWM generator")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml:40:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml: properties:clock-names:enum: 'oneOf' conditional failed, one must be fixed:
	{'const': 'axi'} is not of type 'integer'
	{'const': 'axi'} is not of type 'string'
	{'items': [{'const': 'axi'}, {'const': 'ext'}]} is not of type 'integer'
	{'items': [{'const': 'axi'}, {'const': 'ext'}]} is not of type 'string'
	hint: "enum" must be an array of either integers or strings
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml: properties:clock-names:enum:0: {'const': 'axi'} is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml: properties:clock-names:enum:1: {'items': [{'const': 'axi'}, {'const': 'ext'}]} is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.example.dtb: pwm@44b00000 (adi,axi-pwmgen-2.00.a): clock-names: ['axi', 'ext'] is not one of [{'const': 'axi'}, {'items': [{'const': 'axi'}, {'const': 'ext'}]}]
	from schema $id: http://devicetree.org/schemas/pwm/adi,axi-pwmgen.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.example.dtb: pwm@44b00000 (adi,axi-pwmgen-2.00.a): Unevaluated properties are not allowed ('clock-names' was unexpected)
	from schema $id: http://devicetree.org/schemas/pwm/adi,axi-pwmgen.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250522-pwm-axi-pwmgen-add-external-clock-v2-2-086ea9e6ecf0@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


