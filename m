Return-Path: <linux-pwm+bounces-6261-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 471C0AD1389
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Jun 2025 19:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005531889904
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Jun 2025 17:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CA7194124;
	Sun,  8 Jun 2025 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9lf2STX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25417A586;
	Sun,  8 Jun 2025 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749402873; cv=none; b=fvPqh2nOVAIDC6N17CRUJOD3wO/QM40Fp1nBZpaj4qNYIhkOtJiRVewv0cJjKCuZBbkiAgg+iHdIUj/lSFKVVoyKP+vOmHakHxbRzVvmhKVg5DIS66BRgyuWbi+ipurlkyl07qOe1TuqJAh4AV5/Te/tDpBi//AYbe66gvQ9J+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749402873; c=relaxed/simple;
	bh=RKQPMPxj4MfkIMcsHYvMcLK9KWRbyjeOgrUKCkOD1Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Maf4XVt8NusK5YaUCCkSuE35pFstCkCaeXVQ+ofhkqXy0dhxSea9fNcuJWTXtpc3TU0hfrFsHbQNW+ARgJXbxj99sdeORaUOqX9ixCoDMmAauhGa06OK1DhXn3Y2KXLclhB64+egqgsvhLuGN4n9TSifK9o1SfOPBmtsrkGBJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9lf2STX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313290ea247so538643a91.3;
        Sun, 08 Jun 2025 10:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749402871; x=1750007671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKQPMPxj4MfkIMcsHYvMcLK9KWRbyjeOgrUKCkOD1Ys=;
        b=K9lf2STX2oVoTmZF2LnZFBFDN0nnG19hxr21QuqpTGdPKUPaZ7/P4OXYddSykL9/+r
         kAy+fgowV0dxkOkaepM7tx0u35+PBJHztZhtWNRAyqhWjweX4PGaP1+666s6ZGj4Qm5j
         Q3ht9Kfig5YGxuCo9Lux/HLA0903r0EU7BLCOAuqumU3se1ZdUcavbfzOU1kuTauV7wv
         RgjTSesCiB85ipkDEJ1M79ow7mfyZu0RuCtSEQKSOdyLSIcfgbZTnACJwqc5xWHUvSuB
         38zr1VkVJ2v2aFXMnRTjPas2VvmokqhFnjmWw1agnBUVKuNLorXmnmpCdtmHgrl2J5PE
         MKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749402871; x=1750007671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKQPMPxj4MfkIMcsHYvMcLK9KWRbyjeOgrUKCkOD1Ys=;
        b=Mbbg8scQs243PmI26VGm2wyaPWuRGPsQpNgMaEAqhwMHsp7nfO0SvrfaYMLTVMPV3J
         swZ7ZSsca+0AlXrHVntf9Ta5WsrA3ePzQcPGEnyucnrPkQpcFBX7FRTvQ4YEvNVckmph
         +v4lEXybx4ssMKtyzfBxVtGJXtrwCeINyPhnUB9TTVWVagpZrgqzxcPgS8uzmcVcSdLv
         bWdhzMJ7UqPdrAS3WcO/XiKq+rahi/enfpN7aekTRnNiQ1lh28lXozwjramXFFneHhC6
         8JqeUss+For5u2AFS2vrou+ZwS8W59fCQulFb81HKtZCFHJD8pVuxb2HI6p7WG7HwtYI
         Gqcw==
X-Forwarded-Encrypted: i=1; AJvYcCVX28QrazivnmxTBLvF94KN8AurV6kbWuc0A39F5OhnP0yi+iBt+ZJ1bU3RP5V5gMoosY1JxaCYdGpEQyFN@vger.kernel.org, AJvYcCVyICOZCOXbOjK/jfK/iU/la+MdQWyuAmFDl7nyjFvutBrxYKKEDj9TkXJlEN3nAuKnKCMprWKu9uzF@vger.kernel.org, AJvYcCW2An79ZBgg22xCl7HrJ71IIHZfi4bo8MbEGb/x/0JyDmdpHSVrzdiJ/U9tqU7xxA8D/BWbxDZjpyY7@vger.kernel.org, AJvYcCXRMosJzSV1UAFOr5++ONFu2JDZthH2LVqKFYU2YMEgq7vayFIHVbsOQ6NHAs7J99JarF0UrQuQmF9qbMhn9gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE4ymzSZ8QZKK8q0Cw18BjiuEVPWWkfc7ABoKj1r5FWNuPrpaU
	AZo2WdYAkrmLmPDuAom5YFBN9IWUc5TSgX8QzrY2XBUR73FBMZmG+tNKkmm18v8N/dnoLEBbG8z
	DTbw/h/8P/Iyf87IeWN8hIcEXJcTRaCM=
X-Gm-Gg: ASbGncvFm5N4SHenJb808/FYURddLc+givmqMTwhs//ptb3E4o59kbR+iDMs9nGq7yv
	8Jqo0gUy3W/eeDLP07pYRUqoMFyc21LiiJ9dkzRHAPcVS3LRQbMXa+VS1AiYjpLPqed08wbxolQ
	C4ng7M0LjzMTLcxH7RbnqFLmrx81KpZ9KG
X-Google-Smtp-Source: AGHT+IEBvvvrAwdUwi0gkdHeXQhnZUDJ4usrBz8GyLnmW1wPT6jaQZ8Mxnlnj8F8TSVPOxQPYUkvrhO9C3hSgDaoKWQ=
X-Received: by 2002:a17:90b:4b85:b0:313:2bfc:94c with SMTP id
 98e67ed59e1d1-3134e43144amr5102920a91.8.1749402871506; Sun, 08 Jun 2025
 10:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250524211519eucas1p218997c69b98b14d3af2eb6bf4e9d3187@eucas1p2.samsung.com>
 <20250524-rust-next-pwm-working-fan-for-sending-v1-0-bdd2d5094ff7@samsung.com>
 <aDJGgLZ9tITwGBxq@x1> <b5f4af17-05ef-453d-8f04-283590ae5b87@samsung.com>
 <DA5YY0YF28GO.3DONTQDLY6VBD@kernel.org> <aEXBH5r05FkTxpV+@x1>
In-Reply-To: <aEXBH5r05FkTxpV+@x1>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Jun 2025 19:14:18 +0200
X-Gm-Features: AX0GCFumCLeEEJCyPi9ehiEGEBsNiIydEW7gHiOseH77d-yj2IMt7X5ttFs-zc4
Message-ID: <CANiq72k-FmZe3P_y6FjmiqXViqLKXkDqHY1-KLfmgwAe98oBAQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
To: Drew Fustini <drew@pdp7.com>
Cc: Benno Lossin <lossin@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 6:58=E2=80=AFPM Drew Fustini <drew@pdp7.com> wrote:
>
> I'm not sure if that bindgen warning matters?

If you don't see the `FromBytesWithNulError` error, then it should be
fine, but I would recommend using a newer version anyway.

I hope that helps.

Cheers,
Miguel

