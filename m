Return-Path: <linux-pwm+bounces-7882-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C932ED03D5D
	for <lists+linux-pwm@lfdr.de>; Thu, 08 Jan 2026 16:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7248C31D17D4
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jan 2026 14:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFD64DB926;
	Thu,  8 Jan 2026 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="VbA8UffG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3404D2459;
	Thu,  8 Jan 2026 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881978; cv=pass; b=acNGjDtXppBkFsO9XY3Zuj3vyVAc8sahmEkLRAPNs3g5J/m9EHEUoOSHxa7XhKOLwmFci6agD8WjtB9oPEDwFcDkk0L1fZxodCUG3mgTHO3doAGZU9/6+IJ0t3Pr7IHbCSzXMkkV70lJq+uxilwAclVB0Zaqhzp8MHscfp8SO08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881978; c=relaxed/simple;
	bh=3zz6a3BMr2dfAzv+YoO5B8KGEMHeg6suRN4rMzqljFs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=m7QawYwGjaN5UGTd7SI77F+dxA3RVIcBKkdHiOXzqNsG5Q0ZQTNjJ6axmtgsySkFftOySSP3nrTJeW0XYT4psNlityL91CTcM35SAt/m9gzJZLkWxvrKePmyh4IHnyP9RzcqsjIR5P6LJo2E2C3JyJ5X2zOK6xJluPVcJWggVP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=VbA8UffG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1767881954; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BBGSzaRsEJqZsvO1HpX/hKogi+VqGwt8a7LPvUSAFynOoyqffEdMc9Qr+7R2IIR4l9pelvKaiC4ca8aoRjLdd77cN4Kr//pWDmI1ixoF/5TxpIfJGY0cxEPOa5jH0aDMUvNg53gza47/nqwtchzMJBC9tQ7AcHi8EKYHlqcwLzk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767881954; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3zz6a3BMr2dfAzv+YoO5B8KGEMHeg6suRN4rMzqljFs=; 
	b=I8Ot6vUy0Vz8MiT3dfC/NVer8UkuX/tQ1Kb6KbOZTWAS59zjFpNXUGzu1BCBGqx6cpieP82l/Zax9BYSKp0kuf117sq7StP+PfRpUYksOk52NC6oINCiyLZKfbE/+iZuOZLHzEoHeTLX1iQ21jWDLhG1gp2o8oqnqb6WSuQNW3A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767881954;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=3zz6a3BMr2dfAzv+YoO5B8KGEMHeg6suRN4rMzqljFs=;
	b=VbA8UffGuc5UL/XYfaeXeMSJPiV44xD5qtehsqkQRKeP0AdyLr5yyeoKRIr/6Kes
	RXBPxHHx04baIOYHlqqFmMnjM5ywFy+1LCZ5URfG/J23ZMBAceoe0tEwKa1yl/QRUr5
	FxwCizG5CzDRFkCXgELDDqr5sihhf3L87Q5G3/gs=
Received: by mx.zohomail.com with SMTPS id 1767881952278596.4068382305078;
	Thu, 8 Jan 2026 06:19:12 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CANiq72=38RO9PGAMDtnTK8wj-yRSmg9UOfq7D6af7AwAKwn=DA@mail.gmail.com>
Date: Thu, 8 Jan 2026 11:18:53 -0300
Cc: Maxime Ripard <mripard@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Drew Fustini <fustini@kernel.org>,
 Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org,
 linux-clk@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <16DA3CAF-098A-444F-83C1-AF7BCE149937@collabora.com>
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
 <20260108-delectable-fennec-of-sunshine-ffca19@houat>
 <CANiq72=38RO9PGAMDtnTK8wj-yRSmg9UOfq7D6af7AwAKwn=DA@mail.gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 8 Jan 2026, at 10:57, Miguel Ojeda =
<miguel.ojeda.sandonis@gmail.com> wrote:
>=20
> On Thu, Jan 8, 2026 at 9:07=E2=80=AFAM Maxime Ripard =
<mripard@kernel.org> wrote:
>>=20
>> AFAIU, encoding the state of the clock into the Clk type (and thus
>> forcing the structure that holds it) prevents that mutation. If not, =
we
>> should make it clearer (by expanding the doc maybe?) how such a =
pattern
>> can be supported.
>=20
> One possibility to consider in cases like this is whether supporting
> both cases differently makes sense, i.e. one for that covers
> easily/safely/... the usual "80%" of cases, and another "advanced" one
> (possibly unsafe etc.) for the rest.
>=20
> While it may be a bit more to maintain, it may pay itself off by
> making it easier to review the easy ones if the majority only need
> that etc.
>=20
> Cheers,
> Miguel

This is already the case. The devm_* stuff in the next patch covers a =
lot of
simpler drivers (who might simply want to enable the clk, perhaps with a =
given
rate), while the typestate pattern allows for more control when needed. =
There
will be users for both, IMHO.

=E2=80=94 Daniel=

