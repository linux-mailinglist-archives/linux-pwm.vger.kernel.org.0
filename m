Return-Path: <linux-pwm+bounces-6578-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16F0AED99B
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 12:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D9F189A46B
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 10:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85042248F65;
	Mon, 30 Jun 2025 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH4rrLza"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD81A34CF5;
	Mon, 30 Jun 2025 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278768; cv=none; b=UZuPhTgC3M4uhKeshbWl4KIFcQKKTmMsAE4iebGfeLmC6x9bmUJyE52JSyBOwom6WBCL+tCxgucokbaCvIGBGo+0sTGjdEXzbcWw6Ween59/2GXE5PMO5d5k08kZMUfxSO70rIQ4YSgn2reNnzT5zcqMoZsuK8M99O7tVKWU9yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278768; c=relaxed/simple;
	bh=o0/xe/4JWB/9UT/btiB4gjB1qHYPUz0dQhHO847HiS8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvwiOM9mCY+MXNdrTTovhIAbKSPMrQKGiXaeJvvBrsXYspoaCDaXwrUfsRiziKK5xjJ9TwDxUTUpYi8f++C+3BZcfKyA8osm9AQfkBm6NEHAG4+huHUgS/+28KPv31uOLDJFuim+JM2GF+3y9IsEYrMIMFRx4jKqXPkaIdPTvMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH4rrLza; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a6e2d85705so2353963f8f.0;
        Mon, 30 Jun 2025 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751278765; x=1751883565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YYytyjnVKf5f7mpQA+qzmKhKa7r+QZu71oHHNPXV1Qw=;
        b=PH4rrLzaXKduyyz1sE7QJSrtQidLp55BHHxfSTu/+1d4Ziix6S0E7za1BPx5yxzHtf
         tSNNQGLpNj29QmqQ8azlZ2aLlyC+NOmBBLfzPhcmSNY0lg36XBSghzgfnPnkSzdMJUfY
         o5ybge26veLvYTk2VetN+2ZRHsiXSJ9Y6n42mmyGGyiJG0k3yzmxLL8FHN+9YEhPAUQ1
         T5zTnpP/KMoeNKlVvY8m9WzBNhoncuEF/iwZKH/cAmgWXMj4WptXG3u8Lwj95yEx6wgB
         W01L+OTO+TEF1y7SiG1BWfoZN9UIcmEEbzxuPA31Z8dEQ1WiW9PwyD9lNvT5fnk8BEVC
         5GAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751278765; x=1751883565;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYytyjnVKf5f7mpQA+qzmKhKa7r+QZu71oHHNPXV1Qw=;
        b=oQ87e7oZCud8G1K23FvX8ZKc/zXNfx5SS3Zv5QQ/CmhChKWnxfU7u4mYVc63MG5kBC
         rVdtKy9yUfB2qyi5P93jYBYG11jdIWFptHBtU4Kt+j5VOpreaJslmhufEMTb+zkRfm5Z
         m7QgtaaBCq0j+93GjOAcXo8Po05aBN7nF9OQ4dfF48NevESIjnN+v4a9aF1+CDiawF02
         6nJD3uFrzM9ZgjJBzTDJznVC2PgDo1YHzV5kgT0QUdVz0e7NSvDo35rzPMSvTQa/rPDL
         MqkIbWmq/xtZGFExfNt3KCwIxV/j6RRGllgwyAc4sFOR2k/Pa5SmGGP/JITq6ZcDI9O8
         Zr1g==
X-Forwarded-Encrypted: i=1; AJvYcCUrUC90QHjDgzS5MDqRmcnkwFJhtpOw1yFoXcAkWHjuSg99UpC+hUJoHesYfWZq9TOhiRNz8cqIZzO7@vger.kernel.org, AJvYcCX1VSJ3as1cVzP2tO9QAIKohXMOOB0U5BaZOuwrM7p39jA7ry9wI3FovXw/T6I8g/ZLXkBSlJW+ghv0QQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6CSvMqekPyidNJdjjweYE2Mnux/Xu8nBxUbjfGtmPwHxKioV1
	24I6XzsdWrkx16cM1Ym6aWq2UuNEyEIi/1D0tUswwkt2y+iUdyLvzXnj
