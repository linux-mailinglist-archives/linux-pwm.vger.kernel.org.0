Return-Path: <linux-pwm+bounces-6458-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2F1AE28F2
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 14:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9C73A5AD9
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 12:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61471FFC54;
	Sat, 21 Jun 2025 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak9kxhnT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690431A265E;
	Sat, 21 Jun 2025 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750508474; cv=none; b=nc4AOw86CKW3YmspTwnuPRxBI+wXjoUtiFoPhWN/NEnvBtrR7nBTpHqxbMkTRutzS80fwOKGlbOCb25FaG3sMSvbfXn3EIbGhnA+SaFKdNCzpbNkMGFdADn0nCdOd2NMmwy+5fuBtIqLF5wHzwIH+r3cyagG+InZVswB2LzAuBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750508474; c=relaxed/simple;
	bh=mJSNLN94yCCCB04rPzGHW0u9z5VpgtHFtBKWC0jstGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFFKMS38n/UmutvQkys94HnbDIcA0ukeR5WtCtV74JIsV2b4ASXoADBValV0Du/oOiS2O4T/9ffcNv521Q6IGG1QDROJA93iW6PN+LrqYGz+BH2fl5PZl+TiD1NDwL5js5hZk11BVqCDsHw91+rQb4HdTPXEoSpvBI/rI+ww5Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak9kxhnT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31384c8ba66so289253a91.1;
        Sat, 21 Jun 2025 05:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750508472; x=1751113272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJSNLN94yCCCB04rPzGHW0u9z5VpgtHFtBKWC0jstGM=;
        b=ak9kxhnTri8ALzS2keG9zet5ayaLo9Vs8Ep6xyKNsflId8y7pPB5JrwE5ZcomuUeIe
         BWjM/4Hwmb5V4Nf2vE0+zFOddTO1wzPd5TxflYSVsRF4TJBfNdDmGOuVYXaVKpPpEDC+
         YsvdzJkEfhVn6uIhOUl2Cd5KyF28cmABs2U7fKi+BKXgH2uWKk5TQsuYE8Xxmcwy5HT5
         uhD+2ehiqvx9xnjfc4ZasOt6nhwc602UZ0qW4iY+ntbetqtI8XVzKqLbjHH9/sVCC7yB
         tPJR99RGTgk/+VDOZZKDubYCjvW4LmoYEWyomALNRwb5v4IU1Ble7fXJBjUdpcfu2tJ1
         I1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750508473; x=1751113273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJSNLN94yCCCB04rPzGHW0u9z5VpgtHFtBKWC0jstGM=;
        b=PWRAqYw4gxME1+WeI0NvpRZyqno+Ms7PJ5dJ0iott824TyrE8LLoFwfsR0dMPHZlkk
         F2GRkeqyrwVmWy0dVySjLYB7fK/NOxLGOVE/iDnqw2BYh3SO+rjm4BbgmeWn0qzJYn32
         bUCo/4SngFk+i4VyQjitcCSrrShkt8s/ypmdWfmSFdT1L3DEHUjK/w0/0j3ORinGqyaL
         565+dSp5NP+vVx13q/nmb7UO/9ghsKIAURnJiGLV4fDVK3VAuAS1sdso3vs3BPP4VPjV
         GTmA7SNs4ehd791VLCZo8rcYlY2XBcLd695sljWWTVrLXMrR6gaac6ONb9EB/M149flM
         Ixbw==
X-Forwarded-Encrypted: i=1; AJvYcCUcyeHwFnIxBTNKTjNyurOMt2PUYlkVpHi8CN2+qvPd2PsG1ntYQv7K12eMBbQhNp/x2Tayx0TCWv1h75/Q@vger.kernel.org, AJvYcCVXoaZQsOd1/p+7BIx5kgv8T/+bi8ihlhxWJyL0FqlUk0xoIOyEe8rKKHpswBnkQNllDz+BX1qv9SnB@vger.kernel.org, AJvYcCVdiPIGtFd/79dLLxgredR4zTD2CM3kFiBow/e8zhuk+ASX0sEzb8Maz2z1wvdx+36RK0H64sja3PwH@vger.kernel.org, AJvYcCXNdW9BPiu+soUIh8ZEd+fQyXaWZVfN9h0ysQ0EAH1XDkbS+WT9xo6uaDREdm4audZTgKJ6Uw1lSXvMoNXTOys=@vger.kernel.org, AJvYcCXnOTmCT2P4etY5t5+SUP30N9Zhh/sD7xK4f1uTNAmb6+CK/Pgi4HjKWknyn+Iq6RjhWLoZJtP3HGd/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+DLw4Qs/CXdLTGQ1oUrrb5yojee/x6H50R+tkkU+O5T5ogW5
	A30+/w7uU/I+MstcX4+E191ttYpivMEUtjpZ6Q0YZZMlo3N2+5JupBkzt9ZpbRZPDqoDgKUkyGE
	oPQzdFyur2CA4t63rAAWxfhP4sZc/41A=
X-Gm-Gg: ASbGnctqfUayJM/zqPpXcDZKQrupfy7TWkI07OsU+BLoKXgxjzRvrmEn3jBNzn0benS
	sLbZ3Ree41AhGDOJp4VHdNC5yMW/7KkCAu4E1Cm3Tot3xKIUVINtDfCD80qCTlR8idUui55m26D
	5cHBNw2yrxwskkvFo1JRtBxP73Si8JqNsC9As9WWcSfhk=
X-Google-Smtp-Source: AGHT+IHBkoA8R73wdbCEFSmfGebQhGfDwh3U+PqjqU9Rd7GJGvM7aIk3FgAkUqqEjAXM3xI4sgTT1lGB5ApP/eWh1zs=
X-Received: by 2002:a17:90b:57ec:b0:311:9c9a:58e8 with SMTP id
 98e67ed59e1d1-3159d90f997mr3211194a91.7.1750508472604; Sat, 21 Jun 2025
 05:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250618122801eucas1p2f9ca464e9e5c8d954d5150500952aeed@eucas1p2.samsung.com>
 <20250618-rust-next-pwm-working-fan-for-sending-v4-0-a6a28f2b6d8a@samsung.com>
 <aFSw44++s7xMkJ9I@x1>
In-Reply-To: <aFSw44++s7xMkJ9I@x1>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 21 Jun 2025 14:21:00 +0200
X-Gm-Features: Ac12FXwlYvFTtsebXFsluqzoJQuMLv7aX97g0RdMlPc1xrNUVWgbbVLGEB9yHw4
Message-ID: <CANiq72=YsoFSSm9QU0W2ZQseeQTWFNkXYVR1mODdv3HHg-0PAQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
To: Drew Fustini <fustini@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Drew Fustini <drew@pdp7.com>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 2:52=E2=80=AFAM Drew Fustini <fustini@kernel.org> w=
rote:
>
> Did I do something wrong?

No -- the file just doesn't exist in the patches.

Cheers,
Miguel

