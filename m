Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E99C641FDE
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Dec 2022 22:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiLDVbs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 4 Dec 2022 16:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLDVbr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 4 Dec 2022 16:31:47 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F8613E05
        for <linux-pwm@vger.kernel.org>; Sun,  4 Dec 2022 13:31:46 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0BFC92D8;
        Sun,  4 Dec 2022 22:31:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1670189504;
        bh=ZiU22BSfaBf2V1IOu/eKj4zw3NqHJMR9VyBBSYl+1Ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldTI9peQD33DfV0DUvPhXdJ5gTCbmm5NGmDoSA082azM8dhTFFtbjHWz9P80J8duS
         IzUs9ruF05OCEwTVeqHu+UbSpAgcMEwT/R3OqVoOU3QgTqEAEdgBrdORRd/8NPksme
         bTMyPSI3RTylqWUFz9oBmBWE1G8O1chH2T4HOQlo=
Date:   Sun, 4 Dec 2022 23:31:42 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 03/11] drm/bridge: ti-sn65dsi86: Propagate errors in
 .get_state() to the caller
Message-ID: <Y40Rvi0tyRnfbHp2@pendragon.ideasonboard.com>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-4-u.kleine-koenig@pengutronix.de>
 <20221204210940.qygblu244zvlenxz@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221204210940.qygblu244zvlenxz@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Dec 04, 2022 at 10:09:40PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> my initial Cc-list wasn't optimal. So I added a few people here.
> 
> On Wed, Nov 30, 2022 at 04:21:40PM +0100, Uwe Kleine-König wrote:
> > .get_state() can return an error indication. Make use of it to propagate
> > failing hardware accesses.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > index 6826d2423ae9..9671071490d8 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -1512,19 +1512,19 @@ static int ti_sn_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> >  
> >  	ret = regmap_read(pdata->regmap, SN_PWM_EN_INV_REG, &pwm_en_inv);
> >  	if (ret)
> > -		return 0;
> > +		return ret;
> >  
> >  	ret = ti_sn65dsi86_read_u16(pdata, SN_BACKLIGHT_SCALE_REG, &scale);
> >  	if (ret)
> > -		return 0;
> > +		return ret;
> >  
> >  	ret = ti_sn65dsi86_read_u16(pdata, SN_BACKLIGHT_REG, &backlight);
> >  	if (ret)
> > -		return 0;
> > +		return ret;
> >  
> >  	ret = regmap_read(pdata->regmap, SN_PWM_PRE_DIV_REG, &pre_div);
> >  	if (ret)
> > -		return 0;
> > +		return ret;
> >  
> >  	state->enabled = FIELD_GET(SN_PWM_EN_MASK, pwm_en_inv);
> >  	if (FIELD_GET(SN_PWM_INV_MASK, pwm_en_inv))
> 
> It would be great to get an Ack to take this patch and patch #1 via the
> PWM tree. (Both got an Ack by Douglas Anderson, I'm unsure if that is
> already enough.)

-- 
Regards,

Laurent Pinchart
