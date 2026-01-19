Return-Path: <linux-pwm+bounces-7940-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB09D3AF87
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 16:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE2E8304311D
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 15:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A8E389E1C;
	Mon, 19 Jan 2026 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXXSCU3C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDAE3090DD
	for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837578; cv=pass; b=VALDa9IXQxiAjB+iHT0A0Qsu+V6L+Y/TW0KUXwFEeHV8R6F6aqittRoOMEn1w1P8dWY1jZGpqiz+r+TKKIJ5vBG/8dhJnRpVxOF14ICLBBAKWO42AD3qODiWTiWOpYFjMuug8w4EG/Dn0Zeva/C46kWaF79yItK3qZ6GWjtPo1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837578; c=relaxed/simple;
	bh=46u/WokqzTLpaWP1GT0SroKxBKxCn8SDXm21fmrsTi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooFQGaEUQZk2GMyYg9nHfnav78koOWnf+NXjGT6N2Vx01leSzr0liQtdcd5vS2SFYLHEQc3eClC9u9iSVxgydIxRlwh/xVJKkH1sbfqSUz1UJYzAeATZw0RQhBZqBb7DodAkzqemfMqLrZDA4dJIb50fOUrsnnB8w9NVaRGg3sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXXSCU3C; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1233ad1b4cdso284598c88.0
        for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 07:46:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768837576; cv=none;
        d=google.com; s=arc-20240605;
        b=lGesllDUHbWrH5J+NymrINy3qJ2zr9k16q357wTay+rpcTtSpzrI+zoftfrqswnI5j
         47MXsVCgzZWXvSoI4xWDVKEEC06Gcmqc5PCwOmmmOmURqagmYhYWCdHcLySQssN74U5f
         e4y3Fed8OTPzfsEwIgkaTV7Fk/lesNJtmnSIrR46KCdEZbu6MED8jcu8pSHan0oBCMLm
         fkEZ/B5SJofJSp3o6mn4YqH2YC9P9MzRnwFNma31sZ50qUb6c2rALMDuExCT0sxYMJR1
         NxH7fJNBOOByJeiCWsfN1PjWZm17/+eT8wttBwKKhdBt5IcoM2tNVnmJ/F/746zDmwtc
         rQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=46u/WokqzTLpaWP1GT0SroKxBKxCn8SDXm21fmrsTi0=;
        fh=t+0J+10wUCepqUuNTkB8OS941isTG0LEbDD0xC3/o0M=;
        b=JZ2AGldaXrRhgvecaQPX+hEXXU8DvqEJFXZWSv47srbhCXh1pA+XQfPb98uo8li83h
         yFimLZyKfiE+Ke5Tgkzx2CNX6wMupI4NXhFDUzDrJMeRKiI+iiHv0gabcH6FqAaoRqCO
         Yk/27g+TRl/d+vyO1FRBPMheAiPQIJpOr6E0SwVrpE5pVzlAJwRkGx5keoHn/nKNEduR
         GDEc//jnhKsjsuynIe7lxDVwnuXzh+JdI98i1KYOBispLJtUfJn97KQF3Y6Gj6evV4Tp
         GYyR1bR/2Erefe1JP7Y5nloov48dNXy116vrya/774qBQ/0WGtPrVR2qWwZFrs/jG1Pp
         SOwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768837576; x=1769442376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46u/WokqzTLpaWP1GT0SroKxBKxCn8SDXm21fmrsTi0=;
        b=GXXSCU3CdBM8c+MgPSzgQooJIutWbrMebgtv0WvYE3ZbubHbcip+IwHvDJ9eq+wc2B
         Mka8HrKybre44Z5qJ81M4hwIGKs8x2I+658pDDoSYO5lAXNfuDFahjA5+wuKVOy1uqD5
         +QtGt8P8oTZgfrEpER3ICDP4awqpYwtUy0Cdfkkc5jUGjG5KLHrhtMt86+UkUrx9mL8+
         WKjjF0LOngCoioejgRfEY2bol8HvX5QXUMzXuFzgemphATe8K5EXp3BKdfXwsRtH7l3i
         hYQpfsAggJbzU9tB4Vr9HxzGWJfrreJyN649wORSxiagGFl1ze2jhWOJH0cugSxtW5nI
         PRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768837576; x=1769442376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=46u/WokqzTLpaWP1GT0SroKxBKxCn8SDXm21fmrsTi0=;
        b=oPZX3mPWPVM4oVVSUd9e/rtAIQARt1f2LYowpW35UmEwtM6tT3/XVzl5Q47lMZxI5g
         RwtJgPV1mWkaXYsj7hcX6JrZyOloOMswblqMi6AUcWc78cATYtMXxQEf5KmBDioqQrPG
         zAnQD5Xj1Gdhp+fUsNJTB1a8pUCoE7UPd6+34P2ZWYmmTWJwrJBP8GHbt/eOUfeT5Lhd
         W6Mi56DOMz5cZmdTtT9oeWygcivkhcBf+/2KD6BtSiz9qCPM9qPkSMXCfrDjGY8PL9gI
         NRjTCB/8/zj2Rg/cC+ArtuvpHfY6frzvIHexOvrnruUXCUSg5IMDk/HyyT0r+a0P1m4l
         pqKw==
