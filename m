Return-Path: <linux-pwm+bounces-4981-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A095DA43ECA
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 13:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F35425613
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2025 12:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B521267B9C;
	Tue, 25 Feb 2025 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXUECgvx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED402264A99;
	Tue, 25 Feb 2025 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484929; cv=none; b=UX6rhGSHwArtuqLWF866T4Hg7qJQ7SEpY5MQujFXPjVb9wDDR5kx3IPF9PXAcWLFZFe5/6rXRCw2PJCt1Nll9NS1VqiDOZZ//6Ew45UGgTYHzMxnCUwQMZOO2wkd+RC4TYH1GTJsmPtA5w0Aqq31QqqhSw6/QEpUSZQuVnmA8oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484929; c=relaxed/simple;
	bh=yORW2iO3qKiXB1CP0vLEWVQzUX4QPYnSqxUO9k6Ec6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZUybiDavztsdVP7gVT2pHZ+pKW3fqRRyIsuZG4A9p8L2hgAP83sksJTQwvzEaKTacl1IFosiQw+n7GzF57kEmw130PsC4GUchQ3hhXsfDGSGzDDcRBZCgLCEuUTxN0jGDePqR58Wu/irVwEfuamGQBc4M1Ft1gnA/eoXvENG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXUECgvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7AEC4CEDD;
	Tue, 25 Feb 2025 12:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740484928;
	bh=yORW2iO3qKiXB1CP0vLEWVQzUX4QPYnSqxUO9k6Ec6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXUECgvxZ6dw2v3p6USt0hLALQJ/AnxoJFTYEWdQ26slxWBaxwNePPXCtZpAiY2qh
	 P0t5gPSdiCs8UNzxjyApcIsaAAblvRZBCf3cJOJMUwbk+Eis69qwl4qesj2Rd4IOA2
	 IDc8FIu4Fd4att6obvi5HD/pmKcFQotVywGSswv9uf1fOTXCdDieWjYjXhJDV4lcdH
	 UgMSQyuLx8LtrM42QAAx8hoZeTKd2wCzXkR8Ns/+Q/GfCmLyE0wcnMCxDLrFN+bX2z
	 8RQ4CBU7yru+Y1gXp7fKzLsvmGF5a40eDcHxbjU6gvhz5JfTnKql1lDqNkHFq+VR3h
	 Tp9oIM1f6veuw==
Date: Tue, 25 Feb 2025 13:02:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, ukleinek@kernel.org, alexandre.torgue@foss.st.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wbg@kernel.org, 
	jic23@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, 
	catalin.marinas@arm.com, will@kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	olivier.moysan@foss.st.com
Subject: Re: [PATCH 1/8] dt-bindings: mfd: stm32-lptimer: add support for
 stm32mp25
Message-ID: <20250225-outgoing-scorpion-of-music-be0bea@krzk-bin>
References: <20250224180150.3689638-1-fabrice.gasnier@foss.st.com>
 <20250224180150.3689638-2-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250224180150.3689638-2-fabrice.gasnier@foss.st.com>

On Mon, Feb 24, 2025 at 07:01:43PM +0100, Fabrice Gasnier wrote:
>    pwm:
>      type: object
>      additionalProperties: false
>  
>      properties:
>        compatible:
> -        const: st,stm32-pwm-lp
> +        enum:
> +          - st,stm32-pwm-lp
> +          - st,stm32mp25-pwm-lp
>  
>        "#pwm-cells":
>          const: 3
> @@ -69,7 +76,9 @@ properties:
>  
>      properties:
>        compatible:
> -        const: st,stm32-lptimer-counter
> +        enum:
> +          - st,stm32-lptimer-counter
> +          - st,stm32mp25-lptimer-counter

Driver changes suggest many of these are compatible. Why isn't this expressed?

Best regards,
Krzysztof


