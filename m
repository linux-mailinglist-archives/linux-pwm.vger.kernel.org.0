Return-Path: <linux-pwm+bounces-7274-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D69B4ACCF
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 13:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78B2C4E2B79
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 11:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716E82DA753;
	Tue,  9 Sep 2025 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6XLhSD1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9672FF679;
	Tue,  9 Sep 2025 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418678; cv=none; b=VZuRNdo9AEKbd20zB2vhQm26hhpXJQ0awv0fuBjOGK0eIalJbfyCvAEHgl2UTZm8S1BuwtbQ55x+I9jNc0ZGQLgh+bTUKnfOPa/48VGs0UqhXTivzLyeg2Yu++UHSPD8urYYnDHMwAKftIyE8Dcs7bJvgQZYRbri78EJwVr853k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418678; c=relaxed/simple;
	bh=CQ2kvUrg6Xjd4oVzfUNj3+9j/ESLXxfsuhnrta3/iZw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN3dyIbbandUbCvUu8hVKC1nAz4CXUZs7PZgacRk6xMyJXpV0fPGH0VzUSjNSXpSKxsR4waSokDD502FpAChDf3ULqcOhstX5fUkN6iGg4VEgEY/vhSm+sOAqUZN0vvN8Sc2/eJzh7Cb0OUHZRHvvIDtngULjn5zmin6AR40CY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6XLhSD1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dec601cd3so10182585e9.2;
        Tue, 09 Sep 2025 04:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757418675; x=1758023475; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1NZefnU/TEFBNRXWXEE9bc33fov8eD6d4SSSVTMX6fQ=;
        b=j6XLhSD13Cd1C78O0EK0fk5ORz3UU5dH5B8PAEH3G6hP/sxlkkm6j8pK+0p5ooFZjI
         k1Xdyhxal3RrimEppYRTPJzqBQ+ZsDZcXnsqEseNrIp/P6NocTd6Cenfbe2t9N4Tx5jc
         76ae8bTVolUiuUvcj8zHOVYUVS4/cxJkiteKb8diAPrhGdJgVcGDUWXG0T96Uwd78i25
         lXRVQCuz+G8zb7EDDccIPby69+GX8wAtl+YtPSUpoMNZQ8aVZw+V9bVJ7tSCN7OzIkGr
         xTFogBJpWhdb4kQ6DNz2R2e2RQWeteqHPSXsG5xtiSCKHq4CPOo9Yluv+h8pdI0y+vG4
         0qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757418675; x=1758023475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NZefnU/TEFBNRXWXEE9bc33fov8eD6d4SSSVTMX6fQ=;
        b=ht3EPP6kUdzV95VEst9KAynUSz2xdU+jAeSUqxe8yzm+sAzrKt30/6e1VnvGKgQvOP
         7Z7jxA3wc51jTJsS1RkEWkOvLMLW8KgPVSEPtqAJHceltbZNzINQWt5Kz3bj0pENLQSu
         iiQ6MzxrIVxpD8M24iboOxThMh3CS8XlMW3kxuBUUgishsq+mDEDiCHj9qpdYocbNT7t
         RfCkMeQP1L9f2p8nTvofim9xCK5lsGOENu4H6Zk3tn5MzQf1WUH1lIiPlwPEnir+xncN
         O/RXI8Qz72LZO2xCmJCZYxDKZWX8AauvHIfZ8ccVa9ChK/b7yBhVsJa3ASQhDAINpN1Z
         6K2A==
X-Forwarded-Encrypted: i=1; AJvYcCV9D6PeS7c/tbbCLdQy3+mJXETROV3encVRyPhCqMRr05X4uUVt890m1Dr2Zccf16HE9yYfVGbwSTegws0=@vger.kernel.org, AJvYcCVD8Q1XeZC0TatmWEmqjJyk1FmXKyRmxHNrXddNnM6b7lKyVlb5H2qKUe+7h/nA2XwXsJ+6JTLiD+hN@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1mLPsQsG15dV0p4RjHfa47gPHx2nW9glFLh2RasOlnOCy2g0U
	x7+n9RKcohKmXhRW99ecroxBb8XS1aD4Kx/OLW/qskKvDqFDNHNzgXm1s9MhLw==
X-Gm-Gg: ASbGncsUQJ2U7MGvuglwjvZepftK6WQcJ0Wmgo/8zotk48MnZB0cQAKnyak4GZmt/Bg
	2JkXI+ITQ+mvVwETB780DvWrEkbeoADQaJ5sSo5DQv9aNRwRiY4LxYOmNqMBfkh4DgW9JMd608m
	xDrXTGeR3/KCUW+jMqk2TH5YUTODTPfC9TgBZmDXsZxr4SpTAUjEG9k0W+IOxAepQWw4ixGMoui
	Dh7GMz4CXI49NpZyy5aynBXu03S/fKItc3sWTtFuQRCcvOLBJoXpQHhzHHwNhakf4keJgHFFvra
	CpBtNra+CRmV80XEMEObMXuVGFp+N4Zf91oFfxGPH3RND36VentIuN6yiUYb/203i0qyKY47lL6
	tzfVqtfbcTGvR04MNNFzNhPTwfb5+KlVtgPWP+VKxCkUAHmdAZKLOz6vQXVT1UyPpGAE4dg==
X-Google-Smtp-Source: AGHT+IHTWH8ommu1eqeJFqp/ipl2TcaTWoGb6nKtp3f3NpV93jfnIvywQBe/XfNRedQFhyUhQFBdIw==
X-Received: by 2002:a05:600c:1ca0:b0:45b:8352:4475 with SMTP id 5b1f17b1804b1-45dddf02148mr111281745e9.36.1757418674241;
        Tue, 09 Sep 2025 04:51:14 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df16070bdsm8432555e9.3.2025.09.09.04.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 04:51:13 -0700 (PDT)
Message-ID: <68c014b1.050a0220.1de3c.3050@mx.google.com>
X-Google-Original-Message-ID: <aMAUr6y8dHTzFrU7@Ansuel-XPS.>
Date: Tue, 9 Sep 2025 13:51:11 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v23] pwm: airoha: Add support for EN7581 SoC
References: <20250708145053.798-1-ansuelsmth@gmail.com>
 <xsblhw36y3corxx3pxe6223auirrsqr3efovfnrm5lbo4xy3lf@wf3ytlivzv6g>
 <68bf2509.050a0220.702b3.c003@mx.google.com>
 <aMANiyqxneM1QxQ-@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMANiyqxneM1QxQ-@smile.fi.intel.com>

On Tue, Sep 09, 2025 at 02:20:43PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 08, 2025 at 08:48:38PM +0200, Christian Marangi wrote:
> > On Fri, Aug 01, 2025 at 11:15:41AM +0200, Uwe Kleine-König wrote:
> > > On Tue, Jul 08, 2025 at 04:50:52PM +0200, Christian Marangi wrote:
> 
> > > > +	 * Period goes at 4ns step, normalize it to check if we can
> > > 
> > > 4 ms or 4 ns?
> > 
> > 4ms you are right
> 
> One small but important side note (to Uwe as well, however he seems
> follows what I am about to say). Recently I discovered a nice wrap-up [1]
> on the writing values with units. And I think we should try to follow it
> (at bare minimum to be consistent with chosen — Journalism vs. Scientific —
>  style).
> 
> [1]: https://poynton.ca/notes/units/
> 

Just to be more precise, on comments we should use NUMBER SPACE UNIT? I
think for variables it's problematic.

-- 
	Ansuel

