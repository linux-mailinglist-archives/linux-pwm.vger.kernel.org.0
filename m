Return-Path: <linux-pwm+bounces-482-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF7880B8B1
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Dec 2023 04:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2321C2094C
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Dec 2023 03:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A9917D9;
	Sun, 10 Dec 2023 03:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dpqe82ix"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB29A9;
	Sat,  9 Dec 2023 19:59:32 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35d725ac060so14996775ab.2;
        Sat, 09 Dec 2023 19:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702180771; x=1702785571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84cInsubYIer0iSHh7fFONzX0zWNfmSdIBRyKoPJTkI=;
        b=Dpqe82ixxSSlYbhIzV4rNaEDkOnIiiRPf7jpFsAcHgDwxCr4Ms2JSc0eRfQ7dXDu5d
         bw32ai1gAryHH0ZG+d3fEp6CNoR9WwQArNNtkv3qTKMLFDTvXm0z6Hn7EihQrdKE/jR4
         NU8b+Akh0wOOqzkT3vvftHIbvllFqQc7jOtGd2V1WhEtrZzQKJbHPuWXKN0srVrSHdaw
         HcDjyMUHzmcTibFYvWtEVVKZVd+kGzfx7rmx6EwuqQdRBYywPXrlG/aXFsVfJGMLlfRL
         Z2byYxb9H1kaz53izhAZv1INArcTOb00Or6jAwxWbGqt1+52pMsrLUjgD1if6kXGB/22
         PYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702180771; x=1702785571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84cInsubYIer0iSHh7fFONzX0zWNfmSdIBRyKoPJTkI=;
        b=CE9U9prywbf4ws35fDREq5qeTXLrYc/s58IqiqRPRtnBiftMULtEsaNTUdlT9IN0mi
         p0eTaV64nNpTjeqjXvH+yVy5/zJB+RX9A87P10wxmKDVSdye0iVzJviL0BG8RlnBZx8u
         GSstTGkHFS3W3kWSW0qULyul9DcXxuSey7Q8J1kIe6h6wmvRRHm3MwgdfA8MFtHd0Cjl
         Ix5bav6GfWwhX/ajw2JTcL/eqweW+CPyrvXbF77LCWLTZla1eXENbnyPWfbr4Mr87DWX
         Izx/T5TKk2QBJLHc1O6CmCKZpFkSsvCMmdR1V63UXHevATWRVpDLw0fRLN0VCFvsm0OV
         5m2g==
X-Gm-Message-State: AOJu0YxYMWa48ePM9hNZJCYCfEbni4S4bOF/UBHa1fCesRuAlQIKO9YJ
	sFa0JgRKtpKPXxtbJO15jbu6t3PAA2A=
X-Google-Smtp-Source: AGHT+IH9F5XvBInEJBWDJV2re58BWPH91w8i++zb8S4UYFPdHM7W/4ZmjNF8Wa+XCmRN3R3hwoJNSg==
X-Received: by 2002:a05:6e02:1845:b0:35d:5667:c42e with SMTP id b5-20020a056e02184500b0035d5667c42emr4576271ilv.2.1702180771158;
        Sat, 09 Dec 2023 19:59:31 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:9082:8aa4:377c:de99])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902ed0600b001d060bb0582sm4129422pld.165.2023.12.09.19.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 19:59:30 -0800 (PST)
Date: Sat, 9 Dec 2023 19:59:26 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sean Young <sean@mess.org>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
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
Message-ID: <ZXU3nsNoQxXKUF4F@google.com>
References: <cover.1701248996.git.sean@mess.org>
 <37090c1d8d8f42f1e12fa84942027d995189a99e.1701248996.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37090c1d8d8f42f1e12fa84942027d995189a99e.1701248996.git.sean@mess.org>

On Wed, Nov 29, 2023 at 09:13:34AM +0000, Sean Young wrote:
>  drivers/input/misc/da7280.c                   |  4 +--
>  drivers/input/misc/pwm-beeper.c               |  4 +--
>  drivers/input/misc/pwm-vibra.c                |  8 +++---

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry

