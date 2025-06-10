Return-Path: <linux-pwm+bounces-6284-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71FDAD4473
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 23:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC503A5CA1
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 21:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E0C2676DF;
	Tue, 10 Jun 2025 21:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="Tq2s4Hys"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38623AB9F
	for <linux-pwm@vger.kernel.org>; Tue, 10 Jun 2025 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589858; cv=none; b=HVIn/nsxCZTS8ocZSqRb1lAY1MUDWa9e81hviyo/XY+JPdAzaFmnGqX21NVDNDdAp042IDkOqrets+MGNb94v4uP3z0Zpri3uwXBok1SFj1LLKW7Q1f1aOdeFozmwa80kU5p2XwvWbljds61vWcl2Ysc6xmrtGpZ/CQXwZzGqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589858; c=relaxed/simple;
	bh=xopTrHZYYeehT8ed1EQVkbTxnWFxQKA3lyNFS+FgNus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXyeZtWt8bJmbGHqr8R0uj+Olf3iwI651JWXf4u7mVJq0bNGnooSgYHhBRy3/eogfYTvU1ZNBLKS+CM1yXB2AaZGX4R+hP0Kg+STfmA0x6cNZFQhL5XxC9euGS82SvZKXXvlLfVBK0WOlxizXjkuJg3yHMSEFzbdGE1/Kx6OE4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=Tq2s4Hys; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7486ca9d396so263726b3a.1
        for <linux-pwm@vger.kernel.org>; Tue, 10 Jun 2025 14:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1749589856; x=1750194656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6z/2eKNf3fRnG2uPVmiQPHVorfwCzVQ+3VGe9Xlb1rw=;
        b=Tq2s4HysD8o3z14wQk/nD3Otc/LcaeJmXPDJ20DppUPzeCh1hKg+/I5PhcuHjyF/co
         QHiJ1Ok1vRf+fvvTmDifJXc5VjbLUGf2Ck7iHKOW1eupiwiabezBoItzmrtGQ8wHz52Y
         115O+c+MegTVeI0O7VXnSXGnaty6RaX6eWXo4sRXX/hu8BSbhn6AnLDWduDYsAkqfCTG
         9OBbsnYrQ5k93jpCg6aZHbVcxJaQMRTW6+q2uZZfwNHZy8iN28aACalYP+mwUEiTjviE
         9vkPQVqfPcmvmj2s4svyEru0J/TyhA4SLyWwNhrh6VpR6Z5Atn8jo+7JtpDOA1HWx4n5
         I0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749589856; x=1750194656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6z/2eKNf3fRnG2uPVmiQPHVorfwCzVQ+3VGe9Xlb1rw=;
        b=qjX6M9J88AB6sJcUPm2d9OWyBbOCt/C7ZxmCO1/Wh9TXJzcP/Hlm89IrKD/dcHW4Ex
         ooEfkQhHFW2VlH7E8qfK9qnoRUcyEsKcRYn+/8sCIj/81scCr7gFdno47g2cz8OCwJMr
         QOqooZbOJhdX4XY1ezRCDzG/dMk5R5ndslNJLQIuZw1cOHUxz16P9OE98yX6+OP79Hf4
         oaIBWYyd9a6LnjeGc5vrj/9Ezb7Nui+fwyKHovDtxm3yUYN7qsQdqEO/CsqJN9rZyY5y
         cguBLh3+6l/9E80hsUS8lqrjATuVMgsOLrjXKjj8ovjOVgwzEvq/bNoPajnq9PpXn/1h
         klEg==
X-Forwarded-Encrypted: i=1; AJvYcCVXeQ/QLt5ae3RIw694gHQvjq3S4JVbck8pbMvTseGNfCMKX9kCPuv9NJsBpmxMfjA9fWA0NeaZywM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOlT7BUtTGk4joosroy5pbvOhMZgP+ZMuCNnzAqAT6fl3zj1Gf
	QTHYHM+tgxLTARQWRZFmGb7HqtV7qWUTm4zbJiWIvSENJeiV64U5hwrEu9OnPMITH8I=
X-Gm-Gg: ASbGncs2OiOp2oxkUHpMIioYTKYGSbVmBCL4i4z9nyktQHmxOmjmKy+Rt/X3ftkG9z1
	dqJ01Ui20WqyjL1M1lLUVahu4/hKK/YSH17yjWb8OAS/LngEgW5kPU3oF+0pEgUBoP2SH9/zRJg
	dS3IV7PvwhBwmjmofn6bnA1MCiKbpiDwFvzgKDk9TdAn8SFpfeZEXRhqfZD9Yd1iYUn9NEbfNRf
	rqUlkGG60DaTc6LgbxQdgho38mCDo6EqdkFxZg6uyOy89bQQpm6ZYoT2V3UPKDThd/QY4GFpNyV
	t2PE3sYv+oyIYJ6uyNckLjxf5vOVqtZCGTyKRxrGt0wjJjBzBJnzrQeibKx3fhx7rfWFSrwXiw=
	=
