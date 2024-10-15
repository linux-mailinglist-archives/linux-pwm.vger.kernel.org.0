Return-Path: <linux-pwm+bounces-3656-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5365C99F2BE
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 18:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84FED1C20BFC
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 16:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0C21F669D;
	Tue, 15 Oct 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5UKNoVi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF391F6668;
	Tue, 15 Oct 2024 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009922; cv=none; b=ZXQGRAPEUfTdsT46PpRmQb1qMPQ6lBdu58ibktnIOAl5a2Y0NChUBsXKYeb4/pVHG/x9tXJjnfUJk5qvLflwwz6zdkGAofilRMsjvKyMubFdJ97x489sePtydOGtgnjUqgoxr3XSOyO+dPKfKgbGIR7u7qjY/XA1k4/RehF8g34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009922; c=relaxed/simple;
	bh=rSaBxEWooctyUex7WQS1Iy+/fA3GFDfNlKTOE4OycsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtSkQghL7kAh5pMPAoi6DOmvrZNeJA2XknJXK+BCL9iB3Pm1gku3RC0fCz4LEJ+aWLHy+pVLwswPuEbG1B4412CUQLFMtaO91XH4s80IpHaSvvCqLKKl5Nrg2FJ7qho/PfNuUX5jqN6I2Sbc/2vxUlUksx+og59wyKgpECScp44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5UKNoVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E4AC4CEC6;
	Tue, 15 Oct 2024 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729009922;
	bh=rSaBxEWooctyUex7WQS1Iy+/fA3GFDfNlKTOE4OycsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5UKNoVioHrCt8gD7BOi+QZD48JEHtTs5Bz5O72L1MPjv/NdcYQ++mKfsb3iyqHCH
	 lLKRllUxoYnlPO+E0UMcYpYh5tzf8IdqHLAR3Y+L8ZixnW+7SHJGxd5igOTNKwaL4t
	 pdtI5pYnsCVAxGA5p92j0r+hFYSO/hd2fg0itsv8vewoRBlKrVSbIRyexOS6gGecvX
	 90v7nJyj6i6CtApCP5OoxB2GkhdoBP6T4GALweRn7QQ9gTcI1zmhZof68XU5Jjrmn2
	 VGZ+W6uWDPUTpLbKmsCfXJZhl1EFSezPIRztJjkBhvYrWNlieeLd7L1tMwUxrgxFTu
	 dj6r38gCOW1QA==
Date: Tue, 15 Oct 2024 11:32:00 -0500
From: Rob Herring <robh@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	"open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	justin.chen@broadcom.com
Subject: Re: [PATCH 1/2] dt-bindings: pwm: brcm,bcm7038: Document the
 'open-drain' property
Message-ID: <20241015163200.GA1220909-robh@kernel.org>
References: <20241012025603.1644451-1-florian.fainelli@broadcom.com>
 <20241012025603.1644451-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012025603.1644451-2-florian.fainelli@broadcom.com>

On Fri, Oct 11, 2024 at 07:56:02PM -0700, Florian Fainelli wrote:
> Document the 'open-drain' property that allows configuring the PWM
> controller outputs in open drain versus totem pole.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
> index 119de3d7f9dd..12851c43a612 100644
> --- a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
> @@ -25,6 +25,12 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  open-drain:
> +    type: boolean
> +    description:
> +      Configure the outputs with open-drain structure, if omitted totem pole
> +      structure is used.
> +

There's one other PWM with 'open-drain' so move the definition to 
pwm.yaml.

Alternatively, 'drive-open-drain' is a much more commonly used 
variation.

Another thing to consider is for any PWM controller with more than 
1 output, you might want this to be per output and therefore should be 
a flag in the cells.

Rob

