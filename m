Return-Path: <linux-pwm+bounces-7946-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 326D2D3B522
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 19:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F3A830AC761
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090F33031E;
	Mon, 19 Jan 2026 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJdbRge5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC8832FA30
	for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 18:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845709; cv=pass; b=JjRO8yq5tGa3CLKAqP3HMLHgvA3qcFbeMNRdm+rlfgu5pauNKcw7qGq32XGC0m1i/bMvFgMWjxlcoasCnyBjs2izDyk60gm95tG4ddGZUZ49WCLb06/xb3ZPfug4vf1HxirfCYZirSx3z2E5tJO2KJktBxpWv6cAxtm1CWvKB04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845709; c=relaxed/simple;
	bh=Oimec9R0aCFMLabyDlzla37quguLmEv21TSD6RGlpLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMDbIHzNpjz+6ecZMVdoHRsYjkCy3jWYH1cZk8lWzJTXynB57qOtymcwIGxwqddBCB5ggR/NRcnqLzG35bTe7XbhwUdTCxDFzfy5h8ag89JIyLaiMpd/jkKTY2o1V4JT2lGYMQS/50O+ASxwX6XEeE5hBgvEkN6pHZrZota+HE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJdbRge5; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1232c98f98cso330752c88.3
        for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 10:01:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768845708; cv=none;
        d=google.com; s=arc-20240605;
        b=QlvL0+hzjLql8uzFBRRhRMtWvHKye0MSkXVdgeR9ikSDS8UVWd2TRbEBiGWiaBqR28
         mnnC8C3xsuVSSrN/hYYmHqrT2FUSCayEqrqyr//IwVIEuqq65z5w04nXKNDrto57T2lp
         yNibNN6+OM5fuFTGY8t+wCMcfZIXRMluQARRjCOPEx51g2DpP6aJe+0qStq5g6W/5KTH
         6umsCku3JFrlOPl+FKAcHIngaN15ogPBdp6fDl5xWJxIP5yGYdT15Rf+h9MZxlXErzNM
         zFY6o+7aXO+F/5hTyZ07PA/x+6vQkZOszHsIRXhDEBO8FShQx4uwIGcNBM6e8DyFLGk6
         4ilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mj1iZoozHo2mgRESpJHRS1ASPF5/w4G9hbGEhm4hd+o=;
        fh=3iaId0HQ4X4RaDrKU8wzXdb6FEOya1MRf0/SVlrwHVI=;
        b=dkzhcMn+ks9wwdZBqFGnCton8bqRQnW2P0WSGWDTZ40fYDQZounaub6J/Qo7YzfpFo
         MK4tQMpaZ0VZI7fyNRoDA/raKus77vGsOCtPbUC/N/zE1HqVozaRXgoxr7yxkwQRodUm
         ds6GtiM81F3uucb3r7psepNfZPVozvjIZSjxYG+4PSlLwEcwDgcZm9ZzlFnVXEmppvFJ
         rl8wC5umyLJ+qpowYdXJr/fPPc4WPOnpMxsahCFXdyhLJqid5HYKdl1sU5fWkOq9kfQG
         ydShEwzEQPh464p9ViJvU0WJQ2Yk6+KT8IxeVAJpLrvnuXVQ586yK8SRw1twno6ZY7jA
         VuQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768845708; x=1769450508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mj1iZoozHo2mgRESpJHRS1ASPF5/w4G9hbGEhm4hd+o=;
        b=CJdbRge5s0pPvmy3/e23f6abZrXzcXc5NwsFKz4S3xyxH22dxH+zB5kDMidXoFyuMl
         sC3+6K+lzS6VirlURL/epg2X9iSjfXIF2FFXjyqaq2tE314i0L5bx+8uZxT7mgyBtOZs
         cc8gbQMj4Us5Y9zITm3Vd4TiSQSQc0nu9eKG4a+08e964A0TV/TeJHKwx7W01WO24Vx3
         HYK1bCkiZkaGCZjrqmuCIvdsurAewdRGEzikx8+HK4v5CMtsUcHgHP5EYWebfH/pvYAj
         2ZrfMTEZSRIEQ5IwA/3gFyPvb8QlKO6CBB/D5X7FVNbGzYclPDpvzxsaFDYw3t8BZN6o
         3qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768845708; x=1769450508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mj1iZoozHo2mgRESpJHRS1ASPF5/w4G9hbGEhm4hd+o=;
        b=w03AV410dnExPFpUGc9qQz8vT0e96QHy+4i+ZjwhaiyBPfzG6OCYl6GVw/FAJp+d/1
         vqaEi4LBbHMsVA5WuYq41MCrRboejUxOeugDXn34HMzdNVP4pyeJlBch2huuYdOGUBV/
         rNqEN/OoK4lFHTnadT8+N93qV/Ys4HyourhQCNGhkc8lTvYTIXdMj9+r20cdhdEnV13w
         bzCqfRV7lj1OxwLxXDxiYd0x4TAdz/75qhXEX/vcHx/xqcoEf5pyR+3vsGJkQo8cYq7x
         gD6Rm2CUH8DIP3dB8kng8Drt9dajXoFmS7lV00QSJE3brCeNp3TJUMFFeGlWa2v4wnpN
         tTHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+zBEQsK484BjyUH82PiUPQ1AWA65hgwz0IoU3E8dOhZCiOwEZZUpBUNRdr0O1eLQhK4YygaFdspA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcm0jyxvnd4V5Hnp4pr/IDxHcXjif6RWXyOQ8ebMR6t92WL1tH
	q46Lb17yIxgtDHXdR2KOxYkuElKGHMkSLWgAgXaXEa6t4Vc3QLf1X46AIYhyrCC5Q8qxxfoUAUl
	6RfzvxD+ls+V3+w3043Tgg9tQh1DFjDI=
