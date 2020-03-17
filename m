Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB531891B9
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2020 00:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCQXBX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 19:01:23 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59474 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgCQXBW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 19:01:22 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8D3DEF9;
        Wed, 18 Mar 2020 00:01:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1584486080;
        bh=RsBGOOoR16+F81LqfrqNie4IC7gzYPXK9gaCVKUf158=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NiSPe29FZnt7WxFSA9LrSrh6GqL5oJ2QeexNyTYle+MnyTE2TDYPZTgtIX6TayNHd
         Oy2r2WeZnwzfnJb/8gDdQ5SIrrUovWs3Blg3I8ARdKRpOtLMp1OCCLnHNEZ4DZW0nS
         lnSBNdZxNJhyk94zqQv6HZvh6EOa2aKyr7OxqS+k=
Date:   Wed, 18 Mar 2020 01:01:15 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] dt-bindings: pwm: add description of PWM polarity
Message-ID: <20200317230115.GM2527@pendragon.ideasonboard.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-5-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200317123231.2843297-5-oleksandr.suvorov@toradex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Oleksandr,

Thank you for the patch.

On Tue, Mar 17, 2020 at 02:32:28PM +0200, Oleksandr Suvorov wrote:
> Move the description of the PWM signal polarity from
> <linux/pwm.h>, prepare for removing the polarity
> definition from <linux/pwm.h>.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> ---
> 
>  include/dt-bindings/pwm/pwm.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
> index 6b58caa6385e..c07da2088a61 100644
> --- a/include/dt-bindings/pwm/pwm.h
> +++ b/include/dt-bindings/pwm/pwm.h
> @@ -10,7 +10,16 @@
>  #ifndef _DT_BINDINGS_PWM_PWM_H
>  #define _DT_BINDINGS_PWM_PWM_H
>  
> +/**
> + * a high signal for the duration of the duty-cycle, followed by a low signal
> + * for the remainder of the pulse period.
> + */

Last time I checked, kernedoc didn't support documenting macros (enums
are supported).

>  #define PWM_POLARITY_NORMAL			0
> +
> +/**
> + * a low signal for the duration of the duty-cycle, followed by a high signal
> + * for the remainder of the pulse period.
> + */
>  #define PWM_POLARITY_INVERTED			(1 << 0)
>  
>  #endif

-- 
Regards,

Laurent Pinchart
