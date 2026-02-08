Return-Path: <linux-pwm+bounces-8102-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC+uA9FviGn4pQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8102-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 08 Feb 2026 12:13:21 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B593B108801
	for <lists+linux-pwm@lfdr.de>; Sun, 08 Feb 2026 12:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1ED2330010E1
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Feb 2026 11:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F60346761;
	Sun,  8 Feb 2026 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aey0x/Sg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24833D517
	for <linux-pwm@vger.kernel.org>; Sun,  8 Feb 2026 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770549198; cv=pass; b=LswaM8V/dXdG3PVh+EJWpSSm9smMBR7pySYF7ZERTU4N00QSo9C9ALAfkWneFBcJeMVDW5kQgVBPZTlMijuGYtOo9ffoN4HGLG7klww+jmeXLmnz53/ddeq9qD4ClcXxmoY9Q9CDiUKs5fHwJyNT1BC1nQSJZbNnLQr2vXCAWQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770549198; c=relaxed/simple;
	bh=C9SBYY850XHrUUtc1B5YS3Igfe60vCJ1wBm7vYcA2pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aDBZHU7/7hlltkD7+FZ6I6J8xI3AUYvGWeV77a0jvAyVStZFp/6INvlry+wDST6WCDlNu0vFpXPI5ag/8owt8eteu0haA2Nk+CtCLn3zR23KFNak4ByBQRDfMuUTEFO33dKW/lVOepdqFABIvnoFUhW4cl+eujbQePQ2b3cA7Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aey0x/Sg; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba716126f5so3113eec.3
        for <linux-pwm@vger.kernel.org>; Sun, 08 Feb 2026 03:13:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770549197; cv=none;
        d=google.com; s=arc-20240605;
        b=kXcYu0kCUsOXEUIh2h8awx4bkeKOZugH4RRVlp0H0q4abf6Cuv3+8/SBA8akE6NThO
         r2/Ip6KeomzScGOHNsr52FIiV/fn3wj503vmrQkBaTW3Ow23Q45TSOyyIe3nr+Np1nTu
         QZlxEUgvyoXU5e57AtHDYlyesTFIM1hhrPOH8QzwbAEhPQLqAGBdMTI3ma0Om2dl7nYe
         dIZg242I35MSYfr7es7xQxldOFs3Wg+Is8IzErzAQBydLgBqagN4CPNToNJCn3MCY3Jr
         HYJ+MnLIPUZjlF1xT1szSLivLFtNjOjURoJQUevBtHeStHYIPiMI2Tbo0BXs3aY48fmN
         FrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lusxgIyHsqL2VssGqd2bQqPX3H3isWm6id7LVqrFB0s=;
        fh=PlkU55WIBqV9bzo5nCsaG5reO4UFShcor2whg2oGkAs=;
        b=NAb0vhmo2Wiw8UGKNFnhaUyAFOjSTvj/3eWT1z/c46H28sC4MSrvUW+OBXnSHWJqkA
         QR5cEfpZwrXq1epEnUtb+ZID0OU67GrGoBsKDarj/kQWw4kyPp3/bpOiw6cpxTxVOFpa
         sCTlbADNUtiyueHwqgSNPr+sAbQNMY5kwUXe0aWBwGnnzJ84Mm6/qWUd2VZ53Au2UalI
         QWFOPK/Ptv19b5+C5oMruXD6qjnadq9K6+u4FCVlvOd9uHtc8Wdos8UTU2UP7ZCHhFjg
         a2y5gnHYg9obhTB+/R+YQ4AosSi0IySVJAUxP4p4LGKrULXyUcdRmedhtp3NDidabyQl
         Jmbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770549197; x=1771153997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lusxgIyHsqL2VssGqd2bQqPX3H3isWm6id7LVqrFB0s=;
        b=aey0x/SgJCt0DyYTwn3/wQepj7a/Va1yuH6fwVsOekLrw1KvBjaD4fdmo9UAeEQJJ8
         EFFY9ZBLklkHhGHH5q02KVlO/wFUVk/TF1l2k3esTiN7mscXxF+kHFZMoJyOmFyIRkRR
         e+0osuO2ALnZX7HFuIfL0iEAmnAE4779jIw+CezesuNYfnS3GSguYyvWyVmPFDzH5iBg
         jZBq8FHemd+pgwwiK3y7RqkPKr/nj+lZ2KlFab5C6KmA1i1AE21sssfRr/JiNW/OJk2F
         zMPv+rADkutTZ+InHp6PlWUU0yChNxhcxV+KKV1lSXJmiAE5SJdCD/YfBZEbHyj9oQhs
         qHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770549197; x=1771153997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lusxgIyHsqL2VssGqd2bQqPX3H3isWm6id7LVqrFB0s=;
        b=r3lr4ZjmTlI6dzzGJ82FT6andjrlmgROiY2FjXl5XQgCaooV2bdBDc0JFPc4AaFv2Q
         8hrRb0vzupgudTr87Era2GbqbZNYS3jXULpz5fyWMRJYEYJENwAUL0QSV7HUFQ/YIlNV
         v4fIWC10/zdWfkGth1B3Z0QC/6bCnGKRhhtEUsFrXNiO0Wn/L0wlF6W8k4UAbRu3l3N9
         1wxSvLx1ZKBy2eXrfbBlwDEruLHweu7KaQNYBS8OYRNKdzcpj5YChnjguVFisdSNjPmB
         W9Sf3RGjtR3sPaUefQCuhtv7hXA0Du42gpbGd3jdOgPzNVk/VrTi2qSWfnjNrALWhVJV
         Z49A==
