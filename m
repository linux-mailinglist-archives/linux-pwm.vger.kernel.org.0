Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83071D680C
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgEQM6e (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 08:58:34 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:40530 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgEQM6e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 08:58:34 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id E5C302004D;
        Sun, 17 May 2020 14:58:29 +0200 (CEST)
Date:   Sun, 17 May 2020 14:58:28 +0200
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
Subject: Re: [PATCH v1 02/18] drm/tilcdc: use devm_of_find_backlight
Message-ID: <20200517125828.GB620358@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
 <20200514191001.457441-3-sam@ravnborg.org>
 <9e234824-3cf6-ead4-561b-70c1966ac5fd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e234824-3cf6-ead4-561b-70c1966ac5fd@ti.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=sozttTNsAAAA:8 a=e5mUnYsNAAAA:8
        a=j9Ekg0ZhKnyfv64AlhwA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=aeg5Gbbo78KNqacMgKqU:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, May 15, 2020 at 11:25:47AM +0300, Tomi Valkeinen wrote:
> On 14/05/2020 22:09, Sam Ravnborg wrote:
> > Look up backlight device using devm_of_find_backlight().
> > This simplifies the code and prevents us from hardcoding
> > the node name in the driver.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Jyri Sarha <jsarha@ti.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> >   drivers/gpu/drm/tilcdc/tilcdc_panel.c | 17 ++++++-----------
> >   1 file changed, 6 insertions(+), 11 deletions(-)
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
