Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8001D43D6D4
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Oct 2021 00:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhJ0Wmr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 Oct 2021 18:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJ0Wmr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 Oct 2021 18:42:47 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBFBC061570;
        Wed, 27 Oct 2021 15:40:20 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 37D1B276;
        Thu, 28 Oct 2021 00:40:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1635374419;
        bh=cgfzfPTYFWpAz32L+LDnJuLL6i8dVMB3/l5Al2OTt7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QsTvmPmJe9OPunKZgMpJVYA+m+Eo9RkKB4Q+t4xfpEjfbE5RhWeROfsZPJ4LwDjxI
         F6nthIKCjtme470diNojVj3Vt3GlWALkgBPhspAaY+tIiawFhoq1vmM70JKcsM2k1R
         rP7D3+IFb0f/UMPm5lcgYFDeolg7hlg44YIxgh8c=
Date:   Thu, 28 Oct 2021 01:39:55 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: tpu: Add R-Car M3-W+ device tree
 bindings
Message-ID: <YXnVO19gYMc8aDdX@pendragon.ideasonboard.com>
References: <622e5ac9a841e874f772e0d9d200200706914dac.1635337701.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <622e5ac9a841e874f772e0d9d200200706914dac.1635337701.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wed, Oct 27, 2021 at 02:29:22PM +0200, Geert Uytterhoeven wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Add device tree bindings for TPU found on R-Car M3-W+ SoCs.
> 
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> index 0171a04257b808e7..1f5c6384182e013a 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> @@ -35,6 +35,7 @@ properties:
>            - renesas,tpu-r8a7794   # R-Car E2
>            - renesas,tpu-r8a7795   # R-Car H3
>            - renesas,tpu-r8a7796   # R-Car M3-W
> +          - renesas,tpu-r8a77961  # R-Car M3-W+
>            - renesas,tpu-r8a77965  # R-Car M3-N
>            - renesas,tpu-r8a77970  # R-Car V3M
>            - renesas,tpu-r8a77980  # R-Car V3H

-- 
Regards,

Laurent Pinchart
