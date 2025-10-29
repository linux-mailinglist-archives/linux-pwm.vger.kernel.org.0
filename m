Return-Path: <linux-pwm+bounces-7530-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FCFC1CBF6
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 19:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8071893A95
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 18:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210EE30B528;
	Wed, 29 Oct 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAFJf5qQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF019A288
	for <linux-pwm@vger.kernel.org>; Wed, 29 Oct 2025 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761934; cv=none; b=hbam7RBcnJLKELu9nnc3u0IndIbsESLOTisL/ZDRlIxI6dCA98RtmXnb403x56gQ3hFILl3FgH5WB2m3zshvfoWkXjImapNiIun8a7js7kJDayasQPqs9sQcbthyJrxPn8aGYIMtY/687Akf6tnOh35smEagCSG6cZUF5aYfulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761934; c=relaxed/simple;
	bh=P60WA2IekOhXcaoabZ29P77AB+IQvR9LQbwR2bw+CmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIMfZInX807JLLqaja2AMZPHkU6fm+k0nYJNJxA5bq5fwh6hByEJLmfMp1nftU5P95eOGVSC23CosvMQzohVw4XZpnVJpXxTC0uUaMqvJwTSLSY7PONUm2JVFoYdTEuFVA1mpyNSD6buSp9efAEBuBp1f9CdVcxb2bnwSJTmv80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAFJf5qQ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6d08015f42so3236a12.3
        for <linux-pwm@vger.kernel.org>; Wed, 29 Oct 2025 11:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761761932; x=1762366732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGHEJFApFyOFo7pmpc4STS/EO5YU8lCBDcbtrWvNjWI=;
        b=kAFJf5qQ9N8bj9qZPJ0oD1LZuAiZP4KNXsrDyLaemTocyfNeFeiiwHTMBwC43xDzSP
         THvqcijF97GKepMiXmAVOaR4ReD8Rijxueb4wudo1Zkk5fNE5SWIv7jD2mXRsfaF4qA1
         5/JyfJK11UONsuHdQEraHR6bVl+tc7WcjYWW94euCBDQjV8Ooy1AauU9e0BlCUIz2S+Q
         UC4dNMP6/wfS5BdU0qyNWWPG4Xq53b5PoCOvXcGF584FNaIBCTL4hPiC8c7tbo/5vsMF
         chdBHQHpgzwOgIQd20E8O9humhBMCJSh1CANi8sqLtDWfEkPMu32nZqte7xzBuTPLctl
         JeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761932; x=1762366732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGHEJFApFyOFo7pmpc4STS/EO5YU8lCBDcbtrWvNjWI=;
        b=B8/1f2pQ9kJB4i9cMKNCqRLcBOggx1d3bdsZWuLxa2EzqzyqJEvOESCu/15qBKbFi1
         L+cidzneNLymK5b60DSiLOMZwBt4vchc80xAQRmi+IEE2hsb7NTBfh6e4QNjZooxz1T6
         ZQbBCketIu/OrloCHopen9t/TfBysFgj6L3FUvhIp9V2clVn9AiqKMaEIvHojeOS+EL0
         R2GL90afwj98GEUUdD82fafmHJNWAYbHlP7aXc+NzxV3SbFm/FDPCyb5xnIKOxc8k9CE
         rqppZq3povpkxiSbtIzTqIS6bd+TEdpVczX0DaRbYuvo0IUlRb13FVBn5/ijJEL3RiKk
         aQbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq1DGZvnubs72tAVwI1qQXiBzT+K4B8cnEazx+E7dwYjoy+gekw5W2ZNpzLgR2hPq5kQCQXXNzNaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXkVIDRT7qort04dFrx+Db1hrt+pY6fQB0F0/gOQ5GqRC2yzW
	8EiRxzTThTmFHOjWYayFVah0pF/xC4iDAb6XwfBToAqhKtjBIh6FqCLgTwO6e00rEW7CwOK80hx
	l7OeEDdL835qYvKAnwJLWmq4eqrVUouA=
X-Gm-Gg: ASbGncvOqUybShLiyfmT5T9xHl2UBIXt6B62fLx1kzloeQ4BSkNsbgl6VBORhe9KAfp
	PQOgAFtaXpo6JE2L4TZnDBGIN8WxNuZavjBwGrmr5Fct+xBaqwfj2nDaInoEbDewiFr1FyrIL2K
	rhamFNocVmdjbeoj5rFOSepSGOQvMgcJgTPro1RE7k+XoCpAm4laFdxN/88jRQJPwsLJ4MAMchJ
	uuGjAPmExWn3g/d/9WDdH1adajaeOlpvPQpTFzmFk2Gk8d2srrC/U6duZRKMaUXb+gLet16HBGe
	k3UGTRKZm9YBOxSv6s/Sz98m4xwbqPzuZGDa+34Xe+pyrsTVzHByL1HKIQNa0QVdVyhAItc6ymq
	Rw749aY8c7sZAuA==
X-Google-Smtp-Source: AGHT+IEUmxwJv4cATlvHI24p6sTswb9GOB92tay5pdawn1K9j7QGYDSkyOSrQLmeFPpDeZNCF+IzUDuiQtDiWnxBse8=
X-Received: by 2002:a17:902:ea05:b0:290:af0d:9381 with SMTP id
 d9443c01a7336-294deec2ed0mr25872405ad.7.1761761931934; Wed, 29 Oct 2025
 11:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20251028122315eucas1p159b65037cf6f3f710c1917e2464399b5@eucas1p1.samsung.com>
 <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com> <2dedlnknikkrwg5f6ocuvjrogdjuqyg4sg6zkkao4w4yyvvsje@dkt7rco3fen3>
In-Reply-To: <2dedlnknikkrwg5f6ocuvjrogdjuqyg4sg6zkkao4w4yyvvsje@dkt7rco3fen3>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 29 Oct 2025 19:18:39 +0100
X-Gm-Features: AWmQ_bloR4yaxCgQSRgH9rsP_79aHVebA5y_V5RdiMta-mOKTPlfL_2N2hFhhSs
Message-ID: <CANiq72n8QvygNsdHjaMgYrXiErT82BkWm1XMkc3eUZB1Xy_uAQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Introduce import_ns support for Rust
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:04=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@ke=
rnel.org> wrote:
>
> If you could mention the command that makes this warning visible, I'd be
> glad to add that to my repertoire of build checks.

Yeah, please do!

I do my best to keep even linux-next and stable kernels Clippy clean
as much as possible, so it would be nice to have that Clippy fix added
to -next soon.

I have other steps that maintainers/contributors should run here:

    https://rust-for-linux.com/contributing#submit-checklist-addendum

Essentially / most importantly: `rustfmt`, `rustdoc` and `CLIPPY=3D1`.

I am sending a couple fixes for those.

Thanks!

Cheers,
Miguel

