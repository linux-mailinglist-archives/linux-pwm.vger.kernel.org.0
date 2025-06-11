Return-Path: <linux-pwm+bounces-6310-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759B2AD6406
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 01:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA0717E3EB
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 23:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AA42C326E;
	Wed, 11 Jun 2025 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="UCilMB5a"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4038924C68D
	for <linux-pwm@vger.kernel.org>; Wed, 11 Jun 2025 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749685946; cv=none; b=Df2y5vGvOLLpXK4DbhS8JMLOuNU5tXlTPTVUjzFho6X7zKSYlhZtIsDLHxU+e7eNp3VGscgaQXx6HLgPYMDBs5LbRQJZMH6H1zOjx2bZchj53RMp2QgMZnoqBh31d0GsOv0iuQkIDt0EbxVEV4vZb6o2ZSMKoNc/Fajm86bcSqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749685946; c=relaxed/simple;
	bh=sVzmrh+Xj7m9JqoL9XUk0ved4SUObimi1V5uzxwwRzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgLozdfHUVDC89sF2oqgM4SO5b+52Qazn0XyGqhpuLV21KFZ7KYA1eQCWP+VE6ox+htvyjxmU6erNrQ7y5IkUad5z26Vrtt6uG/mRA0wLSQ58pjnD32Br1P/zwSRQe4uMNPSARnd92s9k0/3+5K2w/v9Ry0xKJHjyyK37GXrkhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=UCilMB5a; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74849e33349so414314b3a.3
        for <linux-pwm@vger.kernel.org>; Wed, 11 Jun 2025 16:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1749685944; x=1750290744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ds26m+OEVEHtTwY8L13PNjwlyxHGQ40Hrmpl5kY1WfM=;
        b=UCilMB5ads5kOuNOzI71W//PeFsFMDueqyG8H0jodz1cg372vFoI51CA5fx8VJNn/U
         rzqT8oyAam9qQradqfDTeDKG6ZHm8/M+NypyQfSauRpZYQtRjSpgFgtqCzaJglD8yyxk
         1taLszMNHJ3yPg5pqSvZXUkIWNkQfS8To21bIhePWvFhwLNq+bZGv/Q3iM5EVQ2vicT2
         tnV2Gp2dc0kUk+S3jJG59sbdB4Gmqpsrkm/bgTaNWMJ0EsOhWEBOranswjOTMDaFsQKj
         Q9CmwVgKB2U9xknmtmDO1Da0R5Rzlb4bxNz8zRpquv3C5r4F98K71sXzMx7ltoLkUQLD
         eNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749685944; x=1750290744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ds26m+OEVEHtTwY8L13PNjwlyxHGQ40Hrmpl5kY1WfM=;
        b=pSJEIHFSE8pYcFyKCivIuFUnO2lNmbYejl46mKpEfrxXSu/KQq3UOZ5l/VMG2FEXk/
         +jhSOlSLiVRITU5oQj0wmJG8u98ZKq/J4Gg+kmX2axZ0bgCBLBFkKyf+GJnHmrIFWxUu
         bUUPZcLOj/r9p9PSP39HCL0nPAcX5lvfIOegHgpq6apl7cpYNtewTZa7tUdeECLgo4Fe
         a6UC1GyM7OBvNa3WVlqYVACFL8Vr+8DkllX97NQzei7hpon4r7VisxQAVrb/P3wVXV5g
         vn7qR9AlLV37iqhZ4As3G6Ux6mzQb0JUma7FpwdPRy/UqdLcGEdWnVrH3PKekhGRdcjW
         xqwA==
X-Forwarded-Encrypted: i=1; AJvYcCVxOZjjx8+wNxeAwf5ubbrDoX2JTVyXxe4rHEw/2Uj+qkU87G687qfFy9B+/F2bSwnR40CerdmLb1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrk3MrPXDKb5M1vIzv8OkWLaUFSuErrR+ux0kmLaEJaP4klQhN
	38BCFO78dOY8Q7yQUotpFaLtXmNKzKAHky6F8iXGMTUglimLWMMmBx+GO9dAtqBR2+k=
X-Gm-Gg: ASbGncuWKfu1pJJtZR2qKHiaFc4NTBBwaMOwQ/Xuif/T6+EBqGzb+AkdhOxn7BI/+cb
	63K06BrJO21ZLVh924LVlAsMTtEJ39Pa3j5bbGCqktDXdLUaMkDjNN9MaQBBVx7CLwtNHOOv2K8
	wThg2qvpTq4ufEtDdKdyNXaeXkbl9z8ETgqK0c6mLGj+OSW99SAxoZRvDU01IqgvXkybChB3Yza
	/U5Gctqwg21GzM0h/3aLir4A6lzrYG1sUMHJXT4e3h8KNXICN6LI2javmuUcYlpFwRXaLS3LDqM
	CFgpKoBNhPpGS1Z7DsvRs5dL4TqBqZubYCILYpxPrT0qsaNEYgnMApVTQyv6tIE4xH+PisksQw=
	=
