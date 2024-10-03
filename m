Return-Path: <linux-pwm+bounces-3441-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D62198E871
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2024 04:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6CD280F1B
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2024 02:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827B417993;
	Thu,  3 Oct 2024 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3zqQNe+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B1816415;
	Thu,  3 Oct 2024 02:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727922800; cv=none; b=PjdAkDr3eN5MvVuUlwoQ6xxI2XER6kZJ/QP9LPgnRH4InorJgyalvnEjEesZpqTl33/Zjwb2/hh6Q3/ZgwURtYSySTyioWoK66pkWIuoVQf3MjRPsnJt8z4R7+R0yonrHtUKC6M87QIK6PWur89uOpIXWqz4s9VHrObJT3oqc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727922800; c=relaxed/simple;
	bh=ievyg8trTrRHAB+z6Z6DCj1Tu10iG5GzPRJdGpAVUbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAYgp1p5EDcjsL9pIBapXHqX6d6/2xju/AEoBDFO+bzuSe9DsTbZ+T+w+ADTEbaHh8Fnp6c+B4HaaZIl9EXWmVvFvLJ/KDY0getgqoIKd6ZGn5U8X5z9iIdxRfRu3YJGYed6/PKTlz3z2/0XQ6RfMWJG2/od7lPbtcx7r7TiMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3zqQNe+; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cb2458774dso3668176d6.3;
        Wed, 02 Oct 2024 19:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727922797; x=1728527597; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xkpfPr0EYRdlxNhthgj3FTAxfyKqmJJR9nkwDDTRTpI=;
        b=l3zqQNe+FyOfhgo1e2Rc5FdgJUNyLfr6WYmEVZaaEcd+pyudEjH3lLXWJC8JUHCIty
         t7SWOFZbkAomhXtZKobA1HttPnViEcZ/B9c8ssFRu2tCdSFOTUVJELVyh5vWoI0c6Vtk
         nbVdcauHk6UmAGMv0oP+QMOzMs+1D4oGCciLxeL3+KvqSLOKfdat7Ltr2qn+gTKBqzCV
         wjvVMO+uGNxqfyFBKrdF0aZ5dtyTyukZVSxec3C4Dw3J9WHxcmpkpXvZwdu0kYwrVIkm
         1Vv65Rcaw8aqZost4vC4+5WBovN2jjISm7w9dNkObTWWvo54DYQOOa5BK0gpmt03Y+mq
         7RQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727922797; x=1728527597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkpfPr0EYRdlxNhthgj3FTAxfyKqmJJR9nkwDDTRTpI=;
        b=IHPRM6QEqs5GC8HtEjoVMvQZzPgTcisQX975ENwJrjeEnExUD0WW2f1rhfTDs+tg3N
         KLUEe2u0BE7WiqbX6Ul1Uqgk5lC2XAJ5Q/aHFMNtp/8leuucd8PlqX+GrsUqyhAENTuh
         3jGANE7iOkzNTJXV3pEjfXcrBkW2QGADMcrQ3ebmbrvLhtI825R6K77FicVvAesYoELp
         aTszZcE+vNKiBprxatTXjlD6rh3ix6ajHylxmKmonSxWOSNhR2fvKkJjYHV1z9+//tFF
         Oulyd3YKJRdfmolQGkbSAFOzYuex8jSytJRAGXULTYQs3S/Q5hA9YWwJJLb5+HZV5k8e
         OcsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNndxGm5ctYh/+jszHrzDo44naB39K7H1RBRsPWNmghCEGiGc/itBOUZBh6i/h1GuGaGS3cBLBOXFT@vger.kernel.org, AJvYcCWbg3FJJpJgTOFLb0snP9M0ijHBc1EiA2FjkMReivw/9ioku7scaTnT/q+4M6nKVi4tC/hL1HTwhv6z@vger.kernel.org, AJvYcCXYU613aB6DggVkjvuGHpA7EELuW4VJMwFwK2+5JHK6EMEKs6hOAouy65FV2gEnsBIA6c/7SSThTpcOH/mW@vger.kernel.org
X-Gm-Message-State: AOJu0YyMd9IC5Mv2TCnp4HOkLKkggI1e+2S7CtiElEXj++umU9xd1362
	bVHS0OxvYKnbJr2HSRkhqXJUFQxV+pA8pdjIVN+FtxqIlrqCY7tH
X-Google-Smtp-Source: AGHT+IFI/jVC3KeK2s+JU4a0+Yt+Rz9wy+dcMj8aCK/vKQWCiYwY7iHn9bnCY+q25G+oSsBZcN4Q1w==
X-Received: by 2002:a05:6214:3f84:b0:6c3:58b7:d703 with SMTP id 6a1803df08f44-6cb81a24c2bmr86793316d6.22.1727922797436;
        Wed, 02 Oct 2024 19:33:17 -0700 (PDT)
Received: from VM-Arch (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb937fba50sm1501446d6.116.2024.10.02.19.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:33:16 -0700 (PDT)
Date: Wed, 2 Oct 2024 22:33:13 -0400
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Mehdi Djait <mehdi.djait@bootlin.com>, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v8 0/2] Add driver for Sharp Memory LCD
Message-ID: <ees3m2qmazah2547ys62zvbrvo4dsgki2z2jwulwz4dfjtm4hk@kpmlapv6occv>
References: <20241002033807.682177-1-lanzano.alex@gmail.com>
 <t4lefcykpoe5i36wb4x5u23sseh6drnphtivuqc3mjviat2vvc@7hg4jyhxvpye>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <t4lefcykpoe5i36wb4x5u23sseh6drnphtivuqc3mjviat2vvc@7hg4jyhxvpye>

On Wed, Oct 02, 2024 at 09:56:38AM GMT, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Oct 01, 2024 at 11:37:35PM -0400, Alex Lanzano wrote:
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
> > Changes in v8:
> > - Addressed review comments from Uwe
> >     - Replace pwm_get_state with pwm_init_state
> >     - Use pwm_set_relative_duty_cycle instead of manually setting period and duty cycle
> 
> You didn't explicitly mention that it's fine if the PWM doesn't emit the
> inactive state when you call pwm_disable(). You're code should continue
> to work if you drop all calls to pwm_disable().
> 
> Ideally you mention that in a code comment to make others reading your
> code understand that.

Sorry about that! The intent of the code is to stop the pwm from outputing
when the display is disabled since the signal is no longer needed. If
it's best to emit the inactive state rather than calling pwm_disable()
I'm fine with making that change.

Best regards,
Alex


