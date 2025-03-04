Return-Path: <linux-pwm+bounces-5092-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C62A4ECF9
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 20:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036D11890560
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 19:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533B25290B;
	Tue,  4 Mar 2025 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wd+VYz5Z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD424BCE8;
	Tue,  4 Mar 2025 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115718; cv=none; b=LFGc2ewl1vLkSFdghMC4v2e3bkP9n8sMLSyFGez5CPdFuQVIfcTZb5ww8JaNvl3stjQyft74J7yLhqnUeERaMH0nI2haAuBOWMgC9hUxf9RPQ8jiKDvnlzYG73FkiMKlfw7bA1RFlZSLM8g4QC6+8UMw2glhRKPHt3F43qEK7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115718; c=relaxed/simple;
	bh=m8gpsFcvErC+OBg1crSKmlYcazdRoOwZ0xMnwbncoLg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=NYpHjrOUrqNzU7LSwekpgEspFnLdH5wUv0RLgdySmZ6VCvjQtrzDZcJUdh548aVWv0pdxRcVRNBc+JkeWnJ52Hf+jw/JLu+6sLOzIZOx1ZgsBuBQ6wR9VpU6GSorusG7Snnefhb8+IKjE/bo4jZFPcZqTLkyI45MKl0q7KXa04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wd+VYz5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA93C4CEE5;
	Tue,  4 Mar 2025 19:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741115717;
	bh=m8gpsFcvErC+OBg1crSKmlYcazdRoOwZ0xMnwbncoLg=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Wd+VYz5Z5pmq6PMWBMCh4meGD69gSJjcGdaQqppo0JES4AT8CP7BglSfJgGMVA3y7
	 UTxQvO0wRGmTbAZ1rh01lKFGskbhM75iCjZ6guHgUT/y704xVrwXatSv5etp8opAL/
	 hMX2QJSLGU+L4BspbNuRwWw7D+P0z4vZhF8JcjMhBRoudk+xaT0kjlBU8ik1AI4bbJ
	 /804WbtwyRXPPLHq2RrTziJNifSXLCDEj8XSDDzcF/V/DkuC7iaKTrjOhKSmKp2bfF
	 1M63SfvUoiIkLLZzovZrXd1NTBWJJQ7O8Xg5BWl8JiUITB6tWMIjQ2m2VpPjnnVLjG
	 opGhzPH4Pok/A==
Date: Tue, 04 Mar 2025 13:15:15 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: tglx@linutronix.de, jic23@kernel.org, linux-iio@vger.kernel.org, 
 olivier.moysan@foss.st.com, wbg@kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, alexandre.torgue@foss.st.com, 
 conor+dt@kernel.org, krzk+dt@kernel.org, daniel.lezcano@linaro.org, 
 devicetree@vger.kernel.org, will@kernel.org, lee@kernel.org, 
 catalin.marinas@arm.com, ukleinek@kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250304173229.3215445-2-fabrice.gasnier@foss.st.com>
References: <20250304173229.3215445-1-fabrice.gasnier@foss.st.com>
 <20250304173229.3215445-2-fabrice.gasnier@foss.st.com>
Message-Id: <174111571576.3307031.12348647271786435979.robh@kernel.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: mfd: stm32-lptimer: add support
 for stm32mp25


On Tue, 04 Mar 2025 18:32:22 +0100, Fabrice Gasnier wrote:
> Add a new stm32mp25 compatible to stm32-lptimer dt-bindings, to support
> STM32MP25 SoC. Some features has been updated or added to the low-power
> timer:
> - new capture compare channels
> - up to two PWM channels
> - PWM input capture
> - peripheral interconnect in stm32mp25 has been updated (new triggers).
> - registers/bits has been added or revisited (IER access).
> So introduce a new compatible to handle this diversity.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in V2:
> - Use fallback compatibles, along with stm32mp25 specific compatible
> - trigger identifier can be up to 4 (e.g. from LPTIM1..5)
> ---
>  .../bindings/mfd/st,stm32-lptimer.yaml        | 40 ++++++++++++++++---
>  1 file changed, 34 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml:26:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml:29:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml:67:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml:70:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml:87:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml:90:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml:103:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml:106:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml:120:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml:123:13: [warning] wrong indentation: expected 14 but found 12 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250304173229.3215445-2-fabrice.gasnier@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