X-Google-Smtp-Source: AGHT+IFS+0RpPDsIJ7Pc4hAG+1bB0h9nua2v+kKuA7YHahR/7bpKq5ETyy2eU0pRRy9UZ+rORXm+hw==
X-Received: by 2002:a05:6a20:2587:b0:21f:53e4:1930 with SMTP id adf61e73a8af0-21f86725dfemr7771431637.22.1749685944426;
        Wed, 11 Jun 2025 16:52:24 -0700 (PDT)
Received: from x1 (97-120-245-201.ptld.qwest.net. [97.120.245.201])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd62a4e59sm121567a12.55.2025.06.11.16.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 16:52:24 -0700 (PDT)
Date: Wed, 11 Jun 2025 16:52:22 -0700
From: Drew Fustini <drew@pdp7.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Benno Lossin <lossin@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Message-ID: <aEoWtviFl0vYATXe@x1>
References: <CGME20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9@eucas1p2.samsung.com>
 <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
 <aEifXZnLxKd2wa0w@x1>
 <6ca6016e-3b17-48a0-ad8d-bb05317aa100@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ca6016e-3b17-48a0-ad8d-bb05317aa100@samsung.com>

On Wed, Jun 11, 2025 at 05:14:40PM +0200, Michal Wilczynski wrote:
> 
> 
> On 6/10/25 23:10, Drew Fustini wrote:
> > On Tue, Jun 10, 2025 at 02:52:48PM +0200, Michal Wilczynski wrote:
> >> This patch series introduces Rust support for the T-HEAD TH1520 PWM
> >> controller and demonstrates its use for fan control on the Sipeed Lichee
> >> Pi 4A board.
> >>
> >> The primary goal of this patch series is to introduce a basic set of
> >> Rust abstractions for the Linux PWM subsystem. As a first user and
> >> practical demonstration of these abstractions, the series also provides
> >> a functional PWM driver for the T-HEAD TH1520 SoC. This allows control
> >> of its PWM channels and ultimately enables temperature controlled fan
> >> support for the Lichee Pi 4A board. This work aims to explore the use of
> >> Rust for PWM drivers and lay a foundation for potential future
> >> Rust based PWM drivers.
> >>
> >> The core of this series is a new rust/kernel/pwm.rs module that provides
> >> abstractions for writing PWM chip provider drivers in Rust. This has
> >> been significantly reworked from v1 based on extensive feedback. The key
> >> features of the new abstraction layer include:
> >>
> >>  - Ownership and Lifetime Management: The pwm::Chip wrapper is managed
> >>    by ARef, correctly tying its lifetime to its embedded struct device
> >>    reference counter. Chip registration is handled by a pwm::Registration
> >>    RAII guard, which guarantees that pwmchip_add is always paired with
> >>    pwmchip_remove, preventing resource leaks.
> >>
> >>  - Modern and Safe API: The PwmOps trait is now based on the modern
> >>    waveform API (round_waveform_tohw, write_waveform, etc.) as recommended
> >>    by the subsystem maintainer. It is generic over a driver's
> >>    hardware specific data structure, moving all unsafe serialization logic
> >>    into the abstraction layer and allowing drivers to be written in 100%
> >>    safe Rust.
> >>
> >>  - Ergonomics: The API provides safe, idiomatic wrappers for other PWM
> >>    types (State, Args, Device, etc.) and uses standard kernel error
> >>    handling patterns.
> >>
> >> The series is structured as follows:
> >>  - Rust PWM Abstractions: The new safe abstraction layer.
> >>  - TH1520 PWM Driver: A new Rust driver for the TH1520 SoC, built on
> >>    top of the new abstractions.
> >>  - Clock Fix: A necessary fix to the TH1520 clock driver to ensure bus
> >>    clocks remain enabled.
> >>  - Device Tree Bindings & Nodes: The remaining patches add the necessary
> >>    DT bindings and nodes for the TH1520 PWM controller, a thermal
> >>    sensor, and the PWM fan configuration for the Lichee Pi 4A board.
> >>
> >> Testing:
> >> Tested on the TH1520 SoC. The fan works correctly. The duty/period
> >> calculaties are correct. Fan starts slow when the chip is not hot and
> >> gradually increases the speed when PVT reports higher temperatures.
> >>
> >> The patches are based on mainline, with some dependencies which are not
> >> merged yet - platform Io support [1] and math wrapper [2].
> >>
> >> Reference repository with all the patches together can be found on
> >> github [3].
> > 
> > I'm trying to build your rust-next-pwm-working-fan-for-sending-v4 branch
> > but I get this error:
> > 
> > $ make W=1 LLVM=1 ARCH=riscv -j16
> >   CALL    scripts/checksyscalls.sh
> > .pylintrc: warning: ignored by one of the .gitignore files
> >   UPD     include/generated/utsversion.h
> >   CC      init/version-timestamp.o
> >   KSYMS   .tmp_vmlinux0.kallsyms.S
> >   AS      .tmp_vmlinux0.kallsyms.o
> >   LD      .tmp_vmlinux1
> > ld.lld: error: undefined symbol: rust_build_error
> >     referenced by pwm_th1520.4789668fc0b4e501-cgu.0
> >                   drivers/pwm/pwm_th1520.o:(<pwm_th1520::Th1520PwmDriverData as kernel::pwm::PwmOps>::get_state) in archive vmlinux.a
> >     referenced by pwm_th1520.4789668fc0b4e501-cgu.0
> >                   drivers/pwm/pwm_th1520.o:(<pwm_th1520::Th1520PwmDriverData as kernel::pwm::PwmOps>::write_waveform) in archive vmlinux.a
> >     referenced by pwm_th1520.4789668fc0b4e501-cgu.0
> >                   drivers/pwm/pwm_th1520.o:(<pwm_th1520::Th1520PwmDriverData as kernel::pwm::PwmOps>::write_waveform) in archive vmlinux.a
> > make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux] Error 1
> > make[1]: *** [/home/pdp7/linux/Makefile:1241: vmlinux] Error 2
> > make: *** [Makefile:248: __sub-make] Error 2
> 
> Hi,
> 
> Thanks for testing !
> I can reproduce the issue with your config.
> 
> The root of the problem was a failing compile time assertion
> (build_assert!) in the underlying Rust abstracions, I think IoMem since
> get_state and write_waveform functions are impacted. My development
> configuration was accidentally hiding this issue, but your configuration
> correctly exposed it.
> 
> The kernel config option that is different on my setup is:
> CONFIG_RUST_BUILD_ASSERT_ALLOW=y

