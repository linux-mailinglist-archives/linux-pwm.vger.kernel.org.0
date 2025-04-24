Return-Path: <linux-pwm+bounces-5687-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503B9A9A532
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 10:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4143B3A9C
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 08:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8101F6667;
	Thu, 24 Apr 2025 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McLVSwIv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870F1F5424;
	Thu, 24 Apr 2025 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482018; cv=none; b=ckUGaQR1UtJ0otSByBHMFFfbg+w3lhgqbKt9cM3cMLUEIU9RkLJKL5LO3/RFp5xWevtf1PssfkVzs3T0ZeLWaldlhz4cNoNB6jRL4s/OZgUqza03yqqF0IvJKBt3/DYKW7YU32OyBrZ+37pvw16T6gq5iJGk1ZCivDo9P92FPdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482018; c=relaxed/simple;
	bh=P37wk7QEM3Frj5cIPHK6cE10wLVDzh0b1mczxCrM1Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBNzEbTjvknYne4vp20Nb4uYnz//ir3GGeFnbgCd5C2k+ho0p0AFKkxIG8t5+D2r8VMmQmM/SvudY3cbxGyLwNlP8PDwy8SCq3S4JGZYVxl+oDut8jefjrf39vVZAXwc2MgKSF7lRagsYEZiBrXC3u2BH6U2BRpFXqorMK0bvek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McLVSwIv; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5675dec99so85015685a.0;
        Thu, 24 Apr 2025 01:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745482014; x=1746086814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuZT78P9j7k7WzwtAOOSjzKOIc347/p+7AmZquWPojI=;
        b=McLVSwIv296cMMicKOSr9LxD+FvmvUBrOlsUsC3O1sESHkns5Eoxd8VctBesrAUNup
         bbcu4s9kY6JsciRV5D0MO0MmKCx7lfYLTWI6dETXB834WTn2GxUt9cZgMr2C3zxHYSWm
         awUESinBp71UIyc7zv4UDOOOZ5KfdxVr4LO0p+/QMwgm6GxdmxaoLUC31/ysXD3wt+5I
         Qe5sLDF6VjPWdtO7pJ7xJ+lpPzbe9O8ZTv3ztJsUheYQ0sqV+s0Ya3yi2Nda22RM78pM
         XCjAFza5M5qytOcPXGDZxJdbbijjhTyNOMP/plgxy0v7erfpOHhlvBftnenxcwDQTQHj
         JYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745482014; x=1746086814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuZT78P9j7k7WzwtAOOSjzKOIc347/p+7AmZquWPojI=;
        b=YDG5JldzPn2V3AuSJW7V8r5ehUDGD6v9erJ+Qghm1wZ9yteByTP74OPyh2L5wX0NqY
         ct3VebtfZNK7eyQ/8l7R0QvRLjpt5h7uyKBROqPfuYBMdQepCfEu7+jR2tdNbQbji+iA
         /95sy1aCZWUm1IuwR0Af2GC2/H0yeRwN0+/SFM7YIS67PhRfXfoc0kFi6YU0AtMT+TG1
         6FmVfUiM7vPgx53D/4CYZFgUtBgfjp9Q38oewgbRlf4uIS1e7q6hrxv1M/kkRVlDbdJS
         Pbnh7TcvypU5ZKPP2IJy3mccdOibiDIRXLOWFssUHDwgLEHXIZTNSbxL1+oZLNEIJlXY
         ergw==
X-Forwarded-Encrypted: i=1; AJvYcCU/aN/OdbqC8WA04qIIc7xjzc1+O+eCr4+74R/qJkPPj7WZJAgJuAmCXh3LWTxiC/bNKVPfzuVv6btg@vger.kernel.org, AJvYcCVnzgLJF/tkwelu3lHxVTCI78Lvk/F8AfeC7F6H240mNcPa+mf1A1W8r5iv0m09g6vJFj6sN/6lDTxvJLw9@vger.kernel.org, AJvYcCXfHW99Ak6wNJuHXvaRgSC/DzA2kznt6MVZgPKDIJPO74heUPJ5MIgn3z8PEhUG2Tgk+vxKT/3BYFgW@vger.kernel.org
X-Gm-Message-State: AOJu0YwfvxQQ0ZuMdTGAqboP9R7XsQmsQiwpRaRNF2bSx7dNVX5yB3/q
	WT7BniWuqHWNZYRaLU1QoAas9He3UAuz8+rPKgGBHhAEjwcW2csq7auk7cZ2OIMK7FOMcXgxVGa
	PtGvnbMu2+u4nxVGtpGQ/idznuT9JyheefTDG2w==
X-Gm-Gg: ASbGncugRUYx2QiU+tOXv1mF70s4L5HC/PUc4r/bSN2HtghLDqGEBsWZmY/tCAU6ZY3
	lZef+ODgY4vtAb5/+L7BBOpqqh6vctyeKjijBKLKr6MQkXE3MHXbjrAJ8PU9AO1FcZZ0OUGzS9D
	aoLXQhXwq6ohNlSErj01MsomA1JKhn8Z44oNOBBrnB73CFAIIUWEG9XoY=
X-Google-Smtp-Source: AGHT+IEhzUA4oc+V3w2NjT7UrZcmGzkKTQD1CxM6C7Ok3vwwIKeFgj3Pi+wnsvImCZYWj5yHmRpA8SR7e+Hur2BVZFw=
X-Received: by 2002:a05:620a:f0f:b0:7c5:588a:5c1e with SMTP id
 af79cd13be357-7c956ed7552mr250436585a.30.1745482014365; Thu, 24 Apr 2025
 01:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418-via_pwm_binding-v2-1-17545f4d719e@gmail.com> <yscledgclp2v4p7djwrszbc3dnqifkcofky7rugkcip7o2rmof@xljfd2kfyzzs>
In-Reply-To: <yscledgclp2v4p7djwrszbc3dnqifkcofky7rugkcip7o2rmof@xljfd2kfyzzs>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 24 Apr 2025 12:07:03 +0400
X-Gm-Features: ATxdqUE5PElP_sYDeMINZqZeeEsmfYCVkfJRWHY7GCzFKR6syg3Z1uN61FCNNqY
Message-ID: <CABjd4YxK+4kEeS_tKBi9zhj85y6U1Dgi3nJNuQ8hfkeoY+iK1w@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pwm: vt8500-pwm: Convert to YAML
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 10:35=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@ke=
rnel.org> wrote:
>
> On Fri, Apr 18, 2025 at 06:55:07PM +0400, Alexey Charkov wrote:
> > Rewrite the textual description for the WonderMedia PWM controller
> > as YAML schema, and switch the filename to follow the compatible
> > string.
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> > Split the series from v1 into separate bindings patches so as not to
> > spam all the subsystems with unrelated changes, per Rob's suggestion
>
> That's a good suggestion.
>
> Applied with Rob's R-b tag to
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fo=
r-next

Thanks a lot!

> I saw you signed your patch using PGP, which is great. However I didn't
> find your key. I recommend to make it available on keys.openpgp.org like
> this:
>
>         gpg --export alchark@gmail.com | curl -T - https://keys.openpgp.o=
rg
>
> and then verify your identities using the link in the output of this
> command. Still better, (additionally) add your key to the kernel keyring
> (which however requires you to be in Linus Torvalds WoT, see
> https://korg.docs.kernel.org/pgpkeys.html for the details).

Hmm, I used b4's built-in patatt functionality with a dedicated
ed25519 key, not a gpg managed one. Looks like keys.openpgp.org
doesn't understand those directly, or am I missing something?

Best regards,
Alexey

