Return-Path: <linux-pwm+bounces-3057-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380919608C6
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Aug 2024 13:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACCB1C2265E
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Aug 2024 11:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE711A01B4;
	Tue, 27 Aug 2024 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euYT819M"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621619FA90;
	Tue, 27 Aug 2024 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758435; cv=none; b=LnUQIl/u9WBK9ameGMAJ9TI+Fnxkx2DTXVHKunyWyNZO01MRWUddGlNnXcmUT6uB/MH1tirvMn6mqJuZGJ0lUYX6z18jOtsWAqGjpdPYDDl/pQ6bMPMmAwHfbwziVdnl8Uzbq/z6MtL5t/1s37fWKs8Y/ENl4lQVIcYeJhAiKZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758435; c=relaxed/simple;
	bh=AK6PhqtQdoRJ9EMaF0NPz8m5pnwJXtpiPu95PXkC+Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc9p8mjrfYjkpkG++KAe+YHSQJ+uLuPCEWa9t6GslYr49pHTrvtampIvA4Aznggy0w2fXfa/2QVnwgZSB9kXDTRhwAZhs7BpJ1wozXGJsJ+4/RazBW13WqEonOplXOUP8djPjKM1v+BmY7XBbz8LCYMpU4DNPLFdeTnd0d8NVtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euYT819M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78159C8B7B8;
	Tue, 27 Aug 2024 11:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724758435;
	bh=AK6PhqtQdoRJ9EMaF0NPz8m5pnwJXtpiPu95PXkC+Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=euYT819MBeH+KhyboXmRZVJAo8YHvwTHo1D8LXSudfRThCnixq/KFw2/cXm2s10Lm
	 BYqV94DYEGhV3Q3JXKbjtaPYcln01texUFPZtiXnGuP6rpLtV3fZqs7o1i+6/VxUTg
	 YEahmX77L9ls3xDRnOt6EddDDNXbzEL4ljoLDSQL26mBIA/skEoJOuha4IJ19eFlxU
	 VL8zYziQ5HsmrqnSJJMy2KLeIGanL82mnaiX+M1DcO7AbsZlI5V29NLg6lMWbGJGzr
	 p9Flj1np7bJ42da6ysziXzJgdB4zeKsePCHoEb5+qDKikw9ku9JIxjP0eCLs97msd3
	 eh5pMtlKQS0wA==
Date: Tue, 27 Aug 2024 13:33:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: haibo.chen@nxp.com
Cc: laurent.pinchart@ideasonboard.com, lee@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: mfd: adp5585: Add parsing of hogs
Message-ID: <6xk5b5tl4ozcziejdejvr3en4vncnf3eypgp7rnv3oyhfgqsl4@ab5abftw3elz>
References: <20240827061710.2091661-1-haibo.chen@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827061710.2091661-1-haibo.chen@nxp.com>

On Tue, Aug 27, 2024 at 02:17:10PM +0800, haibo.chen@nxp.com wrote:
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
> index f9c069f8534b..815a39c18556 100644
> --- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> @@ -42,6 +42,13 @@ properties:
>    "#pwm-cells":
>      const: 3
>  
> +patternProperties:
> +  "^(.+-hog(-[0-9]+)?)$":

Over-complicated regex.

https://elixir.bootlin.com/linux/v6.9-rc3/source/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml#L45

Best regards,
Krzysztof


