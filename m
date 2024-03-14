Return-Path: <linux-pwm+bounces-1758-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3579987BB29
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Mar 2024 11:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FEC1C20D10
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Mar 2024 10:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17076EB5C;
	Thu, 14 Mar 2024 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGd6GxVu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB12D6EB59;
	Thu, 14 Mar 2024 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411640; cv=none; b=Jz32mUkr7A8aDiuERgRv+mpqMQJj+/3AMIZry3m6U3OkLTEiD5E2dRM4TpfnCYVd60lsLkt7VsNV/7WvCibZGmktdFmSiJAWnVxpC053vD5jmGu45jjwzqk0icWtBMBX/hbYoRNwlwe+f8hzj1Lqc/iuj8WA8TVOWAE03L32Sq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411640; c=relaxed/simple;
	bh=ngB6lPw5E5YduqZY9oFh10xcMS09OfDy2k7K4Z+l75I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2So8q5yaT+zFssBX7ycb6wcvNo2t7+I5bqH2ebOFReumrwY4r9ZAdwrl6iJdmTvWFxJArTAy7nXgTHoMIpBHCU6hRKiuA8Pp5R0aGXSJ5eYNKBa1Un1UbCDlpQxFOhVE3c8cVrxV/pRERR8olRGfHObqc3WH8wnt0es5wjGlik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGd6GxVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8974BC433F1;
	Thu, 14 Mar 2024 10:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710411640;
	bh=ngB6lPw5E5YduqZY9oFh10xcMS09OfDy2k7K4Z+l75I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGd6GxVugJMP71VjabhDcHE4Sa68HXsLA3xQe5Uy9CBAJ/OGNgezLljw1E0kxjO11
	 1i/anEQCKL2CVaoxNtQAz1tUyNQ20ZdsGlyKspkkmUFojfZ4OFKOZEH/MLz16Kj4J4
	 dlhuOL/zxQBeh7Y+H6xqK0v8GDdgr780JPmciPgq4iDc4UhMLVTB3tiOCSwVn8CXmN
	 RZdgmVi7oIhcBAZzLfeB6xDsT1wuMK1s/7yTA4gxECoE00jxW4Yc/Lj6WYJ8tYUG7u
	 ZqKnnP2zn3g9HFdN5mnhDYOF+I7e9HNFjfrTFH0VXuS5Y6cBSq2lT1IbXVEjda9vS9
	 bxeH905BBub1g==
Date: Thu, 14 Mar 2024 10:20:35 +0000
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
	kernel@pengutronix.de, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] backlight: lp8788: Drop support for platform data
Message-ID: <20240314102035.GI1522089@google.com>
References: <20240313124828.861731-2-u.kleine-koenig@pengutronix.de>
 <7nvqboywxhviyuzkiesy4qfqybxx7vc5sw2seluc3dwnhk3q5h@hlzwxhnm2q6r>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7nvqboywxhviyuzkiesy4qfqybxx7vc5sw2seluc3dwnhk3q5h@hlzwxhnm2q6r>

On Wed, 13 Mar 2024, Uwe Kleine-König wrote:

> Hello,
> 
> On Wed, Mar 13, 2024 at 01:48:27PM +0100, Uwe Kleine-König wrote:
> > diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
> > index 31f97230ee50..f3a89677c31c 100644
> > --- a/drivers/video/backlight/lp8788_bl.c
> > +++ b/drivers/video/backlight/lp8788_bl.c
> > @@ -12,7 +12,6 @@
> >  #include <linux/mfd/lp8788.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> > -#include <linux/pwm.h>
> >  #include <linux/slab.h>
> >  
> >  /* Register address */
> > @@ -31,149 +30,41 @@
> >  #define MAX_BRIGHTNESS			127
> >  #define DEFAULT_BL_NAME			"lcd-backlight"
> >  
> > -struct lp8788_bl_config {
> > -	enum lp8788_bl_ctrl_mode bl_mode;
> > -	enum lp8788_bl_dim_mode dim_mode;
> > -	enum lp8788_bl_full_scale_current full_scale;
> > -	enum lp8788_bl_ramp_step rise_time;
> > -	enum lp8788_bl_ramp_step fall_time;
> > -	enum pwm_polarity pwm_pol;
> > -};
> > -
> >  struct lp8788_bl {
> >  	struct lp8788 *lp;
> >  	struct backlight_device *bl_dev;
> > -	struct lp8788_backlight_platform_data *pdata;
> > -	enum lp8788_bl_ctrl_mode mode;
> >  	struct pwm_device *pwm;
> 
> Actually this pwm_device member should be dropped, too. I wonder why
> this even passes a W=1 build without a warning ...
> 
> @Lee: Feel free to fix this up while applying, or tell me if you prefer
> an incremental fixup or a complete v2.

Either of the last 2 options would be fine.

-- 
Lee Jones [李琼斯]

