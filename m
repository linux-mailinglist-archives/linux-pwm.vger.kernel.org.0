Return-Path: <linux-pwm+bounces-7730-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16688C91C70
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 12:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3F03A90A0
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15FD30DEB9;
	Fri, 28 Nov 2025 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgO6jjCY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DE23E325;
	Fri, 28 Nov 2025 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764328720; cv=none; b=kPyPOm/ojTDvVA3565idGj8zlQDPUfeKhfKON4A/Sg9rHVqdrhihBfZZD9FNqy+iR1DUJVyjmKuSGGc3qoUAmXf5JWUvHPeGLgpoHzdx1RklgN0/o1U3rMlA3QR53lyE+akWCY2Gc44akDBJuGRZbJ6Qg+21g+Bq+JEyjeeie8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764328720; c=relaxed/simple;
	bh=hg+5U2zi9PtoAVCCeEspm4SEoJznirmHWKZ0Injgva4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=goqHrqyjcaYSFhMERr47gg2Qvx5sT1nKxzNzEifiMB1jDDQCGkfYiZoqBe2ur/TFh6XJAVrmYOmk3X3OCL9DAxa+Ib1DnxbjJHqjCvt6KU9riwHtVEyLLe+k6SbvjA6u+f+8Wdnzrmzw0pNd6jfdAu19T13kitvuKWck4pwjLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgO6jjCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AA0C4CEF1;
	Fri, 28 Nov 2025 11:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764328720;
	bh=hg+5U2zi9PtoAVCCeEspm4SEoJznirmHWKZ0Injgva4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=mgO6jjCYE9r36HzOOo1RqDoWU5+JEbW0wHvmkaJn6AfJcNn63Ya/p6FTCwVCBnoVg
	 h/j4amiuoJZgVrHf0XoxeaU/7Rxktm36+YrwRw0kHHKtCK0qsMcs9mqphKuKut6NZ6
	 AxlRGptNSRSdEHtItXgJBlCdZc73bH3DHjrsmP6KxlCnLCyJUbllz4X7mCehlRHFaw
	 hKXyk3rDVubJG23+eoxEN8R7f1Pb3GiRBOUvC81Vw4LkgEbMEbiCvQS6t+44VedUWI
	 JWAyxX5MfQ8aBE1khAkoPVcWZV2DjIZ8pnuaR3kt8CirlSaW9ScbtV9v+GH52lzZDA
	 njkRLQGfOs6xQ==
Date: Fri, 28 Nov 2025 05:18:38 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Devi Priya <quic_devipriy@quicinc.com>, Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Baruch Siach <baruch.siach@siklu.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 Baruch Siach <baruch@tkos.co.il>
To: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <20251128-ipq-pwm-v19-1-13bc704cc6a5@outlook.com>
References: <20251128-ipq-pwm-v19-0-13bc704cc6a5@outlook.com>
 <20251128-ipq-pwm-v19-1-13bc704cc6a5@outlook.com>
Message-Id: <176432871822.1774259.10260811586771769913.robh@kernel.org>
Subject: Re: [PATCH v19 1/6] dt-bindings: pwm: add IPQ6018 binding


On Fri, 28 Nov 2025 14:29:13 +0400, George Moussalem wrote:
> From: Devi Priya <quic_devipriy@quicinc.com>
> 
> DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  .../devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml  | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c263000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c263000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c265000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']
Documentation/devicetree/bindings/thermal/thermal-sensor.example.dtb: /example-0/soc/thermal-sensor@c265000: failed to match any schema with compatible: ['qcom,sdm845-tsens', 'qcom,tsens-v2']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251128-ipq-pwm-v19-1-13bc704cc6a5@outlook.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


