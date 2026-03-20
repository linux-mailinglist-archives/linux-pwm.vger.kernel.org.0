Return-Path: <linux-pwm+bounces-8309-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODOJEAk9vWkH8AIAu9opvQ
	(envelope-from <linux-pwm+bounces-8309-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:26:49 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1282DA2CF
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 13:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A90B2301EBF9
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D413ACEFE;
	Fri, 20 Mar 2026 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2Th899H"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D283F3AC0D6;
	Fri, 20 Mar 2026 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009593; cv=none; b=u6q6zu7MBDI1SoP63fCaMxDM77CMdZTKY6BSnx2CXOK14mxOpru11NgvSdBawySVSADiIl08U4yfULgDLGz48GjFFnsmmTsX/X1QweJLyLcpsZRH3f2sIossSU0Le5fgus/tE81Z4cJ51hQ6gyogW2+g21HafTrj6KpBPxRwRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009593; c=relaxed/simple;
	bh=jXcv2Q8Am/1SMQ2s+Xp0fxNypJnSSzleE88TmjASg0k=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=UOymc6yn35WMUSXewwc1GnOxltcp0VTu7jEiVBVDaILl/LCoBQXauTCa/SY3KXhEE8yykHnxRq6rw3VZniCyJ8Jf/QWnh/n3iPu13pMVT72gJQ2pabXXWSAgLiv93GiW9/GOEr8nLjt1vKPTSo40M3G1UAt58pSouojZrS+BFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2Th899H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B27C2BC9E;
	Fri, 20 Mar 2026 12:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774009593;
	bh=jXcv2Q8Am/1SMQ2s+Xp0fxNypJnSSzleE88TmjASg0k=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=e2Th899HS6X6sMPqmj0y9cPTOq1+ApmVoSWjGf4o5VYHEwCvk3Mo8gnLtX7DgIh1v
	 b573/r1Zivh9xUTcrZJ/EevSYGq7B+O637knEHr+2vKQhDCkFjctmFYQjicuQJVuVg
	 8w+vn5hsr2ifloAmK4uVvlzhzjw52xgvJeuNHlzgF4mxWUFhWuLmkDrSHFWZ6oQFaa
	 YjTi8hvVeW/sApU31OLvfBp0/Sv7RX77Ri7HO2tzw4h5VEJias5s+wbIZWBjn4EzEz
	 E/uHPQyUPGeaEKXQV7xTbUCPOKQbPubzApsiZGWV0agRrlw7wAZ2j+qTrNcHrSoz2a
	 YesLKAdRTX6rg==
Date: Fri, 20 Mar 2026 07:26:32 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
 linux-pwm@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>
To: Radu Sabau <radu.sabau@analog.com>
In-Reply-To: <20260320-ad4692-multichannel-sar-adc-driver-v4-1-052c1050507a@analog.com>
References: <20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
 <20260320-ad4692-multichannel-sar-adc-driver-v4-1-052c1050507a@analog.com>
Message-Id: <177400959255.943880.4128073323297765287.robh@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: iio: adc: add AD4691 family
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,metafoo.de,vger.kernel.org,baylibre.com,analog.com,pengutronix.de,gmail.com];
	TAGGED_FROM(0.00)[bounces-8309-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.859];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,analog.com:email,devicetree.org:url]
X-Rspamd-Queue-Id: 4C1282DA2CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 20 Mar 2026 13:03:55 +0200, Radu Sabau wrote:
> Add DT bindings for the Analog Devices AD4691 family of multichannel
> SAR ADCs (AD4691, AD4692, AD4693, AD4694).
> 
> The binding describes the hardware connections:
> 
> - Power domains: avdd-supply (required), vio-supply, ref-supply or
>   refin-supply (external reference; the REFIN path enables the
>   internal reference buffer), and an optional ldo-in-supply, that if
>   absent, means the on-chip internal LDO will be used.
> 
> - Optional PWM on the CNV pin selects CNV Burst Mode; when absent,
>   Manual Mode is assumed with CNV tied to SPI CS.
> 
> - An optional reset GPIO (reset-gpios) for hardware reset.
> 
> - Up to four GP pins (gp0..gp3) usable as interrupt sources,
>   identified in firmware via interrupt-names "gp0".."gp3".
> 
> - gpio-controller with #gpio-cells = <2> for GP pin GPIO usage.
> 
> - #trigger-source-cells = <1>: one cell selecting the GP pin number
>   (0-3) used as the SPI offload trigger source.
> 
> Two binding examples are provided: CNV Burst Mode with SPI offload
> (DMA data acquisition driven by DATA_READY on a GP pin), and Manual
> Mode for CPU-driven triggered-buffer or single-shot capture.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4691.yaml    | 173 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 +
>  2 files changed, 180 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4691.yaml: properties:interrupt-names: {'description': 'Names of the interrupt lines, matching the GP pin names.', 'minItems': 1, 'maxItems': 4, 'items': [{'const': 'gp0'}, {'const': 'gp1'}, {'const': 'gp2'}, {'const': 'gp3'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260320-ad4692-multichannel-sar-adc-driver-v4-1-052c1050507a@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


