Return-Path: <linux-pwm+bounces-2615-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FCC91803A
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2024 13:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF8A8B26233
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2024 11:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F17149E06;
	Wed, 26 Jun 2024 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCDqOb8z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E616A92E
	for <linux-pwm@vger.kernel.org>; Wed, 26 Jun 2024 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402717; cv=none; b=uuOOlNbd9BBWzukWdWc2gqXY9NEZsoEDMEw/XHJ5PEpusr7T8qZcYzkBpUwQYbQrmwr6d47iBkC+nsC47Me4/SpkB/vYer4N7ftLWBKMTfv83yyr/SIf4zAxtMNUfrNmRfQmPQaj7dkc69E+t2L5xNH0KvZTfhYnqQLjRJsiRr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402717; c=relaxed/simple;
	bh=xpjrjZmRsZz45Y4K6cy5Tahj6SJPohhDcpzY7RpiacU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luOT6lxnDuJ0afwMYtcyJEQAxRcYIFew9vIp4b4KzPv8F/xRoIydh2HHK6Kb9AjLdZQ5fpBFMxdjXVGhGpd7gA5TiPKjEUPOfyYIMe+8L3IS4GciQP3x6LmYAb5vJL+acg1BLrUsmmEmH4imUE6iUly3Q1bPMHyoIdtIUBlIEr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pCDqOb8z; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cdf579dd2so4119419e87.3
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jun 2024 04:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719402714; x=1720007514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpjrjZmRsZz45Y4K6cy5Tahj6SJPohhDcpzY7RpiacU=;
        b=pCDqOb8zFMCueR+WmT9EGBVxnpIQmDWdpMbtFnzNf6UzPhN8EZHBQ+Q1xWkUSkhal1
         5Il7irWIZ9uKZFmG37sOA9ejvdAhX2CDJwu+bNM/uTdthpDxYmk4recMlajPW5AW6uzA
         TfELVn2N2bOLlIIG7xsyl48HTu0bEP7ZmBuhkjlCYtDGDVCLi1Fglcq3REJuindlD2KI
         jx+9nt9BaZAsJBalxYt4bSl9Pb/z5oxC6UZ77LSmYNkimUnh2Xx3gBycY5O8HjE59lQI
         Hd47Jt0/4gqQx0E6tuQfPmZ9jBeQNth9/oADGqgu7cCMNLQhAew8GKRIw65LqSq8IL+X
         0FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719402714; x=1720007514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpjrjZmRsZz45Y4K6cy5Tahj6SJPohhDcpzY7RpiacU=;
        b=HUmTY31YM7A+IwRVd86A5YBYtkfTn8lQalXiZcFbTGeRXNPEiCmHoTei5rRKzIpE3O
         /bvVKXdMzShqRSXRpzTH8OTJJYxXYrt0BP+uX77ETs1nMNdk8cC7ZeprJZziUcKqZdyj
         hiTNStGO+l0CBOgWxpC6NrV3p9U73pJ4Uk6DABktD6279OHvIt/QdcUAjDHMy02O/h7p
         cGaz3YqhAqsrqRWIqpFfZxh2NQsgn5kkHclR2ZWjXz0y1D7eTwsCIaS/EtqqCXjozgUD
         mDf1KcGwxZlMVl7IFtRa4nt7I0ufSIkpeQZyilLsAnro81RUGQgAouYZQkfR1uWZa/CK
         pnjg==
X-Forwarded-Encrypted: i=1; AJvYcCVPohEH54OiH+JxDLWi3Lpb8kId5Vgx8kzpVRV5cmDMl+TH7+OEXhMTcMz3esV6YpeUl6cx4XPCngSBsKbIUIDzy201QiZ9RfZn
X-Gm-Message-State: AOJu0YzY3ofFN0lyGxBWeGaVNhxYT+LvY/vtek8bx7QGpLqKpzCZEgZK
	eKuTgevfcn1gkar0ZwpYtDK629cM6J/kPCjGoPGlp1E3mruPo51i+IzX4rNU3zVI9wYtbPM15W5
	0xRSAFYQfiLs9f0KHILIOKlM0N3WnjWlY4RJbPA==
X-Google-Smtp-Source: AGHT+IGn/BLs09UZTXijTnoE40QKwlRJA0amamIYfiwwfiDRAcDmK1jL7i2Ig/go5BAD0nIbt9Kry0L/xhH0oehqM5s=
X-Received: by 2002:ac2:4d01:0:b0:52c:a483:4cc6 with SMTP id
 2adb3069b0e04-52cdf7f6665mr7139770e87.36.1719402714424; Wed, 26 Jun 2024
 04:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624152033.25016-1-tzimmermann@suse.de> <20240624152033.25016-7-tzimmermann@suse.de>
In-Reply-To: <20240624152033.25016-7-tzimmermann@suse.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 13:51:43 +0200
Message-ID: <CACRpkdaYzWkBR=m=sokfXJHvWwdkDXb2r=te0i2J3WMwmFeVWA@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] backlight: ipaq-micro-backlight: Use backlight
 power constants
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, sam@ravnborg.org, 
	jingoohan1@gmail.com, deller@gmx.de, f.suligoi@asem.it, ukleinek@kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 5:20=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:

> Replace FB_BLANK_ constants with their counterparts from the
> backlight subsystem. The values are identical, so there's no
> change in functionality.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

