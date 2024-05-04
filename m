Return-Path: <linux-pwm+bounces-2157-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8428BB9A9
	for <lists+linux-pwm@lfdr.de>; Sat,  4 May 2024 08:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253F3283BDB
	for <lists+linux-pwm@lfdr.de>; Sat,  4 May 2024 06:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3178291E;
	Sat,  4 May 2024 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvDgUplk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B4712B7D;
	Sat,  4 May 2024 06:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714805410; cv=none; b=IOzDHDSAlFkW3DE5LRr7KQ9xCwNK6WGmLWO5Fp9D27QzVTY2svFNi0X//JNDZF5psmaWV3KGD8wv/PqFT8E5UQkHOgIFBumCSUG4CrP0xdDBXNfBOokLEkwMaeW3/CnBJyFy+Kc9TUXTQy9rLjcbC5ik+hNQgxwFOR+bBFd03Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714805410; c=relaxed/simple;
	bh=R0TlPIIIm/V0GkqkwHs+5v9yj/zJg44U1G0GZwq2Xw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEUFiiSfKOPYYLygpqtrJ4OUQ1pX+dSvUoDUoVMH6n9dYwYM1GP20lbClg4qoLVF5g0cEoDkiw3G5TXNfAAhMkeHiWeoOxJsDHJyzBn+zrRwdaeiE6TgcefeoDF1aQ0pKYNa+7RGHjVmBi26Ar8XUqLH4mqijvskV6twmzz8xBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvDgUplk; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5af23552172so338609eaf.1;
        Fri, 03 May 2024 23:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714805407; x=1715410207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2sbKjYzT4x1UoL5RpmaK50wwtSEQgH7b73Ky6YXb1k=;
        b=lvDgUplkraVsWnsSW5ndmK3tUHW+HuhAOgMVQ3kL6TwdjrOT5WGFMMxD9YQuUoD79T
         1vlJ5EN3WTaFSiyJ9zzY6t0YVK2paueQDa1a/tZxHQTUV34q15pKrk8ny4LgbEJ+UU49
         HwRhMD23yjY4GQjqJkbOTUXiyGdYm5r5JStBkAZkagGAt+H77MYCbZQztUYe8nJzdRFT
         /UQGCUPGmxY//M5+UCrPkZTAR1c/BB29mptZywk8VG/KMcLJyPlEFeG6N/q28W+15LEF
         FB0jTofTk6ghcGL51yw6WMImcjp7Y2T2kgZzBI+Bu1aoW34karJJeLOazAAgo2qB+4n6
         aJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714805407; x=1715410207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2sbKjYzT4x1UoL5RpmaK50wwtSEQgH7b73Ky6YXb1k=;
        b=mivFycyAdobWQRL7EkxR+pnnXfkpuifeZmejXAeKiLg6/EUxfi1g7kuAF4sNdYsfiI
         Ts7bG3v2NsR8scA+41ire5b7FIuTD5OGQZSfXkba2yHC6LRbDaGTBqLKK/HhtKyJk0cj
         AwXa13KTs/Kxm+AEjrHG2u0XQLpLuXnCG6I8ooI+WJymxv8vmIdCq1QJwFohdPN+bju4
         0cynAtM+2rN9A/EOj+o4JzyPalyk+Zn3SzodymnDs9oZE/MskROpdI+iwms9tzI2KHGT
         w/tWwcFfB5dnw87DbvqitNaIecRdZO5dFN6RjQYQY5inU3qU380Epq/ZOnKwuJSztIkb
         WeVg==
X-Forwarded-Encrypted: i=1; AJvYcCVJAxsOgon2igN3seRPemVjSxvujHxRej5S5+F7szsR5uaIhT4PzFc3r/QNAO2ZzsiLKdYlrue1W8W4Wm5xYWPu79U3MkDa+3HcjVgqqKavXmCBE+yoEIKTjuk+XN2GVvxoUq0MJOq7nNcUiedRwWwCiV3aGCzk39X0F4TnpOkQOrePzA==
X-Gm-Message-State: AOJu0YxQA1i4oTGydfHbvd4jDaFkAN7xj42FVaFzZpodWQZ5Z8M4p1iy
	fA9bmwDYb7xcxib2DI46b4OwImm2DrDdARvFD9B9ejGq22Fn2BIQ6UmE4F9KlbvjXGeKdguY4z+
	okGTjv209A3Ar7yyZ02TvN8PHf7s=
X-Google-Smtp-Source: AGHT+IGWGhtJnlnrAsPTnGzkKYDaCZgrwiomT047J2Lrj8CoCeY+IesKUjnqTtkUFM1xQM+nuPuMXVzwgBopTqoH23w=
X-Received: by 2002:a4a:dd95:0:b0:5ac:9f5f:fbdf with SMTP id
 h21-20020a4add95000000b005ac9f5ffbdfmr4665249oov.4.1714805405859; Fri, 03 May
 2024 23:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501083242.773305-1-qiujingbao.dlmu@gmail.com> <PN1P287MB2818F3818BEBE875C460F158FE1F2@PN1P287MB2818.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <PN1P287MB2818F3818BEBE875C460F158FE1F2@PN1P287MB2818.INDP287.PROD.OUTLOOK.COM>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Sat, 4 May 2024 14:49:54 +0800
