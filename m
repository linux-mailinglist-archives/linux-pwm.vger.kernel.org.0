Return-Path: <linux-pwm+bounces-7880-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 497FED0430F
	for <lists+linux-pwm@lfdr.de>; Thu, 08 Jan 2026 17:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75BE03289B66
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jan 2026 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4143F4C6F1B;
	Thu,  8 Jan 2026 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ilfcfo9l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623AE4C6F17
	for <linux-pwm@vger.kernel.org>; Thu,  8 Jan 2026 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880693; cv=pass; b=oiWA3J35HWJauoDPG0nNT2AUjQ5Nits7BEbubNmQP5EUs9pvUBEsd0g3nRhmUaJKcrBq7sfKT39Dq/MGTFU4Aa1+RFe9YwqPDZmUiLSzwHEWRDtN1/Ot0mHPQI9HG1SN5Q1D+P31zEeufA3BfwwWVsEpyx3p17Fgn9ora2BAP1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880693; c=relaxed/simple;
	bh=0jKmPkTdOWtk+ML1oyRZShyn9g+7S4FBzcZeJc6y38Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4D7MXiKQnj5VF01T+CsMV+F4ZBoryTpTa1XVsOLbdhSxY+2OrDDKGfdNvGJ74Uu7jgu0fRnkIIQTFW2KU9Rp5/WHP2E9o2a2Nys5DdfPic4lUK0KvJ4ocMoOzbhLBHwsPco6EA4fkb8f6w7rnH+3XlLCVQylzXb2b5xEHUpiI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ilfcfo9l; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ae9f7fd413so54017eec.3
        for <linux-pwm@vger.kernel.org>; Thu, 08 Jan 2026 05:58:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767880690; cv=none;
        d=google.com; s=arc-20240605;
        b=O3NRzUFdVpXekkRuZYUXuUEYrigJEVOLsmgeLKafDb9geJy8lQOqmSmbBIy6NTcn3z
         9hTYX3QTEonXQ38KbpKcr83rdVEaksxj9AJPTKxEYoYBvBgFcl2yIz0FOa5eW4PGl36F
         Lemc4pyAXSBqtEMzCbNMUjgszn6MAl/vv2M+jb4eiBaPo4Rtap3PZY6vxgErvwIM/kRK
         7XgK0v3RrCruKSBGFM3N3mFUiaJoHZQIYqT0gJq+edHVSJGwAmgYWEAbO9KIy6y0V1h4
         JEVIdhrMKuGqMlaZM3oKTe1gDtCww3ur6caLU9KF+Ny+hn9zFq3A8A8y7nxdTlkHadIV
         YCOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0jKmPkTdOWtk+ML1oyRZShyn9g+7S4FBzcZeJc6y38Q=;
        fh=nRX/j5crXV2BQN03aR+iSRxiQfQzUuwBCe8CzS1xHmU=;
        b=G7s2b9yBEQeUFZQ2I0iqyTz3uGkIBktaB1rD3qoZEFguWceguNDh/2Nxinrfy0vH8Q
         Edhdr3X/6nJG2b5TffsUyrM1hN7aKOh4MQaJJ1TIkNT4wKAc0DdK9M3k/nAfACDLkcgc
         Li5GJwdZJ4iA9tbQA58L9V4LIvJjQIF++8VqY/qjSF7ee1OtwZLvtKnY70pRw9sPtgUI
         2/5UdQVQ6/FDoj6SYg5rkKx6xb5EXs1v8zyEu/Y563jxpNEKJsxx5JpvdbaQ9MbA9lkl
         k0k/MklP9vRFhT+3NmoKL/Y6Na97vHqk7HDCLCSkpnlZTYDMTWOzGX0nwqNGs/oLVFpq
         /TVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767880690; x=1768485490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jKmPkTdOWtk+ML1oyRZShyn9g+7S4FBzcZeJc6y38Q=;
        b=Ilfcfo9lhPbFoRwXYyeWTa35Ybnj14xI7aJp+J3RZeWzb1Y58ehXAKXbI2lCRWxjri
         9l1F8djK2AftPQ4aVHsRmcLERuPatxSLv0s7oGJrs4iVgh+Q3nBRw6By6yAt7TQoZun5
         3DOZnFeI1gL3oNBsmeZNRVGzoE+JoBHHr/hDfRJyQNVVuwSXuAHKy4BE5mzSQfcanEsE
         5Sd3iX50T/MSSzc+jdmaBFXlOVQgRzo3CCMFo5QBBWs6wM/lcBJpDS02fshclj7GWE5+
         mP7J+FTxRVOdCYbKDJyhFh3MSSuveyxcPSvMCTlpDu0Yw3hsQS5ezi1MiJrQ9lUieQ+t
         2RJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767880690; x=1768485490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0jKmPkTdOWtk+ML1oyRZShyn9g+7S4FBzcZeJc6y38Q=;
        b=gpGDDAxA0fxtqtPRqaRGuAneIH2tMvW6+seCRLO9j0MarlflKoREg5jYy92yQKirPa
         F4qjc/sevpirLmcwzM1KYxJMnMNqxxgUw7ka+mxPMs4LNy4fSbyqJGFGh/tc/UQbHpxQ
         GCnNA28RbzPByjajSEz+RC9loGaUtr+rK3pcQPzIeEkesdQJtv5TiRGQDsGm5Ee7GYL8
         JrlF2tTyihVHGr65LXuWfFVWI18LrlaRaMBcdCooNwpb0zcu2X+bjE1tJFnjVfHh+FXq
         qq2a4Zuu17d0QwbAwemU7SeB38c5uSxA0hLTXExE6TJhn+9RHkGVsBUtpnYUnV/UMQoq
         OSUw==
