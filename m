Return-Path: <linux-pwm+bounces-6507-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84BBAE5FD8
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 10:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718FA4A4849
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 08:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8DA279782;
	Tue, 24 Jun 2025 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFP07deC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3617D22A4EF;
	Tue, 24 Jun 2025 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750754888; cv=none; b=GR406Wc50m4QnkfDl5NO/qrJnSyvasaJ28tTbZCgDvp0v5FrSlWYy1GlGBWgL71GTvXk2daO3iLenV6MwDuIrLQTsJTIRj9eJtTfKOZEi8W7GUj0hyKLlSR2SgkoKk2yScxe5unAUBUGFaJ5t27FBcQcVRQVSdw0X30pjJtVNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750754888; c=relaxed/simple;
	bh=NOQI8g4dfs0HYeDLDwfEccbzpLfED7N9UEukFoQp9WI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqJzHqj4dKHlNzpd1tZtfCJD++34AxAzloMKMb4avBmj4LHi8N/7lZ+kC9ZaWGoKvVcOV9RsUKFj5wEZXevFVIWprpezFlGEqEVpAdpyy0w62j3KLcedKBzQ1HvNDrxCvcNbCj91av1miG2j0ab+aFxKuzNGcjofpdpDlroy30w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFP07deC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a6cdc27438so4307964f8f.2;
        Tue, 24 Jun 2025 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750754884; x=1751359684; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rv7eKaKc5LbryF7yhD1E8x8iFqDYhUljO3uszUBAt5g=;
        b=UFP07deC6z4/6jjjv2MXWxLfUv9T8tY9PcypyH7kQ/GON9ahmXtmeVvwf/C6/fI4Sj
         hTryGn3eC5IGslILyFIdqe+x38tOA3SY6nrAJJCVUJlp2WcLWyyYmWWS8pW4GTYvn0zg
         0z8VuCIxGacI+Enz9VPalK+6zM2XACCUb4Z+wMOMQMB5W2zt04B28ZklsvbQG61sC3I6
         sBG/lyPVX3vbJPLDC8hzmEHDUpTroVics3ZvXKMuUzu8+KFmNHOkwSJHt0VSClqthuYJ
         O+CdfJHNmOaZZZD3zDFAEmbQCoLxNy9iNmCkWtMDNtHAi+sR6PISrdT8wISP7GCFODMu
         qh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750754884; x=1751359684;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rv7eKaKc5LbryF7yhD1E8x8iFqDYhUljO3uszUBAt5g=;
        b=CurCQB4W2bA1oP1QO8FE4CzGkPu5CaPkbCQpo4iUazTZpVw34eYpjiFANbWeRiWVYX
         RerRkXPBntLz1istZxBKm73dM5syX7GTCHV2GU77pfMk431Jownr4+QBx8jL8twhteHg
         jtFlFz196GdTp92s4ysvenaP9vmhGAC9EZ4NgMpBO1VNVOpXS90094samCWRaK/DDlbn
         F8ykk2Kr78Em2EpvfNIyyt3n0WuAaBTPEzkfpMAcOImrwPViGvT3L1DyIZa19rvgZ/+W
         +iJFCNCDCVpf3qUzlIPwu/kDiJl0QvtCXb/nkIiFtteILIc+OLYMZ+ZLTwRtTIsq8SWg
         B9Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUtzRoFGBmhfEUZB/t41L2ED7IHC2FpAF7OnBap/SLaz14ToUQoQDVhOaH4YaiXvlGrAYcT06Ftcldy@vger.kernel.org, AJvYcCWk9kzk+0PGVsE97Y/bRAwIzY94l1NWbRW35zhZc/SFLkMhq0rLI2kzZBhmcZCIWnq45edJsd1ksettaJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoeEoxCWQLIHMZm/78ktotMfDTYD4lbWK6aok8+X8CZANyrAUw
	S0DsRC/m5f1dmE9KguNZ9s9cOLdF5z+6FQ0m+fuCCPX7kgugIm6OB5dk
X-Gm-Gg: ASbGncsT5xn+Y6v/RILMTos73pT/LjRhprOt/XFgqUPSEpLvXgJ6viAne/L/E3w4Bxy
	jic0jZra1HGWnz2QJ9QGsGwGC/qRFqanK/A+di7k1kxUoGLO5bSu/lE7E6g4UWquMxQ1DLbfkub
	QJJrmN5nv9I1+sa+4R3TTITdjN6v6lOAr8k6Vs+sigQLKqJUtbLlNc2fNKa+yfdja9NQljmutw0
	BdttP05a9rCCBWkU+PdQSusQkoQ5TC3V3TT6cQVFyMVl3zcBzUMayEBNcMIJheV2pqSI4NtJeI1
	fH3Htpk1yUJ0y6AWrU08uzVnCtWNUPKXR8cVe8ewJWXusQfpO0K/9Az28BW0umCZMMitraQvbq4
	aWnNKDw/je3AE1loN2Q==
X-Google-Smtp-Source: AGHT+IFn++j+s5vAIqZEneBuH1SwkdqABSpMqqdDh6+kFSBu93Z8sJ+i3oZcwTtUI6k9wNIxDrILFQ==
X-Received: by 2002:a5d:5846:0:b0:3a4:e6e6:a026 with SMTP id ffacd0b85a97d-3a6d131708fmr13724969f8f.28.1750754884379;
        Tue, 24 Jun 2025 01:48:04 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb641sm140195965e9.3.2025.06.24.01.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 01:48:03 -0700 (PDT)
Message-ID: <685a6643.050a0220.167500.2f82@mx.google.com>
X-Google-Original-Message-ID: <aFpmQO-woMQLx2Lf@Ansuel-XPS.>
Date: Tue, 24 Jun 2025 10:48:00 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v15 1/2] math.h: provide rounddown_ull variant for
 rounddown MACRO
References: <20250623211116.1395-1-ansuelsmth@gmail.com>
 <CAHp75VcWW=RaHS9Yb8BcK2Jt7qtNOQzA3eDOZQ88RQG63981cQ@mail.gmail.com>
 <685a5787.050a0220.20ff0f.fd7a@mx.google.com>
 <aFpkmjlc-14xxkn4@smile.fi.intel.com>
 <CAHp75VdNm_3ASFytiY616KsbbhfKFOicCwwNATbFQA68ZgVbdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdNm_3ASFytiY616KsbbhfKFOicCwwNATbFQA68ZgVbdA@mail.gmail.com>

On Tue, Jun 24, 2025 at 11:44:10AM +0300, Andy Shevchenko wrote:
> On Tue, Jun 24, 2025 at 11:41 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, Jun 24, 2025 at 09:45:08AM +0200, Christian Marangi wrote:
> > > On Tue, Jun 24, 2025 at 09:08:32AM +0300, Andy Shevchenko wrote:
> > > > On Tue, Jun 24, 2025 at 12:11 AM Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> ...
> 
> > > > rounddown_ull()
> >
> > Btw, I don't like name for this, it's better to be in math64 with the u64 or similar suffixes like it's used for div/mul variants.
> >
> > Also add a roundup to make the API symmetrical (yes, it's okay that it has no
> > users, it's a macro and doesn't consume memory at run-time).
> 
> Ha, there is already roundup_u64() in math64!
>

Ha indeed! I was searching for roundup_64 and I missed the last tiny
function in math64.h. My bad.

-- 
	Ansuel