X-Forwarded-Encrypted: i=1; AJvYcCXcVKlcgS5OJ6kJJABdwjvs78ziMkOlbtRGTV3kahKPgu28yEqDzEQpfSCe3drG7IW2ACYtXsAt+Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTcesQh7E7qVaRUsem9KKsdirxnCPCfVtCtbohS0fD6ciIlJ43
	GFAKOmonFGOw6jsHFTeYlZVzLFA4ZlcKyNb+KSZYpbBpszY8Z0eWHItJj2XsB2dC6QFMsFIlVgs
	uoLG0963PgY7kMg+tt9f3CI9/DtY2D44=
X-Gm-Gg: AZuq6aJ5lkhc+p0w/GtZIcUo2MiCHeS0rqots2lJxpsbOVv93St6+NZPOSevK2Ww5YA
	IaNTNSa0tY79U0jsMG9yVCl8sszqJGJJYtMEs/WocORehGqWUB9LMYzLTyuGeR8F+pyPrwrnh6q
	69jWPmzioXXdpN2QMUroSy3dMD82ucDA3RatP3V1FdhQEWnpNDeczJeCwTP7c+dApJdJOKjXzeb
	Ydx4TzRMPTysqeWu0TEM4kKMrifv4Cn1E06l2L54ZAHsbCenLnHTmNXyF3y4wbBl47fawZ8x9bf
	njAPaiJmZA0drYIE0mzN8h7L/tMfTdRYShTYGKtiypTcSVnIhh9z0DzTNKPrdUWloL96z5hHHyJ
	tJ1+tnO5USZNDBfCBKNrcuWE=
X-Received: by 2002:a05:7301:3f13:b0:2ab:ca55:8940 with SMTP id
 5a478bee46e88-2b6b40fc353mr4845380eec.7.1768837574267; Mon, 19 Jan 2026
 07:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com> <DFSMRQFIYQPO.1A38Y84XZ1GZO@garyguo.net>
 <CANiq72kcRQShDgMJKZ+ekUEdP1T6Jr=4PDiMJCqnQjgCQEK_eA@mail.gmail.com> <DFSODY3NWRBQ.2VGQWXERVW1R1@garyguo.net>
In-Reply-To: <DFSODY3NWRBQ.2VGQWXERVW1R1@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Jan 2026 16:46:01 +0100
X-Gm-Features: AZwV_QjEkXpU0cn_dPvCmG7mx9ccCkl54ToiMM9A8sew4Jw7jWCplASiAflPTPs
Message-ID: <CANiq72kCi8=mK8V282O-tsbWvLC6M2vdc50mnLW3M3pWTACyOA@mail.gmail.com>
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

On Mon, Jan 19, 2026 at 4:36=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> Which crate are you talking about? I can't find a linked crate in the iss=
ue.

The commit message (i.e. not the issue) has an (unused) link with the
`sealed` crate:

Link: https://crates.io/crates/sealed [1]

Cheers,
Miguel

