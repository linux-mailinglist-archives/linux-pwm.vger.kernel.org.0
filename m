Return-Path: <linux-pwm+bounces-7937-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 151C2D3AEE5
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 16:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C52930133EA
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 15:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100F738B7B8;
	Mon, 19 Jan 2026 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AitzS9lM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6F361DDC
	for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768836177; cv=pass; b=bY8pNfkUhbliSsmTQ65n0lFyyM8PuYsjfvRI/mGfFONuWlIgAMFVOFOE/++vhw75iuG1m3mBpUP7nbkSfgdpaQ/4k2au2+DbzdeW+bB0HocUQlKpbwVpC+jP61d7W+sbY0UQndFcywnx+XbUVFd4WAd1DAGDOxYMs00DLeMuoqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768836177; c=relaxed/simple;
	bh=tR0gCtypqd1iX1iRkqWIYioksTf/njgA2aZ4h6BcDxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3igIvzeVDCGp/S5aPR/QbkVkYcmDglSpBuOjbOX9hyi+xJ7AVz0w1kj2mZljUoIYjjmyTZQ+vDeELQBgszVxr7E98DGdyX/5aaaM0SDgB8C3j5fnzSZB0SdVZlCpqy2C74DuT4hMZ04kfXPp3nu/08EPzdoOWYXj7xGf8M5RoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AitzS9lM; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1233e05c77bso176900c88.1
        for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 07:22:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768836175; cv=none;
        d=google.com; s=arc-20240605;
        b=lOpn9FmQD/XqCTVa1zVhCD+I+Bngl8VUTn7qf3vS4haO1PBOnbewWOIzJJX32qsNtG
         xqk/IwzsvyxQPoTRLtzQPlesTea0siuqTz4qO/BnkZ0GffIdz5WaqFWkZO3UfIoGGT/m
         OJI9c11IAsB7gdfK6bjiVXhcR52+LosNO2XHK3eRcn/YftD52Sy+jguUhaxVreagmn/8
         LKAt8oNploNk5jprOAq1syLoMjgNj1xxsbPj20H++2b3h8RD4Wyzi1QkB3tkTYK8kSMQ
         eHjVBvGXQUExbUZsho93cEKaAG4gmNLk7JEGKBUhpkKkzO0xqbUfGE5ijjwIDX6Oa8yC
         lnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tR0gCtypqd1iX1iRkqWIYioksTf/njgA2aZ4h6BcDxM=;
        fh=m1uQ9yxJhIHRiBRYsh3lmJS6hNG01/HJIkQ3j847CCA=;
        b=Pro3w6vJ3GRbg/QBITqBgdUfzfcIzJ+ceMuYjR8nButexAMOsdpY9vIdE98rqnRk++
         j4x/Kv106WFQrmYgiJJOzbSpK6a+lXkt8UtS2O2a7bQ5F+rRBj5ppmM1lKRGYqDoHOQO
         //9OdLfPj0c1Lh9y3iKHFMCTwf0AeVYUTZvTml/lsf4bKzdBuWdOUlaWgYJeJ1RSvF0H
         8lO7szuP62xCbC6KvGMfXFRHjgLOp1YdcUgIRkDx5WgKUoF4u5K0wbhgLDctXojKw/Vq
         hEr5AHbKhVo69gu6kUijdpMYelbd8R9780GssCVnuwSU6mgSfT/sv0iZte470z0b6ch5
         sazA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768836175; x=1769440975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tR0gCtypqd1iX1iRkqWIYioksTf/njgA2aZ4h6BcDxM=;
        b=AitzS9lMQwv4+fdWYBLW4qMQFvS0PfAesTfFeFGvl6x4XWg1Y/WFr1kTmFIDODAIrT
         OsJ3v6RHnxP8T7v/xmPcJA9AvmSAxKKeK7k/YTdlf8rSOfSNqEiMrZUis1XRsW/5TFTU
         I42ndpD/s+RX+n1G75OsTnYR92yrNDKQa7Nlb3Iym2/QxjJu8vwbU+7Wp17DxDeU4wDd
         TmMjKSlZsub+p2JSB9288ug/ipPwFzsDd1Ni1l7h9CtWRRnodPCrXHzd07aUIb08+ovj
         iFcB29jKkC5RjVwPsgTsq5r8E/m5iWgLSgdd9oXoJmvy1qA7PSAHVTb1Hhxf4ctF4H9m
         Pvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768836175; x=1769440975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tR0gCtypqd1iX1iRkqWIYioksTf/njgA2aZ4h6BcDxM=;
        b=RgNJc7QKteqmwhyk3QGgXN3H2au0vLfsOlAimNMBxZOl1xsFTgfSU90oKqH+nz0klq
         sXiuS7Dq+361MM/ChtwIEACiz96qZ1aJIpYjcz6AWYbesWQnpdL1yuuOuFDKjWPfDqkf
         444NaW5rEZnNrkLyJMhTHj7uat5JACcY1alhxLfhgQJ0ckIg9zMj2u5XhjT5Z0oEMUdn
         qqKwHtjuxlCAOQQrhMqjgWmvMn91b6CzZkrB++ZO3+u6tuEQhaS5wPSUcwvSF539PwJg
         56JIOP40AaLSbmt4w746cas6CHvlufsNj31UkSF2SEuB9lmuN91f/rOVlN7X9gpWMwkV
         jbtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz9hRNNn4DnAhBBvatbBu8uNVEKX0vB7Mi3G+UdokK4G1djqcyNJY6kMiiwnQxx2X83GVvERfjmkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaN52esEQEx2HXOQOI4Ib8cG5RLUtiNZIgtlHNDoFq9IdbWQau
	tWcXmIQmAhju/LHfgGHPkJBql19mw0+ZcTrqENzFGkZxfXJElZOY/IVCB6AKRfjmGZSVpVLqRGb
	khjDFUwDm+MUpBlORgNIs6HvGxwPlOjk=
