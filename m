Return-Path: <linux-pwm+bounces-5597-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC6A94E52
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 10:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F08A16FFFC
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 08:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5814A20FA96;
	Mon, 21 Apr 2025 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WW1nk0Mj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1776F5234;
	Mon, 21 Apr 2025 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745225777; cv=none; b=D2jHcZtvHX609N/V+GUqVNxHbot82naApf1GkJ77jp1dTYGuW+9SOyWkTguMtK1gE2TQ3ezgjJdZbIHvrmKu/qUHrT2sgcspX1YYlNYGfUcBol+YyBrTjWlwGJm2eItbrKZgJa8taRymZjyvAvSXy/9trTXndj+e2XCDkRCdJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745225777; c=relaxed/simple;
	bh=I9ZK2oC1PT/LtiEJr/C3hAm3LGHTFplYIKxdYHEhFGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zpgv6aaIygxzmtkswuZvZ/bjFQugRmxaaRlB8vCDho2CGMGPdGdHCVx7oetNT74i+YHhQZEOHrmmyFqZP4Ew0G5p9edd8gmapEzHx7nfpf4Rpeb0V8tgiDfEa6oBeUlnreYl39Cye/isIbtgXk1ncwOhNIz+76d3rRMgKuJnzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=WW1nk0Mj; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9AE2D56D;
	Mon, 21 Apr 2025 10:54:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745225640;
	bh=I9ZK2oC1PT/LtiEJr/C3hAm3LGHTFplYIKxdYHEhFGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WW1nk0MjOc4bburKPo2kNek06wYZbNDDADDnFrSdWLweSM/yITBX7KsN06XTYIsFX
	 D4iVIKJmE0R+o7zmsWciTbkI0hNYQP9huBSTaWDfc6ABmmSOb+Rv9+vdKCJ9nGDfb5
	 dgQ2TBvTbPz62d0Is4Ur5B0XXTfYvfAPo/Bfkk0s=
Date: Mon, 21 Apr 2025 11:56:05 +0300
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
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 01/17] dt-bindings: mfd: adp5585: ease on the required
 properties
Message-ID: <20250421085605.GA29968@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-1-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-1-3a799c3ed812@analog.com>

Hi Nuno,

Thank you for the patch.

On Tue, Apr 15, 2025 at 03:49:17PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> It is not mandatory to use all the capabilities of the device. One can
> very well only use it as a gpio controller without the PWM support. This
> will be even more evident when support for the matrix keymap is added.
> Hence drop the requirements for PWM and GPIO.

This seems to make sense.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I however expected changes in this series to *not* register MFD cells
for the devices not enabled in DT. Could you do so in v3, on top of this
patch ?

> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/mfd/adi,adp5585.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> index ee2272f754a339569c793102928ddd13249f8fee..e30e22f964f78519b2ec207e9415e4897db5c702 100644
> --- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> @@ -52,9 +52,6 @@ patternProperties:
>  required:
>    - compatible
>    - reg
> -  - gpio-controller
> -  - "#gpio-cells"
> -  - "#pwm-cells"
>  
>  allOf:
>    - if:

-- 
Regards,

Laurent Pinchart

