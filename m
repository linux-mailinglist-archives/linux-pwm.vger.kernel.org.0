Return-Path: <linux-pwm+bounces-3641-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C0999D806
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 22:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17678281513
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 20:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052F314D2B3;
	Mon, 14 Oct 2024 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvQL74/K"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA1148FF5;
	Mon, 14 Oct 2024 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936913; cv=none; b=j5ZtfICcAN7YxU7SaB7RExEtEq0GTwVya/SdX5sWQRuVsXXV57mrscR51i4TtYIw5RII0HijxmaHr2W8MvSN46W2SVEgwmko6TQPqlGC/2gbZ574tWxMLSg8gpwRe77SI1d8l+WQQ07+cKNOViQFvIyoGvxvE032fze5pxhAup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936913; c=relaxed/simple;
	bh=OJs6zdOtIeAhgerCz4fGfsBYiuRtasrfJZ4O8b/wJJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSi4XE1+0Q6GdGz9zcULxZvJNSEuy3VmKgS7GBydtdJBuT51LefB+yjsk+9uL66xgS+NRH+CrY/CUYQlW4vgjL/bjenmcQZk4Wk6/NDZSwF6oriye0OWR9FlaoJHQuCdAHT5B3A6NF/cVeksi+WJ/3QLjNg46uuF2m6BqwJU18c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvQL74/K; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b120428a3cso243242085a.3;
        Mon, 14 Oct 2024 13:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728936911; x=1729541711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dpw2WNuTyCqysTkudvUql0camhRiNDGOcryatLTQ+dk=;
        b=MvQL74/K88Lb9w9Y3bbAc0a3rrosPnRzLRkcMmDSBkH15oCT4DGURA7I7T9Oo0LHdf
         YJ9eUfJ83DmWwkHSIUtfda2FeE20Or4oExpwFJ87UIP+gdxhqbFyiFFDp+WD5VBngYND
         lIwL2sJjLU8/UQj87sha7cOOZBFQgdT6UUs4o81qoDHlYBPM7Qd2JdW+eptmvSnkm8lA
         i288TdaJduoBtndFCSE53UoynfehNbnKnL19/vrnTX8Y6t+Bd37AM2jX7fB10yhilCMy
         BV+cy/PZSH4yiBnZHHGvgvxkvZ0sA0WtiLyNcRsMJHtmnbsYG/XufK2sIJ3DjhU4mT8f
         jQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728936911; x=1729541711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpw2WNuTyCqysTkudvUql0camhRiNDGOcryatLTQ+dk=;
        b=O0vD3hiwx5u0yjeAl7DsbZf1QHTijrRPrEGnKmbvlN6EA+JzANjr/HhXTphbtwrn89
         Gc154XVP5gpn5e/iotrubeUrSC7+jE9zJbptCRYN9pDt3bMPEEP0lnEjZz8NxTbT3xfK
         ucXnW3YrrFd4bIaWqXQhT0Zn3ikTPfGd4b3gnrTyAS7Q88/V9raepN2RogciJOypSyhf
         EU/Dy6TSKjWmrqQ01TDf863TzGCHL1GTkb7adVZ0E8XIZNEIlzbnAdqHeMF2at+m7FRo
         6d95QlIga+B0WoahwJAtL413afG3cHuuoWldLnC4cevS2fbJxpC14K3WCN8gvVfDREMc
         mUmw==
X-Forwarded-Encrypted: i=1; AJvYcCUEJd1l6DbLyOUKA3Bf9MdgOril5rTdBYxxbaZ620KMAKUxRqY+2EOkZoMQ1PxFilHKENCYxzznjkuz@vger.kernel.org, AJvYcCVqYIRFzkC/bymtSyTVOaZZ4MZ/QW6HUe/mbYgeIsVgEVuoFV2TuYzrHS2cTw9UUztvSNxYRsTJapL+SqNU@vger.kernel.org, AJvYcCXZtWfK+k/8BwxePmOI0avrod2707wGABuKJWjDsl6HAvxORJtJd7yirIudYv4Akeg3mR12dAXtVRxO@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOrvjhkWOEWXNccKaDqCNYLSY/9m2r0P793ikwloQmv6QITXD
	T5SNmYn9GGoZWWbRG3d5TkcxIw4oOmE0eCPGcILWvdKHjwsUVIG9KSwYAfcI
X-Google-Smtp-Source: AGHT+IFcMk5820x03/AY7v0duvIy0JMNHUd1BnYfTeb0HIwZnlUhGZf9L7CFpFzNKinLIdNqMfdDrQ==
X-Received: by 2002:a05:620a:28cc:b0:7a9:a883:e22b with SMTP id af79cd13be357-7b11a34b9dcmr2292551885a.7.1728936911258;
        Mon, 14 Oct 2024 13:15:11 -0700 (PDT)
Received: from VM-Arch ([2600:1001:b148:c0ba:c7c4:edb8:1e9:3521])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b11497a931sm451280085a.110.2024.10.14.13.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:15:10 -0700 (PDT)
Date: Mon, 14 Oct 2024 16:15:02 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: u.kleine-koenig@baylibre.com, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Mehdi Djait <mehdi.djait@bootlin.com>, linux-kernel-mentees@lists.linuxfoundation.org, 
	skhan@linuxfoundation.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v10 0/2] Add driver for Sharp Memory LCD
Message-ID: <sxxpdm66dukbef27nnvnxa5igglepkcer6qtgv2hdfaim2jmqy@5xd3zwu2ta5f>
References: <20241008030341.329241-1-lanzano.alex@gmail.com>
 <hfpq35cxext6vd7shppa4ovtszywzqkc5gqo3t7p77uldasxts@gyfrypofijmd>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hfpq35cxext6vd7shppa4ovtszywzqkc5gqo3t7p77uldasxts@gyfrypofijmd>

On Mon, Oct 14, 2024 at 10:35:03AM GMT, Dmitry Baryshkov wrote:
> On Mon, Oct 07, 2024 at 11:03:09PM -0400, Alex Lanzano wrote:
> > This patch series add support for the monochrome Sharp Memory LCD
> > panels. This series is based off of the work done by Mehdi Djait.
> > 
> > References:
> > https://lore.kernel.org/dri-devel/71a9dbf4609dbba46026a31f60261830163a0b99.1701267411.git.mehdi.djait@bootlin.com/
> > https://www.sharpsde.com/fileadmin/products/Displays/2016_SDE_App_Note_for_Memory_LCD_programming_V1.3.pdf
> > 
> > Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> > ---
> > Changes in v10:
> > - Address comments from from Uwe
> >     - Replaced -EINVAL with PTR_ERR
> >     - Error check pwm_apply_might_sleep function
> >     - Remove redundant error message
> 
> Let's wait for an Ack from Uwe's side. If there are no further issues,
> the series seems to be ready.

Looks like I'll need to make one more version to accommodate the new
client setup by Thomas Zimmermann.

https://lore.kernel.org/all/20240924071734.98201-1-tzimmermann@suse.de/

Best regards,
Alex

