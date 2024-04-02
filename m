Return-Path: <linux-pwm+bounces-1841-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295A5894916
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Apr 2024 04:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BB71C20C25
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Apr 2024 02:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8951FD502;
	Tue,  2 Apr 2024 02:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Kykk28s4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C35BA2D
	for <linux-pwm@vger.kernel.org>; Tue,  2 Apr 2024 02:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712023313; cv=none; b=bRy7s9mgDEJKe5yyVmXiIQPetcONuPCObl9wOJf7U+YBI/ejPHJctsvO9++du0veGYwhXN3AdaFIe0s2KWEhi9mLJ9HNSLbM8Nt+z3syv+jMpPZUwUjOMdDzIMGdvFX/3782UoOsLYlRqPw0YlIabet38yhU/cCka4C44ZnzG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712023313; c=relaxed/simple;
	bh=ZkW2O+QItGCfBp/Z2YzczJnP+UFR/LpqxThI1ialKH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhxTb0VKsB+yzaSk6s8MLRkEgdhha58H06vR1xm5JXt0wwjeQRdxKLc2YwLLPJP1eXVUMVZ/a17mbas2jStk1RuKKuRLnh67MUgUifdYDDZsaqnAveQNmIBFN9Mn9QndJqbfr5kMrijU2GVCQc1qYWljmFk4YTAVT283j1oinlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Kykk28s4; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc74435c428so4440791276.2
        for <linux-pwm@vger.kernel.org>; Mon, 01 Apr 2024 19:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712023311; x=1712628111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvr2WqmK4l25YNAt8b0NZcWlTzIuuYI4Iz17Klvwotc=;
        b=Kykk28s4e9QuP10LJEdiXyv5YXAaNrS0zQrwz6lYblPY3q7WYc6OBfQv9wZeammYQr
         OwCUgAX7mZnWu4xs53ZOzziAwowFCAGP0zXBcJPPsZx/l3GXfY9hPFtbMioS67+fsmQu
         KxdAbj2SxB5wDDnLvjQLYHApfoNXn4IkdNwaygjCpobJ/haepaKKPATICOrUS4RxKGxm
         aLYnd1aT69H4bVJL6hiVAFboD1GMhGF1eswlDA/LYlq623LuHcLy8nQU3PTONugh9YSv
         dy7fXYfIkY3OXadWOrxSKM7rrg/oylkc7sJWiEWg/4q1s9jF5Wwt5tAYDR8C2Y1vyOZN
         TZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712023311; x=1712628111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvr2WqmK4l25YNAt8b0NZcWlTzIuuYI4Iz17Klvwotc=;
        b=URdMUMpPjKgtbBB8yEUdpskzrfK/DKCuC9yMOYPWJATD31vNVEPYMDIH9hfSnTf6Nd
         55mLbvQhtDr1qs1yqEfwGt9oKYXBxADvckD6Mv3bKIPUgn3L66riIxiiPW2Pv3fHDNwf
         GVnXBilPZBWQE7sSZIWEuXlw59ZGypW6/yqBLn8w+5SfWy+r5o4IM0Qod6KH8JWhU10l
         nVp0yNE8M7RinNb2Q85iz5K7S55oIKrmgGEmceVZz2A7n+cKuVTHbuPvOJQxHEt9phEE
         mGY1baY+j3/ZFtZVSrZrEsrIpyaf1eGldQ4Z+NAtGhi50jDHX5m0OC6LtHUEoPzQuUGl
         g+3w==
X-Forwarded-Encrypted: i=1; AJvYcCXh4y5DeHGhu5++8yaqekKVgYREtcV6nJ9N5cNunJId+VVmvNPsDDLT3uIibqXXc8TH5/KuJegMndgtWhgsbchowu94FdPKjjcS
X-Gm-Message-State: AOJu0Yxj1pewuZZwg/nfeBMrxwOO3Ox/DxUhKqTBcreL0t+Wf2hJFfZa
	myDL2NK0QysXq1kWH/q4ITNntmANLFnMM4yVwDpQDWPaO7Vctqt2U0zuz2AXuKT9zyhSqtp27wz
	5bQmbse4xIZcndtikmZEc7jnvaf8T1HcpgEMVOQ==
X-Google-Smtp-Source: AGHT+IEiTesJ6e5VvTHdNiIZOlQ0XIWLmXy/mt4x0B4EzVBfFyQZ042yMQyfl2fZmz0rPpzr+oqCLTurlcAbC3agZZc=
X-Received: by 2002:a25:2e04:0:b0:dc7:4f61:5723 with SMTP id
 u4-20020a252e04000000b00dc74f615723mr8867725ybu.39.1712023310864; Mon, 01 Apr
 2024 19:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222081231.213406-1-nylon.chen@sifive.com>
 <20240222081231.213406-4-nylon.chen@sifive.com> <jvwgsszvs4jtcytcphsdjulzgqfqzdp4sisu236ddwsqgmvriw@ngi4ljgh5b74>
In-Reply-To: <jvwgsszvs4jtcytcphsdjulzgqfqzdp4sisu236ddwsqgmvriw@ngi4ljgh5b74>
From: Nylon Chen <nylon.chen@sifive.com>
Date: Tue, 2 Apr 2024 10:01:39 +0800
Message-ID: <CAHh=Yk92=hp+kaTJWL13_jwJ5gzAAi8gbRF=Ns9=yq2trRUQEg@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] pwm: sifive: Fix the error in the idempotent test
 within the pwm_apply_state_debug function
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, conor@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com, 
	paul.walmsley@sifive.com, aou@eecs.berkeley.edu, thierry.reding@gmail.com, 
	vincent.chen@sifive.com, zong.li@sifive.com, nylon7717@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> =E6=96=BC 2024=E5=B9=
=B43=E6=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:17=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> Hello,
>
> On Thu, Feb 22, 2024 at 04:12:31PM +0800, Nylon Chen wrote:
> > Round the result to the nearest whole number. This ensures that
> > real_period is always a reasonable integer that is not lower than the
> > actual value.
> >
> > e.g.
> > $ echo 110 > /sys/devices/platform/led-controller-1/leds/d12/brightness
> > $ .apply is not idempotent (ena=3D1 pol=3D0 1739692/4032985) -> (ena=3D=
1 pol=3D0 1739630/4032985)
> >
> > Co-developed-by: Zong Li <zong.li@sifive.com>
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> > ---
> >  drivers/pwm/pwm-sifive.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> > index a586cfe4191b..bebcbebacccd 100644
> > --- a/drivers/pwm/pwm-sifive.c
> > +++ b/drivers/pwm/pwm-sifive.c
> > @@ -101,7 +101,7 @@ static void pwm_sifive_update_clock(struct pwm_sifi=
ve_ddata *ddata,
> >
> >       /* As scale <=3D 15 the shift operation cannot overflow. */
> >       num =3D (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH =
+ scale);
> > -     ddata->real_period =3D div64_ul(num, rate);
> > +     ddata->real_period =3D DIV_ROUND_UP_ULL(num, rate);
> >       dev_dbg(ddata->chip.dev,
> >               "New real_period =3D %u ns\n", ddata->real_period);
> >  }
Hi Uwe
>
> pwm_sifive_apply has a DIV64_U64_ROUND_CLOSEST(). I wonder if that needs
> adaption, too?!
According to my experiments, no adjustment is necessary.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

