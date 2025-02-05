Return-Path: <linux-pwm+bounces-4793-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88474A29A37
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 20:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2A5165ADC
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 19:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E0E2054F9;
	Wed,  5 Feb 2025 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pw1dD3d7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB48155335;
	Wed,  5 Feb 2025 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784151; cv=none; b=I6u8e8fhvD3e2ivVbuDe0xeXsf63u5WaUSPPcQild4RMiH/+6q7tJe+/3xdVPHOwzpZlpw76+IkrINnBbamFzcHxh6u+VcVx1Kuzb9BRVmc2SdEtCxDCQlPBUtvleWEyJty8dKtYNOxQuK4IAS5KKEjNrUZVJzi+L1zgzKNaw44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784151; c=relaxed/simple;
	bh=l94FF8P1w7MiX05RA/T0pW7/kmfbGvyA+LpwGszjAyI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=cf/uDUAxMwFSzmyuWCU2vAndznkLrWNtfcS+iwspI40rVb7mZ8XwulY29edWIX/evjaCbBIcME1cN0oS4K240SrOv3TYEkdU1EtK3kYD1u7GfwwbOz94EZbMHYk2xWc4KUQQzzv3uhVD4kaB+Iae41X8gU3M9zAqsZFNKy7+2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pw1dD3d7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB51C4CED1;
	Wed,  5 Feb 2025 19:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738784150;
	bh=l94FF8P1w7MiX05RA/T0pW7/kmfbGvyA+LpwGszjAyI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=pw1dD3d7zc2mhC3xcYMdVVtX4RuGi8Q7yZ9KJwmM7NNNxgehlcKJy/lhUniUr/tfa
	 SyPp/unMH5ghf3VJvcG/4PQ9C/ZTdMezQKEIwTboFQlOo+xs72JZjmAOCb5ZBlR9Ih
	 ANq0Uz20Aqwg8yGtXrup/P8b8BGGDcprYYMiwl5W5JE+vERN0Du6nq4n3Wh/gje5f6
	 egDN45KaqBJ6srcCU58p4C8QXogMx1fPRVpEhpaXljP0u8j0VdcHnMMSoegpWUfTqq
	 /Ov8udZwMclLhWBTSDkdQRkgUhsfEGA4AL0NsPYZkGBwfPCXn/ZMsQACcTsnMCbPl7
	 oIAb9S2Wn/EDQ==
Date: Wed, 05 Feb 2025 13:35:49 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-pwm@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Daniel Mack <daniel@zonque.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
In-Reply-To: <266765abb8251bd60796a3c4270e3809bfff952e.1738777221.git.u.kleine-koenig@baylibre.com>
References: <cover.1738777221.git.u.kleine-koenig@baylibre.com>
 <266765abb8251bd60796a3c4270e3809bfff952e.1738777221.git.u.kleine-koenig@baylibre.com>
Message-Id: <173878414916.2733923.916545149543480294.robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: pwm: marvell,pxa-pwm: Update to use
 #pwm-cells = <3>


On Wed, 05 Feb 2025 18:54:01 +0100, Uwe Kleine-König wrote:
> The PXA PWM binding is the only one that doesn't pass the PWM line index
> as first parameter of the parameter cells. However this can be upgraded
> to the mandatory binding for all new PWM drivers without breaking
> compatibility for old device trees using #pwm-cells = <1>.
> 
> So bump #pwm-cells to 3 with the (undocumented) promise to keep the old
> behaviour for #pwm-cells = <1>.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.example.dtb: pwm@40b00000: #pwm-cells: 3 was expected
	from schema $id: http://devicetree.org/schemas/pwm/marvell,pxa-pwm.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/266765abb8251bd60796a3c4270e3809bfff952e.1738777221.git.u.kleine-koenig@baylibre.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


