Return-Path: <linux-pwm+bounces-6119-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4DAAC31C8
	for <lists+linux-pwm@lfdr.de>; Sun, 25 May 2025 00:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92367AC585
	for <lists+linux-pwm@lfdr.de>; Sat, 24 May 2025 22:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F287C27CCF0;
	Sat, 24 May 2025 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uatuq8DB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C544CEC2;
	Sat, 24 May 2025 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748125318; cv=none; b=bNoCBFeTN4xBj/gQbOjT5COLnhIMTkg7Hsml3cEB19SOwHgKYca+SRqTT8D5kW5vCA3/ptQk1xh3ffBBL/tf52XuObj1/1iEDct3dAE1S2ncSzwfk62MPJwqKYQ+wXXBzCoMjHrfzhn4hskUfZeTcTLqkVy4b7gVNQ0sOcF5HUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748125318; c=relaxed/simple;
	bh=0fe0ICSGcRinXQBkMrS5yeZT6AjuGZds52zt0L9pGb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqwfUEHYnqX8CWJinep7eHRC5IHx7wSfXuS+0goCodkhooOs4NMyQEO8zXaqL1tvJ3M/YFfHTgeZj9wBdAsmju8BxcICy9xpsDiSSGaXEiad2511r1f+XUatge1yduWEZArolt/SDWSGQBnnnnDu1BTniyzYxK2BgPeHPOrLE+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uatuq8DB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso847254b3a.0;
        Sat, 24 May 2025 15:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748125316; x=1748730116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/gfY91nGDE+0RHxKKLvxKyOlcgQwxa07VE2VttyjsQ=;
        b=Uatuq8DBKNoqxs34s1tm97E4LBq9Dytgp4Rt6nq/fHiwICOtI7BxbVxUPiscHaGQfZ
         GPUeAh0NxWgHV8CXJhBNwWlb9sDErnNgpUl5IaHtvzpsW6KA1a4qw6NWgPZzMwToP6Zg
         OAmiAOdo+zu2lXuXvDXcQvDAcNpad9Vbfo/UvfRVsTRdCvwDLjq+8fXMg+oy7I8vu6Cg
         a6FcTZ+WTWqTOVW62KoZC7I5PgPALdMgL+hV5p+WPlLWcTFcvbyvFP79XOwGuQPEP+dC
         vfhiSwgSBVdbZAUZVSROxKFQw/x4Ftieu9eB+l8iD389kzlvkHukYJQYqL62Vzb5KVjT
         s4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748125316; x=1748730116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/gfY91nGDE+0RHxKKLvxKyOlcgQwxa07VE2VttyjsQ=;
        b=qQr8GaXZjBbTIMOX4jaYI03cBG089v6MjAp+jYW630xKMD3+ss3Mz9qbBtJPDJHhT3
         3ULLzaqUfm6/cqEipXR67ym3xPIhwgTEhcdxjyKEQnYgxNqXUIcq8kFquwYmhJghgMpP
         FTHuZcACVffg/C53//fwxsT1YVbePHkDZrH6U+93+fUDH5J6s4b/FYave94NWdE8SdNl
         Uo4mJ6eu/Wu6s8yr4P+G4lRIGGUzV9+Joa8GYelJHb7JOwKwCNikj7KOFANuZ3vMAIH2
         tvUi/22fbH6qnG2meXyzUfrOUxqwEL+xZ8TodHf4ZRUbjFScXKKD2DzlORtrmp178sCK
         hang==
X-Forwarded-Encrypted: i=1; AJvYcCUloOzrY/cko6udQVTF3npl+ij+sQ/ld7ZZlc2Z8NOvp1ygPliiBuuqoQf0jI26Ijgjxx1ImCunbVtsAjyB@vger.kernel.org, AJvYcCVytr2yyqqkci42Mg8lPWZxquqowGj7TwuFn06lg7UOv5H8M/pn5ojPE+vB3IRHTFC7kgp/YxIVvQqs@vger.kernel.org, AJvYcCWbXtyL2hJs90GxwCdar9pyDfF2nDP+jw9zOHjuBFq+WIvfLSaHLd1cU8n5N5JMAhW/J+TVhIc5e8yY@vger.kernel.org, AJvYcCWbbUUniLiwk+o1F8w+xph5XD5H+JRId/rB5ePdmgzQz2YIbqBPMkhEBTBWZM41MzeWQzwnt751BSo/92+R6js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5tQYeNlMyx2YWjjHUMakMG5l6HdzpACZTe97wsr5Zb1yq50rQ
	IGQbyYczmNiWIAjpPKSdd08DOCXPRtJ6DnBMAfs6Qia3sK7VtFplpI+m
