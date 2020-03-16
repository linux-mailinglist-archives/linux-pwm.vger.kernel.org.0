Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94689186919
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2020 11:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgCPKbE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Mar 2020 06:31:04 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34952 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbgCPKbE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 06:31:04 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 49C22A3B;
        Mon, 16 Mar 2020 11:31:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1584354662;
        bh=TKrls43C5f1/bWmKF3TeVnSLC0R214JGxpZXZHFtiNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SU5AT+764RDUnnP6lkjjCtKTX2fCDjQllsT2uNzha4m6f+iCtMI5odDOIebPhx4Xt
         EW7cAmntrTBW8y06SpOTtyusiGSNfkdOapBYZNAJP1F21qOWtD06z81Q8DaC8EZOC1
         c7Cz1UJg9Y+80PhNL/0l8kHXqnKmW6H36YS4Ee2Y=
Date:   Mon, 16 Mar 2020 12:30:56 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: renesas-tpu: Document more R-Car Gen2
 support
Message-ID: <20200316103056.GU4732@pendragon.ideasonboard.com>
References: <20200316101453.27745-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200316101453.27745-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Mon, Mar 16, 2020 at 11:14:53AM +0100, Geert Uytterhoeven wrote:
> All R-Car Gen2 SoCs have a Renesas Timer Pulse Unit.
> Document support for the missing variants.
> 
> No driver change is needed due to the fallback compatible string.

I think this sentence doesn't belong to the bindings patch.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Tested on R-Car M2-W.

What do you mean by tested, how do you test bindings on hardware ? :-)

> ---
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> index 4969a954993cb693..4bf62a3d5bba8e3a 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
> @@ -19,6 +19,10 @@ properties:
>            - renesas,tpu-r8a7744   # RZ/G1N
>            - renesas,tpu-r8a7745   # RZ/G1E
>            - renesas,tpu-r8a7790   # R-Car H2
> +          - renesas,tpu-r8a7791   # R-Car M2-W
> +          - renesas,tpu-r8a7792   # R-Car V2H
> +          - renesas,tpu-r8a7793   # R-Car M2-N
> +          - renesas,tpu-r8a7794   # R-Car E2
>            - renesas,tpu-r8a7795   # R-Car H3
>            - renesas,tpu-r8a7796   # R-Car M3-W
>            - renesas,tpu-r8a77965  # R-Car M3-N

-- 
Regards,

Laurent Pinchart
