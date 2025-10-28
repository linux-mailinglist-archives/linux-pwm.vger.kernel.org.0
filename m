Return-Path: <linux-pwm+bounces-7516-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF59AC17375
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 23:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E570420340
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 22:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B763563F7;
	Tue, 28 Oct 2025 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="RsrNvQPr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151782D6E58;
	Tue, 28 Oct 2025 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.90.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691277; cv=none; b=slSgm7dM/XHYjDdHQzCkkmlTf1TpoqKiVWAMqBo3ZHhhh80ZbCEkrdB43acYLQafLTmd7A92SShYNVMlfodEmXsJt+IGWZ3/HFaw364RPCL2c5Z+f4ok9XM7Nk6dSXqsbjHSOIPMWUhqOHioUkid6O7vSuecHJajT23a1Kmlquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691277; c=relaxed/simple;
	bh=ovS3F4Ji8YIzTXUX3iGcqGh38VGc/zziXtLpzHf6TiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQrNzbsndLT3RA/pkSxo+TbVt05NP+sWSG9XWX35bQk3odPaWNLEsyctw8mU4gDx+rCcnKMFEUVqffPtGeroZjifKzRPHZd4zaJj3OPGQmx16NvNgp3DhnU4y8y7roD5TJ0JhNa/G50pgShvaMDoPxv8D0PBqtoE8YsgtM8Xk/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=RsrNvQPr; arc=none smtp.client-ip=145.131.90.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=startmail1; t=1761690773;
	bh=ovS3F4Ji8YIzTXUX3iGcqGh38VGc/zziXtLpzHf6TiE=;
	h=Date:From:To:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From:Subject:To:Date:
	 Sender:Content-Type:Content-Transfer-Encoding:Content-Disposition:
	 Mime-Version:Reply-To:In-Reply-To:References:Message-Id:
	 List-Unsubscribe:List-Unsubscribe-Post:Autocrypt;
	b=RsrNvQPrL+hBoTA6C+XNlXTAxw+GaoY9JCiSMj/KjG7Qiq7MZmjhDZhbXMZNy76BQ
	 wl3La5/8iDB2+9GqE2QOWt7wAleWti9tUVD/2LelRPgzmREwKtF7FE7p3QLh+xUtDV
	 cOFgkD9GKWHJx1m41az/TXYKTPjVcTcCP8o3POc3efyieUx/QWYAU3UuMl95e4gORS
	 pUsYTye0cK56+pJ5HhFt3Y9NFO4Fww2WRMvfwuzQWxkcEU/3efm1M7yrc8Kjqu5TUH
	 pIgcrgUy2nefisESGS+OwH+CKmWJpXXkiLSGlVKeduBI+UoiI9/VqUovunINDRTerz
	 4NzvUzDHWq2eA==
Date: Tue, 28 Oct 2025 22:32:50 +0000
From: Elle Rhumsaa <elle@weathered-steel.dev>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/4] rust: pwm: Add module_pwm_platform_driver! macro
Message-ID: <aQFEkm532VZo_QIM@archiso>
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
 <CGME20251028122317eucas1p1e7c925502a83dd3324478c0209de08c3@eucas1p1.samsung.com>
 <20251028-pwm_fixes-v1-2-25a532d31998@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-pwm_fixes-v1-2-25a532d31998@samsung.com>

On Tue, Oct 28, 2025 at 01:22:33PM +0100, Michal Wilczynski wrote:
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

