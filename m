Return-Path: <linux-pwm+bounces-3059-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D1E961F0A
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Aug 2024 08:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE73A1F2469B
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Aug 2024 06:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55FA15530C;
	Wed, 28 Aug 2024 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdWvGxD8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2E14F12F;
	Wed, 28 Aug 2024 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825226; cv=none; b=UDKyssYvfLRx6j2Dd940nH8KA6ODKx8oBDLwm7YM8JcpBZ590MuDIir6g+HF7LN/H05bH/fj9gFikvIBgiHxkEkw9Xv5x4b9fCdJnIup812UmUTfv0aGDka2HRE5JVgJLKqTVB8mWfKFSrsGO4kiJAnS0/BMcZZI88wmn/cnFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825226; c=relaxed/simple;
	bh=ToM86BOW2G76tm5IRZWQ9pOJ3jMo74NW5cB5i3zKHcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEnZNj1v5TG4PZeiEUfz1MkXDuENGvJ86JcsMIWaTXkTwMZqOh+zpXVsHT5mNGWkN7mCxmzOTXNwabpBFBcPTv/PyZZN+JGLOqSxkJRQUHVyTaVsHkSXp1vnssRbWGAHVm3Zdu+cySWbp5ardKyqCOiu5H5pcZ5LVjjfNAH65Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdWvGxD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30260C4AF13;
	Wed, 28 Aug 2024 06:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825226;
	bh=ToM86BOW2G76tm5IRZWQ9pOJ3jMo74NW5cB5i3zKHcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rdWvGxD8qnXWkOkb2D2xNskRt2utApMAFzKAk+IpFKB4PXbFPXts+FJArv1dAc9Rk
	 mHFY4E+ZCM2isq0IFR+NlHB/bGiswYBAw5yoyieyKOYQbYIVpj0sl4XcFPqqgtIGIE
	 6O6X2HSdzK4r7Ai6wnUok4GetMf8vBSg0ehtyBgqcCbis7P0b0LqBMPyUl4pjEqeUl
	 JgnHszGQ3kDQLLFX7SOqFNA6NJN2NINYAODlYYZfArjwNIes977z87gtmRjL8SJytS
	 ONoCMMYqPUEquX8iwpjQ4zAKa4lq1EhQRxez0SSn+VJJCWO2g7o6cFGNgI3yaZbX+7
	 VG6ummL7bz1bQ==
Date: Wed, 28 Aug 2024 08:07:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: haibo.chen@nxp.com
Cc: laurent.pinchart@ideasonboard.com, lee@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev
Subject: Re: [PATCH v2] dt-bindings: mfd: adp5585: Add parsing of hogs
Message-ID: <m65v3odvubmcoafe3gzhcsyu63iggamoadzdufo7h2lcffyfvo@vqzi73apacws>
References: <20240828030405.2851611-1-haibo.chen@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828030405.2851611-1-haibo.chen@nxp.com>

On Wed, Aug 28, 2024 at 11:04:05AM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Allow parsing GPIO controller children nodes with GPIO hogs.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  Documentation/devicetree/bindings/mfd/adi,adp5585.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> index f9c069f8534b..ee2272f754a3 100644
> --- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> @@ -42,6 +42,13 @@ properties:
>    "#pwm-cells":
>      const: 3
>  
> +patternProperties:
> +  "-hog(-[0-9]+)?$":
> +    type: object

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


