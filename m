Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103A71D849B
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 20:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbgERSMn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 14:12:43 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:42300 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729959AbgERSMe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 14:12:34 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id CFD6C80629;
        Mon, 18 May 2020 20:12:28 +0200 (CEST)
Date:   Mon, 18 May 2020 20:12:27 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jani Nikula <jani.nikula@intel.com>,
        linux-arm-msm@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2 15/16] backlight: make of_find_backlight_by_node()
 static
Message-ID: <20200518181227.GC770425@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-16-sam@ravnborg.org>
 <20200518165648.ltgtofjsteyyse4j@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518165648.ltgtofjsteyyse4j@holly.lan>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
        a=5yQEYNe8RFLK8MwGuM4A:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=cvBusfyB2V15izCimMoJ:22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 18, 2020 at 05:56:48PM +0100, Daniel Thompson wrote:
> On Sun, May 17, 2020 at 09:01:38PM +0200, Sam Ravnborg wrote:
> > There are no external users of of_find_backlight_by_node().
> > Make it static so we keep it that way.
> > 
> > v2:
> >   - drop EXPORT of of_find_backlight_by_node
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> 
> Assuming the 0day-ci comments are because some of the patches have
> already been sucked up in a different tree then:
Correct. For now only drm-misc-next have no users of
of_find_backlight_by_node() which is why the other trees failed.

 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Thanks for all your reviews!
I will shortly (within a few days) address the comments and send out a v3.

Is is correct that I assume you or Lee or Jingoo will apply the patches
to a backlight tree somewhere when they are ready?
If you have a tree you use for backlight patches I can base v3 on that,
given that I get a link and have access to pull from it.

	Sam
