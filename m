Return-Path: <linux-pwm+bounces-2043-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E018E8ACB0C
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Apr 2024 12:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF9B1C20AF7
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Apr 2024 10:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CAA146D68;
	Mon, 22 Apr 2024 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="akLMyIq0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2BD145B19
	for <linux-pwm@vger.kernel.org>; Mon, 22 Apr 2024 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782367; cv=none; b=rel7EyDVvUiAyr4QMxpVz1Bkl2QOFJphQd/F9xIDcyZWBtPY8nrY6Gmr/0oyxSk/AXBGeu5VE9ZQ3r/F6xdsA1Pgp/FKM30pNbQyxeBAY5ofJ4eVMTNU/oRONC2aXxbhUc2UW7ypGoScME+WbllFPTn3XJ3QUBWJJoLVsWd4dAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782367; c=relaxed/simple;
	bh=tw/ruLJw2IldqcRfR0Fp7vfH4KWxGbJZHGJPXcevGa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbUHaATjMD7sSwgYlkXhzlrojGjzYqB6/ygY2qLiaBLsWUyf6z2fZMzLPJJJhsQLggXde3Bz1rF/MmcvUr3BKFpAFfG2qHMVMXEaGtnsYTjdyRdaBRpAJMyZ2uiKXgXAJgeQJr2SesbGSf5VaJBwMGHGqzDAaBIRQqXJEnrC6EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=akLMyIq0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ad8fb779d2so544194a91.0
        for <linux-pwm@vger.kernel.org>; Mon, 22 Apr 2024 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1713782365; x=1714387165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tw/ruLJw2IldqcRfR0Fp7vfH4KWxGbJZHGJPXcevGa8=;
        b=akLMyIq0VrmEX1uWnZRFeRCkeK6CxK4TRVjz7Od1V/J+5R/A+t/skq82/ftTR8wZvJ
         3zN70hoZS4wehVpcCYc0HMG5e3aM8qzsIi8SW8MgmpJTB9jDBqwk0DgcyKCu8ccbiUw/
         Povf/u3YFUQ9qsQLU3+F5unFahS3i1DjCuudQTYcmYgVJrwCkkiwr0gAh583OnfYT/rC
         /1SXO91pbY2K1uRdXtyWMGru2PPc+bYY8bANYm2RO8vfvLb2Wk024raVKVKuBWJYg1Q6
         Y/oLLlyM8i/tdXEFDQmJyabeFWZHagYuK7sTiVs0egOzY3iDvCA5rKi1rOTtN+o2f6mE
         27IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782365; x=1714387165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tw/ruLJw2IldqcRfR0Fp7vfH4KWxGbJZHGJPXcevGa8=;
        b=n9VJE+TRnLpafNCgSN3lucz0B7EC49SiW0dSTs+iVmppLu/QYNQwtwQBDJdcuxNMzd
         NuKe5XZDsSIBYTZEidFH3iwTGGLVZl2wLMF5+9fxhhFN0nWCyy6NBF3KgM66hla87wGe
         Mr4VipSm+Qic7C8k5zAogElQsKBS/xv13Z8XHzcB1yONhm/z5Qn1l+XrL0mY1ByacEgV
         Ufoomc7+gMzR49c1vXE52OUj3r+PLZ4CFlc+0mjgFRL5zz7GTfZ0VkJXGBrFPnlcebRo
         k8ExRPDo8AF45hBKL9InbyXH4cBn+5muSLHIXfjPiZPy39Cwi6jTrYZkBsGF9wD83qQQ
         v93w==
X-Forwarded-Encrypted: i=1; AJvYcCXEM44NXV5xsK6/3djAZL4/C1rnAnjNZETMimB5uiLU+B9BSfnYCvpyDobmwHtcwsZwzgN0JNE6WNaRsO0ZrUW6DAWE+QSCckjU
X-Gm-Message-State: AOJu0YzfXVhPrIoOHMysNHl+9diYnJLTAi8pgqmIZo3n2xfPZNOfPZui
	C2B+kMUfd4Ipj8K3BQFZxIVXu5X5kQMLAcOoeYGtbW/mNbalImdqIFS5uJzOfplsN8SuvBvs/TL
	m9il4v3z7lymMMw6Mm5x7/ag0KvuDUrjLA+2LtA==
X-Google-Smtp-Source: AGHT+IEY8we/dWrYRB/yxAUGuYNMNlMwrdJ2+M3MXEXX0Tp8j2MD0fZjxDax1iTRPLWYc2bGHOUcREPQl1a/jn+isOA=
X-Received: by 2002:a17:90a:4294:b0:2a0:3dc3:8a8b with SMTP id
 p20-20020a17090a429400b002a03dc38a8bmr6662584pjg.47.1713782365451; Mon, 22
 Apr 2024 03:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416171720.2875916-1-naresh.solanki@9elements.com>
 <20240416171720.2875916-2-naresh.solanki@9elements.com> <ecddd7f3-fc25-4021-9758-b00893ac9622@roeck-us.net>
In-Reply-To: <ecddd7f3-fc25-4021-9758-b00893ac9622@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Mon, 22 Apr 2024 16:09:14 +0530
Message-ID: <CABqG17hebvkpvxwGVfp0nT_YMrvgdkEqU2_XjijCpdtgU6C+1A@mail.gmail.com>
Subject: Re: [PATCH 2/4] hwmon: (max6639) : Utilise pwm subsystem
To: Guenter Roeck <linux@roeck-us.net>
Cc: krzysztof.kozlowski+dt@linaro.org, u.kleine-koenig@pengutronix.de, 
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

On Wed, 17 Apr 2024 at 02:52, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Apr 16, 2024 at 10:47:15PM +0530, Naresh Solanki wrote:
> > Utilise pwm subsystem for fan pwm handling
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>
> That adds a lot of complexity to the driver. I am missing the benefits.
> You are supposed to explain why you are making changes, not just that
> you are making them.
>
> Why are you making those changes ?
Sure.
This is to align with fan-common.yml wherein chip pwm is exposed.
I'll update commit message

Regards,
Naresh
>
> Guenter

