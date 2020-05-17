Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9F61D6805
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 14:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgEQM6Q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 08:58:16 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:40454 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgEQM6Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 08:58:16 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 11C0A2004D;
        Sun, 17 May 2020 14:58:06 +0200 (CEST)
Date:   Sun, 17 May 2020 14:58:05 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Uwe Kleine Konig <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jani Nikula <jani.nikula@intel.com>,
        linux-arm-msm@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Support Opensource <support.opensource@diasemi.com>,
        patches@opensource.cirrus.com,
        Douglas Anderson <dianders@chromium.org>,
        Zheng Bin <zhengbin13@huawei.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Enrico Weigelt <info@metux.net>
Subject: Re: [PATCH v1 01/18] drm/omap: display: use devm_of_find_backlight
Message-ID: <20200517125805.GA620358@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
 <20200514191001.457441-2-sam@ravnborg.org>
 <6d733332-35d9-7799-c0e5-9f012485d738@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d733332-35d9-7799-c0e5-9f012485d738@ti.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=sozttTNsAAAA:8 a=i0EeH86SAAAA:8
        a=ag1SF4gXAAAA:8 a=ZTmiYS-oAAAA:8 a=3jHMjg6xAAAA:8 a=P1BnusSwAAAA:8
        a=e5mUnYsNAAAA:8 a=lkPWAOAZn4v6L6_uTwEA:9 a=V1nGDLRQSAgxWdh8:21
        a=k8BduORwcpa7AOfL:21 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=aeg5Gbbo78KNqacMgKqU:22 a=Yupwre4RP9_Eg_Bd0iYG:22
        a=Bgfdu2smNuKfk3vLOmSO:22 a=_Ilv_KrDiT527o6t6YB_:22
        a=D0XLA9XvdZm18NrgonBM:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 15, 2020 at 11:24:53AM +0300, Tomi Valkeinen wrote:
> On 14/05/2020 22:09, Sam Ravnborg wrote:
> > Look up backlight device using devm_of_find_backlight().
> > This simplifies the code and prevents us from hardcoding
> > the node name in the driver.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Zheng Bin <zhengbin13@huawei.com>
> > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > Cc: Enrico Weigelt <info@metux.net>
> > Cc: Allison Randal <allison@lohutok.net>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > ---
> >   .../gpu/drm/omapdrm/displays/panel-dsi-cm.c    | 18 ++++++++----------
> >   1 file changed, 8 insertions(+), 10 deletions(-)
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks, pushed to drm-misc-next.

	Sam

> 
>  Tomi
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
