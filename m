Return-Path: <linux-pwm+bounces-224-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1F67FD1BC
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 10:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C6AB20D06
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 09:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D8E12B7F;
	Wed, 29 Nov 2023 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="BAZ/6qGN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E0385;
	Wed, 29 Nov 2023 01:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1701248932; bh=Xv3LVDjykwD/IOkFuRPxIVNxFelutLAZSXS7jeSQqIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAZ/6qGNguReQ4NFwPXT8Bi2uaQNZ0Q93gRgXJPFRYxINiE+0NAHwqYEo8gcRktTI
	 g5OWo09C5jJHok3S1c3vfX72MgTtnOlRCfK/TqM9Rhw5IHY9zlrMU0Lm6ESMeYefR5
	 o0o+IWUBwaImm3Ew7Uz5W7jNB5PpjVR/Xzp9G3VEMAH3MPFJnFwTN5A/JF0jvSM53H
	 TD72MGqWdop+SC6I4X83nrxxAJKPcPymeSSvEn8ptLrmEICedV7+oDpdhH/aFgVPau
	 +Aaz/bRn6yA421udzBxvVtiTPtc21WHM3jUynkqXosp+xZ5HbIh4FPd2hzKqYs08uU
	 fPTAj/lk7FXSA==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id CB5B0100100; Wed, 29 Nov 2023 09:08:52 +0000 (GMT)
Date: Wed, 29 Nov 2023 09:08:52 +0000
From: Sean Young <sean@mess.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Gross <markgross@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Jani Nikula <jani.nikula@intel.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 1/4] pwm: rename pwm_apply_state() to
 pwm_apply_cansleep()
Message-ID: <ZWb_pEixK07cRlnr@gofer.mess.org>
References: <cover.1700323916.git.sean@mess.org>
 <2b973840d800ffb71c2683c37bc996e0cf90a140.1700323916.git.sean@mess.org>
 <ZWClpnMRg_vjuI_R@orome.fritz.box>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWClpnMRg_vjuI_R@orome.fritz.box>

On Fri, Nov 24, 2023 at 02:31:18PM +0100, Thierry Reding wrote:
> On Sat, Nov 18, 2023 at 04:16:17PM +0000, Sean Young wrote:
> > In order to introduce a pwm api which can be used from atomic context,
> > we will need two functions for applying pwm changes:
> > 
> > 	int pwm_apply_cansleep(struct pwm *, struct pwm_state *);
> > 	int pwm_apply_atomic(struct pwm *, struct pwm_state *);
> > 
> > This commit just deals with renaming pwm_apply_state(), a following
> > commit will introduce the pwm_apply_atomic() function.
> 
> Sorry, I still don't agree with that _cansleep suffix. I think it's the
> wrong terminology. Just because something can sleep doesn't mean that it
> ever will. "Might sleep" is much more accurate because it says exactly
> what might happen and indicates what we're guarding against.

Sorry, I forgot about this in the last round. I've renamed it _might_sleep
in v6 which I'll post shortly.


Sean

