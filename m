Return-Path: <linux-pwm+bounces-7893-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AA5D116BD
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Jan 2026 10:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2233B306A0F7
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Jan 2026 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C794534677D;
	Mon, 12 Jan 2026 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9hUOhhB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4545322B66;
	Mon, 12 Jan 2026 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768209026; cv=none; b=LJ/pY5xHacTzudajkqpmGkHiyGz71f8LU5mKOAFG/GlwL6NQLMCnoiDorn9sDBrKZlKIUwSxEG7BPXeJCV59zERTtGCu8O7SIZNwCn8iu7ePPuVmuBo/wN9/cevWpgH40xfLGS/mziJgn4J2v+knYfyht7W4E37essagQacaZ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768209026; c=relaxed/simple;
	bh=btIfgvN//QCdfFLDobhX7wI+ddL2rHMM6ASGnTTOltI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTM0omLot5PGyD4Icq0rdYHtR7QukWcJ0aph4jeWcfTqCSzwGr7tGvPaQCKqBBjhGH9OxhoYyL1BXIp/IAs5S/JelT59126aN2YvBxLQC/WKbJH66FwfH+jYIE2daJZuMsxP1/B3BNfs8AzZrn4Gc8KU0s8kUcSWu3JZ5Q5MJbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9hUOhhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B56C2BC86;
	Mon, 12 Jan 2026 09:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768209026;
	bh=btIfgvN//QCdfFLDobhX7wI+ddL2rHMM6ASGnTTOltI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9hUOhhBivbYhH0L79leJUnCAzU484e/Z8gGzumvj6wzb4MN6U2NNqybUhnfcOyQO
	 Zhne5wgu4VbOhr73oWsDCMLLQb5oQVokoSDiTQzShgJV9o4f972SXVcnyxphapswkj
	 U8+yyWXoSHe29KEtxgerrKJzwnLPE/GsjjxRSfriQYqFfnZaDVdj+deU6kbLYa7cr+
	 d75nsNdcqPAGBoJU6ZINvGXhYeZRXR2xFHlKrC8QyEfvNDsqtLR9n3j5pknqwsnCkI
	 cd2wejipsyGe3qAsBwW3bacLNUKRplkQ3XSCLVw3HDHxQVeBjdeYfy9aumhIIajCER
	 6iF1dxv2dCAyQ==
Date: Mon, 12 Jan 2026 10:10:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: nxp,lpc32xx-pwm: Add optional
 Motor Control PWM interrupt
Message-ID: <20260112-garnet-axolotl-of-acceptance-3978fd@quoll>
References: <20260110014524.3379187-1-vz@mleia.com>
 <20260110014524.3379187-2-vz@mleia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260110014524.3379187-2-vz@mleia.com>

On Sat, Jan 10, 2026 at 03:45:23AM +0200, Vladimir Zapolskiy wrote:
> NXP LPC32xx Motor Control PWM has an interrupt line shared with TIMER4,
> and the interrupt may be used to report events from programmable counters
> e.g. timer counter limit (period), match counter (pulse-width), or from
> counters on input lines of PWM channels.
> 
> As a reference and for more details see NXP LPC32xx User Manual, table 595.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  .../devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml       | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> index cdd83ac29caf..53520f005acb 100644
> --- a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
> @@ -32,6 +32,16 @@ required:
>  
>  allOf:
>    - $ref: pwm.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nxp,lpc3220-motor-pwm
> +    then:
> +      properties:
> +        interrupts:
> +          maxItems: 1

Properties must be defined in top-level. You only narrow constraints or
disallow them :false per variant in if:then: blocks.

Best regards,
Krzysztof


