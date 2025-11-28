Return-Path: <linux-pwm+bounces-7719-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1363DC91713
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 10:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCA23A7C1A
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Nov 2025 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ECC302174;
	Fri, 28 Nov 2025 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CAEtnk/y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB7C302149
	for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764322140; cv=none; b=ID1Q7au2tZQwAd1VRHIzCA5unqDmDt3oXw+oi1rlk63nAqAyXkfz/8ohNo+zQp/aWkCQEMPq75uYNMilNi5AnPY9JKiih/gZeUhd1blquE/loEqmWE1dDbH+ssi89o9C9FhT3qE+wHlje2Lvhu1GWth0SXtIo7pif8wAlbxh9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764322140; c=relaxed/simple;
	bh=BNgX/Kl8aLf31K9BhcMuloUt4smhu1Y8uRALWghyYMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IYbDNdpWinJR2VHsz0lf4VaAq+i8hwP4tk+o6FpQ7le07+T1tyjAxdLwgMBX8vjgK8EIkFnpmLBRboPPxg8jM0ZbXmz3hel/lWJXYm2UBSq7Qdqob+ctJIQRiLV2gEW1lpXlNHgkdRBoe6YlH5Xe5y85z4FxsNJuBwadljS5JfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CAEtnk/y; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429c5f1e9faso1267380f8f.3
        for <linux-pwm@vger.kernel.org>; Fri, 28 Nov 2025 01:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764322133; x=1764926933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfB1+1n54EtAaQ0p4axZ7CMqQap0WXeaVLrFGnbDa00=;
        b=CAEtnk/ytGh0kBP0w896f3dUu6aG0CqQUaJSzhrrRvsZhvVcpiQNJtc6vn3RSkhToX
         2+ZIP92Ku54QAlWaI0LqS6eyIVI8M5C8Ob5Yl2huGzUVlXa9RoplgWq6nQ2TyX5/Wcta
         pfzcnFMW5bTFCJh1usjPXruk2BBUHf94oeSJarGQNf7NO7LWYlKBO13QtfrsqgNc/f0t
         EMBU25viQ2EEceGU/B1zpU0RGLswU03LLPwFc2BKXpRMCNNmh+oMTdDjz9xj1zqwF7GO
         JeYRZzqKNGP/rIRchzIki6aHnMIYfHZZQLwJmNcsBjfk+DtFH1rXK5sE/iHwAQKVuW3y
         sagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764322133; x=1764926933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfB1+1n54EtAaQ0p4axZ7CMqQap0WXeaVLrFGnbDa00=;
        b=VG6ndZ1ejMtq6IxGtZbDvm0VdX4uf8ULZqasdk0WIqoDwRUVjHdhn6VmV0vAZpBvWD
         AdCpGXtlX/cpLg2Ub4MQAUpqNsxILF9LYLs8iqJgSoh7gDPI0LQ6UnT3EZsjLOrbAu64
         tldS7T0LEIyWXtEZ/Rf+F5IU6UmVsIoVl8PqSUAPml1OoPwGxa7y1ygAWNLGDYe6Cgib
         Wa4925eZeVaOR0uorM47wgXX0Zv+P63TvQcqSOl7iaHt+hDhEbL86lZxoAm0E11Jt0Q2
         oKsjP7vG7rGONc5cWRuJb4TRzKrALqYHHElwJe7nn+uE60CzJZ27NB6AYDbLsJNrfKoo
         SV8w==
X-Forwarded-Encrypted: i=1; AJvYcCWfjIyQsPBuMaPW5V6fwpwaNE9mQd3f5IGxlD9mJVo86i2j0fyrhkF5m1/G++ehOsEB978hOFLrAyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKA8BFB76qNa7Zzwyn7U8jNDnTcl7dphHvw8/tm6BwoaA7OCpU
	sMCoC1bLvWlkD3okjZbR+F9RWm+TPksTjvZyZfPs9h60WeMLNmQUgXE0AxgIpwTWDunQyRJHeRs
	27RWwES6zSsjATyPFcw==
X-Google-Smtp-Source: AGHT+IFiVYsI2OdISn6VZC7R1ztAkjTUn9DQuinLJur4JooHB2So2nt10pptXhN77fC9tVjIw7LQO6s8qx3FfOQ=
X-Received: from wrhm5.prod.google.com ([2002:a05:6000:1805:b0:42b:2edb:9e83])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2387:b0:429:dc9a:ed35 with SMTP id ffacd0b85a97d-42cc1d3479cmr28776643f8f.43.1764322133683;
 Fri, 28 Nov 2025 01:28:53 -0800 (PST)
Date: Fri, 28 Nov 2025 09:28:52 +0000
In-Reply-To: <20251127-pwm_safe_register-v1-1-d22d0ed068ac@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251127-pwm_safe_register-v1-1-d22d0ed068ac@posteo.de>
Message-ID: <aSlrVLT92kmazgyh@google.com>
Subject: Re: [PATCH] Move pwm registration into pwm::Chip::new
From: Alice Ryhl <aliceryhl@google.com>
To: Markus Probst <markus.probst@posteo.de>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	"Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Nov 27, 2025 at 05:15:06PM +0000, Markus Probst wrote:
> The `pwm::Registration::register` function provides no guarantee that the
> function isn't called twice with the same pwm chip, which is considered
> unsafe.
> 
> Add the code responsible for the registration into `pwm::Chip::new`. The
> registration will happen before the driver gets access to the refcounted
> pwm chip and can therefore guarantee that the registration isn't called
> twice on the same pwm chip.
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
> This patch provides the additional guarantee that the pwm chip doesn't
> get registered twice.
> 
> The following changes were made:
> - change the visibility of `pwm::Registration` to private
> - remove the `pwm::Registration::register` function
> - add code for registering the pwm chip in `pwm::Chip::new`
> - add Send + Sync bounds to `PwmOps`
> 
> Note that I wasn't able to test this patch, due to the lack of hardware.

Overall looks reasonable, but I have one question:

> @@ -654,50 +668,23 @@ unsafe fn dec_ref(obj: NonNull<Chip<T>>) {
>  // structure's state is managed and synchronized by the kernel's device model
>  // and PWM core locking mechanisms. Therefore, it is safe to move the `Chip`
>  // wrapper (and the pointer it contains) across threads.
> -unsafe impl<T: PwmOps + Send> Send for Chip<T> {}
> +unsafe impl<T: PwmOps> Send for Chip<T> {}
>  
>  // SAFETY: It is safe for multiple threads to have shared access (`&Chip`) because
>  // the `Chip` data is immutable from the Rust side without holding the appropriate
>  // kernel locks, which the C core is responsible for. Any interior mutability is
>  // handled and synchronized by the C kernel code.
> -unsafe impl<T: PwmOps + Sync> Sync for Chip<T> {}
> +unsafe impl<T: PwmOps> Sync for Chip<T> {}

Why was this changed?

Alice

