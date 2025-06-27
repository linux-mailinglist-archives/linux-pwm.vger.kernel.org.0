Return-Path: <linux-pwm+bounces-6558-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D1AEBC1D
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 17:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835FE17C30C
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC252E92C8;
	Fri, 27 Jun 2025 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf+kGXdR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B83A2750E7;
	Fri, 27 Jun 2025 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751038665; cv=none; b=qU6BW6D9xi3fWqGPJ8cWWWcyU0EMuZWkmDltzaJd4T/crwH8c5utEriBJXiP0g5YRMZc+MXnankqWz6vdflilj42nOWp4UbRM6tN1tCHu0tLu9wdy2hPZ0n8vqFxZH7pgws3qF+8wpwGvzc5OnP/exE1azUXUWc3EYHu4/X+Ha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751038665; c=relaxed/simple;
	bh=ZCmaznIAEW9CdV0v3lggh2s8vZKtTSHxMp/86AwX+Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKO4Rah1L8D4N0vwCXze+O8/Z9R/GKa81rQXfk6fVEGz3QCH/gSU1Q2RvfZiZ1PZnGPNIiYI9t2phabqGkbWgxc1SpGBBOXUem9Txna1ZkXbbaWsQRntGvW8MrHalA9f5AJhSnrB9OURSRFiDQHVlQntTA2HRnTjmqVVSPr66eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf+kGXdR; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b34b770868dso304386a12.2;
        Fri, 27 Jun 2025 08:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751038663; x=1751643463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCmaznIAEW9CdV0v3lggh2s8vZKtTSHxMp/86AwX+Gs=;
        b=Xf+kGXdRN64JXlEbj4Hnub96fcoc8vnE2cmZSQStNqdUOfj1t2t6LEmiUAS4AvsgJa
         WwQ3GckPqmsYzqud1hCJq0USFuHIUAPuUMMJEjS9EJT5vrbV4EwjL6XRkw2MweX3Ql4f
         vw1TFZNzPFXP5BQshIfgyuevAgMlcz23vm5qmdG1Yr502WzdRaXK7G44/ytpHANOmcWM
         YfP7mQWAEA8HDhQYk2JLK+amNmcBgAGj5iEfZ6O1DdLYy8eYtl/LAG9EFS8VhG0HvYMc
         XSSo3I+spGeR9viKfmN2zYBUS1Oa8sd9U7QlEbOx0LioBvC8KMRSmWtmA0+rYCTGXpze
         5EXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751038663; x=1751643463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCmaznIAEW9CdV0v3lggh2s8vZKtTSHxMp/86AwX+Gs=;
        b=frHABHgurbfoG1SKKwXy3AkBVRqgaJB3qr/6VjakQdbAFAAiWdy2yi5PiSIP1DK8sq
         H+Rq+IMjK4pJCPNr6FTsHCtsgLtXLe8OikoHERFJNh6dTDjSb3wxvgzfT0iUtcQ5UgtY
         1s2FXfASOnYs4aiX1rQMtfYe3BjJVWeHIs/RIh1wpnMgRncsS5p0ycNk2aiSxlA/qAQh
         uXAZ549B4yEE5drvD5Qy47wOjrgliab4ecWKb7evLjgbrJgKwj4HfV4U+EZoufMJ2PhC
         jVQGsmyW3wGUc9baj5RLxjwp2zv+IDdyQny4xaLIN0H/NVrLTrsxcp1H2Oj1KLftCJce
         5khA==
X-Forwarded-Encrypted: i=1; AJvYcCUgGkb+sgw37KsnKTX45d27Ntf8PcwpupMkDcs0nSRVAma3GPzJNUr8B9b4c08rAQ+sA7vvB50tRuTIQ0se@vger.kernel.org, AJvYcCVs0Rf5X/vjdFmT/dcKV6FUOHgU92P71qBiedc6JBVqPcXBApQ6JOH2Z6UaDfdBTAfUrbQtK80Adieo@vger.kernel.org, AJvYcCWFeJMCh6xRE131gdjQr4xD+QS06dKMA6Dt3gtvzkE9pTyYS1sJQvj5IiDzsg5YXDZ+1R84ovlB2ACL@vger.kernel.org, AJvYcCWg4LzE5NsgXRJpKPWOolaONrfXfD9n4QKxcg3sJYmxkdLvXnNMamUGGkuuDfKhFLE1+RfEHwe3CbhkgWlcuhI=@vger.kernel.org, AJvYcCWwNRs2VQKTYuB8CjOy2osA4O4ELGyvzF/cafal8+uFbL78HO9NPafyGHrd0dTHNHE3Txp7b6xuZKAV@vger.kernel.org
X-Gm-Message-State: AOJu0YymAQ1bBobeXeiUk+FNpGtgHYBpvYAu03EFYxSGYzzGcLTMctjf
	3YEovNcF9fiwZPVeB5xuAxHZxO6D1QZceLj+fb/YX59qw8Zzk5isRmBCGT8sZCxnoYfhtcfWgQf
	qeWDQkBas4Ij39hQjN+wJMlrypsHFz6Y=
X-Gm-Gg: ASbGncsDaps+bOj2Wywtwz1V1GI83ht5D/e2H2e83QVorMZe5K6UUBKo6ensONlsJdX
	pH8VM3SB+NiwuTQ+EW+Pa8rF6PfZv+MXSrUzS2DQbzaBPDkCKS0JFqDO13zWWguvmAKQ+U6Qf+6
	mKuQvbDp4WWgVY53Z3BvOxs4TV/r2qTG+XeE9h9ItrZyg=
X-Google-Smtp-Source: AGHT+IGml+/wI/ttVJxoSaAeHmsEJgv1Qyo+AziT1f7C4wzb0+XtAzoRAvO/6UJcBeBiENnHea2kADFQnSSIKre+AeI=
X-Received: by 2002:a17:90a:e7ca:b0:312:639:a06d with SMTP id
 98e67ed59e1d1-318c925acf9mr1963338a91.5.1751038663269; Fri, 27 Jun 2025
 08:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
 <CGME20250623180858eucas1p1815f6d6815b1c715baad94810cefacd5@eucas1p1.samsung.com>
 <20250623-rust-next-pwm-working-fan-for-sending-v5-1-0ca23747c23e@samsung.com>
 <q7sz7uci5vnyc24laqzs56vgt4i2jamb3ifyxkqom6qcml5kkv@642prvwxjkxc>
In-Reply-To: <q7sz7uci5vnyc24laqzs56vgt4i2jamb3ifyxkqom6qcml5kkv@642prvwxjkxc>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Jun 2025 17:37:31 +0200
X-Gm-Features: Ac12FXyJg4tT9bxwLEYb_HLIZtlp-3_A8C-ynNyjXzmSe2QQtKFWNglZwQDRbqQ
Message-ID: <CANiq72nZzuqgNRU7RnUP+D2R+Oj8q9Nhje2XiyauW8Pby6UxPw@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] rust: pwm: Add Kconfig and basic data structures
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 5:10=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> Currently CONFIG_PWM is a bool, so it cannot be =3Dm. But I considered
> making PWM a tristate variable. How would that interfere with Rust
> support?

At the moment, the requirement would still need to be `PWM=3Dy` until
the `kernel` crate is split, which I guess is why this was here (I
assume copied from elsewhere).

Cheers,
Miguel

