Return-Path: <linux-pwm+bounces-813-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2DB82FC09
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jan 2024 23:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B121F28CD1
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jan 2024 22:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4C721376;
	Tue, 16 Jan 2024 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRmc+pU0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A0F1D54F;
	Tue, 16 Jan 2024 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705436071; cv=none; b=ETiZHlgJ6R9vIUiMt22SJYfhM5qQeCbJfbDPf2S8UdEYdoNZYlQ7y5PgP7dDqLUBL0rDyu9R04eBumuHLqnXwpjRzihwulV3xlAhMwkm8yfZcZJ2epMgwBOJqispXVXSbw4ZHPdyMkqO35fvg+hmQd0rjmChpqy2PA830eQ3f14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705436071; c=relaxed/simple;
	bh=gbuoZx71FH6A8ZgMSxmXVfmDtNcYNFclF4KzObTGBpY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=M+ToyWEbvw4LvdP15EpDUuETNrDi3+N+2mUik7YnkDv+1m5ze2PTUV6dD0Uof0hpwOx/CCYoYRPSQK6r3mMhDaNMOwx7zPDXc0lQoE5XM45AHrEIUewr2lQ0vY29au0zSGCyWZgm1zY1YhO3n8iTyaqslBKpkOkPjSnWLEBx5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRmc+pU0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a28b1095064so1160063766b.2;
        Tue, 16 Jan 2024 12:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705436068; x=1706040868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbuoZx71FH6A8ZgMSxmXVfmDtNcYNFclF4KzObTGBpY=;
        b=KRmc+pU0fMj/1YI6pi+DmkUL/KSbPWtL8RzOyulc16/OpVUPO126t2xuFks3wY6nn+
         aZ4lEJ88NT3jE5qkXqi4+xTWbpFs3eMyDG7fuu4yNG+DRz/MUvCPu12scZiojtptb1a8
         Za6qYqwTd5HWUjNgDggTwRrS/lxilxSi8P6zIizinKDsX1uy1R5aUf2KUPHvbiEoWnDM
         +R1/BN4gzKd7PaEvKY1K1JGt/rNdV0cJxNglL8ruDBGlT+2Yj9KfdnjtGkbtPQdu5N3V
         dy9oJlMFGBmc4QwCADSfzpMgHYAGL0NZPKdXvVWfB5/P5LR6SBkN/1jKL6m3fHYgX+CZ
         Kzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705436068; x=1706040868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbuoZx71FH6A8ZgMSxmXVfmDtNcYNFclF4KzObTGBpY=;
        b=MJsMjuvXHuF0uaysAVslx9hENJUDj+K9b1gPChNOk0LU0SLd2nwiw+Qno7d5q/GG7S
         Vmj15wLYXk+YifFUlsRl1Lra9sXz+ZISCqQdLLP2QRbgC0mmK9wbOZ9vYISFxDykVEfb
         QgL+9jVrjSUYwucQ+a+QAyWOL+KvBctomF7TIlWaTHCEhJ3LMvydDXriITN+xtQ/SKWJ
         DvCROi4C/63+iDjngLKg2i4jHe9zwpFcu/9jyyfqhHVxJUR6tf2abOJR+3XVFJookPt5
         bFCw1OIMdgWhhBGAPcPmUuovM/3KWOCSa3000YBPmc3kfwmD2PoeBqtdqHFOQpUZt7zO
         nXyg==
X-Gm-Message-State: AOJu0Yw/99ebVxtJxLhCF0rEBNHUGls6e5JW9gkSNa5c4aHda5Kz7Glb
	c+o/WbN5d9XT3kxwUhn3COdKRj0yqMWU1/fronQ=
X-Google-Smtp-Source: AGHT+IG58HwU8rJHDRxz56XmFyk02seqYGpjo2GT2CvonR3q73elLuGZU0ltKR1+LWhhT75oTCZEYv5n8P+wdWKTdsE=
X-Received: by 2002:a17:906:3c08:b0:a2e:9845:ae28 with SMTP id
 h8-20020a1709063c0800b00a2e9845ae28mr305082ejg.294.1705436067899; Tue, 16 Jan
 2024 12:14:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
 <20201211170432.6113-1-nicola.dilieto@gmail.com> <20201211170432.6113-2-nicola.dilieto@gmail.com>
 <20210117130434.663qpp6noujptdyt@pengutronix.de> <CACRpkdawMpuznr-XC2uvZm8PvOj-jObpnbz6iptV-Q4OFxjesw@mail.gmail.com>
 <CA+TH9VnrsSQDUfvXk8c+q6Sx2Jc5TCN5XLYCRLtgv55-6voLWg@mail.gmail.com>
 <Y/YPtJK8nVBthCML@surfacebook> <Y/YuJoxkz+o0Omie@einstein.dilieto.eu>
 <5521796b-d51e-42a3-831a-7fbf75247726@gadgetoid.com> <CAHp75VfLEBw=ypFiLpd8ken5JPkW5DJey_UroV+3B6ZSaK3Jyw@mail.gmail.com>
 <CA+kSVo-yjU17Q97vN+DrpUUxCku6H309iXNDiBy9fJ3QPM8aTQ@mail.gmail.com>
In-Reply-To: <CA+kSVo-yjU17Q97vN+DrpUUxCku6H309iXNDiBy9fJ3QPM8aTQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 16 Jan 2024 22:13:50 +0200
Message-ID: <CAHp75VdNir8G+CLDd7LZhgA=j+PZuQSXLEiYPwaVEmin7=bUYQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pwm: pwm-gpio: New driver
To: Phil Howard <phil@gadgetoid.com>
Cc: Nicola Di Lieto <nicola.dilieto@gmail.com>, 
	Angelo Compagnucci <angelo.compagnucci@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, 
	Rob Herring <robh@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 4:15=E2=80=AFPM Phil Howard <phil@gadgetoid.com> wr=
ote:
> On Fri, 12 Jan 2024 at 18:32, Andy Shevchenko <andy.shevchenko@gmail.com>=
 wrote:
> > On Fri, Jan 12, 2024 at 3:38=E2=80=AFPM Philip Howard <phil@gadgetoid.c=
om> wrote:
> > > On 22/02/2023 15:00, Nicola Di Lieto wrote:
> > > > On Wed, Feb 22, 2023 at 02:51:00PM +0200, andy.shevchenko@gmail.com=
 wrote:

...

> > > I'd love to know if you're still likely to look into this.
> >
> > If you are asking me as well (since To refers to me), Cc for the new
> > version and I might look at it. Currently I am OoO till the end of
> > month and after that I probably will have more tasks to do, so no
> > guarantee for this cycle, but just in case Cc and we will see.
>
> Thanks for your reply!
>
> I'm not sure I know how to "Cc for the new version," it took me about
> an hour to generate a (hopefully) suitably formatted email response
> to this patch. I've only just subbed to linux-pwm.

I use the script [1] that uses a heuristics for the Cc/To fields,
additionally you can add --cc "Andy Shevchenko ..." at the end.


> But yes- my reply was cast out into the ether in the hopes that logging
> my interest might get things moving again, or at least let me know if I
> should try tackling it myself.
>
> I'm moving over to libgpiod on Raspberry Pi, losing software PWM (
> from the library I was using) in the process. I don't want to use or
> contrive another not-invented-here solution.

Totally supporting this motivation!

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.=
sh

--=20
With Best Regards,
Andy Shevchenko

