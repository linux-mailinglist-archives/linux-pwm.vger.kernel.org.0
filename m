Return-Path: <linux-pwm+bounces-5606-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1EDA94EBF
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 11:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCA23ABE60
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 09:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66A92135AD;
	Mon, 21 Apr 2025 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="N45W4kUH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116A1C2437;
	Mon, 21 Apr 2025 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745228207; cv=none; b=MHORkSkkCHRaVbHns9luOOAGvvYCQrAKHnXjo2QEMSFIOrSIjmOpz4lyrBkoFa6d7dJHg3/Z1wfNJpQ6VXQ3xU5MN4ZMTCMfYBMbwI0+xOhMQkPoXf+yVHRjnGPyNb4M/Z99C09G8CaLkdpmD2Je/X0ws7rJreK4WhdyljzAk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745228207; c=relaxed/simple;
	bh=7AZzAYCam1AqMuMh+YRPxGl1dCyvp2PMzHeA6fe7Aqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iv30QATG5jsdAlV0QHM7viryMHebDjgc15RAeBUz/Xkq4Ip0MTk6NHl+mB4U9ryJsyVnc2bVTYbaTjdVEZ+n2qtkEQik/WBnzYF7BgmnxqqN0XLaTafLSfyj0UTVAFTtCj3nTPNuQm8t5GAWi9xV8EQP1O0Dlp+ip+8Mjg8ZSjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=N45W4kUH; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5DC5D6D5;
	Mon, 21 Apr 2025 11:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745228078;
	bh=7AZzAYCam1AqMuMh+YRPxGl1dCyvp2PMzHeA6fe7Aqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N45W4kUH1tW7BzkmUxjMwOLXNWP689imJ9CHeqTHRfQPvOwwVG1XoWQKtgmWQV5rv
	 x0n2qyu/uSN1foRdMxlapwPUZ0LhVGZ+NA9/khql3CriVIVixbs2335aD3Z7ov9zxY
	 0/t4YZvHjhjTe+rTUZJnC4zzMD8ojIk+K7rdawno=
Date: Mon, 21 Apr 2025 12:36:43 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 15/17] dt-bindings: mfd: adp5585: document reset gpio
Message-ID: <20250421093643.GJ29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-15-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-15-3a799c3ed812@analog.com>

Hi Nuno,

Thank you for the patch.

On Tue, Apr 15, 2025 at 03:49:31PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> Add a reset gpio property. Note that for the adp5585-01 models, the
> reset pin is used as the additional ROW5 which means there's no reset.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/mfd/adi,adp5585.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> index b7c36e2d4bfc4e75c856a0b8b9c842627bf3b1b2..218d6d6399d02adf678acff67b4ee246d833d209 100644
> --- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> @@ -39,6 +39,9 @@ properties:
>  
>    vdd-supply: true
>  
> +  reset-gpios:
> +    maxItems: 1
> +
>    gpio-controller: true
>  
>    '#gpio-cells':
> @@ -166,6 +169,7 @@ allOf:
>          adi,unlock-keys: false
>          adi,unlock-trigger-sec: false
>          gpio-reserved-ranges: false
> +        reset-gpios: false
>          adi,keypad-pins:
>            minItems: 2
>            maxItems: 11

-- 
Regards,

Laurent Pinchart

