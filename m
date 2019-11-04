Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFCCEDA48
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2019 09:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfKDIEK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Nov 2019 03:04:10 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38187 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfKDIEK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Nov 2019 03:04:10 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iRXLF-0006NS-DR; Mon, 04 Nov 2019 09:04:01 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iRXLD-0007VH-Qm; Mon, 04 Nov 2019 09:03:59 +0100
Date:   Mon, 4 Nov 2019 09:03:59 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/7] dt-bindings: pwm: allwinner: Add H6 PWM
 description
Message-ID: <20191104080359.6kjugbt3yi63ywhb@pengutronix.de>
References: <20191103203334.10539-1-peron.clem@gmail.com>
 <20191103203334.10539-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191103203334.10539-2-peron.clem@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Nov 03, 2019 at 09:33:28PM +0100, Clément Péron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> H6 PWM block is basically the same as A20 PWM, except that it also has
> bus clock and reset line which needs to be handled accordingly.
> 
> Expand Allwinner PWM binding with H6 PWM specifics.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 45 ++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> index 0ac52f83a58c..bf36ea509f31 100644
> --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> @@ -30,13 +30,46 @@ properties:
>        - items:
>            - const: allwinner,sun50i-h5-pwm
>            - const: allwinner,sun5i-a13-pwm
> +      - const: allwinner,sun50i-h6-pwm
>  
>    reg:
>      maxItems: 1
>  
> -  clocks:
> +  # Even though it only applies to subschemas under the conditionals,
> +  # not listing them here will trigger a warning because of the
> +  # additionalsProperties set to false.
> +  clocks: true
> +  clock-names: true
> +  resets:
>      maxItems: 1
>  
> +  if:
> +    properties:
> +      compatible:
> +        contains:
> +          const: allwinner,sun50i-h6-pwm
> +
> +  then:
> +    properties:
> +      clocks:
> +        items:
> +          - description: Module Clock
> +          - description: Bus Clock
> +
> +      clock-names:
> +        items:
> +          - const: mod
> +          - const: bus
> +
> +    required:
> +      - clock-names
> +      - resets
> +
> +  else:
> +    properties:
> +      clocks:
> +        maxItems: 1
> +

I guess this hunk says "If this is a allwinner,sun50i-h6-pwm, a mod and
bus clock is required.", right?

I wonder if it is sensible to require a clock-names property in the else
branch, too. This would make it obvious if the clock there corresponds
to the "mod" or the "bus" clock on H6. (I guess it's "mod".)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