X-Gm-Gg: AZuq6aI5r3dQYS08VxYQLMJXhWd0WBbvVXQTfuq8s5QOuPwk3D3OlFJJIj1bzSznSF4
	+hm4PRZkHoyCFqz3Euqo46UAkxw4CxhRe9KOmGxA7g8F5zoU4L8Phg3i4NYCRQgTfDMkeetLHf1
	d3PgcjqkpPGdv5qdH/J26sTtdgCgw9iR3ESwO+1X/kVAQYuraekhYwu3QL9Z+xVY65x5QPtowlF
	N1wjXIj0ItWXP2V4qrny/FQ57mKRxOqI64WHePI0KgqIbjLoy+F66VywjytnRIpip8+MtyQvmEY
	zuugGjkGaRMC0Ela53N+Pmx1i0DCGwAeBaEwJ93k9QnpxA57CN1GWkVvCtqscASvTT9wWqOKqZp
	gJmCyNy0milRX
X-Received: by 2002:a05:7301:228e:b0:2b6:f613:74e6 with SMTP id
 5a478bee46e88-2b6f613797fmr27366eec.4.1768836173425; Mon, 19 Jan 2026
 07:22:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com> <DFSMRQFIYQPO.1A38Y84XZ1GZO@garyguo.net>
In-Reply-To: <DFSMRQFIYQPO.1A38Y84XZ1GZO@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Jan 2026 16:22:40 +0100
X-Gm-Features: AZwV_QgNN_SRIlYoHUy-qlXXeVjMEAqzZugkTtOGHbXvqJ3qT7hNtgfXtF3Q8KU
Message-ID: <CANiq72kcRQShDgMJKZ+ekUEdP1T6Jr=4PDiMJCqnQjgCQEK_eA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
To: Gary Guo <gary@garyguo.net>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 3:20=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I guess it's time for me to work on a `#[sealed]` macro...

...and perhaps pinging upstream for the language feature... :) I added
https://github.com/rust-lang/rust/issues/105077 to our usual list of
wishes at https://github.com/Rust-for-Linux/linux/issues/354.

Do you think using the linked crate in the commit message would make
sense? It seems to be a couple pages of code, using `syn` 2.0, which
should be fine now.

Another option is a "good first issue" of medium difficulty if you wish.

> I wonder if it makes sense to add a general `ErrorWith` type for errors t=
hat
> carries error code + data.

Sounds reasonable...

Cheers,
Miguel

