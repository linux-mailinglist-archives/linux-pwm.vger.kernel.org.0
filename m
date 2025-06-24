Return-Path: <linux-pwm+bounces-6502-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E743AE5E4B
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 09:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863141BC0FF2
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jun 2025 07:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EFC2571DD;
	Tue, 24 Jun 2025 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EN/DqN8S"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40102571AD;
	Tue, 24 Jun 2025 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750751116; cv=none; b=APJVO3THenDlBdD9HQvqUXGmwb9JLMK4YLpcbYt98iFCcB4PPmakpXU6n7YD5Kp6Gern2CYeTi6fmUaRO1nzJUzrzWuLA+mTatZj9TJpot524V43xRtA3s8lXvbjAIfrUaPdafud8CkWOkVKFLhjqLYizMVTLWLH6m7wTcVWPJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750751116; c=relaxed/simple;
	bh=OMYfjk/HFBuh+RTKM3jVKi0nByrXItMtgixjn74Xy6A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLv5jK/HO+G+xSEpO/5ujEPW6GS1BlS3JgsGByJ98Bt+XgSenUcrUCNSLCXmbk5yqlWGMGNZlR1rveABJoJRD3KJOSVD0LjIrAoOgJLJqrCR4NkA7HZDjQq4B5qVRtgNKIAwh22hnBgxI0J4U7NZlwJIMQNd1rR+vEiVotzXlQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EN/DqN8S; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so3931910f8f.1;
        Tue, 24 Jun 2025 00:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750751113; x=1751355913; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g0Qw5wb1qPbwmyPbsLrs16hi2rdMz6r9QLI+Zkxs80I=;
        b=EN/DqN8SQPSyhcRP+BHiwZGHKO32f62KZ2sT8LdzHAa/b94z35+3IZGbyHDdyYQbws
         3akHsaFvQ/cm+2vm039NwWc/xJXzNAKr77EuD9sE73L/CoULckEbSUPhhBa80+GEESda
         6SxEtLMP6j+O3hhZqQjPNJ0teR1t8Xahx1eOz54pARkv3kQQSOhIDFMsV+XBuGdBR/hP
         XxnYCFngrcBAx3GApXYpVeVIs3pZ1CxnKT/t4vP9ONDYCI3ereKaGxn7yXCd4FJcJu0A
         XXywV10AYSN9w5UTBhI62VQsKBSIINZ8CQF1cx3M8BERM+bllgLaKeNV/n+cMy1xwWW8
         XQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750751113; x=1751355913;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0Qw5wb1qPbwmyPbsLrs16hi2rdMz6r9QLI+Zkxs80I=;
        b=TCqD6Rno/nS7iMJ+pJog/SWwz9+Bmi2v72lb4IGXH74vrn+5Yd+PTuQ3avUn49gJs/
         aAbgnS3hdAbOrK8WasWYvG5DoHGJT7RTMWMg5UrBQh5jQA682NVegTWm7sM9mTV2oHUI
         ZRtsef8F1Q3FnRWqiPsvDbvl8ZYBX+E2SUXaeN7D1vduImu16HbFZPCiVNuDaB0eT8Z5
         YQWrgoIGbYCx1o3dIr0Lhq3hpB8BVi/tty3FlGpIpHSeOOE/Be6iHTIGeuiq3+PXDfXv
         D8SfTTq3aZ0c1bjSnu5cdpoIhzIIVPshM0ICdrdCjnDtqQ+qf+u/+tF8s62aQFn06eeL
         S9pw==
X-Forwarded-Encrypted: i=1; AJvYcCV/ogYZ3i8oU54gI012FQFsNllcWdo5FwTSvglUXLgz+mqU46itKc/hJ9LFUg5+znrUheqIhDeFm6Wp@vger.kernel.org, AJvYcCWFYfdeoclyQQjUy2dLW4HS6acw+K4dthQnLdCsICON0boKCJl2c5ToVcOTYeVfrmUS7SPHmqL5u9WbkmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzq6EBATubhhPmPyil5BCQIPDCnssAHplGc9Q8mqjHi2t1skCY
	o1R+sEidUjLm2bTk8YORRAYJWsH7zSRCUGlNzIByCHMmpsE1hgy7WHz2qlCXsg==
X-Gm-Gg: ASbGncsTXTharGMCDpvnilP3eVKsLZ7YKYdpesACncqDX/apDRneYyGeGFnSLPMv3C+
	u6oqbmEH23QYTOebgOh7AS/s7UcrAOdj/5sxNF44Ir6H+ptLPGu3xn5S1NK/A8YWkDvok0hgqGx
	a4F0bzT/9HTqaHsdJUAKixpDsgeNGQc6p3Gl4+d7+i9w8P2A7073hUs1piez9Tv+0a6WaydTET0
	q6QKkB1j9xx1D28kjtN8+04CN5CAslFRvkcGITx7oaJ9yPDpLHnzoT1ZYT7nQyCQYmMMqiPMW60
	RVImnJb/p+4mzObcuGG3m+MZk6P72u2Ot7HpI54lp3OxB8VK4dQ6t+C6cirP26FwUnx2/KWsn6v
	zLttqGMDYtFSxkNKmLw==
X-Google-Smtp-Source: AGHT+IE0gWJM7aSHVAxN1GTQvphCOkft5ulLOzwhDZvQOYQaffQzFyUGVVNZrQjCmYXfWS8WYgK6DQ==
X-Received: by 2002:a05:6000:2409:b0:3a6:daff:9e5 with SMTP id ffacd0b85a97d-3a6e71c5b54mr1705345f8f.7.1750751112954;
        Tue, 24 Jun 2025 00:45:12 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4536470370fsm132895045e9.29.2025.06.24.00.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 00:45:11 -0700 (PDT)
Message-ID: <685a5787.050a0220.20ff0f.fd7a@mx.google.com>
X-Google-Original-Message-ID: <aFpXhMeTm_7QT8sj@Ansuel-XPS.>
Date: Tue, 24 Jun 2025 09:45:08 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
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
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcWW=RaHS9Yb8BcK2Jt7qtNOQzA3eDOZQ88RQG63981cQ@mail.gmail.com>

On Tue, Jun 24, 2025 at 09:08:32AM +0300, Andy Shevchenko wrote:
> On Tue, Jun 24, 2025 at 12:11 AM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > There is currently a problem with the usage of rounddown MACRO with
> 
> rounddown() with
> 
> > u64 dividends. This cause compilation error on specific arch where
> 
> causes
> 
> > 64bit division is done on 32bit system.
> 
> on the 32-bit
> 
> 
> > To be more specific GCC try optimize the function and replace it with
> 
> to optimize
> 
> > __umoddi3 but this is actually not compiled in the kernel.
> 
> __umoddi3()
> 
> > Example:
> > pwm-airoha.c:(.text+0x8f8): undefined reference to `__umoddi3'
> >
> > To better handle this, introduce a variant of rounddown MACRO,
> 
> rounddown(),

For this and the other... Is it correct to use () for MACRO?
I assume () should be used only for functions.

> 
> > rounddown_ull that can be used exactly for this scenario.
> 
> rounddown_ull()
> 
> > rounddown_ull new MACRO use the do_div MACRO that do the heavy work of
> 
> The rounddown_ull() is a new macro that uses do_div() to do the heavy work of
> 
> > handling internally all the magic for 64bit division on 32bit (and
> 
> for the 64-bit divisions on the 32-bit platforms (and
> 
> > indirectly fix the compilation error).
> 
> ...
> 
> > - Add this patch
> 
> Why are math64 APIs not usable here?
>

There isn't a rounddown API for math64.

-- 
	Ansuel