X-Forwarded-Encrypted: i=1; AJvYcCXGzAIel16k8Igl6+OxE48SF+l997lNXL9rz5CdmTauCZQjDhhZhJYXSLY/OZpot9j8vPEmWiI9VOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVwmYWs9xEp+Tw3wPltXVEuupv2KvSE7E4cLcfGjXeRzoj2SAm
	FCRwE2U7fcZBNHhZrKTjwuFzzO683FqBmT+9Jvz3HBujBFti49hjXmkbGpHtIwRpUsW70BtGjJd
	8LmBAFg3zAL9h+fWgm42EcGzho//+wFQ=
X-Gm-Gg: AY/fxX7LEVhbwiw64r19dQ9vO/ux7Ruy9B7QPOIt8b/q5d1R1H8jB4PtK0Wcck8wuFv
	nPcdzU3RRJ0AXK17p1YfOuP7k/EZiT6Ob23evNdWXgOzq5dmoakxuglWfRCAgDK6TFOGAC/sXYJ
	msDitDHetFUvFCA/Kk/1Jp3Ydt2CYbVnJu9RVTry6SJhO2KCZaknieAq51NFJM1G/fr5PKu83MZ
	3uk/ARPtc9u4/BVfkhCyT6BnpJrGxDpN7GMZE6nemrdRMWRo7j0QkwvbijKZyRhiVKg+Q2y5Q+u
	rnbvXNJZOsvSq1tanFlaV2bsakS3sxBmSbNKdNU0O8CkZCt4c4emWm6RIGVnaLs6dXYdw9692+c
	6odkiPmAemmt6Km015Bdlrug=
X-Google-Smtp-Source: AGHT+IHlnNhSjE3fiGAFdHKCvng7Zuc8n9ttJNcOcaKfOXOHrvEYhA907pjuVU71kxGKClIXln7ajb5XI4DP4iSFO60=
X-Received: by 2002:a05:7301:10c4:b0:2b0:502d:c27c with SMTP id
 5a478bee46e88-2b17d2b80c6mr2509787eec.5.1767880690160; Thu, 08 Jan 2026
 05:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com> <20260108-delectable-fennec-of-sunshine-ffca19@houat>
In-Reply-To: <20260108-delectable-fennec-of-sunshine-ffca19@houat>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 8 Jan 2026 14:57:56 +0100
X-Gm-Features: AQt7F2rtmhmzWGc_DLT6cTXt2EVzqLjQhI34cDZ6wkg42nM_UD7cfFl6t1r9_zk
Message-ID: <CANiq72=38RO9PGAMDtnTK8wj-yRSmg9UOfq7D6af7AwAKwn=DA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
To: Maxime Ripard <mripard@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 9:07=E2=80=AFAM Maxime Ripard <mripard@kernel.org> w=
rote:
>
> AFAIU, encoding the state of the clock into the Clk type (and thus
> forcing the structure that holds it) prevents that mutation. If not, we
> should make it clearer (by expanding the doc maybe?) how such a pattern
> can be supported.

One possibility to consider in cases like this is whether supporting
both cases differently makes sense, i.e. one for that covers
easily/safely/... the usual "80%" of cases, and another "advanced" one
(possibly unsafe etc.) for the rest.

While it may be a bit more to maintain, it may pay itself off by
making it easier to review the easy ones if the majority only need
that etc.

Cheers,
Miguel

