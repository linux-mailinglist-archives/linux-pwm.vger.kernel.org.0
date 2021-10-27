Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B9843D6CF
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Oct 2021 00:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhJ0Wmd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 Oct 2021 18:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhJ0Wmd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 Oct 2021 18:42:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242BFC061570;
        Wed, 27 Oct 2021 15:40:07 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 286B3276;
        Thu, 28 Oct 2021 00:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1635374403;
        bh=jnLPKc9lqfUuJXUmQ4Sx8eLrQsKGPZCtQyGXfQ6SkDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDnRaW2jyMVdi09tU4LMyHb5cIJhZmnjMuBZlwQPgc1qp0UjMcFPwHZUS9T6EJX56
         kKeOa1ld1Do97pD8IAhfzPazHNnts065A6ahs3xAOrg0gIywEsywTlOyu6TV7FzHWh
         cnbMRkgUd88Zq9w/17KWmf6vqGwQ5wYccwoHecnY=
Date:   Thu, 28 Oct 2021 01:39:39 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: tpu: Add R-Car V3U device tree bindings
Message-ID: <YXnVK41hi/425wDQ@pendragon.ideasonboard.com>
References: <8ec1e2aadfc894a3cc8c412e266b87220fa0404e.1635337616.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ec1e2aadfc894a3cc8c412e266b87220fa0404e.1635337616.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wed, Oct 27, 2021 at 02:28:09PM +0200, Geert Uytterhoeven wrote:
> From: Duc Nguyen <duc.nguyen.ub@renesas.com>
> 
> Add device tree bindings for TPU with the PWM controller found
> on R-Car V3U SoCs.
> 
> Signed-off-by: Duc Nguyen <duc.nguyen.ub@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> index 81ccb2110162c3eb..0171a04257b808e7 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> @@ -38,6 +38,7 @@ properties:
>            - renesas,tpu-r8a77965  # R-Car M3-N
>            - renesas,tpu-r8a77970  # R-Car V3M
>            - renesas,tpu-r8a77980  # R-Car V3H
> +          - renesas,tpu-r8a779a0  # R-Car V3U
>        - const: renesas,tpu
>  
>    reg:

-- 
Regards,

Laurent Pinchart
