Return-Path: <linux-pwm+bounces-7600-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69620C406B5
	for <lists+linux-pwm@lfdr.de>; Fri, 07 Nov 2025 15:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04E7534D517
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Nov 2025 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726E02EBBB9;
	Fri,  7 Nov 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="yABQUk8U"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6FD19CCF7
	for <linux-pwm@vger.kernel.org>; Fri,  7 Nov 2025 14:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762526965; cv=none; b=Sgrhi1xgowPTVQVyEQ7iTFNafXqePAa1DVLSIWVQqaEpwxKSKvqU2vCBhsxfE4/dgFXI5CtoIOCIb28HqyuIFLo+Jr9CmyiFHVk36289JV+oTtw64+6mULNrePN0qVTIUfm/VOwImjH5krfadekV210/veAdmQJhDfaQM05V270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762526965; c=relaxed/simple;
	bh=RUD1Jd43ZASIpcsxuX1N2ssGIFWOzPtdxIFtmeCDnJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gf1euj1ggTrF3dnL/1GS8d+Qj5N4v7F8GeJzzutHd30ttKvAjlb8L/EDJzfiKcsVXNjsFK/dmMtM1VCEpDGQ+qBWgbtF0BPvaJLgSE1axvOf7dEZrjptK8TtLMkCZJVLtR3L1Xk6Xat2Ho9xd5W7ZGEy8GjshIXoTZnZHteS/jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=yABQUk8U; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso791636f8f.2
        for <linux-pwm@vger.kernel.org>; Fri, 07 Nov 2025 06:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762526961; x=1763131761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUD1Jd43ZASIpcsxuX1N2ssGIFWOzPtdxIFtmeCDnJw=;
        b=yABQUk8Uc1TtA2DtluqrZ5DqW1jAnyQmQp6Q4nOI6qjXTbZOiifQc6yL0Oq6cnE7dD
         rseThXB9Y76pqLcOgm2hyqUOtu1hbX5/7ju1g+Q5K67iG6XmaMW476rQ4fgDYC7rPntT
         mKs10oTo/H9McJb++b9bL0BHpLjaun7V/+/sMVW364dlCfN2o7w3W8S3rBBThT2M49Fh
         uxxYMR3ce1WCbBPNpdGdjOXtgIWW1fsqXugwD3rNP9uhzxKLPj3I8NI+2XnWw7Pn2jF3
         F01kwc9IqLpXdqDJe+izWd9aKsrHV1B6uapjCLyi3EVwit/59n0vlBivEXljB8SdkO6e
         mRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762526961; x=1763131761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUD1Jd43ZASIpcsxuX1N2ssGIFWOzPtdxIFtmeCDnJw=;
        b=RGcH0vvn8LhqW1qgstR6Dp6oGhWL9sdt0jglpK1+PWqZo5OdDkObjR4KJcuYjCHjuZ
         lg5ChavhLb9JAgYRSycmJHVHkYY/xcaIQ/OA1x5bYlCsdU31wdRKY6JJgXUwWSsknk+0
         yQSYZL1K3in4swkwRsuvm3t1OWwi42gVGUseMcKWRPtH8aqYVsbqA1Te9GGbgFk6S/Ds
         u6nXJjCQXX5/kiyaa2ajWfPqq7TOgT6yya2OH/vFceQntTnOYKObbPtm3pjsH2Hf3DPZ
         i7yOzCScsdeMWE7F2tfZz8i8HUlyhf01DllVIlAZgigMbyIY50wAbap03nticF1rvKLs
         NaVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA/UvWPhjIgHlQdmw+HDVczKcbpZFFANXfVpur1uygTxjIi+Izyl3iJals1uQq44d48WCOZxj+Mn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymrkIpwmvW2t/HZF+yS1ZMoJ9SI7FqfUWJSZ73TPImIhEyOZLQ
	he+I755+pL7/CM7fNTHUUPfXq7LuR1IRJmIcqgdSf48w/hDQRnFe4UfvHmsloztgD+E=
