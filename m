Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C1E16A21
	for <lists+linux-pwm@lfdr.de>; Tue,  7 May 2019 20:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfEGS1V (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 May 2019 14:27:21 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:39660 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfEGS1V (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 May 2019 14:27:21 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 31EC0803C6;
        Tue,  7 May 2019 20:27:14 +0200 (CEST)
Date:   Tue, 7 May 2019 20:27:13 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Claudiu.Beznea@microchip.com,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, thierry.reding@gmail.com,
        lee.jones@linaro.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH v3 0/6] add LCD support for SAM9X60
Message-ID: <20190507182713.GA16862@ravnborg.org>
References: <1556195748-11106-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556195748-11106-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8
        a=KFo_gGakGootahdhYqwA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
        a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry.

>   pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's PWM
OK to add the "pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's PWM"
patch via drm-misc?
Then we can add all 6 patches in one go.

	Sam

(Kept remaining of mail for reference)
> 
> Hi,
> 
> These patches adds support for SAM9X60's LCD controller.
> 
> First patches add option to specify if controller clock source is fixed.
> Second patch avoid a variable initialization in atmel_hlcdc_crtc_mode_set_nofb().
> The 3rd add compatibles in pwm-atmel-hlcdc driver.
> The 4th patch enables sys_clk in probe since SAM9X60 needs this.
> Specific support was added also in suspend/resume hooks.
> The 5th patch adds SAM9X60's LCD configuration and enabled it.
> 
> I took the changes of this series and introduced also a fix
> (this is the 6th patch in this series) - if you want to send it separately
> I would gladly do it.
> 
> I resend this to also include Lee Jones for pwm-atmel-hlcdc changes.
> 
> Thank you,
> Claudiu Beznea
> 
> Changes in v3:
> - keep compatible string on patch 3/6 on a single line (I keep here a tab
>   in front of ".compatible" to be aligned with the rest of the code in
>   atmel_hlcdc_dt_ids[])
> - patches 4/7 and 3/7 from v2 were applied so remove them from this version
> - add a fix for atmel_hlcdc (patch 6/6)
> 
> Changes in v2:
> - use "|" operator in patch 1/7 to set ATMEL_HLCDC_CLKSEL on cfg
> - collect Acked-by, Reviewed-by tags
> 
> Claudiu Beznea (4):
>   drm: atmel-hlcdc: add config option for clock selection
>   drm: atmel-hlcdc: avoid initializing cfg with zero
>   pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's PWM
>   drm/atmel-hclcdc: revert shift by 8
> 
> Sandeep Sheriker Mallikarjun (2):
>   drm: atmel-hlcdc: enable sys_clk during initalization.
>   drm: atmel-hlcdc: add sam9x60 LCD controller
> 
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c  |  18 ++--
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c    | 120 +++++++++++++++++++++++-
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h    |   2 +
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c |   2 +-
>  drivers/pwm/pwm-atmel-hlcdc.c                   |   1 +
>  5 files changed, 132 insertions(+), 11 deletions(-)
> 
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
