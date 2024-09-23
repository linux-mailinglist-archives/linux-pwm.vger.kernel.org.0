Return-Path: <linux-pwm+bounces-3323-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E918A97E4D3
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 04:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EA1281085
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 02:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7461FA5;
	Mon, 23 Sep 2024 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0Gcnp8M"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA22184;
	Mon, 23 Sep 2024 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727059046; cv=none; b=uoFUnSwWTLAlsnfk2isIIq1DSJPHaaeMHJrjqf473ilTLAL1N48Pn+xaqcqD6SDIqAxO2ingenDD6hcvpm23oNRyJQWTHHaRflEqd44A2gr2WZcwE1dwfWMYVK16oi+RQYrJvu2oo+AAUX1NgeXoSDjeRMcvJdyJFaocLwMvP7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727059046; c=relaxed/simple;
	bh=Ciikf128OS0hgTBt14xTPCABhuz2zFT9Q7RLcouaqOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPXUFcWrdCQ7K4oifAFBQ26eWEfWwvIMva6OxCXAsTuJUZF9Xf2kCVJ8Jv1JqNj454YZUsJjetcdBfTC+pxQrYkbiUMV4j2yHa18DKZ4toBhFJzTH1lViKnd7kesFDYRwvf8b3aLDpD6GLZ/LYjO6pQYg5bG/Ax8sIcu24hhk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0Gcnp8M; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6c35334dfb1so26274216d6.0;
        Sun, 22 Sep 2024 19:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727059044; x=1727663844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIqzX0FBqD/ZNeBFpuyexZ2T62Ip7J8jtfwLOqLZqmY=;
        b=T0Gcnp8M9mK18AtDhp2o1LPMI6vX8h471JGje8oGCfwsZjPHn+abuODZ84+B5Nim8X
         I7+nlhaTf65YAwsxGhMVhPjJp9zHNOmrqV8UDaWbl+gqbJHGnRtNijHjvNPfN0NbRUYQ
         g01bQSm2KFXREFZCY+6ftRoq9WNChkxBZa4cwdiLDITHTRPuxvbLnR0nldQBPPZTvvyM
         ioCCBdVf5B3m9jfhDExGB4ObROdVvSduyA1nBfn6fCMu1ogQZ8xvLsi7WhU+FwFRAU5T
         PP7oUa/mDyoatxn1GxdcLP53XSxXRXSj09WVJrAlTFJ9tV/bh8mb10CbgTUHb+OawLcA
         FsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727059044; x=1727663844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIqzX0FBqD/ZNeBFpuyexZ2T62Ip7J8jtfwLOqLZqmY=;
        b=tsk+LHVuHt0A+LSxp4AGOXdw5yElGNgsmlYYQWWveP9USpqxF8Ew66lWSkz/qexOFL
         KZmL9+1rpvyopq3CmO1v+KF6yF6T5vvys8tTLa86Wn9miZBpLDlvRirJlWQtPZAyl9ww
         lRqzZ5SmnR8bYVm/1Yn2ImpegZ8sq4zHGgxdG4+6hKPhWAFadyTX1/ubD50MSSx1dF+L
         9E0aydHzC14IKgXtJBIF+hkXg3/tzDt0JqPvDdlU1CEVCifzENmFx+qApz7xN1JquW7E
         j8HkPloC7Mdt5wjsb+TSxPon6IX13CtdLnn6+Hj3+b8RsVKUYKXwNr4JrnSS9sO/g1FK
         7rZw==
X-Forwarded-Encrypted: i=1; AJvYcCUcPtAbhKJyRoj4wAl4iKF2QZMP7VvLV1MiXppLgDA6Frnfij9HlhIYSttdnXdq1z045jY7PS6wXmn0@vger.kernel.org, AJvYcCV+zFkKTDMQZvF5i+pDiyudPGnj4NPaYHWcFmyH/bPdYAoWvAh7r0lkyYO79eUg5j6dL9v+RNZqcuyT@vger.kernel.org, AJvYcCXc4fHv4oHpzOSXHs8wbnUfqzlSU64zBtL7UZIU83A4KLIXRpzeUIiaoyU39Ni6FFZ2MRM0Jgc+dDcIXzas@vger.kernel.org
X-Gm-Message-State: AOJu0YzkjecJpw7D/HaIHp5roq9pGhLe3CnHDn6H6Cea6f28omP6Gaci
	DW/5JVD4YUY4Qd92+mBlXvJl7SLGEYeMU2VioQCqDwgA34iQYAKuvFS8R9+T
X-Google-Smtp-Source: AGHT+IE+mYw96iWRcnEj8dIXoH9CWm44dytWYvziov5CUGy0gWmSkBVDokP8NrxBtb+/rO6CisPuug==
X-Received: by 2002:a05:6214:3904:b0:6c7:c81a:690f with SMTP id 6a1803df08f44-6c7c81a6970mr133771536d6.7.1727059043749;
        Sun, 22 Sep 2024 19:37:23 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e557a79sm42696686d6.76.2024.09.22.19.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 19:37:22 -0700 (PDT)
Date: Sun, 22 Sep 2024 22:37:19 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Mehdi Djait <mehdi.djait@bootlin.com>, 
	christophe.jaillet@wanadoo.fr, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 2/2] drm/tiny: Add driver for Sharp Memory LCD
Message-ID: <mm52ohzvg6v2ggnlzin5i2bofuustwpmjhwtd23yyak3wv4ivt@z642uzexaumy>
References: <20240905124432.834831-3-lanzano.alex@gmail.com>
 <5brnhm3yqqbsnukllo4l53ohaeqmxum53mwq7dme74ny5dsnjq@shjoravp6beg>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5brnhm3yqqbsnukllo4l53ohaeqmxum53mwq7dme74ny5dsnjq@shjoravp6beg>

On Sun, Sep 22, 2024 at 11:14:17PM GMT, Dmitry Baryshkov wrote:
> On Thu, Sep 05, 2024 at 08:44:00AM GMT, Alex Lanzano wrote:
> > Add support for the monochrome Sharp Memory LCDs.
> > 
> > Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
> > ---
> >  MAINTAINERS                         |   6 +
> >  drivers/gpu/drm/tiny/Kconfig        |  20 +
> >  drivers/gpu/drm/tiny/Makefile       |   1 +
> >  drivers/gpu/drm/tiny/sharp-memory.c | 682 ++++++++++++++++++++++++++++
> >  4 files changed, 709 insertions(+)
> >  create mode 100644 drivers/gpu/drm/tiny/sharp-memory.c
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Please sort out the review tags for dt bindings (either as a v7 or as a
> reply to the corresponding patch). Then the series can be applied.
> 

Will do! Thanks for the review!

Best regards,
Alex

