Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4641891A7
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 23:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgCQW5E (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 18:57:04 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:59434 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgCQW5E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 18:57:04 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 02333F9;
        Tue, 17 Mar 2020 23:57:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1584485822;
        bh=LkGALHj3ZbXtSeBxaDQ/2X+mEFinyF7ObC7hBw1Ives=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rnTSNTlUYdXRicamiaFRw+BvmOlabFDpWfrQfE51i7c3B8LsxmLase1kq9CXypUEW
         wp7KuJpbaYS1QKPkZyKOMc4ElMrSGR9rr8KNJAo+gf/I7idaoSjEOd22PMHjGib/B9
         ObH4Lf3m7tL7pGQLm9bS0uKmfL7KWqZtcf0eKTkE=
Date:   Wed, 18 Mar 2020 00:56:56 +0200
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
Subject: Re: [RFC PATCH 3/7] dt-bindings: pwm: add normal PWM polarity flag
Message-ID: <20200317225656.GK2527@pendragon.ideasonboard.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-4-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200317123231.2843297-4-oleksandr.suvorov@toradex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Oleksandr,

Thank you for the patch.

On Tue, Mar 17, 2020 at 02:32:27PM +0200, Oleksandr Suvorov wrote:
> PWM can have a normal polarity and a reverted one. The reverted polarity
> value is defined.

As mentioned by Paul, I'd use "inverted" instead of "reverted". Your
patch series is trying to standardized on "inverted", let's not add
another term :-)

I would squash this patch with 2/7, apart from that it looks fine.
However, I also agree with Thierry that the PWM cell that contains this
value is a bitmask, so once we get more flags it may get a bit awkward.
Will we have one macro for each flag that will evaluate to 0 to report
that the flag isn't set ? Or should we define a single PWM_FLAG_NONE (or
similarly named) macro ? In retrospect, maybe PWM_POLARITY_INVERTED
should have been named PWM_FLAG_POLARITY_INVERTED.

> Define the PWM_POLARITY_NORMAL to be used further.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> ---
> 
>  include/dt-bindings/pwm/pwm.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
> index ab9a077e3c7d..6b58caa6385e 100644
> --- a/include/dt-bindings/pwm/pwm.h
> +++ b/include/dt-bindings/pwm/pwm.h
> @@ -10,6 +10,7 @@
>  #ifndef _DT_BINDINGS_PWM_PWM_H
>  #define _DT_BINDINGS_PWM_PWM_H
>  
> +#define PWM_POLARITY_NORMAL			0
>  #define PWM_POLARITY_INVERTED			(1 << 0)
>  
>  #endif

-- 
Regards,

Laurent Pinchart
