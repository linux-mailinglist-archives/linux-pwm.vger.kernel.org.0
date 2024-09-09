Return-Path: <linux-pwm+bounces-3160-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C832397126A
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 10:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574501F22D8E
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A511B1D4B;
	Mon,  9 Sep 2024 08:45:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614B38248D;
	Mon,  9 Sep 2024 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725871536; cv=none; b=o4VRWAhfebsuvrYv2/sAwYVFIqKderk0XB/FfIUojGpkmgDtsCSPmyr/oqJl5JJue7Dj5MmLGOO+cTs5I4AzuCn8t3H91uUxyNhkBedctrdYBArXUPLoPt3wiyHLYPGeA7oE6EBvDncRKBajK47qSR7ItdQINgLJGfKQv5U/Ppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725871536; c=relaxed/simple;
	bh=Hjz+O50xaShzsCzJW4dtU4OnYeaMBQRxnhVWq8j2+HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aa4f+Uhtxtgtzvs7QO8yqtoxwZYV5AtwBuVsmN6c0+bDCVWY0NBBZJ40ReZN61pwyJQ5NpAbX+mL/O0YGNpOnKmLqFX7TUI+t8wjPeP3u+crw5+QNfMPVL72ZALEEvP0YN1UZljrcZ/nejDQpe6PUk25aCymjwJrEL+PfI3Iu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6c49c9018ebso36300287b3.3;
        Mon, 09 Sep 2024 01:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725871533; x=1726476333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OClx8FdjyQ2dYCnYDOmUx9fSX8zEhQ05R0o7VQeRBrI=;
        b=ZiKNMaA8NsDgq8HkhVPz9KIWExFmAZxnMeA7ATPJ9vz8MIdToMrKP4M3aSYY73c8Ap
         56BXt/EgXm6/IkdIKTVgcFSJx3yG6zH+JxmuovDRr6rgp3C9Gctah6UwFz0zk1PIromN
         lKMx2nfvgIamwOsJh76ofwMV/11X3Ta+1ERbkCW/9hzzOcCJmZcEf0Htic0ECFM6ZWW6
         86IhqxHnN5TFeuJfMTpc4hxv21/8lj9d1pukHxT7K2i7NM66TjIcY60YEYFy3O036Ls6
         L7zw7gflfg1hcoSGzbcx+xS4LCWflSxllp/B0yIgTTfZPoD7R/kAbgFEXTZre3U8/3zv
         /0mg==
X-Forwarded-Encrypted: i=1; AJvYcCWLmVhBhptRs/9do85g+ztSXZe4++RxAM/NCJu2VwRDc9VgwpiQnK9w2XTczgpKwmr1GIPxMWoNoL6XRk49@vger.kernel.org, AJvYcCWW8WpJBHwQumkdDzUmqTTQjao7qYax7mwGfIpsUIEzcdHsMg0tKqnnatHBPcLdgcaL4IL5WagFnT48@vger.kernel.org, AJvYcCXqeDV/gXlab/1u9mApLiQp4L8EjCgA/tkq/+/2sJCPf1vHnNnEc8lX/rAYiuF26URQac5aIJgQI5rn@vger.kernel.org
X-Gm-Message-State: AOJu0YzSVzh++tCxgWn6oXrAcqs6Ig4/xcaKLDhKK+y2CIyuJMoN6sLF
	q22yKNzi174tPctYKbJmORJLpdSfC9Pt6YhADRd8Xpe3Iw/vR6/q+sKGlege
