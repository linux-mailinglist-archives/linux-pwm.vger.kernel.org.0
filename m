Return-Path: <linux-pwm+bounces-2408-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2B79026BB
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 18:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2FA281AE9
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5B3143886;
	Mon, 10 Jun 2024 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbpC3E39"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2FF1459EF;
	Mon, 10 Jun 2024 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036990; cv=none; b=XnWtXzjr0VT+S8bgN91CJN3afcLUVzTHLISkLgo75FbkEppOzDlQ0Xk1nvz2rpTfCT8hNoIwtAiq/CDdN3vPkBNSWbybHeMUCEtTDWekAMvqF9rTuKNaAGarhCMH8MwAzrEkS/C22Odn+hJWU9oCqhX2SMJ/Z//5gY1pUdS1zQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036990; c=relaxed/simple;
	bh=hG+WGtxwsZuR+f62hkW67KZ+t1AQjeby7UbLM/4qRZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTX2I0kx+coJrHZx0GgDDAHad6iBx4oq0Lur/f7O9w14uw33n2MhyN90CZ8Dr5lLaXdnwm1/kEZoOrXfozQzXMQPvfmVNSzZvILvxbMU0MvOtUoeipgoOowroGJ7IzLxMjLttbSNA0Iat9ELKWy7B4NK9ubV0rLt07tfKk80ol4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbpC3E39; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f0c3d0792so12177166b.3;
        Mon, 10 Jun 2024 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718036987; x=1718641787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTzeLr/JnQOlBuaDILNqwfiL1947Rz1K+v45ebNmSsw=;
        b=EbpC3E39qikKu1ZxQoypZu1ouOA5bTytnAxdB8IicHjlQaSgHsoPGJOhRnL3LcZAwx
         1H78zS8eOGbLeJ+d6O2xGI98rAV8qfOO1tvZ4DmfaxSFFQPor8+18Lf8ZuPXXoPO4jyR
         voxKsnu1/OpUTqTyeY3q5B78OK/aOVGK81uVq6GYf3c8uaS2zwilDYGWArytteuUeiEy
         Wep4vXKLjFXfb5aY32m0kLSNQye1hlvyAU8Uc9sxtnbZdy4qshCiS5BD9F4MqMGxOeab
         8gP5szihmt5l8HuBRshFL/jFv0M55idtY9vwFfaGXswEBDj0T+/g/3yS8sFP/CDefbck
         c3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718036987; x=1718641787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTzeLr/JnQOlBuaDILNqwfiL1947Rz1K+v45ebNmSsw=;
        b=IWYeDmxRxByXkIof7JqWt797DaAe+QtlgFQEEpTxeJ5mzs6wWaU/SDm/Rl0FJImXM2
         js2S7zg7AlKTXKx/siMRTmflGJNA1e+A74pyK5mkxTABPWgRXIHcRe+k+denA8082VDa
         Rmbj6xkoS+JiLx3Q5QbP75yzzU8UnxhKrgV+tXkBMoisLyF9Ix0g3TBYS3NzuT9rY5IQ
         pYw9/ZqagN0oYvstVejGWgEzUYNQEAGtObFDwo3p66Qa/pTWQ4OWqFzEO/2zJyJtG1y3
         AwXJ16zzNzWgd07+pkxyINi6SmKZJabBdezHW6OpTByIulJCfTvv9Ww1aaplJw/KBGYj
         +iUw==
X-Forwarded-Encrypted: i=1; AJvYcCWIRFWeuQ0gtpZVQgXhCZHF4X7lcP9lpneyk6YCthd8MRV3JYdVPOb7n9/ZgtzZE01S6f3TNIiF8W4hBIujlb3CJshlHDp/x1FTwzOXBOO0LeCv9tizpQiolGulVGPhgnNlwUspU0YMrvAXDlmdW/yIukw0C4bvrKofPRERJpgPSN0=
X-Gm-Message-State: AOJu0YxBDo+xamtqujK1ikRITTx4fDv5CbqaclyZr1sM1lqo7RnY9bu9
	Aw4IOo+VqdF7Vo8ZisY8d7Xixkh651mbRQ1IGghhY8dHnkqVkaBDIeSt841/zq6vF/Ctm4XI/QC
	zaaxSHC7P8Xg3YMZjMJcXEtvx4L4=
X-Google-Smtp-Source: AGHT+IH+aJ31YhcT+XCnHzzB7ZwuqIPk0c7mJiRny1L23ls65d4QvH+gFk0LcdXDK0qX9slKWat8i3itVJ7PacbDWEY=
X-Received: by 2002:a17:906:2844:b0:a6f:1d3e:d1af with SMTP id
 a640c23a62f3a-a6f1d3ed202mr254217966b.5.1718036986539; Mon, 10 Jun 2024
 09:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608141633.2562-1-laurent.pinchart@ideasonboard.com>
 <20240608141633.2562-4-laurent.pinchart@ideasonboard.com> <ZmcYnDf0YIWA9A85@surfacebook.localdomain>
 <20240610152555.GV18479@pendragon.ideasonboard.com>
In-Reply-To: <20240610152555.GV18479@pendragon.ideasonboard.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 10 Jun 2024 19:29:09 +0300
Message-ID: <CAHp75Vd-TZYsm+fe+o1XvDYGHO6sDqZhMFqojowRx2scwxEhLw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] gpio: adp5585: Add Analog Devices ADP5585 support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Haibo Chen <haibo.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 6:26=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Mon, Jun 10, 2024 at 06:15:40PM +0300, Andy Shevchenko wrote:
> > Sat, Jun 08, 2024 at 05:16:32PM +0300, Laurent Pinchart kirjoitti:

...

> > > +static const struct platform_device_id adp5585_gpio_id_table[] =3D {
> > > +   { "adp5585-gpio" },
> >
> > > +   { /* Sentinel */ },
> >
> > Drop the comma.
>
> I prefer keeping it.

For what reason?
The sentinel should be runtime and compile time one. Why should we
make our lives worse by neglecting help from a compiler?

> > > +};

--=20
With Best Regards,
Andy Shevchenko