X-Forwarded-Encrypted: i=1; AJvYcCUeuahBeXWZv9wGGDdmajKZFqRPKp1qtJS0SPB1xhGC8gFksbUHUNTTBqRVzsPLfgdFj8ydY0pXaaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7yQabvH5jU46iC/C9Wk+1KvwOt/Z909O/8mbCCxssokUV55h
	c6p9YUiglIuCSrroQCKEmFV+N9e6cxABOlyAovIUiQvbkYWSH2RtZkimVgqODJF4YstYWxGfaD/
	G6sFBZqwtuDMakhOGtgzvyCnbTnSJcFFlIcnd
X-Gm-Gg: AZuq6aIhsGoAbpZZ32tDOyI7yONNMN8naxvV/Gh5VWZJweWd0y6Cs4dAtvdp0Cx6+iV
	s4XNA62Z9dhfKUSpdbAXmMd6xB4CcMkbYqTL0yDj4QJs3yd6+uhsqis71WwkhFeeKQN9h+4cpRs
	P2Jyo4T5KNo2K5VYlm89/Vb8IA/nYlvJ1BYMn7b+kPLWCjxCeOMFmXIbTOez1gmtntfVtA1OIHq
	E/agBfD70+83eAXbKsNTkXFcWHfCe8whfXagdHtk9cRv5UYOu/nLcIEkIvmPad1HSzwSVBPEscr
	EtHP0exHvZewqxFH3M/HV0aWDTWpIXLzytMUeGk4vRoPMjLO2zrW0OfvzpL2A7tI6x4yNc/qRsZ
	yl0dVS7+IJf+4
X-Received: by 2002:a05:693c:3117:b0:2b7:2f29:64a7 with SMTP id
 5a478bee46e88-2b856400b99mr1820149eec.2.1770549196977; Sun, 08 Feb 2026
 03:13:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121183719.71659-1-ojeda@kernel.org>
In-Reply-To: <20260121183719.71659-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Feb 2026 12:13:03 +0100
X-Gm-Features: AZwV_Qhuy65TaUeSv9KkNVGrPf0KNHqDONqd5x0zvd51P_7nd1tMK7wVtHr8VgU
Message-ID: <CANiq72=Nd7S2HXOpUeW+EyY4G1E-1a5-bAuD6TYa_6fONt6F+Q@mail.gmail.com>
Subject: Re: [PATCH] pwm: th1520: fix `CLIPPY=1` warning
To: Miguel Ojeda <ojeda@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	linux-riscv@lists.infradead.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8102-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,lists.infradead.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,rust-for-linux.com:url]
X-Rspamd-Queue-Id: B593B108801
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 7:37=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> The Rust kernel code should be kept `CLIPPY=3D1`-clean [1].
>
> Clippy reports:
>
>     error: this pattern reimplements `Option::unwrap_or`
>       --> drivers/pwm/pwm_th1520.rs:64:5
>        |
>     64 | /     (match ns.checked_mul(rate_hz) {
>     65 | |         Some(product) =3D> product,
>     66 | |         None =3D> u64::MAX,
>     67 | |     }) / NSEC_PER_SEC_U64
>        | |______^ help: replace with: `ns.checked_mul(rate_hz).unwrap_or(=
u64::MAX)`
>        |
>        =3D help: for further information visit https://rust-lang.github.i=
o/rust-clippy/rust-1.92.0/index.html#manual_unwrap_or
>        =3D note: `-D clippy::manual-unwrap-or` implied by `-D warnings`
>        =3D help: to override `-D warnings` add `#[allow(clippy::manual_un=
wrap_or)]`
>
> Applying the suggestion then triggers:
>
>     error: manual saturating arithmetic
>       --> drivers/pwm/pwm_th1520.rs:64:5
>        |
>     64 |     ns.checked_mul(rate_hz).unwrap_or(u64::MAX) / NSEC_PER_SEC_U=
64
>        |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: consider u=
sing `saturating_mul`: `ns.saturating_mul(rate_hz)`
>        |
>        =3D help: for further information visit https://rust-lang.github.i=
o/rust-clippy/rust-1.92.0/index.html#manual_saturating_arithmetic
>        =3D note: `-D clippy::manual-saturating-arithmetic` implied by `-D=
 warnings`
>        =3D help: to override `-D warnings` add `#[allow(clippy::manual_sa=
turating_arithmetic)]`
>
> Thus fix it by using saturating arithmatic, which simplifies the code
> as well.
>
> Link: https://rust-for-linux.com/contributing#submit-checklist-addendum [=
1]
> Fixes: e03724aac758 ("pwm: Add Rust driver for T-HEAD TH1520 SoC")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Pinging about this...

Adding Michal and Uwe to Cc in case it helps (the driver is under
"RISC-V THEAD SoC SUPPORT" so they don't get paged).

Thanks!

Cheers,
Miguel

