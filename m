Return-Path: <linux-pwm+bounces-4640-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9433AA14B1B
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 09:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDD6166D14
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 08:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34981F8920;
	Fri, 17 Jan 2025 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OwA1i5Wn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F711F6686;
	Fri, 17 Jan 2025 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737102438; cv=none; b=cL5m/OVYt3vN4it16wEtcL7SCWZ6sHhDyIQ/yuHCsWuPQQLKFE44Dh7Ksj/X7R/sQZxqGikhse0VHfxKB2rL0a9QMpWG0eSHJKr78knHnqWRfuCJSs84E6WlRhmiSHshDjSxUr+LboJDEK2rDswbJZUARQj4MEqEaGJNRsgAVwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737102438; c=relaxed/simple;
	bh=Xk4G2fPvBtHZOC1vN27DUSwpcLs1inWzAcEnMDQfeAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J0wPdmCi64KFRqajZdXCwfM2zL7UWNEWTYJJMb2UQgWZhWz3Z+/ajrO+JoVGo9yGQNt1gTRnzAvd4lzJMmme+3vELZ7PyyaVMDKxlkUNtZ9jX7j0TBkHJlJCOm3DYGlrYokayNADcd8/yfyEPy5KgI0UEKKr7Iq8mfrRNLjAv1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OwA1i5Wn; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5EE0C1C0002;
	Fri, 17 Jan 2025 08:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737102427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qaIpPOSpq9MWqlSnlayKk2Pj8EJtBTTEujrFPq0fHoo=;
	b=OwA1i5Wnz7oO8tgopYa0EmT/rxq6imJN3cSccLTrw9VGbFcpxW6QAlNM0WyZwz3YN99km2
	6MODIE7dTcslLqAI2ZI+Qd1OQvhv/qj0uN9oOIcFqXrhC5eUSqRS+MDMgW/iB9NxyTeQ3w
	BXXux/WXprSKMxtg1w2cdkn+V4KBjF0ZSd3IoJEZAAtOQJ0CcSwd4E1e6CdzanltANOsq2
	IhSd30cNbUTjEuMGLg0NpK18oSVpRbe3dMbZh/iz4Wv6v+7CXQ76NMpdBySmtTF7szmRF4
	SwRbWIeDU2euRpT1w3MVMQv4L4VEA1GcGulXJCkTqP8LqiExsFnOsGTmQ4n94w==
Date: Fri, 17 Jan 2025 09:27:04 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 u.kleine-koenig@baylibre.com
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/1] pwm: Add support for pwm nexus dt bindings
Message-ID: <20250117092704.2b4a1a1c@bootlin.com>
In-Reply-To: <20250108161853.431915-1-herve.codina@bootlin.com>
References: <20250108161853.431915-1-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi All,

I haven't receive any feedback on this patch neither the v1 nor this v2.

Maybe an issue with the mail. Add u.kleine-koenig@baylibre.com and hope to
have a feedback on this patch.

Best regards,
Hervé

On Wed,  8 Jan 2025 17:18:53 +0100
Herve Codina <herve.codina@bootlin.com> wrote:

> Platforms can have a standardized connector/expansion slot that exposes
> signals like PWMs to expansion boards in an SoC agnostic way.
> 
> The support for nexus node [1] has been added to handle those cases in
> commit bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through
> a nexus node"). This commit introduced of_parse_phandle_with_args_map()
> to handle nexus nodes in a generic way and the gpio subsystem adopted
> the support in commit c11e6f0f04db ("gpio: Support gpio nexus dt
> bindings").
> 
> A nexus node allows to remap a phandle list in a consumer node through a
> connector node in a generic way. With this remapping supported, the
> consumer node needs to knwow only about the nexus node. Resources behind
> the nexus node are decoupled by the nexus node itself.
> 
> This is particularly useful when this consumer is described in a
> device-tree overlay. Indeed, to have the exact same overlay reused with
> several base systems the overlay needs to known only about the connector
> is going to be applied to without any knowledge of the SoC (or the
> component providing the resource) available in the system.
> 
> As an example, suppose 3 PWMs connected to a connector. The connector
> PWM 0 and 2 comes from the PWM 1 and 3 of the pwm-controller1. The
> connector PWM 1 comes from the PWM 4 of the pwm-controller2. An
> expansion device is connected to the connector and uses the connector
> PMW 1.
> 
> Nexus node support in PWM allows the following description:
> 	soc {
> 		soc_pwm1: pwm-controller1 {
> 			#pwm-cells = <3>;
> 		};
> 
> 		soc_pwm2: pwm-controller2 {
> 			#pwm-cells = <3>;
> 		};
> 	};
> 
> 	connector: connector {
> 		#pwm-cells = <3>;
> 		pwm-map = <0 0 0 &soc_pwm1 1 0 0>,
> 			  <1 0 0 &soc_pwm2 4 0 0>,
> 			  <2 0 0 &soc_pwm1 3 0 0>,
> 		pwm-map-mask = <0xffffffff 0x0 0x0>;
> 		pwm-map-pass-thru = <0x0 0xffffffff 0xffffffff>
> 	};
> 
> 	expansion_device {
> 		pwms = <&connector 1 57000 0>;
> 	};
> 
> From the expansion device point of view, the PWM requested is the PWM 1
> available at the connector regardless of the exact PWM wired to this
> connector PWM 1. Thanks to nexus node remapping described at connector
> node, this PWM is the PWM 4 of the pwm-controller2.
> 
> The nexus node remapping handling consists in handling #*-cells, *-map,
> *-map-mask and *-map-pass-thru properties. This is already supported
> by of_parse_phandle_with_args_map().
> 
> Add support for nexus node device-tree binding and the related remapping
> in the PWM subsystem by simply using of_parse_phandle_with_args_map()
> instead of of_parse_phandle_with_args().
> 
> [1] https://github.com/devicetree-org/devicetree-specification/blob/v0.4/source/chapter2-devicetree-basics.rst#nexus-nodes-and-specifier-mapping
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> Changes v1 -> v2
>   - Rework commit log
> 
>  drivers/pwm/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 9c733877e98e..4a7454841cef 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -1707,8 +1707,7 @@ static struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
>  			return ERR_PTR(index);
>  	}
>  
> -	err = of_parse_phandle_with_args(np, "pwms", "#pwm-cells", index,
> -					 &args);
> +	err = of_parse_phandle_with_args_map(np, "pwms", "pwm", index, &args);
>  	if (err) {
>  		pr_err("%s(): can't parse \"pwms\" property\n", __func__);
>  		return ERR_PTR(err);