X-Gm-Gg: ASbGnctz3/iksa05/w8RWt9UushCr5vLxZrrQcZiKQDHcaeA4y06+FVKJCmX+OA8QGS
	erS9+mx+fe48grpEp7DU4Oy4qzmU2b/pmmDEYbP1HfAfszG1yLMAvLePJLAXFMSsswktiJ6bZ2H
	PvvV0gA6P/JOkbTkXV7NpvnDEFD/+ckUmJ9bokBKzHQNT+VYlviBvVj58shm7/W4YmoGu5aS3/K
	1KQSk24S0EGT3YL/jOD92jv+R7W82N+O57eQtBar+FEvIz3K3n4zngMjZJ/63CDwMRBpg/wVY4I
	4ZCq7XhiyBPXxuA+CiPIFwFJAt7wDow5IAQcv/871tWXZruCnFYXcI0smK7SyyhcqYireZhFyxu
	RUde4LW7CiJfe0/2X38WV8muULOZXR5a64D0ejlR0TaqYOEIMsAaXTEsBB/hdBUewMAaSRr7CS3
	kgbCbby3NuKlG4pJorntDZughwRwia1FWkgCTjEhho2mrTKep3puCXj4QLY58=
X-Google-Smtp-Source: AGHT+IGVSynVCb+VhjrR6Z2aEb6MRhX4htxmgyYFU/R10GQ6nAy3fDU1kADzW8iu4OBmJz15vaN2pw==
X-Received: by 2002:a05:6000:200d:b0:427:454:43b4 with SMTP id ffacd0b85a97d-42ae5ae8448mr2952999f8f.48.1762526960292;
        Fri, 07 Nov 2025 06:49:20 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm5596030f8f.9.2025.11.07.06.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:49:19 -0800 (PST)
Date: Fri, 7 Nov 2025 14:51:15 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Lee Jones <lee@kernel.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Pengutronix <kernel@pengutronix.de>, linux-pwm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
Message-ID: <aQ4HY5Hncv1fvxVk@aspen.lan>
References: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
 <aQNRK5ksNDMMve0x@aspen.lan>
 <t6wtfnmnclnzwdpbmdcalvyf3mulmpexnryolxkygqkpx7vdwz@dqwbwvlzawrr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <t6wtfnmnclnzwdpbmdcalvyf3mulmpexnryolxkygqkpx7vdwz@dqwbwvlzawrr>

On Fri, Nov 07, 2025 at 09:00:33AM +0100, Uwe Kleine-König wrote:
> On Thu, Oct 30, 2025 at 11:51:07AM +0000, Daniel Thompson wrote:
> > On Thu, Jul 31, 2025 at 10:47:18AM +0200, Michael Grzeschik wrote:
> > > Currently when calling pwm_apply_might_sleep in the probe routine
> > > the pwm will be configured with an not fully defined state.
> > >
> > > The duty_cycle is not yet set in that moment. There is a final
> > > backlight_update_status call that will have a properly setup state.
> > > However this change in the backlight can create a short flicker if the
> > > backlight was already preinitialised.
> > >
> > > We fix the flicker by moving the pwm_apply after the default duty_cycle
> > > can be calculated.
> > >
> > > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >
> > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
>
> I guess this tag resulted in Lee picking up the change. I wonder if you
> share my concern and who's responsibility it is now to address it.

You mean the ordering the backlight registration versus setting the
properties in the probe method?

I definitely share the concern that there's a short window where
something could request a brightness via sysfs and then have it
overwritten by the remains of the probe method. Likewise I can't see
why there would be any problem moving the call to
pwm_backlight_initial_power_state() before the backlight is registered.
Thus I'd be happy to see the backlight registered later in the probe
method.

On the other hand I don't see any problem calling
backlight_update_status() from the probe method. This is a relatively
common approach in backlight drivers to impose the initial brightness
on the hardware without needing extra code paths.
backlight_update_status() is guarded with a mutex and should be
idempotent for most drivers. Therefore it is OK even if something gets
in via sysfs and provokes an update before the probe method has started
it's own update.

In terms of who should follow up I've got no strong opinions on that.
It's worth noting that I don't own any hardware that uses a PWM
backlight so I'm not in a position to test it!


Daniel.

