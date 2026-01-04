Return-Path: <linux-pwm+bounces-7839-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87019CF08B8
	for <lists+linux-pwm@lfdr.de>; Sun, 04 Jan 2026 03:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E04A301E170
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Jan 2026 02:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A9929BDAE;
	Sun,  4 Jan 2026 02:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmPVNLCX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FB41DE894
	for <linux-pwm@vger.kernel.org>; Sun,  4 Jan 2026 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767493872; cv=none; b=RF3EJWWwHi/j46WY3Iki98nzPnvnv8S7vxsS/Lg/7NAHZOZj0d6bId2tNqRYbS32cMMRVMtGm3MOjAho59Xjp+1yF/fkDqQBq4q4OutZDiq23NYYJa7ZTXgaMoit1cIhddGSFEVDryBCcQvhlrnljQjxyfTzIotw08aC6KpQrjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767493872; c=relaxed/simple;
	bh=SXUs0395dHcb2gfcReYaXRrzvSio3wMCt59ML1bLCOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwB469JqUyKgt4aauIS8VUFkuF3f2jczZO/39R/cAI9ioqFTsU9HegTktFBVGKuCSV+ujaYiqDghZhaGoDRhBEHhW5DRa/r2UkabUMgYn9fIpvQPeQFEc1+cFomNl+CSvOwA+Y43dL7vhbPoNCxM+oGykLPfdSSF8/+O9wYHr0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmPVNLCX; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5958931c9c7so14949612e87.2
        for <linux-pwm@vger.kernel.org>; Sat, 03 Jan 2026 18:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767493867; x=1768098667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsRWgvZP95DFqQgE5Dg/83eeX9dTEUkTAnlAVYh6kW4=;
        b=SmPVNLCXbfW44c8Mg4p1byHfZewt2c4184Mm3MOQfK/7QBNu4LCAG5UXAOH/OefU66
         /v2Bi7KQ9UDfDnFMaEbh6PYJUfqzZtuN/nmJ6VWGUQTWGmkphyjJ5y/IRWf+J3lwKg9N
         jOSXFPheF50YiaNjeVs9fWPHIlMF1h7HeVXDh9FeEVS+0IxUnIn8zlhxW6/L+YgAm1Un
         4vj6xmJTXkM6yN5p+gb4rcw7k4p/jVmX9gW2nuHTHh7bsGKfvDPh3YvdWhawXN31SANz
         suEnN6RyHsoJEYxt/qK3ppB/osAxhAdy3k0/LE4+Ez3Bcs3ppyEDFvoSIVwKwEiXCBOu
         WSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767493867; x=1768098667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hsRWgvZP95DFqQgE5Dg/83eeX9dTEUkTAnlAVYh6kW4=;
        b=vxICVOH2BgwrCSGjQ9QM/mJtRSpS/G7hqFUSR9C1AsRYpREtJmj/eMPm7GT88ZxP7X
         ZT09Ulm7UGVUyDK3EB78Ij9VD7qWrnk3dh+JrpV+B0rdk8qiqEretbXXuQBkW1fUix/b
         /j+7qh5WHsL4vuMhVW17uHQTPQnqDGSPZGb3BmIu8ZSyh9+rnSXpFXWh3aqd8mFB6Lv6
         aa1x0DyJ8V04hjIXykhPOOi0mUzosVRCKpBX7Q1nljyWChCRGZ2cOIyLdbPf8tLLZptq
         8m8HYvA8xdWG2XNWdXLZ2yCsLHBVjIzQmVcSNGs6cfIYtpba0b5n6UF2GaxxQlvBQPjZ
         Ioig==
X-Forwarded-Encrypted: i=1; AJvYcCXeqTzPo14JR0dXzi8rVdxEp5YOLDzuqdvnnvVILSjQyG13BjIs3p9AgvQ9gf4WnjnSUgKrORJYtio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAR9iDj10bftzOdIxrFZBnrG1l29TdI5Eb1+4hG8V4DS/XxVDY
	HS3jWN3Z/LJIAvLM5n4pDSZH/w8xtsGqOOZn6SjJTybwomdAGsQj3Wzhz9dhYgbEKHe4CQ9Yc4D
	OLUEiTqMCZ8BFhXdKxoJFgWH7dChh9Vo=
X-Gm-Gg: AY/fxX5TmMatHzwGmeynEjW8SAQk+OsPpoG/l+XZbv/wMh22mGOBSSs1Y0BBAJGR97C
	8ZfcrlfU+qNKiQ7SWRII7nvMpHX5Q3bO/f3ghxefAX3voSegq7VdUDm1a0R3jJs4L5v2gANBjTi
	N+XQDeGw54L+EOT/VHg5xsiKst/JLlbBHiZugLCVDy6YhE8zrWdDED7ACA7pl2OYOehWSetkkDp
	IgonUm0dLZCynIr3qTGxcBujYgfJ/GOZQnGt7AIAfu3BqsRxvsqXj2okur3y3GO06XrRHb1U/qg
	1r9S4c8Ztr2Gupd6CQLN61B129bQdSp4SXBetFeGZuz/u4zSxRkRZSWkRYZYf5g4+X3r4xkQFtN
	4vO44ps/ElqS7vhUSi5eX8mgXsFwhdJOe6Xyx3FQumQ==
X-Google-Smtp-Source: AGHT+IHCfWg304ZdWsohB+YD/N10Y1S3fIz7YcKtU4yVi6JuHY84X3Cvj0L0zoUQtCI/DmqwIRlf4bayHj2gTJG6s+o=
X-Received: by 2002:a05:6512:398c:b0:594:522d:68f4 with SMTP id
 2adb3069b0e04-59a17de2c1amr15711243e87.28.1767493867357; Sat, 03 Jan 2026
 18:31:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com>
In-Reply-To: <20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 3 Jan 2026 21:30:31 -0500
X-Gm-Features: AQt7F2qNa6HgMSZbmev-xRE2S9e0Bs2mMObDhaf91cavhP-VhsbNAWN5nPUG0C8
Message-ID: <CAJ-ks9mrpcLaeiGjBcXNqTUwo00Y2MhhHWnWauou6exU1y920Q@mail.gmail.com>
Subject: Re: [PATCH] drivers: pwm: replace `kernel::c_str!` with C-Strings
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 7:24=E2=80=AFAM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> From: Tamir Duberstein <tamird@gmail.com>
>
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  drivers/pwm/pwm_th1520.rs | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> index e3b7e77356fc..8ae8f852ec02 100644
> --- a/drivers/pwm/pwm_th1520.rs
> +++ b/drivers/pwm/pwm_th1520.rs
> @@ -22,7 +22,6 @@
>
>  use core::ops::Deref;
>  use kernel::{
> -    c_str,
>      clk::Clk,
>      device::{Bound, Core, Device},
>      devres,
> @@ -327,7 +326,7 @@ fn drop(self: Pin<&mut Self>) {
>      OF_TABLE,
>      MODULE_OF_TABLE,
>      <Th1520PwmPlatformDriver as platform::Driver>::IdInfo,
> -    [(of::DeviceId::new(c_str!("thead,th1520-pwm")), ())]
> +    [(of::DeviceId::new(c"thead,th1520-pwm"), ())]
>  );
>
>  impl platform::Driver for Th1520PwmPlatformDriver {
>
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251222-cstr-pwm-c9b9a4701157
>
> Best regards,
> --
> Tamir Duberstein <tamird@gmail.com>
>

@Uwe could you please have a look?

Cheers.
Tamir

