Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3131922265A
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Jul 2020 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgGPPAb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Jul 2020 11:00:31 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:42950 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGPPA3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Jul 2020 11:00:29 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id E0E1E804D0;
        Thu, 16 Jul 2020 17:00:22 +0200 (CEST)
Date:   Thu, 16 Jul 2020 17:00:21 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 05/20] backlight: improve backlight_device
 documentation
Message-ID: <20200716150021.GA1936267@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
 <20200703184546.144664-6-sam@ravnborg.org>
 <20200716143941.GS3165313@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716143941.GS3165313@dell>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
        a=i7-e4zb6R47tXRK1UEkA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=cvBusfyB2V15izCimMoJ:22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Lee.

On Thu, Jul 16, 2020 at 03:39:41PM +0100, Lee Jones wrote:
> On Fri, 03 Jul 2020, Sam Ravnborg wrote:
> 
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
> > Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > ---
> >  include/linux/backlight.h | 72 ++++++++++++++++++++++++++-------------
> >  1 file changed, 49 insertions(+), 23 deletions(-)
> 
> Some of these do not apply cleanly.
> 
> Please collect the *-bys already received, rebase and resubmit.

Will do.
The patch-set is based on drm-misc-next. Are there another
tree that I should use?

	Sam
