Return-Path: <linux-pwm+bounces-3753-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14F19AB840
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 23:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886751F23FDA
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482131CCB50;
	Tue, 22 Oct 2024 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA7sOREF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA518DF6B;
	Tue, 22 Oct 2024 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631536; cv=none; b=GpDa33aar7G4LWZ4aslxXKewni1eTxrgDrZkLrkpDpm5mUQG4Xdmpv6kY3srVj0fgz3lAbXuxmxA1jvPSMF2h94OSN3SbbiAB7usGHRV05erJ5Ng2i4l2YyjilHoEUHnTlUsCcsGUPJrGWmPM53Cz1L4pFEHyECWpmql4z+CGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631536; c=relaxed/simple;
	bh=0ZbHdOdhPHO6tK5tV+5WpGsJUHeJH0s91iEhq1CXEmw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDo9gyMsfiZ3F+V7xsCCRkBhJnCLR6TE1F47taAi6nxoaV6Mha3GrELUhSYP0M7F4O/YRUuLjxdLsCR8b1kdyhUnzNQOVOd+D8LxDm+CCTuyNpSiIYaSaFbN6+ATMTgQn7Q6uIwQJGYzCn44WQ/2tVjMDIE196azMLWv77giHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HA7sOREF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso62504895e9.0;
        Tue, 22 Oct 2024 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729631533; x=1730236333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rNu/FvAWyLA/JckutZ/iwvJKerjABgFZGmn6jKJRXBQ=;
        b=HA7sOREFGFKULQWcSorVZRRb3/Rqm9SAEXsdRr6SNSE7V315hCCHEcjBoUn/jXJe36
         7k54v5xOvIttfWbzbbcZnXtgRNKtBAI+CLSbY5T2wSE6hEdBxKqgrfEV2u5ZRzpfou82
         Fc2YjidaYgpqie7OR0gHwHH08lcR5m015HaBAXG5QAlxjkYvUlOPebQGZNWIi8n00gc/
         dkkfPNLYXmgNd6egw8Id21XXxzUgwaNX3oK1v0xA7a/Pl6Sd0wTQYZ2tZGkisoiUShCB
         IQbKgnfJYzOPsYDpChIHfWzioEroBMJp4rXxr+PRzawmtcTckdhQoazNreNMjKrjS9KS
         o7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729631533; x=1730236333;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNu/FvAWyLA/JckutZ/iwvJKerjABgFZGmn6jKJRXBQ=;
        b=t/f9aGB10UA8qlAwuD/pPXG89NGrivIbiXRi0tRNUemAnRrQAOLdt/mvHoJJK50yt7
         SQSMXDYz+AwgwO26ABUsqo/d4iwTp/9cCbAAyHuK5aCxCckjQyZsO3/aHoGl6KU53w23
         6wdacRZBYn4N9M4IjIMYNZ2O+ZA2pL/VR50ItlLrSYfck5iXZCp6X9FyMDIzwnlsn/dS
         EK7qjVJqdThhgNBJNGUsrAqPRC7/HeA5GraVQDqpxqHJ0tVhpAryoXX0SkfKt/TSdswG
         eFuGrq3zkA5eHlGbKYiO4ByHQCVoQTiJTdn0OLDks2rARzDuyru7P5BME7Gnr5i60ejS
         mw4g==
X-Forwarded-Encrypted: i=1; AJvYcCVt6zUtSsHtiaMJBBn02tTUjgMd8oSYzwdSjM5clgqi+/50Kn2E02Kysy1sFpuPv+6ZRfxSp520hemEwg==@vger.kernel.org, AJvYcCWdk/Z+Po3SHGskjgqo4XopeoNyMcpGAcQsaPwTM7PG6fzmb3Kubk3qelzKwIwEm9w7mwryQXfX5nMM@vger.kernel.org, AJvYcCXO9liweXcKBnCbma/Jxx8qVCoaOp1tGSOvOFSKGUcxWvSpHrN/nmeLvG1wGAUlAC1GkC7TP01DBQS0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8PU28/wXlNMS0b2S9ghsjKdXO2NUIy4ygx4FC/5EPZbffMDJu
	okngGFG1vHY68VNWKOEytjkc0avgmYtRNrxmLAQL0IpkEazyybcd
X-Google-Smtp-Source: AGHT+IGa88Nr1D+evYXWzyT7ItOhzzlRaH3zdup02HiVkyXY0Xjn7H177GR7+9NtHZ6zi58DyBHcTw==
X-Received: by 2002:a05:600c:46c5:b0:431:54f3:11ab with SMTP id 5b1f17b1804b1-4318424f36bmr3854185e9.33.1729631532571;
        Tue, 22 Oct 2024 14:12:12 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c2fa7sm99791705e9.34.2024.10.22.14.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 14:12:12 -0700 (PDT)
Message-ID: <6718152c.050a0220.3afab9.2d2b@mx.google.com>
X-Google-Original-Message-ID: <ZxgVKCj-uBPlAxw0@Ansuel-XPS.>
Date: Tue, 22 Oct 2024 23:12:08 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v8 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
References: <20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org>
 <20241018-en7581-pinctrl-v8-3-b676b966a1d1@kernel.org>
 <20241021190053.GA948525-robh@kernel.org>
 <2da79425-0cfc-4c73-8fb9-bd3c92aa28d7@genexis.eu>
 <20241022210858.GA1565063-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022210858.GA1565063-robh@kernel.org>

On Tue, Oct 22, 2024 at 04:08:58PM -0500, Rob Herring wrote:
> On Tue, Oct 22, 2024 at 10:02:05PM +0200, Benjamin Larsson wrote:
> > On 21/10/2024 21:00, Rob Herring wrote:
> > > > +  airoha,sipo-clock-divisor:
> > > > +    description: Declare Shift Register chip clock divisor (clock source is
> > > > +      from SoC APB Clock)
> > > Where is the clock source defined?
> > > 
> > By measurement the clock was found to be 125MHz.
> 
> What I mean is the clock input should be a 'clocks' property. Assuming 
> this is a clock input to the PWM which I'm not so sure about given the 
> other replies.
>

Yep it's not, we are just dropping this property and hardcoding it to a
sensible value in the driver. Sorry for the confusion and thanks for the
clarification.

-- 
	Ansuel

