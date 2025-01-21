Return-Path: <linux-pwm+bounces-4690-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8641FA1797C
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2025 09:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A3D188C2C2
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2025 08:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2736F1B85CA;
	Tue, 21 Jan 2025 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lLYsa0Dw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB4188938
	for <linux-pwm@vger.kernel.org>; Tue, 21 Jan 2025 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449280; cv=none; b=e22EgkBcIErtlv72ibsVltHXD1tTWtqR2BD4C1yew0heG5jPhqbLbez03r5wv98YJ+yLUt8lwKOEKLotMPdBcYMZhqK6phvEIq1XJ7cDtIoAlo+O1Ir+n7dnP8QqhgLNyzdOLtqGUF8TLbm7QTazuj8O8p/V3p/prpX2vx8wj4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449280; c=relaxed/simple;
	bh=W0gV58YMdVAgUpJ7DgzgpwUIMKPDw9p1SpbYXncdnBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eH5LYKMHuCf4YOWOu4WP63MXAWxg8BFoAeYhZIo7TEU6TnnHTvbPbWnHoANT0+82ojedP7yL61CU7Pp09rKsXRW49i7IowAXce+pjyBYbOszw8eYG1XQV3mVDvzcthjpA+7TRCqpaNJgr+CC+gTrwTPD+M8i69c9WmU6StVv0y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lLYsa0Dw; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-85c4b4cf73aso994743241.2
        for <linux-pwm@vger.kernel.org>; Tue, 21 Jan 2025 00:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1737449277; x=1738054077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylm0SQb6Ef9jjirSI4sl+IsEvfZdYeaZm3dNfDBGQWQ=;
        b=lLYsa0DwvH1le/p8zCBdetzYw6za0RUFLTGxiZRZY9Hjy+5FK81+/oGsCBhyBswHCO
         r/FHUeJarRCoq8uHBqOIg/DKRs6tkDAOa/1YkW5ovKPz1+AVB2c20oJsnDp+DQtGE/7N
         xHgK+334QX4kPh3McH/6qImftLXI7HZe611ghF7Td4Zh8nVN3XGLui8B/diiwwEIcA0G
         JMXfbeOD+CgbXQGsu2dTTqKUkpoH2iQRlU0aaOuy5b5X0rUakcsuo3ZgUH4Y228+YNTE
         G6mrSISeK881JSJulbLNbWFbNKsS+CKYRLNlVGsRac8fyfmA+FhuAyjvtUa7xqfzU6nA
         O4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737449277; x=1738054077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylm0SQb6Ef9jjirSI4sl+IsEvfZdYeaZm3dNfDBGQWQ=;
        b=XgIALlrmiqtCf/pBpUK+0z6maQffZ5MGr6jqZbBwIiDCYpMAw3S3sASUfjO8wOH3bT
         oyy33SL5EBVBwb5ZuNgflyAEqlYJjsTW8xfPyHHQ9KbvNA+X51xstW69SDHMpglbOHe1
         rrhtyP0+BhOzSgkObBTTIX8+wdBgFfpbFe5P7GUCExG5/LtpUod/uTiDlFeel8Oo6vkG
         TufuOZzveKuEdz6qPIjt1gmK1dPQSdey/nrMMtx+fRpiR/2xH5O5hXGf9oXJphkUEMVZ
         v6Ek5aDX3OkfSklEq6N2jVJZ8Bn/ClgpJpU0c4eJaDb1hl7ttkOjUOY6AvLzCjZqefr2
         iWAA==
X-Forwarded-Encrypted: i=1; AJvYcCUTXib3McmHi/r46cHfWCiQ/0itseU/DmHv4ZAZ7JNWflvLB0kL2T2BupUZKJpB0sIE6TFd+7oRlRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV1ossP1cJ5g2+uEkSzO/9h5Hw9MNfGJ35/k2lytooUl+8u+uy
	Zcb9E1NWa+uwkEaH3kUS8CNJ0Kih4Lz889FSLCxA6+lquy7jdJfXA/UCIX/3pXzbjeo8Gy/ekH1
	1qvCCF9ULuV2eXZ0o2YZWg9iVxC0/UjqUInPMpA==
X-Gm-Gg: ASbGnctkJanQ5VT4Kqy/e4MikCbjws6S2yFGKcD3NVeuqDvV7kOhRrHrWj5Po/2OQLL
	1HOpjlZkpbHcNqsn9XXJ0Bjl09GSbnwn64gYyU6MDTWsp6KG6dJ+buQ==
