Return-Path: <linux-pwm+bounces-6545-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F59AEB517
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 12:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B71188D844
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 10:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0BC25F78A;
	Fri, 27 Jun 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMFJvfUU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63990218EB7;
	Fri, 27 Jun 2025 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751020499; cv=none; b=h4K1CGw6Tys7f8sirvRklpBcQsiUYgHBRNsmzsS5rViRm1IcN56ggLGi767qfdKhTI1dlcxVBQRaZiYPaqEMq6/Llo9mzVFhjLJWgRntvl1gWUWapf66+rIqZVQWXZxI4AaqVAYHzLxOnr5wb9n8kXyMxdhqJJkQhnUUMCL69gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751020499; c=relaxed/simple;
	bh=sP7eB94NnhZK1xna9CpCGCFE23Qc6HGEQNYmmcJR+fU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcP50liQwRA1yqr/PmfIsrVmDKDyPNWvWcFdz1tcBkGXrIfAQyBNR6FPn3wGqGJV2M+1VB4rGVIICaJANgFQWvNiuhBA9vMoIMpbA02zu3YhSITtviQjVjf3GNxEdKPqnJj9j2BAO+wvQJtgqrIwICobraKcwzix4be6tYtWwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMFJvfUU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so1767525f8f.2;
        Fri, 27 Jun 2025 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751020496; x=1751625296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FYCPYhXwvbl67YrntbHDgHlcse2PpEHhXgqEt3NJXKQ=;
        b=mMFJvfUUxzKwX4xRoZPfOms59Z6mZELgBR4nVhVOygCUd6YYW3ZIiR7OBMlOLlX0FV
         lnFPSu/JgVCLmuCWBYVMuTCvFKlRhU0MDpfGELj855rxJ1cWWxUlOau5LKhGqYrd1b3i
         MZlHht9tCA36SN4WQDg87pg2pNmDJhuCSN1Y3Wx8yZ/z3jY7WhAfVmMIDe9df/8PLHva
         KUfkpgHLCGlP3nr6pbik0M77t9TtsSGU3dkVB3fcgNDJZxbCDCHmcvqw2/jeiT6E52Ov
         +O61Hb7kVNCa1jo58SuxMB62mBLDZhHR+ELXZYxrEGARVk6bMX6W5Ki4XrUBCWdj8x/U
         5k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751020496; x=1751625296;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYCPYhXwvbl67YrntbHDgHlcse2PpEHhXgqEt3NJXKQ=;
        b=kKoFigmc3eLSOttoSZkX9O/+Ov27PB2E+qH4y56eonzo8exictNNt8htCvqE6nhvH1
         pvpwtrOSEibaN2Ow11fB8aZCCxBMu+e2zYWoxxrKnQOM6liXnN/2gTp8oUrQ5/vke6NI
         GR1lFniTfJmYsSEyG1xd3LHrbBDpMNnDxs8VuzGX/f1+KTMobLQ1THDxbeRHOtl/0jCr
         5/V3xyVRdDX9tgdCeVUHobq0kvsWg3wYW7UVyHaH6lNoSpUHHcYOeuYlq17AhYyzj8Nv
         6QW7/cIVymJxt9EK9fCbiO21YzLOSHZrZLt166NQZt1mj3os6R95NesaecJ2RkZISv8k
         9wpw==
X-Forwarded-Encrypted: i=1; AJvYcCX9FauI9K2HO5cSwKj6bFkNLW4XKx4FZ7RRCVW6gnjb2cFIk9JUUKURkbrx2zlDQe5R0/YsCIekBkQpgWU=@vger.kernel.org, AJvYcCXWCce11gnBcsJzDSjw7J7SPOk1Vfs/G449zcJOPtcMFXkNCBOTzFB2QKlOGrg+wN7kf4w80WM5jbN/@vger.kernel.org
X-Gm-Message-State: AOJu0YyJbmEjuLdtQNwjcNtRFQLMYAB2LSNmo2hPaJqwdfG7AZvetIMz
	iy5KMoneaEH1k6wJd//ncvHNpEdEpBJ0qKs+pqjgmjO+Hw5DVY2nkesnvdlzQg==
X-Gm-Gg: ASbGncs4mIRD2FulTn94Tw2z/YBgADBX+b6nl46OIXn95HwC/79h+LdClPqC6HEEg3t
	tXXPovDxLwIL4YSdL/EiI0lcHE0wwhHHvJ80y3j32NTDr3HN3tO0xnXhYN67XVpH+QwyHQhA5E0
	VdZuUWEyVCauym08NAqwJA321fxLdu2IdwRudEBbqwjwVa/OLBdJZEVfW8eoa4SmGmwgwvIEzkY
	mjCMaayRfZM2CnLDFuCZMDDRUX6S/UknyQtk96uAdYBRg+7qKCPSHTMwdTtgnc33VxtVuNneKm7
	dy6/wVuRI7EKLIB4trMsXr4DHKcgRhAdCH5EvF6WMa3AZcfgvTrfNnQfIJzxtug+njYiO81Eap/
	CCMUZd9bZ6za1MiCiPg==
X-Google-Smtp-Source: AGHT+IEpbbKGizSeHC2f9m6bPvaeLpE43IfxzxnuwTKbPHVI/5Tb9NpHN+EvY0SxhR3aaIJmzZgsFg==
X-Received: by 2002:a05:6000:2893:b0:3a9:dc5:df15 with SMTP id ffacd0b85a97d-3a90dc5df54mr2755755f8f.13.1751020495468;
        Fri, 27 Jun 2025 03:34:55 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa8aasm2298990f8f.27.2025.06.27.03.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:34:55 -0700 (PDT)
Message-ID: <685e73cf.df0a0220.214b10.9998@mx.google.com>
X-Google-Original-Message-ID: <aF5zyeGvNGX_q15U@Ansuel-XPS.>
Date: Fri, 27 Jun 2025 12:34:49 +0200
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
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF5xrHkTr8Tb71ZH@smile.fi.intel.com>

On Fri, Jun 27, 2025 at 01:25:48PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 27, 2025 at 11:32:46AM +0200, Christian Marangi wrote:
> > On Fri, Jun 27, 2025 at 11:58:04AM +0300, Andy Shevchenko wrote:
> > > On Fri, Jun 27, 2025 at 12:47:53AM +0200, Christian Marangi wrote:
> 
> ...
> 
> > > > +	/* Global mutex to protect bucket used refcount_t */
> > > > +	struct mutex mutex;
> > > 
> > > This makes a little sense. Either you use refcount_t (which is atomic) or
> > > use mutex + regular variable.
> > 
> > Using a regular variable I lose all the benefits of refcount_t with
> > underflow and other checks.
> 
> Then drop the mutex, atomic operations do not need an additional
> synchronisation. Btw, have you looked at kref APIs? Maybe that
> would make the intention clearer?

It's needed for

+       mutex_lock(&pc->mutex);
+       if (refcount_read(&pc->buckets[bucket].used) == 0) {
+               config_bucket = true;
+               refcount_set(&pc->buckets[bucket].used, 1);
+       } else {
+               refcount_inc(&pc->buckets[bucket].used);
+       }
+       mutex_unlock(&pc->mutex);

the refcount_read + refcount_set. As you explained there might be case
where refcount_read is zero but nother PWM channel is setting the value
so one refcount gets lost.

kref I checked but not useful for the task.

The logic here is

- refcount init as 0 (bucket unused)
- refcount set to 1 on first bucket use (bucket get configured)
- refcount increased if already used
- refcount decreased when PWM channel released
- bucket gets flagged as unused when refcount goes to 0 again


-- 
	Ansuel