Thanks for the explanation. I wanted to see how far I could get so I
also have set CONFIG_RUST_BUILD_ASSERT_ALLOW=y for now.

I also enabled the pwm fan driver. However, there is a probe failure:

[    1.250921] pwm-fan pwm-fan: Failed to configure PWM: -524
[    1.256546] pwm-fan pwm-fan: probe with driver pwm-fan failed with error -524

This seems to be the result `set_pwm(ctx, initial_pwm)` failing.

It seems like the TH1520 PWM driver loaded okay:

# cat /sys/class/pwm/pwmchip0/npwm 
6
# ls -l /sys/class/pwm/pwmchip0/device
lrwxrwxrwx 1 root root 0 Jun 12 07:37 /sys/class/pwm/pwmchip0/device -> ../../../ffec01c000.pwm
# ls -l /sys/class/pwm/pwmchip0/device/driver
lrwxrwxrwx 1 root root 0 Feb 28  2023 /sys/class/pwm/pwmchip0/device/driver -> ../../../../bus/platform/drivers/pwm-th1520

I'm using your mwilczy/rust-next-pwm-working-fan-for-sending-v4 branch:

7ec07c93dbac riscv: dts: thead: Add PWM fan and thermal control
c8a6138b2a13 riscv: dts: thead: Add PVT node
14e2f1bfd26b riscv: dts: thead: Add PWM controller node
afe06057030e dt-bindings: pwm: thead: Add T-HEAD TH1520 PWM controller
fe75d1ab60c9 clk: thead: Mark essential bus clocks as CLK_IGNORE_UNUSED
47dc6a551376 pwm: Add Rust driver for T-HEAD TH1520 SoC
9370bdd31cdc rust: Add basic PWM abstractions
f077d5bf0be8 Rust Abstractions for PWM subsystem with TH1520 PWM driver
f153d0d0221f rust: math: Add KernelMathExt trait with a mul_div helper
51c4a2e7d48a Fix for Device<Bound>
4847fa4f7ac8 rust: platform: allow ioremap of platform resources
929c56df82e5 rust: io: mem: add a generic iomem abstraction
09dfabb4677c rust: io: add resource abstraction

I uploaded the kconfig [1] and boot log [2]. Any ideas?

Thanks,
Drew

[1] https://gist.github.com/pdp7/58ca1f543898daeb281c013facb79aed
[2] https://gist.github.com/pdp7/e263b1b928a17d499f94fa5be7b3a7f8