X-Google-Smtp-Source: AGHT+IHq4KMBokiyD5WugWcwEvEj0WpVyisepAYzvkq3Q3ow3rYydwBTKGAk6ok+pF9C8Pda6DGP35aW3y6LsiGm1r0=
X-Received: by 2002:a05:6102:161e:b0:4b2:cc94:1879 with SMTP id
 ada2fe7eead31-4b690d1e374mr11844622137.22.1737449277184; Tue, 21 Jan 2025
 00:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224093902.1632627-1-nylon.chen@sifive.com>
 <zqkx7cx5nalslfmxeoxdnsjbvrvzajrjybsmsyeyc65a64sntr@gpc5qp6aoyp7>
 <CAHh=Yk-_0rKB=FG6Voif2MDjtRxzUA5vXDP2J-o5=8ru1ewt0w@mail.gmail.com>
 <CAHh=Yk-TosOmwEughfK9mMx-=DgzWK5H_bf6H641SGh1ue8BrA@mail.gmail.com> <zneb3qwgf52zitcbq4wz76shnmhwfkabbsts3sussjpc5s5tsz@uneaxdfp4m2f>
In-Reply-To: <zneb3qwgf52zitcbq4wz76shnmhwfkabbsts3sussjpc5s5tsz@uneaxdfp4m2f>
From: Nylon Chen <nylon.chen@sifive.com>
Date: Tue, 21 Jan 2025 16:47:46 +0800
X-Gm-Features: AbW1kvb1k96mTed4V1SVNr18MrzJpI0GDeXCbwcceOVDYQeW1YSiE4o1vNYPLLY
Message-ID: <CAHh=Yk_oTdURhkna_saF6mrA9gDY=+v_j5NoY_7jTDLuZ=EXtg@mail.gmail.com>
Subject: Re: [PATCH v10 0/3] Change PWM-controlled LED pin active mode and algorithm
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> =E6=96=BC 2025=E5=B9=
=B41=E6=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:47=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hello,
>
> On Sun, Jan 19, 2025 at 03:03:16PM +0800, Nylon Chen wrote:
> > I ran some basic tests by changing the period and duty cycle in both
> > decreasing and increasing sequences (see the script below).
>
> What is clk_get_rate(ddata->clk) for you?
130 MHz
>
> > # Backward testing for period (decreasing)
> > echo "Testing period backward..."
> >
> > seq 15000 -1 5000 | while read p; do
> >
> >    echo $p > /sys/class/pwm/pwmchip1/pwm0/period
> >
> >    echo "Testing period: $p"
> >
> > done
> >
> >
> > # Forward testing for period (increasing)
> > echo "Testing period forward..."
> >
> > seq 5000 1 15000 | while read p; do
> >
> >    echo $p > /sys/class/pwm/pwmchip1/pwm0/period
> >
> >    echo "Testing period: $p"
> >
> > done
> >
> >
> > # Backward testing for duty cycle (decreasing)
> > echo "Testing duty cycle backward..."
> >
> > for duty in $(seq 10000 -1 0); do
> >
> >    echo $duty > /sys/class/pwm/pwmchip1/pwm0/duty_cycle
> >
> >    echo "Testing duty cycle: $duty"
> >
> > done
> >
> >
> > # Forward testing for duty cycle (increasing)
> >
> > echo "Testing duty cycle forward..."
> >
> > for duty in $(seq 0 1 10000); do
> >
> >    echo $duty > /sys/class/pwm/pwmchip1/pwm0/duty_cycle
> >
> >    echo "Testing duty cycle: $duty"
> >
> > done
> >
> >
> >
> > In these particular tests, I didn=E2=80=99t see any functional differen=
ce or
> > unexpected behavior whether I used DIV64_U64_ROUND_CLOSEST() or
> > DIV64_U64_ROUND_UP.
> > Of course, there=E2=80=99s a chance my tests haven=E2=80=99t covered ev=
ery scenario,
> > so there could still be edge cases I missed.
>
> Just to be sure: You have PWM_DEBUG enabled?
Yes, to verify my patch, I always enable it by default.

>
> > From what I understand, your main concern is to ensure we never end up
> > with a duty cycle that=E2=80=99s smaller than what the user requested, =
which a
> > round-up approach would help guarantee. If you still recommend making
> > that change to achieve the desired behavior, I=E2=80=99m happy to updat=
e the
> > code accordingly(CLOSEST->UP).
>
> No, .apply should round down and so to ensure that
>
>         pwm_get_state(mypwm, &state);
>         pwm_apply(mypwm, &state);
>
> doesn't modify the hardware setting, .get_state has to round up.
I have some questions that I'd like to further confirm, to ensure I
understand correctly and can adjust the patch accordingly

your earlier suggestions were as follows:
"Round-closest is usually wrong in an .apply() callback. I didn't do
the detailed math, but I think you need to round up here."

The more recent suggestions are as follows:
"No, .apply should round down and so to ensure that....."

I speculate that the latter suggestion is to ensure idempotency
between .apply and .get_state, avoiding unnecessary hardware setting
modifications during repeated reading and applying processes. However,
the earlier suggestions seem to conflict with this.

If needed, I can provide more test results or make further adjustments.
Thank you again for your patient guidance.
>
> Best regards
> Uwe

