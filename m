Return-Path: <linux-pwm+bounces-2649-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C21B91E7B6
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 20:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC58281549
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 18:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F2E16EB67;
	Mon,  1 Jul 2024 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1i8joHi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B53381CC;
	Mon,  1 Jul 2024 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858992; cv=none; b=uSrrl02hWLTOp0OEEF6dRL9RY5+xzravBRJYhc+uz2YKM76AFpw4AX5JQiitKM5n4xvBQU7RWy4vNEHqWKb8bS5ONzXiqN4GhMKjYicZurG7RyDPtwnXjb2BV7SPjkx+XB9fp+RnJiN+I9/iWpYcAhpbASrPW/uTHiP++b4R2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858992; c=relaxed/simple;
	bh=PtmpIxW7QtZRZGSwCmMzSgdpUv310aGaJeYhAgzViwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhBjwx882Cqjw9IK2IVZFqvupjfStoMlSwaN56msZQl5nhFO91+gln30VSY1qy2dLYtHCsniBlY6+SLiQqBThWbZGMdqWgnh69Ts+GNNmJ6B6GVOytcdk7NHowrKFyczPdgas0O2CPtFjgu4TItfVsV+T6dvmSTxlD5jgFJha+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1i8joHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2892AC116B1;
	Mon,  1 Jul 2024 18:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719858992;
	bh=PtmpIxW7QtZRZGSwCmMzSgdpUv310aGaJeYhAgzViwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1i8joHio0IzCMxKBhGEFgei3HHw7ygdeCR3CAglvJMsZFMYe6bgeaLT8w3eXH8uZ
	 0wnahBan1xLupL68xx3DPMJtL3CdwHHZNTXRfJM1Ys//jPd9y4PSzyaZtVrQ48aabu
	 dpaTvX3D18/ZGJc1HfXl3f6o2SHUNZBfBHaXSTLLW9L2VflxGGc96B7kXiLlHEyVSK
	 1amC0DpO7Yq2VTIiISBHuf52YjNgZaYJrDn5Gf5i8VjBP1ULbVqjKWThpJmNqeWJfj
	 FebHhcKrJDdGsVOgT1jMyStSml6H77i7COpyZHcWldp7RIAIHfTrmw7jdvAp6EKzSY
	 8B8fbD1hfXGsw==
Date: Mon, 1 Jul 2024 12:36:31 -0600
From: Rob Herring <robh@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: ukleinek@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	neil.armstrong@linaro.org, khilman@baylibre.com,
	jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
	hkallweit1@gmail.com, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@salutedevices.com
Subject: Re: [PATCH v2 2/3] dt-bindings: pwm: amlogic: Add optional
 power-domains
Message-ID: <20240701183631.GA349021-robh@kernel.org>
References: <20240701172016.523402-1-gnstark@salutedevices.com>
 <20240701172016.523402-3-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701172016.523402-3-gnstark@salutedevices.com>

On Mon, Jul 01, 2024 at 08:20:15PM +0300, George Stark wrote:
> On newer SoCs, the PWM can require a power-domain to operate so add it
> as optional.

If required, then how is it optional?

If the 'newer SoCs' means the one you just added, then this should be 
squashed into the prior patch with a conditional schema making it 
required for the new compatible.

> 
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> index da22cb3ed878..c814d88748dd 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> @@ -60,6 +60,9 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  power-domains:
> +    maxItems: 1
> +
>    "#pwm-cells":
>      const: 3
>  
> -- 
> 2.25.1
> 