Message-ID: <CAJRtX8SRudWy7q-ON3L-oTjQo8+GCKPX9_sP8Dq8p3t915yvMQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] riscv: pwm: sophgo: add pwm support for CV1800
To: Chen Wang <unicorn_wang@outlook.com>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dlan@gentoo.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 9:47=E2=80=AFAM Chen Wang <unicorn_wang@outlook.com>=
 wrote:
>
> Hi, Jingbao,
>
> This patchset should also be sent to the linux-riscv mailinglist.

I will do that.

>
> On 2024/5/1 16:32, Jingbao Qiu wrote:
> > The Sophgo CV1800 chip provides a set of four independent
> > PWM channel outputs.
> > This series adds PWM controller support for Sophgo cv1800.
> >
> > Changes since v6:
> > - add detailed Limitations
> > - using BIT(n) instead BIT(0) << n
> > - use 0 instead of disable macro
> > - modify OE judgment criteria
> > - add devm_regmap_init_mmio error message
> > - delete unused variable
> >
> > v6: https://lore.kernel.org/all/20240406063413.3334639-1-qiujingbao.dlm=
u@gmail.com/
> >
> > Changes since v5:
> > - delete the OE function because we plan to use the counter subsystem
> >    instead of capture, so there is no need to reuse this code.
> > - fix set polarity reverse error.
> >
> > v5: https://lore.kernel.org/all/20240314100131.323540-1-qiujingbao.dlmu=
@gmail.com/
> >
> > Changes since v4:
> > - drop filename
> > - fix macro
> > - optimize cv1800_pwm_set_polarity()
> > - optimize cv1800_pwm_set_oe()
> > - add comment for cv1800_pwm_set_oe()
> > - use ticks replace tem
> > - fix duty_cycle larger than period_val
> > - use devm_clk_rate_exclusive_get() replace
> >    clk_rate_exclusive_get()
> > - map linux polarity to register polarity
> >
> > v4: https://lore.kernel.org/all/20240304085933.1246964-1-qiujingbao.dlm=
u@gmail.com/
> >
> > datasheet Link: https://github.com/milkv-duo/duo-files/blob/main/duo/da=
tasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
> > page 614
> >
> > Changes since v3:
> > - use macro instead of npwm number
> > - add support for polarity feature
> > - add support for Output-Enable/OE feature
> >
> > v3: https://lore.kernel.org/all/20240223082014.109385-1-qiujingbao.dlmu=
@gmail.com/
> >
> > Changes since v2:
> > - use 0x08 instead of macro
> > - split if statements based on conditions
> > - in order to round up, first calculate the
> >    number of high-level cycles, then subtract
> >    it from the PERIOD to obtain the number of HLPERIOD
> > - use new pwmchip_alloc() API instead of old style
> >
> > v2: https://lore.kernel.org/all/20240212121729.1086718-1-qiujingbao.dlm=
u@gmail.com/
> >
> > Changes since v1:
> > - drop full stop from subject
> > - re-order maintainers and description
> > - pass checkpatch.pl --strict
> > - fix naming errors
> > - add "Limitations" section
> > - use a driver specific prefix for all defines
> > - using bool instead u32 in cv1800_pwm_enable
> > - check and set state->polarity
> > - use mul_u64_u64_div_u64
> > - use clk_rate_exclusive_get(), balance with clk_rate_exclusive_put()
> > - using macro definitions instead of shift operations
> > - remove shift operation on 0
> > - use priv replace cv_pwm
> > - hardcode npwm
> > - set atomic to true
> > - remove MODULE_ALIAS
> >
> > v1: https://lore.kernel.org/all/20240207055856.672184-1-qiujingbao.dlmu=
@gmail.com/
> >
> > Jingbao Qiu (2):
> >    dt-bindings: pwm: sophgo: add pwm for Sophgo CV1800 series SoC
> >    pwm: sophgo: add pwm support for Sophgo CV1800 SoC
> >
> >   .../bindings/pwm/sophgo,cv1800-pwm.yaml       |  45 +++
> >   drivers/pwm/Kconfig                           |  10 +
> >   drivers/pwm/Makefile                          |   1 +
> >   drivers/pwm/pwm-cv1800.c                      | 293 +++++++++++++++++=
+
> >   4 files changed, 349 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,cv180=
0-pwm.yaml
> >   create mode 100644 drivers/pwm/pwm-cv1800.c
> >
> >
> > base-commit: 32c44e1fa921aebf8a5ef9f778534a30aab39313

Best regards
Jingbao Qiu