X-Gm-Gg: ASbGncuHeguvm++lNXGXlKd/QqBHu99s3Z114Tq2OjMpAJwqCfI/m4/+X/Axxhh3u77
	HHBwQy5OSVSZNmqUIx7J8TyIESuDuR/5iLkq73rvTJ6tcFnsSE0wSUZ0b0x/lJsLrIwZsPYC8K+
	703AdnUr+O3xxOmk1v0+PDThcwbOcC2tjty20PKwSfrutcAW05DpNwmD9j62Pf1vN7lUqt20jCY
	IRsLKfL/Ebw7PgYwhCeWPUZAhFGv6aqaqtrRXyfEKVXoe5re9QVHLN7zbsxJh2apeHN+kknZsgp
	PwOkTOiaWv0jxr0zdl81GTMFmPDognppsDV9fqztikVxXGn7UsIoTKNfI+18IXq7mYFClLNrpxV
	3MsI+LDGKHpJAD+LWwOfLIjIYwmipb5I=
X-Google-Smtp-Source: AGHT+IHpTZWldZLghotIau2Mlg0lfLxdb5ZY7nUx9Y4IMUxtmaELb1sia+Q2PUSneM7iCe6V3UVM0g==
X-Received: by 2002:a05:6000:20c4:b0:3aa:c95b:d1d9 with SMTP id ffacd0b85a97d-3aac95bd1ddmr4729133f8f.6.1751278764716;
        Mon, 30 Jun 2025 03:19:24 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-3-254-137.retail.telecomitalia.it. [87.3.254.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c8013b3sm9999344f8f.39.2025.06.30.03.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 03:19:24 -0700 (PDT)
Message-ID: <686264ac.df0a0220.feace.3044@mx.google.com>
X-Google-Original-Message-ID: <aGJkqsNwztdjl-ow@Ansuel-XPS.>
Date: Mon, 30 Jun 2025 12:19:22 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v18] pwm: airoha: Add support for EN7581 SoC
References: <20250626224805.9034-1-ansuelsmth@gmail.com>
 <aF5dHDr8yDSKlp5j@smile.fi.intel.com>
 <685e6544.5d0a0220.20cf55.9440@mx.google.com>
 <aF5xrHkTr8Tb71ZH@smile.fi.intel.com>
 <685e73cf.df0a0220.214b10.9998@mx.google.com>
 <aF544lt-9YJq8r0y@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF544lt-9YJq8r0y@smile.fi.intel.com>

On Fri, Jun 27, 2025 at 01:56:34PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 27, 2025 at 12:34:49PM +0200, Christian Marangi wrote:
> > On Fri, Jun 27, 2025 at 01:25:48PM +0300, Andy Shevchenko wrote:
> > > On Fri, Jun 27, 2025 at 11:32:46AM +0200, Christian Marangi wrote:
> > > > On Fri, Jun 27, 2025 at 11:58:04AM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Jun 27, 2025 at 12:47:53AM +0200, Christian Marangi wrote:
> 
> ...
> 
> > > > > > +	/* Global mutex to protect bucket used refcount_t */
> > > > > > +	struct mutex mutex;
> > > > > 
> > > > > This makes a little sense. Either you use refcount_t (which is atomic) or
> > > > > use mutex + regular variable.
> > > > 
> > > > Using a regular variable I lose all the benefits of refcount_t with
> > > > underflow and other checks.
> > > 
> > > Then drop the mutex, atomic operations do not need an additional
> > > synchronisation. Btw, have you looked at kref APIs? Maybe that
> > > would make the intention clearer?
> > 
> > It's needed for
> > 
> > +       mutex_lock(&pc->mutex);
> > +       if (refcount_read(&pc->buckets[bucket].used) == 0) {
> > +               config_bucket = true;
> > +               refcount_set(&pc->buckets[bucket].used, 1);
> > +       } else {
> > +               refcount_inc(&pc->buckets[bucket].used);
> > +       }
> > +       mutex_unlock(&pc->mutex);
> > 
> > the refcount_read + refcount_set.
> 
> Which is simply wrong. Nobody should use atomics in such a way.
> Imagine if somebody wants to copy something like this in their
> code (in case of no mutex is there), they most likely won't notice
> this subtle bug.
>

Yes I understand that someone might think the additional mutex can be
""optional""

> > As you explained there might be case where refcount_read is zero but nother
> > PWM channel is setting the value so one refcount gets lost.
> 
> Right, because you should use refcount_inc_and_test() and initialise it
> to -MAX instead of 0. Or something like this.
> 

Mhhh I think API for _inc_and_test doesn't currently exist and I don't
feel too confident implementing them currently.

> > kref I checked but not useful for the task.
> 
> Okay.
> 
> > The logic here is
> > 
> > - refcount init as 0 (bucket unused)
> > - refcount set to 1 on first bucket use (bucket get configured)
> > - refcount increased if already used
> > - refcount decreased when PWM channel released
> > - bucket gets flagged as unused when refcount goes to 0 again
>

Do you think I should bite the bullet and just drop using refcount and
implement a simple int variable protected by a mutex?

-- 
	Ansuel