X-Gm-Gg: ASbGncsl3yakRnitK9C4qMQI0DQ2yqdAH5U7NBZJtCxkcRjIVVf5u3JjATTeDm/45zl
	cOi4N1bFDuHd+hDROB+A7PVj5+1tp2eEzhluGttKeTSRBnA+I0J1SEty4XUcwVgGO7fp5hsPujK
	cF9hRrD74o+PD5kYzvW1fJPgnJIqfg8bF9AyMZYSwdSleg3yCnMzt+C8c2S+aZQmfUE1tfHZ9zB
	Oxyx8Nhl8JABk9yIV0R/SErpfVJ9v/WkMRvmDqvJOcpWVqKGVJtCVQzNqSP2dzox/uNf2i2FhDQ
	qm42XxOkP3qbVMFH4b2AN72S50CFrUfi5+DJtkXxnAjluiTNFky+LF2TovD2pXZtDZO83w==
X-Google-Smtp-Source: AGHT+IHEUxETV0pocM5atEPYdJlqffDPIUlgr2gOFmaZoXDKfwNisfSk+PUUDevzM5Z0StSlaes5OQ==
X-Received: by 2002:a05:6a00:3d15:b0:742:b3a6:db10 with SMTP id d2e1a72fcca58-745fe083538mr7389041b3a.18.1748125315849;
        Sat, 24 May 2025 15:21:55 -0700 (PDT)
Received: from x1 (97-120-251-212.ptld.qwest.net. [97.120.251.212])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829b9dsm14653654b3a.88.2025.05.24.15.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 15:21:54 -0700 (PDT)
Date: Sat, 24 May 2025 15:21:52 -0700
From: Drew Fustini <pdp7pdp7@gmail.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Message-ID: <aDJGgLZ9tITwGBxq@x1>
References: <CGME20250524211519eucas1p218997c69b98b14d3af2eb6bf4e9d3187@eucas1p2.samsung.com>
 <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>

On Sat, May 24, 2025 at 11:14:54PM +0200, Michal Wilczynski wrote:
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
> The series is structured as follows:
> 
> Patch 1/6: Introduce basic PWM abstractions
> This patch lays the groundwork by adding a Kconfig option for Rust PWM
> abstractions, necessary C helper functions, and a new Rust module
> (rust/kernel/pwm.rs). This module provides initial safe wrappers for
> core PWM data structures (Chip, Device, State, Args, Polarity) and
> functions (devm_chip_alloc, devm_chip_add), along with a basic PwmOps
> trait focusing on the .apply callback needed by PWM chip providers.
> 
> Patch 2/6: Add PWM driver for TH1520 SoC
> This introduces the Rust based PWM driver for the T-HEAD TH1520 SoC.
> It implements the PwmOps trait using the abstractions from the first
> patch and handles the specifics of the TH1520 hardware for configuring
> period, duty cycle, and polarity. Resource management leverages devm
> for the PWM chip and Rust DevRes for I/O memory, and RAII for clock
> handling.
> 
> Patch 3/6: dt-bindings: Add PWM T-HEAD controller dt-binding
> This patch adds the Device Tree binding documentation for the T-HEAD
> TH1520 PWM controller.
> 
> Patch 4/6: riscv: dts: thead:: Add PWM controller node
> This patch adds the actual Device Tree node for the TH1520 PWM controller.
> 
> Patch 5/6: riscv: dts: thead: Add PVT node
> Add pvt node for thermal sensor.
> 
> Patch 6/6: riscv: dts: thead: Add PWM fan and thermal control
> This final patch adds the Device Tree configuration for a PWM controlled
> fan to the Sipeed Lichee Pi 4A board DTS file. 
> 
> Testing:
> Tested on the TH1520 SoC. The fan works correctly.
> 
> Points for Discussion:
> The rust/kernel/pwm.rs abstraction layer is currently minimal,
> focusing on the immediate needs of this driver. Feedback on its design,
> scope, and potential for generalization would be highly appreciated.
> General feedback on the Rust implementation, FFI wrapping patterns, and
> adherence to kernel development practices is very welcome.
> 
> The patches are based on rust-next, with some dependencies which are not
> merged yet - platform Io support [1] and clk abstractions [2]. 
> 
> Reference repository with all the patches together can be found on
> github [3].
> 
> [1] - https://lore.kernel.org/rust-for-linux/20250509-topics-tyr-platform_iomem-v8-0-e9f1725a40da@collabora.com/
> [2] - https://lore.kernel.org/rust-for-linux/0ec0250c1170a8a6efb2db7a6cb49ae974d7ce05.1747634382.git.viresh.kumar@linaro.org/ 
> [3] - https://github.com/mwilczy/linux/commits/rust-next-pwm-working-fan-for-sending/

Thanks for the patch series. It will be great to have PWM working
upstream.

I've not built Linux with Rust before, so I'm going through the quick
start [1]. I've also never built Linux with LLVM before but clang seems
like the best compiler to use for Rust. Are you using LLVM?

Drew

[1] https://docs.kernel.org/rust/quick-start.html

