Return-Path: <linux-pwm+bounces-7563-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF65C22817
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 23:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E8618973E1
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 22:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FECA33557F;
	Thu, 30 Oct 2025 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUZwFQ8j"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067C2F5A23;
	Thu, 30 Oct 2025 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861915; cv=none; b=RrtcebrLyc8zgNcIWvAdFVQjWnVVvYPmhMJ8yOhye1M1a9Y4LlRIqUQcYLKX+fs+AJif3eWr+AJ0tjKXF92DWz4WySWzgb9R8yjwkD4/YhldogcPp8k/qa9r/3D/fQUBB7f4ONmaMkKsUWdEeNyWFRlEGHHhYyDjlqBSpGObGCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861915; c=relaxed/simple;
	bh=hGsR/Bnd3mOKXtUfbzp7EAHPu03Q3W/5Ygz618c3ElQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7Xy75nj3TpxPR3eICqye59vz9j8duYbyynb+luBouvFktvD3Gj7HZ69nOmmAGUhpAK65dCM+giKibfYnEe6BaIqx54P5h/Hmas2v1D/OBASW03fhC1iG+uyaYujgdCWP41zkqeocDZQQ7aBEyukuf9ZA7O2AIc65S902AE1hsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUZwFQ8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E70C4CEF1;
	Thu, 30 Oct 2025 22:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761861914;
	bh=hGsR/Bnd3mOKXtUfbzp7EAHPu03Q3W/5Ygz618c3ElQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUZwFQ8jSNkVT08Pf3tnwI4rsFxKGf4Wk73qhas/2kGpPCwR4PV537euKdBKNQt5U
	 sCEcPMUSO/cFUTM1TvhEEn7ETkgXLe3533+YdOqyjbrhrYKzE7bIDINzV9ouZz0Ttp
	 Ekn5v5e0W87uIAzS5K0Iw9xIhDs9jpY6ouvPjHgQ7EFy6ijOgYq2AK2iXv3IJFamlK
	 AUHmr5EUSmEWfJgkd7ey0N5UA0bmSADl8JU7jgnAlgDq2jNDrN9fle5bRQkNE6AKZy
	 wc1NrPDhCToOXWWgJ8k3/s6SiuFKpIEqi4vIcqqUJY4vTmGhu1os12+45Sozoecu3M
	 8kTBDoSc0O88A==
Date: Thu, 30 Oct 2025 23:05:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/4] pwm: th1520: Fix clippy warning for redundant struct
 field init
Message-ID: <ch7ys43hapks5pmbnr4tq5ygycngy4oncsecaefarxjuucpvue@qtofn5rzq46m>
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
 <CGME20251028122318eucas1p1863a8b44efe27c28a1bcf427d2855c00@eucas1p1.samsung.com>
 <20251028-pwm_fixes-v1-4-25a532d31998@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6lyb3gh27aqsig22"
Content-Disposition: inline
In-Reply-To: <20251028-pwm_fixes-v1-4-25a532d31998@samsung.com>


--6lyb3gh27aqsig22
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/4] pwm: th1520: Fix clippy warning for redundant struct
 field init
MIME-Version: 1.0

Hello,

On Tue, Oct 28, 2025 at 01:22:35PM +0100, Michal Wilczynski wrote:
> Clippy warns about redundant struct field initialization when the field
> name and the variable name are the same (e.g., `status: status`).
>=20
> No functional change.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

applied this patch only (for now) to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards
Uwe

--6lyb3gh27aqsig22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkD4REACgkQj4D7WH0S
/k6vXwf/XwD/aC75mmgEhgwLegHCDLc8YAWadtXPwkYBVbyfpIVTujQtNNa6IbNc
TBTyepfIq1hGhoF3xnQg8+E6QsNsUsNeFb6DPVQ0/P59IiazUtvJ7MEyH1BPa2HI
9bwa7hPqViVIhZK/GALE1F8Ivf2xMGBRFJuSw2sjb8lYd6YTh5xWgVn+PUJ91iGT
OecPfhHged4zRochSwnc4mQ4IdMHg30dDAy1iYFeXYJrQcSVDKhZcThSfnq22OAg
w1kdhMBkqxkY+FDIUb6Fl+Tmkb9VlQrJ5Q2jACq10bSlWidKluZ6eUbPV76MkNV+
DklMBwxJMyiE3IkckG9X+wpR8Fxp0A==
=Lof5
-----END PGP SIGNATURE-----

--6lyb3gh27aqsig22--

