Return-Path: <linux-pwm+bounces-497-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2D880C337
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 09:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EECFF1C2090C
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Dec 2023 08:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF68A20DF3;
	Mon, 11 Dec 2023 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="GlrMhEoM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D29E8;
	Mon, 11 Dec 2023 00:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702283410; bh=bMk50ArkFZn/A6zyDTd+gORFOrRBh0Vv7u/HdHRDSdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GlrMhEoMcOOmT9hZVPZID5jh68eRiPW06fPO3FGYZ1O+ZkJhZ5iYrEyZli7NmY3Jb
	 mP6E5Y/RsBzD8XmsI0DeRez1i3fS5OY4s4i3iL5i3Up4IhuIph5zCkc2KO42esii6L
	 vIeS7eQJwbupke3WsUAoWi+TWJnbLT2PFJXpTGsgmlofKXYcdyDgLVwZv2+PY2kBQP
	 EhFFrETlCgHvrzyXGKVjF/TNO3GPfFI0OhBjaAdUZb7jPqcgSAXUyBNLE6S6OIMLF9
	 sOuJCffDus+Qy6X/clIMoJnbtuOg5ihgJL7dWMQOPy0Jk4c0FuC3BPGCYpx36iuzpm
	 xfRjdtTrrqIKA==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 9DCBD10008F; Mon, 11 Dec 2023 08:30:10 +0000 (GMT)
Date: Mon, 11 Dec 2023 08:30:10 +0000
From: Sean Young <sean@mess.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
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
Subject: Re: [PATCH v6 1/4] pwm: rename pwm_apply_state() to
 pwm_apply_might_sleep()
Message-ID: <ZXbIknpNVxb5Mh2B@gofer.mess.org>
References: <cover.1701248996.git.sean@mess.org>
 <37090c1d8d8f42f1e12fa84942027d995189a99e.1701248996.git.sean@mess.org>
 <20231209135742.3ieusuq3h3xlvjfn@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231209135742.3ieusuq3h3xlvjfn@pengutronix.de>

On Sat, Dec 09, 2023 at 02:57:42PM +0100, Uwe Kleine-K�nig wrote:
> On Wed, Nov 29, 2023 at 09:13:34AM +0000, Sean Young wrote:
> > In order to introduce a pwm api which can be used from atomic context,
> > we will need two functions for applying pwm changes:
> > 
> > 	int pwm_apply_might_sleep(struct pwm *, struct pwm_state *);
> > 	int pwm_apply_atomic(struct pwm *, struct pwm_state *);
> > 
> > This commit just deals with renaming pwm_apply_state(), a following
> > commit will introduce the pwm_apply_atomic() function.
> > 
> > Acked-by: Hans de Goede <hdegoede@redhat.com>
> > Acked-by: Jani Nikula <jani.nikula@intel.com>
> > Acked-by: Lee Jones <lee@kernel.org>
> > Signed-off-by: Sean Young <sean@mess.org>
> 
> Not a in-detail-review, but I just noticed again, that we have
> 
> 	K:      pwm_(config|apply_state|ops)
> 
> in MAINTAINERS. That one needs adaption, too.

Fixed in v7.

Thanks,

Sean

