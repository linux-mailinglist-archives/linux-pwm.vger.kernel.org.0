Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389D8225AFF
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jul 2020 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgGTJOi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jul 2020 05:14:38 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:55006 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgGTJOh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jul 2020 05:14:37 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 5E31220027;
        Mon, 20 Jul 2020 11:14:29 +0200 (CEST)
Date:   Mon, 20 Jul 2020 11:14:27 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
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
Subject: Re: [PATCH v5 14/19] backlight: cr_bllcd: introduce gpio-backlight
 semantics
Message-ID: <20200720091427.GA140081@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
 <20200719080743.8560-15-sam@ravnborg.org>
 <20200720084822.wt5guzetkrgbgdcc@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720084822.wt5guzetkrgbgdcc@holly.lan>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
        a=OARlJtXb7fUog6UZhKUA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=cvBusfyB2V15izCimMoJ:22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 20, 2020 at 09:48:22AM +0100, Daniel Thompson wrote:
> On Sun, Jul 19, 2020 at 10:07:38AM +0200, Sam Ravnborg wrote:
> > cr_bllcd can turn backlight ON or OFF.
> > Fix semantitics so they equals what we know from gpio-backlight.
> > brightness == 0   => backlight off
> > brightness == 1   => backlight on
> > 
> > Use the backlight_get_brightness() helper to simplify the code.
> > 
> > v2:
> >   - reworked to introduce gpio-backlight semantics (Daniel)
> 
> Wasn't this added for v5? However, I spotted this change amoung the
> other patches so no worries...

I do not increment version for individual patches unless there are
changes. So this is the second version of this patch, but included in the
v5 submission.
But I can see how this can confuse the receiver.
I will consider to adapt to the practice to indicate version of submission
and not the individual patches.


> 
> 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Very much appreciated - thanks!

	Sam
