Return-Path: <linux-pwm+bounces-7696-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0334C84F7D
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 13:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 832804E110A
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 12:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8C320CAA;
	Tue, 25 Nov 2025 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2Zmu1Yh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115E320A24
	for <linux-pwm@vger.kernel.org>; Tue, 25 Nov 2025 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073894; cv=none; b=oeGVcOgZbUOTtw+RzOmF7H0xRVsXs6c030v7kkIYbstp3hk0fH+ueIc3tZ2gzDB+430N5b0kCk2GFTmm/gRW0q7j4g+zWnCTnNJfAeI/Fcid+UCFCvUdyckEluW0vlt2CJ8otBlIPr5UhFqeVDtamTIHsegPc7yMpzZ+fcAw97g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073894; c=relaxed/simple;
	bh=ZoWbCU/Fz1+eyrddUOSOAHDIsvDgxcG/td4vjeOMl2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juM+0wcLCGv/Oodhi3bAUEXbltCleORxF/NT2HetbIymCTRCZvaGI0cXBDone/DYRwADJGXMKg93C6SnKCGUQKArl1psbjwUNnMRUL7dGPaSokcJHo+nSA6HLEvlrF/v724IDKPFNrbcErpeRBS3pWo6FORxb3DL5NSz0J8fCdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2Zmu1Yh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29800ac4ef3so11129135ad.1
        for <linux-pwm@vger.kernel.org>; Tue, 25 Nov 2025 04:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764073891; x=1764678691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoWbCU/Fz1+eyrddUOSOAHDIsvDgxcG/td4vjeOMl2A=;
        b=Z2Zmu1YheNfqUUaODuws29/+BPn/BkdyS8uYlok75G0e3u0C+yTn/RURG9FEyzUodj
         eNcjwPq7qqNpvQWDdnil1+sDXY90lRTS81sWEoE6qA0jjAvEzdHSa7FNWRHZa1kcXr2d
         B6q5A8jRiuLVW0t5oR7rwOAWQ4ysgrzZsep2mCRbIrDgAPtbaEa6n4d2ARGu5S30Mvm1
         a5Wl85njIxmZi+dGQQ1gsLZW+Fw7ROe5CCLhsMY40LkYQ5BA3cALYyn6YlaG9xUuKs/w
         UiONKJhipTT3mjCdfuzCJoXFG4keKkmjj5kkZ680a/bU+3Oh5RqDTL9NMK22ySjW7F7W
         QHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764073891; x=1764678691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZoWbCU/Fz1+eyrddUOSOAHDIsvDgxcG/td4vjeOMl2A=;
        b=quSPW7gMwQAs3jZYySjwzYf2aBbaf2Cbaee2zPbCY4dxQV18ggbD0T45EKay5TTmjT
         lEwN5vaeZrkjDk9942PhrXc3JYzOdgT0rGg+cMVRIpseAexqPDU4TxhZDT3n5ziIACat
         EyXwd5AahZZSYOr4WKJ1b/f/Kgq3rpHF/Va15KT6fE1ZYIhqA7E2d7+TC868TPD8ce+2
         LHXL2W6gwiPKseYdXqCdmpj5iu1GM/fl08pOKma011TveKre4U+L10CKVOJ2W7gEmFTw
         qIN8cwEQpmPiCeFOGkGbRkavcISpQMp+MWBJTS9iu30MSwPrD0KQf+9ZnDfZuHk4nLOO
         3Z7g==
X-Forwarded-Encrypted: i=1; AJvYcCUEzlCFNx4HGOtLCBWfTlT13beu8OTul/YGusLuwJOXD4qXMLUlThGanoIVLULr/HpfILNY6PA7IKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0geAHIa3Hre1pmmUCfgUsKxY4a0I+5s69QQxcnHMtxX7J+Kan
	MDs85NwRxyYDXW4y2gr/3lkY4/xnLj4CFBvv+RlXjL8gP0jZdwAFR5LRvhCqRT3K5Oa660DDX7v
	MVp53QU1K19iUipYMODi+HtpUlQzmBuU=
X-Gm-Gg: ASbGncshvcPPytHWlpr6M8oM0eYZQT7mh/CTmPL2TjtpQCaPPcbJRwjDxh+hykCC841
	TSwTUL3e0NfKUp+tsuk7+ELmoG29nBg0kffZ3xrrAruLHDXX7I+J+WHg0ztkFsEjklkoXLpQNqQ
	ZFwhkDlpYLXMLf3YbopJAvvWBlSTS6KpnSec9lvg2M2ZoMmhawGg141yZnj/v7g0fnEdtAUUfhU
	gJtCAFLz8xpAm9F256BqUXNPMj/7ybUGnRBbTt+ZBj4JWl/Tj1cyxN2lOXI5tmm3Iagg5NAcib0
	8AdgVHnru94IcIOIE6fs96V25XogOAcKKUHhEKI2T6X1XoFIZ7JSm9pVJc5g2MJq+9mAwAt+Nh4
	iZ3Fz1EWbSKzf3A==
X-Google-Smtp-Source: AGHT+IGgw5LUw+voSfpyRnybKCW9uSxmytNtm8JMKkx1AQxluRQJPOoxkh2lwkkXY6q2xRvx9r7q82tUTs2y48xKT6U=
X-Received: by 2002:a05:7300:ac82:b0:2a4:3593:2c0a with SMTP id
 5a478bee46e88-2a724c02369mr9704335eec.3.1764073890450; Tue, 25 Nov 2025
 04:31:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251123092438.182251-1-shankari.ak0208@gmail.com>
 <20251123092438.182251-7-shankari.ak0208@gmail.com> <44gv3fhqppn4fyg5fnxkhhanlbbxr2slqq7k3kr3owx7frpnxw@idgwxlcv4otn>
In-Reply-To: <44gv3fhqppn4fyg5fnxkhhanlbbxr2slqq7k3kr3owx7frpnxw@idgwxlcv4otn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 25 Nov 2025 13:31:17 +0100
X-Gm-Features: AWmQ_bnzR1pFS2tnO0i1TQxesvIl8Xiz1UJW9FJjv7yVIIdoY1qGA_4D1PTisOA
Message-ID: <CANiq72mQ4cu9wehGKxS92EK2H3kcX8XPpRmv2DdYmn6Ve9iDAw@mail.gmail.com>
Subject: Re: [PATCH 06/10] rust: kernel: Update ARef and AlwaysRefCounted
 imports to use sync::aref
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Shankari Anand <shankari.ak0208@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexandre Courbot <acourbot@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Igor Korotin <igor.korotin.linux@gmail.com>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 5:10=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> having no clue about Rust:
>
> Can this patch be applied independent of the others via the pwm tree? If
> I understand correctly it's only patch #10 that depends on the previous
> patches, right?
>
> Is there already a merge plan for this series?

Yeah, if subsystems pick the independent patches at their own pace,
then that is great, so please do!

Then, after 1 or 2 cycles, we can do the flag day change on the Rust
tree (with any last changes needed Ack'd, but ideally there will be
none remaining).

It is what did in similar cases for renaming (or moving across the
path hierarchy) things in Rust. For simple things that get Ack'd quick
enough by everyone, sometimes we may be able to take everything in the
Rust tree.

Thanks!

Cheers,
Miguel

