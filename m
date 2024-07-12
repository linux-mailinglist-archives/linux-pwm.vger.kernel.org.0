Return-Path: <linux-pwm+bounces-2784-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D9592FC45
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 16:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79B7AB229EA
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 14:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56039171653;
	Fri, 12 Jul 2024 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snYEw/rq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E9A17164E;
	Fri, 12 Jul 2024 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793342; cv=none; b=izJDZVm4xBki4jsj2T9yrilppyXhY6C3FscAxq9x7ecFtRBYKzqyM62FznCoYH72zL10Xs0OKPcb/QYT9GKU2/ccwpeewWUP3Yz2W76eY2gcFlPzHMBEdyprTF7Ta+YSnhHS9sgoOgLM0bvSv8tGf7/we+DdTZgKSE5J5pLlsDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793342; c=relaxed/simple;
	bh=fJ7W7ObBwRXepJekHDsIU7vAlTSyciIHK+CeROsPYPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1f0IhEnEuVmEWdSP6wlTe/HBCEeRa1EFkZQmFd0UyEOO7wDnTy63yHH3ckw+9zgDJ8XVGGWGu0fuWtfoX/JR3QskEnGF/xbJCSJFCucZqbYuMdAFesloRsbBv9GLDRdLCfVWKWYP2lNNBYGxJfw8/7pk1H+qJNa47nPTMWh/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snYEw/rq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60CCC32782;
	Fri, 12 Jul 2024 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720793342;
	bh=fJ7W7ObBwRXepJekHDsIU7vAlTSyciIHK+CeROsPYPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snYEw/rqVt4S8dTJWWYRjP2noAGoi4FceMKXG/IAMhNarcsemBvWEhYBn+UTenVjf
	 dt0l1aaKItOloWZCx8Xyksy8n+CMDlsRM6PhAwJCAfoT6wnQ0mnht5LLzVeAkdmfH+
	 ita1j76MzS5PGVSVfQewJ3GciuFD5YoSi11le8UCRBmo9rsQD30HB/oFObj2WXyA9F
	 4/lqqodCTiyQLPavNFur/Ly1zoSRbNVu3rC/H/+Km736S63I56ZCIkOSyUVnxGZCLW
	 hFaTqfWI8EpJZjuIs/UDojpRF6qcrmXWIDyVNZnVIzpWN9ATqWLqp6YzlbGq83cUG4
	 5F5+YicrfSFzw==
Date: Fri, 12 Jul 2024 08:09:00 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: pwm: imx: Add compatible string
 imx8qxp-mipi-pwm
Message-ID: <20240712140900.GB595171-robh@kernel.org>
References: <20240711-pwm-v1-0-4d5766f99b8b@nxp.com>
 <20240711-pwm-v1-1-4d5766f99b8b@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711-pwm-v1-1-4d5766f99b8b@nxp.com>

On Thu, Jul 11, 2024 at 05:08:56PM -0400, Frank Li wrote:
> The pwm in imx8qxp mipi subsystem require one extra '32k' clock. So add
> compatible string 'imx8qxp-mipi-pwm'. Increase maxItems for clock and
> clock-names. Add allOf check to make sure other compatible string keep the
> same restriction.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 29 +++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> index 04148198e34d0..750636985f937 100644
> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> @@ -9,9 +9,6 @@ title: Freescale i.MX PWM controller
>  maintainers:
>    - Philipp Zabel <p.zabel@pengutronix.de>
>  
> -allOf:
> -  - $ref: pwm.yaml#
> -
>  properties:
>    "#pwm-cells":
>      description:
> @@ -42,6 +39,7 @@ properties:
>                - fsl,imx8mp-pwm
>                - fsl,imx8mq-pwm
>                - fsl,imx8qxp-pwm
> +              - fsl,imx8qxp-mipi-pwm

I'm not sure I'd do a new compatible for this. Is the instance really 
different? It's fine if some instances have an optional clock.

Rob

