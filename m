Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B2E5F7B96
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Oct 2022 18:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJGQhN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Oct 2022 12:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJGQhN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Oct 2022 12:37:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0811A2A702;
        Fri,  7 Oct 2022 09:37:11 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8EE7EBBE;
        Fri,  7 Oct 2022 18:37:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1665160629;
        bh=97pBNmV86ZVOaN6D4MpiNCBGOD0ODinP3LiNmN/vpLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ee22JhDOhnYR/K/k+LlBrNKDbjJHUe1V3rK+T1JtDqjfc8hU3Ye07BUQpwGwGp8OL
         FvccFRJPj77oLpXzTjA3nuVJXuhbSGx2PwsDpZht3leklhX86nYZV5/rRLfQg5SXrd
         hqZ0Pc20MheOjEcwu0azX7S1hvjw3H+JuDFnz/O8=
Date:   Fri, 7 Oct 2022 19:37:04 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: renesas,tpu: Add r8a779g0 support
Message-ID: <Y0BVsLW6KRdxiU3s@pendragon.ideasonboard.com>
References: <f5ad691051f69f2dbfcb5c5a722960bd9cd41b06.1665156364.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5ad691051f69f2dbfcb5c5a722960bd9cd41b06.1665156364.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Fri, Oct 07, 2022 at 05:26:37PM +0200, Geert Uytterhoeven wrote:
> Document support for the 16-Bit Timer Pulse Unit (TPU) in the Renesas
> R-Car V4H (R8A779G0) SoC.
> 
> Based on a patch in the BSP by CongDang.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Easy enough.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> index c6b2ab56b7feade7..a3e52b22dd180422 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> @@ -40,6 +40,7 @@ properties:
>            - renesas,tpu-r8a77970  # R-Car V3M
>            - renesas,tpu-r8a77980  # R-Car V3H
>            - renesas,tpu-r8a779a0  # R-Car V3U
> +          - renesas,tpu-r8a779g0  # R-Car V4H
>        - const: renesas,tpu
>  
>    reg:

-- 
Regards,

Laurent Pinchart
