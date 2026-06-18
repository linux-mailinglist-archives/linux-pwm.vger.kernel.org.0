Return-Path: <linux-pwm+bounces-9315-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2BgfJ8DLM2qzGQYAu9opvQ
	(envelope-from <linux-pwm+bounces-9315-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 12:43:12 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B24569F753
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 12:43:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZDW4jrkf;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9315-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9315-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B7B830A6B32
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 10:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0C62609E3;
	Thu, 18 Jun 2026 10:40:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4F03E5591
	for <linux-pwm@vger.kernel.org>; Thu, 18 Jun 2026 10:40:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779233; cv=pass; b=AyRDech+py4KcbKZ4btadGhfFdyZzuUkOUyUFwOSZ5E7TDS1IeDeI1mH2EGD7/xyTpk7sTXgrtH66y0Be+RjMCfCJuz6+n5g2hWUhizXY2j5UNh7wWEe4wtQEKU8f1kMlKgNPngfBDMqNa48BWeHZrKjOJ8Zz0DzicvIcjXkc0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779233; c=relaxed/simple;
	bh=yhUtjbZV53eJ33+I5WWMx1PK7EZ98q+cI9GUW0pweEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhsd63EU4C5/bJ+RGSCKDM7CB+Zot7bWdj2TG7iebH3A0jNKuG+gP6ug5CjPOjJJ9fCe2RX9dcnzwluprkU3snph28RR+s9/GKhj3uqlVqSe/xv53mvwhTIwS9KvCApTnnxMoD52EuGSUPAXBq0mnLnfTuE7AFq+3IT9xshU8NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDW4jrkf; arc=pass smtp.client-ip=74.125.82.180
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30bc5fa5a2aso97744eec.0
        for <linux-pwm@vger.kernel.org>; Thu, 18 Jun 2026 03:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781779227; cv=none;
        d=google.com; s=arc-20240605;
        b=ZzwUUYy2FKMQY6Ra5Fl42N85PLrzmOcfMfgcIRQYoU9PU55cOO9F5Uak1veCFEp9FQ
         eOrICa9z6qF5zMXsIUWkkBpFHNvUBBbWt72LvyzRR8fjDW+n1//e59XHl6vC+WqCXR8G
         w1oLdmdmXyEkuqdO8pgHSsKsuAObWY3PlWD0nzVf/2oiS7ipGT3hpysgc6Ic3oJsF0m+
         48KSC9CoTSWaIOk2KnWpml7ZrjE6ssMEqH80HO2Ze0Z2C5gb0J8EnH4OzpoyGN2j2UdK
         zuAzktd18gqTV8NBehPx/TfeH2nB2u/JmnkNFmfHtJagtq0pN7OV4L9NK0EXBmySkrbv
         z/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7DUQbCb92xOvO01pv+r7iCHPQp0UAu27WllptLJOlB8=;
        fh=818X+b4FTY1dwz8Emtqj0zLAUXffOryZiHpMJvoSiNk=;
        b=SsVBSEjgqiyMffff0RElhgItPqxTC1BV/hNZ0Mtlz2EnWbFnx2uSvVxKW08j9AHCRl
         KylL7baqYsRFoHBoXp6kXOVXWCWFWUZ/PKn2byIM4W4kvyjA3BwS8dtQlgWDkADvS4cZ
         yZj6acjLTd9q8mIq6tZQGOvJblhroW3oe4korbUD1TEELdtPTUte8qUay/z5Boa9yuPX
         v3eTw/5BG5eGFRV3FW2kiH7omxcYfE1iTtP7K0lSrKKHwAJ407BkgoUJYII8EC6f+pb4
         gtF6nnqfeUmJlSpppwnnr5ZSFSUi0jyga08t9nLgh5i5Y5OFlCAfD2frUq7+nNd6fTbe
         cVJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781779227; x=1782384027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DUQbCb92xOvO01pv+r7iCHPQp0UAu27WllptLJOlB8=;
        b=ZDW4jrkfk3387CIo4fAM4NOExN7ZA+JSUepXfBLmjVA+9FSYPSR+jjJ6jViBSqlURM
         S9V6LCLaqgcwgr9YDdt1Mgl6rSrPgLi8WYmsdwGZtGJJHr8fYYLDPOoydPJz4Ej2woKa
         VGi8nER7rddQjktBGGDNpeu/TaA3SWCVmWzCouZBHU0fSB6Sdk7+0DOLfMz5Xd9t+1tq
         4PPNM8eij0R9Mi9C35+amzk2T60DWvpon7MBlHRKPr54i4XVSTz2ulaIiuYX181sHbxm
         yTzCEmnhvbEtgMB/vBKfM7I3+8rtXvucGfl2SYuH7oSYFK02IzPvqvDmqj2hgddxeFNX
         K+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781779227; x=1782384027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7DUQbCb92xOvO01pv+r7iCHPQp0UAu27WllptLJOlB8=;
        b=I8F3FKnG4teQbD65J65gaAvQl3W2SCUsSkgppsPnmaoI69xWl3d0TOsPH7nJlW5rGq
         F1CxMhKgIFypGNAxHjweymncATw/gQ6ItE97e0NO559yMsT1sR5ZKoDatQ3u+YDUtzdG
         eJeTFWLzh32RdFkcyefr37U4XH9Z2DBU2qmmVWmUxoCQUarDfCYDO5OJPkLTVwuq6Mws
         eE54p/YqH3fTlH+n1GSsfsUjnfpRfIvIKGMYpN36+rEuP8A2nm2927S2abrXcEilwBqs
         gYwkSgy3Qj1HEpLBrSXRmApfYT2KkugZKi9CZmyImKtwddzO/ibUxpEIqms1WWLRpa5H
         DgIw==
X-Forwarded-Encrypted: i=1; AFNElJ+6VfE4wpHc6LqdKLcxGEZJeWiglAcuCuKgaaxL+v+yqkgwoNV7cP+oSxm0SAxlMe+q3nlKITJVXZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL8qjLpD7YS++BBFNhhkZYswQ+XMPViEn0CpLj056ldZ611uQr
	mZ4niBeu5icr24tMufQ8Ci2D4euePPcHOK6U9HU6kepFNtSFJK7m46p/Gui8S9ijTexl1Z6G7M8
	FhIJ6ks0OnYBOol/TvWNGgN8l7XtxLxI=
X-Gm-Gg: AfdE7cknXyG5Wt12Yv42wO22K2EJ2WsKsfymuexnjdGLNUzGh3rTWS6xlL50pg2KcNH
	5UICYeqJfOwA+TCHtx85YYQKQZll31kO/8nUukaUbTZUDbCt7aNJ5O3QEJOcbsd53VUUggCIHgi
	uum9gn7B6L1dmUptwulbPJVBLdm/gC6fjjKGZ31rUH3z5esAFLAh4SFMsHBt7hz5YjFINsrcfBu
	ly8P13AnxjtfkoE+mN4J/l4LbAt6l+Mua7He0KT3tgoW8MyWQPqr0eoQnDkrPwFwQBk8yH3Wx5E
	2EgO6NQhKnKVAmkUyACbe0jObqz0vyU2H37njEO5qDbBPSEbsGnN/ACTmliX1Vjb7H5Y7yRxLsH
	WNpSZKobzgLqh
X-Received: by 2002:a05:7300:ed85:b0:30b:c021:5045 with SMTP id
 5a478bee46e88-30bf09c4416mr1020403eec.5.1781779227291; Thu, 18 Jun 2026
 03:40:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-clk-type-state-v4-0-8be082786080@collabora.com> <20260618-clk-type-state-v4-3-8be082786080@collabora.com>
In-Reply-To: <20260618-clk-type-state-v4-3-8be082786080@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 18 Jun 2026 12:40:14 +0200
X-Gm-Features: AVVi8CcKkRQ8t8MfiUD4gXtI1Y4DMiQAI7JLxiiYKqJ_3SsG98lF2VyIrlJ2k1o
Message-ID: <CANiq72myoVT9npyaB0pVvbJ1v9ELzw68uAvSoAkdJJX2MJQ=kA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] rust: clk: use 'kernel vertical style' for imports
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Brian Masney <bmasney@redhat.com>, Boqun Feng <boqun@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9315-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:daniel.almeida@collabora.com,m:rafael@kernel.org,m:viresh.kumar@linaro.org,m:dakr@kernel.org,m:aliceryhl@google.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:ukleinek@kernel.org,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:m.wilczynski@samsung.com,m:bmasney@redhat.com,m:boqun@kernel.org,m:linux-pm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-clk@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:boris.brezillon@collabora.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,google.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,samsung.com,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,collabora.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,collabora.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B24569F753

On Thu, Jun 18, 2026 at 5:48=E2=80=AFAM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> +            Result, //

Since you import the prelude, I think you can take the change to
remove e.g. this one.

>          /// use kernel::error::Result;

>      /// use kernel::error::Result;

>      /// use kernel::error::Result;

>          /// use kernel::error::Result;

Similarly, the prelude is imported in doctests by default.

Cheers,
Miguel