X-Google-Smtp-Source: AGHT+IGb9gqXqKIN9fIUjDtAcew9X5va5dHZFxhuGA86ZEXsNGRocZ9KPLZ13REy0m/66vLNKPCBHA==
X-Received: by 2002:a05:690c:2b10:b0:6d3:c634:f5eb with SMTP id 00721157ae682-6db44dc362bmr64560687b3.14.1725871532813;
        Mon, 09 Sep 2024 01:45:32 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db6ea880a8sm5739467b3.114.2024.09.09.01.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 01:45:31 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6d3c10af2efso37150937b3.0;
        Mon, 09 Sep 2024 01:45:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/5+KcGSF/B5mfjAZntafFkOc6xnWN3CewGIg01UjO5DoMHHNvoruFCjBLqW5NZLn/iLvzjT5hFdAV@vger.kernel.org, AJvYcCVjaRuaIhcDO14CrBdEk2cuiwECr07tOAFiZeqLICtEA82C8iR/SBwT0TduUtU8AtsID39Jj/EsD5jc@vger.kernel.org, AJvYcCWt5eubhF6bNBqNBIUI062bnoZv8ROV404VLp32vML36M1i9qJ1jYoTLrZFMM5vw+nUUweARfOqijA+YHdK@vger.kernel.org
X-Received: by 2002:a05:690c:113:b0:64a:7040:2d8a with SMTP id
 00721157ae682-6db44f10494mr80803477b3.23.1725871531566; Mon, 09 Sep 2024
 01:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3985690b29340982a45314bdcc914c554621e909.1725536870.git.unicorn_wang@outlook.com>
 <202409080100.h6lX5Asm-lkp@intel.com> <MA0P287MB28225ECCF1D263A20917AD5DFE992@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <MA0P287MB28225ECCF1D263A20917AD5DFE992@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Sep 2024 10:45:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXOAmCsdcvdo41qD9f4L=K2uZa6nJN7D5YOTTuCnBHtWA@mail.gmail.com>
Message-ID: <CAMuHMdXOAmCsdcvdo41qD9f4L=K2uZa6nJN7D5YOTTuCnBHtWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pwm: sophgo: add driver for Sophgo SG2042 PWM
To: Chen Wang <unicorn_wang@outlook.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	Chen Wang <unicornxw@gmail.com>, ukleinek@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, inochiama@outlook.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, 
	chunzhi.lin@sophgo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chen,

On Mon, Sep 9, 2024 at 10:26=E2=80=AFAM Chen Wang <unicorn_wang@outlook.com=
> wrote:
> I wonder why CONFIG_PWM_SOPHGO_SG2042 is enabeld for m68k? Please remove
> this.

Because it depends on ARCH_SOPHGO || COMPILE_TEST.
So it can be enabled on all architectures when compile-testing.

> On 2024/9/8 1:58, kernel test robot wrote:
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on 431c1646e1f86b949fa3685efc50b660a364c2b6]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Wang/dt-bin=
dings-pwm-sophgo-add-bindings-for-sg2042/20240905-201303
> > base:   431c1646e1f86b949fa3685efc50b660a364c2b6
> > patch link:    https://lore.kernel.org/r/3985690b29340982a45314bdcc914c=
554621e909.1725536870.git.unicorn_wang%40outlook.com
> > patch subject: [PATCH 2/2] pwm: sophgo: add driver for Sophgo SG2042 PW=
M
> > config: m68k-randconfig-r133-20240907 (https://download.01.org/0day-ci/=
archive/20240908/202409080100.h6lX5Asm-lkp@intel.com/config)
> > compiler: m68k-linux-gcc (GCC) 14.1.0
> > reproduce: (https://download.01.org/0day-ci/archive/20240908/2024090801=
00.h6lX5Asm-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202409080100.h6lX5Asm-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >>> drivers/pwm/pwm-sophgo-sg2042.c:99:34: warning: 'sg2042_pwm_match' de=
fined but not used [-Wunused-const-variable=3D]
> >        99 | static const struct of_device_id sg2042_pwm_match[] =3D {
> >           |                                  ^~~~~~~~~~~~~~~~
> >
> >
> > vim +/sg2042_pwm_match +99 drivers/pwm/pwm-sophgo-sg2042.c
> >
> >      98
> >    > 99       static const struct of_device_id sg2042_pwm_match[] =3D {
> >     100               { .compatible =3D "sophgo,sg2042-pwm" },
> >     101               { },
> >     102       };
> >     103       MODULE_DEVICE_TABLE(of, sg2042_pwm_match);
> >     104

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

