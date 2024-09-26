Return-Path: <linux-pwm+bounces-3377-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44554987550
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 16:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7400D1C2530D
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Sep 2024 14:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5074313A24D;
	Thu, 26 Sep 2024 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og+xLFIq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A01384BF;
	Thu, 26 Sep 2024 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727360390; cv=none; b=eyz+wY3JN1/KVff+0OM3RR6MdJhV8k2U3QIHJt8GLnXb/Z8ibsd8MGBx79euQVhMbCZosxS3STJ3NPUFNi8z9NAcmFJvSXSV9wnxOHT6ZagPtS3F4Z/NcOtXyHcZEOe0hyNfIBkjfSUaQoTqFz3t83cPzerFl3RjiXrdsWJXE6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727360390; c=relaxed/simple;
	bh=RFqYzT/mEdIgiB6FJ5XM7lwMmktvYt6mzUSzSr6cvaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usio+AisvlQ2jr4kchHJAPfOuRqI9nWWiIee0Z/YqErxJ4YIoPfNBOWD9xFsVaM++CD9o6og3UptfQ39qtvxCqPDO97DtvQSeSQCrtr1Y9jkrw9BO1ajZCQwmV7TRdXmT/ulHZCs3bv+HU37PRqYUtIMeVAWn5q2PfRgi1TmHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og+xLFIq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2059204f448so9479975ad.0;
        Thu, 26 Sep 2024 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727360388; x=1727965188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFkAMzHwxIDRWXfTMuLhfcGNG6C28loXn9aYz20AdFs=;
        b=Og+xLFIq/uomocsRGxjrKcdEgQ9duXYvlYVrm/WcZzRx5xjRlGKhTptyb9BospriZF
         29AA8OZXtSEfWZWIlgdB9GtiBAPtzBPQy1njoYqdO3ZC7SaSnLPGZAjpdOFnKx3YlwXQ
         WFILXN6gr9C+1uSxKzmPSwzQ8Bvt4YdoV2EfT22YVg23gNGmupyJf5Xnak61675k3+c0
         TH1D2sRoll9q+q2eNjEHTkGv9GgdctARw17H+m4ZIeC3jC3gTCIMxzsMu4jTr3WxBMmV
         Be+tD9AbxROkk1dzdcJWwEOt/RerLaWsuwwNDecC+uJlxwXY821ZqEXDlaocu4ZYnM8P
         xocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727360388; x=1727965188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFkAMzHwxIDRWXfTMuLhfcGNG6C28loXn9aYz20AdFs=;
        b=GfRshpxAnOE8hO55Wo21tWNOif7xlgRuxZ92KiVWJBZ6BoM7rbDC28ivFwSpXibgLE
         1FDtztXT2F0Eo1M/1yjncmP4atrI+Pd0XJL7INU94ANE45kYhiZFF7FcCc+eKyXRXu0l
         G9CdeCMR3EWnGDSI736HMPQ0FcSHr02oiM49XyM1/zFcMTmGvV9q0rSmUu+IUAWbEbAS
         LwMqCZgTTY6tyLkxpU2VtuavaLV2wXkwLKKNYEMIiZblLiR+KHpVm5m2B7hdY82mVkSj
         tcH7IYCHE6Ltb7ZFuFd5jTzTM75qr+X5w0qOCynX4sdE6fNyu9FEvLMNlUySCQjjcOaS
         Ab4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXG3xdIZoNkc1gpaIJm7dAJmlCNZ+KOipGfhkM1+hsqU4AgWEqEdRZM0i01k4rGzTeOQkvadoG4xC9o@vger.kernel.org, AJvYcCXM5kNnowF3HFKf6YjfeFmJQe+MRsolV7Sip3wyvypqysEhDbUR83vBZKj/RqeNh8R4Tq0NArE7r8B3Z2Gp@vger.kernel.org, AJvYcCXs6goG4N0wfsLajdCF7TdDNA0es/N0u93s5Ss17R16yRlrZ395V7dsM4FHX/dgxWJA2XVrvOxV/Z06QQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2AvjZmh3piWzwDDQ1JHTOxj35qXgSRG/0qEaWNHtC+G4Bmbic
	hNhOVcoLY09mZQOn1N5F7bbA26xctvL4ULu0YAVr5wMsiiB4sIsD
X-Google-Smtp-Source: AGHT+IGZlWj6W0mVeziJb26C6kCddMl29225aY4d1xUjmLvmbE0PNRFaI1Gg5pW0xVVugbaz0OgKOA==
X-Received: by 2002:a17:903:11c4:b0:203:a0b4:3e28 with SMTP id d9443c01a7336-20afc486301mr87840675ad.27.1727360387713;
        Thu, 26 Sep 2024 07:19:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e6ba5sm39240055ad.60.2024.09.26.07.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 07:19:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 26 Sep 2024 07:19:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH] hwmon: (adt7475) Fix memory leak in
 adt7475_fan_pwm_config()
Message-ID: <ec56554c-b538-48b1-b878-938266d911fb@roeck-us.net>
References: <20240926-hwmon_adt7475_memleak-v1-1-89b8ee07507a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926-hwmon_adt7475_memleak-v1-1-89b8ee07507a@gmail.com>

On Thu, Sep 26, 2024 at 11:38:11AM +0200, Javier Carrasco wrote:
> The device_for_each_child_node() loop requires calls to
> fwnode_handle_put() upon early returns to decrement the refcount of
> the child node and avoid leaking memory.
> 
> There are multiple early returns within that loop in
> adt7475_fan_pwm_config(), but fwnode_handle_put() is never called.
> Instead of adding the missing calls, the scoped version of the loop can
> be used to simplify the code and avoid mistakes in the future if new
> early returns are added.
> 
> This issue was recently introduced and it does not affect old kernels
> that do not support the scoped variant.
> 
> Fixes: 777c97ff08d0 ("hwmon: (adt7475) Add support for configuring initial PWM state")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Applied.

Thanks,
Guenter