X-Gm-Gg: AZuq6aKtbSp+YulFL38AHQCyrIi70/tOak2EUTE5VZyWhq2oVwPl3RA6tEblyZd5R6A
	2UW861bUuWRGyR//lRZpiIdpQ3fBPZu5QE3l4bZltKT52cNA8lM7HNP7unTg0ooKoa0jRN6JYgw
	C+kbwnzfBSPeekFICUVGUKIE4Y3Dvh6VtGyaqc7QyrYcEYgwbro4YIFKckDlZ8gzhu02m7unpk8
	rP1bUBVCIBSubKIqlI3kqbu+WwhoIoNKQkLNpWbe6YAh3adQqbz97eEk00cXUTUi6uILW/ayErK
	1LPTjSMaWKYMJmm/ya5G5uSm8RPII6mQViN0jYuTu/vbhAlueDKob9dvgr/MrNR8XKLraD7rvOB
	NbHHzjuXrHkP+
X-Received: by 2002:a05:7300:6d06:b0:2b0:2e6:5363 with SMTP id
 5a478bee46e88-2b6f6f808a9mr129151eec.1.1768845707489; Mon, 19 Jan 2026
 10:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-cstr-pwm-v1-1-e8916d976f8d@gmail.com>
 <CAJ-ks9mrpcLaeiGjBcXNqTUwo00Y2MhhHWnWauou6exU1y920Q@mail.gmail.com> <2wmijhs5pbrynsgxuropvlxuozsubk7euybxzwc5ox2a3izfci@v6hzmzs5pmml>
In-Reply-To: <2wmijhs5pbrynsgxuropvlxuozsubk7euybxzwc5ox2a3izfci@v6hzmzs5pmml>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Jan 2026 19:01:33 +0100
X-Gm-Features: AZwV_QiT9HJYrgBsJ2EfKS49UFQygV8XYXgkjsQ2HaIze_49iHqtRlkRLMtga98
Message-ID: <CANiq72mSxtO0s8xGhgYemfz9DvvwDzC0fsF2covGFspduDz5XA@mail.gmail.com>
Subject: Re: [PATCH] drivers: pwm: replace `kernel::c_str!` with C-Strings
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Tamir Duberstein <tamird@gmail.com>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:53=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> I did, but given I'm more or less rust illiterate I would welcome
> feedback by Michal Wilczynski. I only now notice that he wasn't on Cc:
> up to now.

Thanks!

In case it helps, for context, this is part of a long migration:

    https://github.com/Rust-for-Linux/linux/issues/1075
    https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a9152403778=
3@gmail.com/

(@Tamir: in the future, for patches like this, and especially since
the patch was split from a series and was a multi-step/multi-cycle
migration etc., it probably helps to give maintainers some context
with Link: tags to the ones above).

Cheers,
Miguel

