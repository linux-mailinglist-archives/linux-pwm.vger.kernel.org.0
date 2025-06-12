Return-Path: <linux-pwm+bounces-6313-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0977FAD6BE0
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 11:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555DF18813EE
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Jun 2025 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CF1223DD6;
	Thu, 12 Jun 2025 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNmY3HVZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C41DDC1B;
	Thu, 12 Jun 2025 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719546; cv=none; b=MbV2Wau/N+m90dX8sqm5dcGMjMqgSUhKSmB+QDvTKNUCeizNhvoO/RN3ckZHoT8v6DImQz8C+B9rrKpYJr87m7iVQD4OBPYPqcpPbTPV5/0MYshD7sB7hqOohgrLEDnXkKWq32aa9mLcYsHEhICvBZgNWEjvRqa160sjefKlcy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719546; c=relaxed/simple;
	bh=zJQ79n0+FenXg8CW9hXrEPBZ2mMHVHaVY55v6bEoH3c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UO6DLSYZEyJZgs9oQngoiTsDK97+dk7YRZqsiCrPmyrc7RktifkEg8lvKbC2y3t5uWMBtvInnqTvxal3XrqgQO24Re69E0Zd3CzU+sEUm/laExl5BQw34D47Gjp7eIuRE0L5UGBPHXycbusSjxAt7v9IhGvo3i9OiIVz41lyr4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNmY3HVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333E9C4CEEA;
	Thu, 12 Jun 2025 09:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749719545;
	bh=zJQ79n0+FenXg8CW9hXrEPBZ2mMHVHaVY55v6bEoH3c=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=vNmY3HVZoPLE2n2l1u5VMrnXXjfglJfJQkQW/kG9MSzoncNmdaVGVF/Zw0VdhSd+2
	 3+zr6nieafadxOb84+tYiZSE33Iz+U0ONwWQLxb5+sDYXYrzn9EF4QTGZlREZVq/zq
	 Y4Gg/fT7BII/gpL1zRNomeJYsQqlCwd5uZC14eZjOx//CxZ3nRpEtdZrFCkYF4gsTZ
	 tphePEpk50umpQ61omEd+GsAQtVOFyun0lIgSpexo5QiBohESdem3p1NFx9DZucQZk
	 MEsSLIQKk31UVAkkrQ8bIv0OypuJ0QRzSRHZoZhseI3nEmGq9m9auyauKk0xWUhlAC
	 FAAKddH+Qwn/Q==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Jun 2025 11:12:18 +0200
Message-Id: <DAKFT7C8IRC4.2ID8TJIKN4Z5R@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] rust: Add basic PWM abstractions
From: "Benno Lossin" <lossin@kernel.org>
To: "Michal Wilczynski" <m.wilczynski@samsung.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Drew Fustini" <drew@pdp7.com>, "Guo Ren" <guoren@kernel.org>, "Fu Wei"
 <wefu@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley"
 <paul.walmsley@sifive.com>, "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250610-rust-next-pwm-working-fan-for-sending-v2-0-753e2955f110@samsung.com> <CGME20250610125332eucas1p2da441aa44760236527afc82495af95d1@eucas1p2.samsung.com> <20250610-rust-next-pwm-working-fan-for-sending-v2-1-753e2955f110@samsung.com>
In-Reply-To: <20250610-rust-next-pwm-working-fan-for-sending-v2-1-753e2955f110@samsung.com>

On Tue Jun 10, 2025 at 2:52 PM CEST, Michal Wilczynski wrote:
> Introduce safe Rust abstractions for the Linux PWM subsystem. These
> abstractions provide ergonomic, lifetime managed wrappers around the
> core C data structures and functions, enabling the development of PWM
> chip drivers in safe Rust.
>
> This initial version provides the core building blocks for writing a PWM
> chip provider driver, with a focus on safety, resource management, and
> idiomatic Rust patterns.
>
> The main components are:
>
> Ownership and Lifetime Management:
>  - The pwm::Chip type, an ARef managed wrapper for struct pwm_chip,
>    correctly handles the object's lifetime by using the embedded struct
>    device's reference counter.
>  - A pwm::Registration RAII guard ensures that a call to register a
>    chip (pwmchip_add) is always paired with a call to unregister it
>    (pwmchip_remove), preventing resource leaks.
>
> Safe Type Wrappers:
>  - Safe, idiomatic Rust types (Polarity, Waveform, State, Args,
>    Device) are provided to abstract away the raw C structs and enums.
>    The State wrapper holds its data by value, avoiding unnecessary
>    heap allocations.
>
> Driver Operations (PwmOps):
>  - A generic PwmOps trait allows drivers to implement the standard
>    PWM operations. It uses an associated type (WfHw) for the driver's
>    hardware specific waveform data, moving unsafe serialization logic int=
o
>    the abstraction layer.
>    The trait exposes the modern waveform API (round_waveform_tohw,
>    write_waveform, etc.) as well as the other standard kernel callbacks
>    (get_state, request, apply).
>  - A create_pwm_ops function generates a C-compatible vtable from a
>    PwmOps implementor.
>
> This foundational layer is designed to be used by subsequent patches to
> implement specific PWM chip drivers in Rust.
>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  MAINTAINERS                     |   6 +
>  drivers/pwm/Kconfig             |  13 +
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/pwm.c              |  20 +
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/pwm.rs              | 864 ++++++++++++++++++++++++++++++++++=
++++++
>  7 files changed, 907 insertions(+)

Do you mind splitting this into smaller commits to make review easier?

---
Cheers,
Benno


