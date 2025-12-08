Return-Path: <linux-pwm+bounces-7773-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8301CAC39D
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Dec 2025 07:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ABB7304639A
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Dec 2025 06:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FA73271EC;
	Mon,  8 Dec 2025 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eo8if8oC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38015326D68;
	Mon,  8 Dec 2025 06:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765176358; cv=none; b=jXak0CFkOCO15AKQTSfT3PsDoMoczwDicHhvFP+Fe+G6kui/S/tMd4XmCrGKEPWHXA2OHUf+MIMKOz7Ny2keKOnp9bZTxZb24yIK1DeuvOpCZJ5MHalpoG5xCEMgYTMxPhm7o4SxCoeMXjJTXGVuOLUjpnRvp7b0AYewXsqAzTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765176358; c=relaxed/simple;
	bh=nnJu3U+qCQGvyN98FX7xu7pumvxzjQeZ4LH/i9P5OJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+Ge8LDpUzcUD3Y0PIbmHkfnKsQS4Ba8SVMzWVW/UckmcpUTCShuq2RKW6VD6L/MVIAdmp3jbP1d9entx+AOy4Jt5PQdvhXwH22z6kpGCQxC5QamuPv/PZ4FqMrKC2LrNm3DKCbYt1rMLP/JjRwuC12dgrzuq5UcpnvjNX3Rt+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eo8if8oC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AE0C4CEF1;
	Mon,  8 Dec 2025 06:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765176357;
	bh=nnJu3U+qCQGvyN98FX7xu7pumvxzjQeZ4LH/i9P5OJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eo8if8oCPqnPs9qaBZxE6Dh4TvFC59luH1dxoQmyd0yRm5smDeGYzxRiTXrbZcFxx
	 k4iw1DAGtehN+EBuGysngsDXNhKCQ3vD1zszkjTHs/pRPk7qjbM6y5BlfwNfjYfKzK
	 UAQlmnRt9D8ScMc59rck+fOwjRiD5Dj51UMdOmtF/2czWzxWgtOBG+J0MqAyMMCYuy
	 40ti0hyI7tN6K0Tx0LjvjJ9k8PPAN+yZLGcVTBB+h45qp5DN++1R1ZwCixsHcDzjoQ
	 f+xEt/SCrEqxL9dRGvzWc4P9x6bswCoOrJ6JobYDoNkPxEm4hlB2dsv/5T2puLlgqx
	 L0pOPIoGw6Flw==
Date: Mon, 8 Dec 2025 07:45:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH 1/2] dt-bindings: pwm: eswin: Add EIC7700 pwm controller
Message-ID: <20251208-rational-trout-of-purring-a6150a@quoll>
References: <20251205090411.1388-1-dongxuyang@eswincomputing.com>
 <20251205090450.1446-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251205090450.1446-1-dongxuyang@eswincomputing.com>

On Fri, Dec 05, 2025 at 05:04:50PM +0800, dongxuyang@eswincomputing.com wrote:
> diff --git a/Documentation/devicetree/bindings/pwm/eswin,eic7700-pwm.yaml b/Documentation/devicetree/bindings/pwm/eswin,eic7700-pwm.yaml
> new file mode 100644
> index 000000000000..8b7dc7d4dffe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/eswin,eic7700-pwm.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/eswin,eic7700-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ESWIN EIC7700 PWM controller
> +
> +maintainers:
> +  - Xiang Xu <xuxiang@eswincomputing.com>
> +  - Guosheng Wang <wangguosheng@eswincomputing.com>
> +  - Xuyang Dong <dongxuyang@eswincomputing.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The EIC7700 PWM used the DesignWare APB timers module. The PWM driver
> +  supports a duty cycle range from 0% to 100%, with explicit support for

Driver is irrelevant here. Describe hardware.

> +  both 0% and 100% duty cycles.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: eswin,eic7700-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +  pinctrl-0: true
> +  pinctrl-1: true
> +
> +  pinctrl-names:
> +    minItems: 1
> +    items:
> +      - const: default
> +      - const: sleep
> +
> +  snps,pwm-full-range-enable:

1. Wrong vendor prefix, thats eswin, not snps.
2. Why is this a hardware property? I really do not see that. You
described the desired Linux feature or behavior, not the actual
hardware. The bindings are about the latter, so instead you need to
rephrase the property and its description to match actual hardware
capabilities/features/configuration etc.

Best regards,
Krzysztof


