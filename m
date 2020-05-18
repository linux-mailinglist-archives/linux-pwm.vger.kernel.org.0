Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1BF1D74F5
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 12:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgERKQX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 06:16:23 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:39208 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgERKQX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 06:16:23 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 55002804CE;
        Mon, 18 May 2020 12:16:13 +0200 (CEST)
Date:   Mon, 18 May 2020 12:16:09 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        MSM <linux-arm-msm@vger.kernel.org>, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Russell King <linux@armlinux.org.uk>,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 01/16] video: amba-clcd: use devm_of_find_backlight
Message-ID: <20200518101609.GA759699@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-2-sam@ravnborg.org>
 <CACRpkdbogVA=12Xzh6jC0AaE7DrH8Z7iVuG3s_gS4MQBYF61Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbogVA=12Xzh6jC0AaE7DrH8Z7iVuG3s_gS4MQBYF61Dw@mail.gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=PHq6YzTAAAAA:8 a=hD80L64hAAAA:8
        a=sozttTNsAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=cm27Pg_UAAAA:8
        a=RYpW3c0wQFxx2xuxHgkA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=ZKzU8r6zoKMcqsNulkmm:22 a=aeg5Gbbo78KNqacMgKqU:22
        a=cvBusfyB2V15izCimMoJ:22 a=xmb-EsYY8bH0VWELuYED:22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Linus.

On Mon, May 18, 2020 at 10:10:12AM +0200, Linus Walleij wrote:
> On Sun, May 17, 2020 at 9:01 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > Look up backlight device using devm_of_find_backlight().
> > This simplifies the code and prevents us from hardcoding
> > the node name in the driver.
> >
> > v2:
> >   - Added Cc: Peter Ujfalusi
> >
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Jani Nikula <jani.nikula@intel.com>
> > Cc: Douglas Anderson <dianders@chromium.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
Thanks. I went ahead and applied this now, so we could kill
the last user of of_find_backlight_by_node().

I hope we can make of_find_backlight_by_node() static after the merge window
so no new users appears.

	Sam
