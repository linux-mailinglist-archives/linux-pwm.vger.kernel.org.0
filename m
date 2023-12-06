Return-Path: <linux-pwm+bounces-417-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6212806F70
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 13:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7FD21C208F4
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2D035892;
	Wed,  6 Dec 2023 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QbHhi9JH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DA41A5
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 04:06:07 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 13592E45;
	Wed,  6 Dec 2023 13:05:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1701864324;
	bh=DAaoGZkut7V125jbv7jlLsqrF/urm43gSPz3mOH0DQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QbHhi9JHEjzAN+7TsAfZDufXMbCdK7xdEpxTy1FjI2T1tYNDeijLNUu47F996GX6W
	 d9P88L6F2L6Ts3zAYha7liOEeqM6IO5GLoNpds4eFSEH/s2VD9U7LUbLXeO1D6sxBy
	 ykeYwXu+sGpzwE//5r8KSb3cZOuMSHy6yEZSwD+Q=
Date: Wed, 6 Dec 2023 14:06:11 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Douglas Anderson <dianders@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 101/108] drm/bridge: ti-sn65dsi86: Make use of
 devm_pwmchip_alloc() function
Message-ID: <20231206120611.GI22607@pendragon.ideasonboard.com>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-102-u.kleine-koenig@pengutronix.de>
 <20231123094652.GH15697@pendragon.ideasonboard.com>
 <20231123101018.u6c6nymmkam5ltir@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123101018.u6c6nymmkam5ltir@pengutronix.de>

On Thu, Nov 23, 2023 at 11:10:18AM +0100, Uwe Kleine-König wrote:
> Hello Laurent,
> 
> On Thu, Nov 23, 2023 at 11:46:52AM +0200, Laurent Pinchart wrote:
> > (CC'ing Bartosz)
> 
> I'm already in discussion with Bart :-)
> 
> > On Tue, Nov 21, 2023 at 02:50:43PM +0100, Uwe Kleine-König wrote:
> > > This prepares the pwm driver of the ti-sn65dsi86 to further changes of
> > > the pwm core outlined in the commit introducing devm_pwmchip_alloc().
> > > There is no intended semantical change and the driver should behave as
> > > before.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 25 ++++++++++++++++---------
> > >  1 file changed, 16 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > > index c45c07840f64..cd40530ffd71 100644
> > > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > > @@ -197,7 +197,7 @@ struct ti_sn65dsi86 {
> > >  	DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
> > >  #endif
> > >  #if defined(CONFIG_PWM)
> > > -	struct pwm_chip			pchip;
> > > +	struct pwm_chip			*pchip;
> > 
> > Dynamic allocation with devm_*() isn't the right solution for lifetime
> > issues related to cdev. See my talk at LPC 2022
> > (https://www.youtube.com/watch?v=kW8LHWlJPTU, slides at
> > https://lpc.events/event/16/contributions/1227/attachments/1103/2115/20220914-lpc-devm_kzalloc.pdf),
> > and Bartosz's talk at LPC 2023
> > (https://lpc.events/event/17/contributions/1627/attachments/1258/2725/Linux%20Plumbers%20Conference%202023.pdf).
> 
> Once the series is completely applied, the pwm_chip isn't allocated
> using devm_kzalloc any more. You're only looking at an intermediate
> state where I push the broken lifetime tracking from all drivers into a
> single function in the core that is then fixed after all drivers are
> converted to it.

Indeed, I missed that devm_pwm_alloc() got changed later in the series
to not call devm_kzalloc(). The naming is quite unfortunate, a
devm_*_alloc() function really gives a strong hint that the
corresponding cleanup at device remove time will be a free(), not a
put() :-S That's pretty confusing for the readers.

> If you find issues with the complete series applied, please tell me.

One thing I still dislike is forcing drivers to dynamically allocate the
pwm_chip series.

-- 
Regards,

Laurent Pinchart

