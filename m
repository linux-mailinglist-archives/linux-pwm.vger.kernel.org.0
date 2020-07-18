Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B101E224926
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jul 2020 08:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgGRGAP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 18 Jul 2020 02:00:15 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:43540 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgGRGAP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 18 Jul 2020 02:00:15 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id E1896804EB;
        Sat, 18 Jul 2020 08:00:08 +0200 (CEST)
Date:   Sat, 18 Jul 2020 08:00:07 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jingoo Han <jingoohan1@gmail.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 05/20] backlight: improve backlight_device
 documentation
Message-ID: <20200718060007.GA2419852@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
 <20200703184546.144664-6-sam@ravnborg.org>
 <SL2P216MB0105B428FFAB66BDA245B814AA7D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB0105B428FFAB66BDA245B814AA7D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
        a=VwQbUJbxAAAA:8 a=qfaL6h6_04lZHQssqbcA:9 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=cvBusfyB2V15izCimMoJ:22
        a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Jingoo
On Sat, Jul 18, 2020 at 05:18:39AM +0000, Jingoo Han wrote:
> On 7/3/20, 2:46 PM, Sam Ravnborg wrote:
> >
> > Improve the documentation for backlight_device and
> > adapt it to kernel-doc style.
> >
> > The updated documentation is more strict on how locking is used.
> > With the update neither update_lock nor ops_lock may be used
> > outside the backlight core.
> > This restriction was introduced to keep the locking simple
> > by keeping it in the core.
> > It was verified that this documents the current state by renaming
> > update_lock => bl_update_lock and ops_lock => bl_ops_lock.
> > The rename did not reveal any uses outside the backlight core.
> > The rename is NOT part of this patch.
> >
> > v3:
> >   - Update changelog to explain locking details (Daniel)
> >
> > v2:
> >   - Add short intro to all fields (Daniel)
> >   - Updated description of update_lock (Daniel)
> >
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>  > Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> 
> It looks good!
> Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

Thanks!

> 
> For the rebase, if you don't know which branch of maintainer's git can be used,
> linux-next tree [1] is useful. The linux-next git collects all next branches from 
> other maintainers' git every day.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/

I had used drm-misc-next because the original focus was to clean up
drivers in gpu/drm/ - and then I just continued to use this wrong tree.
linux-next is indeed a good place to catch the latest and greatest - but
as I now have the URL for the backlight tree (thanks to Lee) I will use it here.
Will try to find time this weekend so we can land these.

	Sam