X-Google-Smtp-Source: AGHT+IEwLiXrZcnfbq3Tv7L10VDTAaWuwBouaxEsiIQvsla3HLyJ0NW+H5r5c64jx5IdZukdlDUpIQ==
X-Received: by 2002:a05:6a00:23c8:b0:742:a334:466a with SMTP id d2e1a72fcca58-7486cbd86f3mr1332331b3a.12.1749589855939;
        Tue, 10 Jun 2025 14:10:55 -0700 (PDT)
Received: from x1 (97-120-245-201.ptld.qwest.net. [97.120.245.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b083ac7sm7858957b3a.82.2025.06.10.14.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:10:55 -0700 (PDT)
Date: Tue, 10 Jun 2025 14:10:53 -0700
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
Message-ID: <aEifXZnLxKd2wa0w@x1>
References: <CGME20250610125330eucas1p2a573627ca8f124fe11e725c2d75bdcc9@eucas1p2.samsung.com>
 <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com>

On Tue, Jun 10, 2025 at 02:52:48PM +0200, Michal Wilczynski wrote:
> This patch series introduces Rust support for the T-HEAD TH1520 PWM
> controller and demonstrates its use for fan control on the Sipeed Lichee
> Pi 4A board.
> 
> The primary goal of this patch series is to introduce a basic set of
> Rust abstractions for the Linux PWM subsystem. As a first user and
> practical demonstration of these abstractions, the series also provides
> a functional PWM driver for the T-HEAD TH1520 SoC. This allows control
> of its PWM channels and ultimately enables temperature controlled fan
> support for the Lichee Pi 4A board. This work aims to explore the use of
> Rust for PWM drivers and lay a foundation for potential future
> Rust based PWM drivers.
> 
> The core of this series is a new rust/kernel/pwm.rs module that provides
> abstractions for writing PWM chip provider drivers in Rust. This has
> been significantly reworked from v1 based on extensive feedback. The key
> features of the new abstraction layer include:
> 
>  - Ownership and Lifetime Management: The pwm::Chip wrapper is managed
>    by ARef, correctly tying its lifetime to its embedded struct device
>    reference counter. Chip registration is handled by a pwm::Registration
>    RAII guard, which guarantees that pwmchip_add is always paired with
>    pwmchip_remove, preventing resource leaks.
> 
>  - Modern and Safe API: The PwmOps trait is now based on the modern
>    waveform API (round_waveform_tohw, write_waveform, etc.) as recommended
>    by the subsystem maintainer. It is generic over a driver's
>    hardware specific data structure, moving all unsafe serialization logic
>    into the abstraction layer and allowing drivers to be written in 100%
>    safe Rust.
> 
>  - Ergonomics: The API provides safe, idiomatic wrappers for other PWM
>    types (State, Args, Device, etc.) and uses standard kernel error
>    handling patterns.
> 
> The series is structured as follows:
>  - Rust PWM Abstractions: The new safe abstraction layer.
>  - TH1520 PWM Driver: A new Rust driver for the TH1520 SoC, built on
>    top of the new abstractions.
>  - Clock Fix: A necessary fix to the TH1520 clock driver to ensure bus
>    clocks remain enabled.
>  - Device Tree Bindings & Nodes: The remaining patches add the necessary
>    DT bindings and nodes for the TH1520 PWM controller, a thermal
>    sensor, and the PWM fan configuration for the Lichee Pi 4A board.
> 
> Testing:
> Tested on the TH1520 SoC. The fan works correctly. The duty/period
> calculaties are correct. Fan starts slow when the chip is not hot and
> gradually increases the speed when PVT reports higher temperatures.
> 
> The patches are based on mainline, with some dependencies which are not
> merged yet - platform Io support [1] and math wrapper [2].
> 
> Reference repository with all the patches together can be found on
> github [3].

I'm trying to build your rust-next-pwm-working-fan-for-sending-v4 branch
but I get this error:

$ make W=1 LLVM=1 ARCH=riscv -j16
  CALL    scripts/checksyscalls.sh
.pylintrc: warning: ignored by one of the .gitignore files
  UPD     include/generated/utsversion.h
  CC      init/version-timestamp.o
  KSYMS   .tmp_vmlinux0.kallsyms.S
  AS      .tmp_vmlinux0.kallsyms.o
  LD      .tmp_vmlinux1
ld.lld: error: undefined symbol: rust_build_error
    referenced by pwm_th1520.4789668fc0b4e501-cgu.0
                  drivers/pwm/pwm_th1520.o:(<pwm_th1520::Th1520PwmDriverData as kernel::pwm::PwmOps>::get_state) in archive vmlinux.a
    referenced by pwm_th1520.4789668fc0b4e501-cgu.0
                  drivers/pwm/pwm_th1520.o:(<pwm_th1520::Th1520PwmDriverData as kernel::pwm::PwmOps>::write_waveform) in archive vmlinux.a
    referenced by pwm_th1520.4789668fc0b4e501-cgu.0
                  drivers/pwm/pwm_th1520.o:(<pwm_th1520::Th1520PwmDriverData as kernel::pwm::PwmOps>::write_waveform) in archive vmlinux.a
make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux] Error 1
make[1]: *** [/home/pdp7/linux/Makefile:1241: vmlinux] Error 2
make: *** [Makefile:248: __sub-make] Error 2

I've uploaded the config to:
https://gist.github.com/pdp7/e2c34dd7e4349a54bd67b53254bd3a22

Thanks,
Drew

