Return-Path: <linux-pwm+bounces-7515-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4818C17346
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 23:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B861B262FD
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 22:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43763557F9;
	Tue, 28 Oct 2025 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="XbXNg3Ah"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864A328B7D;
	Tue, 28 Oct 2025 22:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.90.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761690844; cv=none; b=Hq2a021hef9XH0VmMNw3eYFleiXVjYb4s44K5PJd4n7UXehTcZ+k/bEitNKo+108bI+0xX5pYMt8EAm7Hmmbt6EjRa4Qm17rJKQoMl/IsQKEzwdXCSfaMV2LEmQhvFBm264Q41SLnl/3k6CObZpkxTU3DOoMgGxeR9wffA2JDSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761690844; c=relaxed/simple;
	bh=iqa/oXvDIF1kSlE5Bx6xl2J/jyNf0x3ciXmOvj+Rd3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqruo5Sa5S/raPBq8Hd2c8r+JHOKeulpw6QeQXISJxnYU0SDRrPVnXR1Xe5vM3SMdHPPMivvvs0rRBtedWmZwsm3ACJJzxlTvWRV5ZCmbu+FPE0ec8K8T0gFr0WqipZEqnycBtoDPUwvCV48IECg5M4ogmpp9x+aFSFPKSO+Au8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=XbXNg3Ah; arc=none smtp.client-ip=145.131.90.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=startmail1; t=1761690839;
	bh=iqa/oXvDIF1kSlE5Bx6xl2J/jyNf0x3ciXmOvj+Rd3A=;
	h=Date:From:To:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From:Subject:To:Date:
	 Sender:Content-Type:Content-Transfer-Encoding:Content-Disposition:
	 Mime-Version:Reply-To:In-Reply-To:References:Message-Id:
	 List-Unsubscribe:List-Unsubscribe-Post:Autocrypt;
	b=XbXNg3AhOOIFLo54iEz52G7QmxUUmeIgP8jTa9HTcEYpqOXWe3EcSUl78yixaI4Th
	 eT5FsrwrLq9hsZlWAcU/HgeRx4z8ZKOWn+QeDwixExEc7uwtRjPDvpZbo88dm+mpCa
	 4x2j+Hbhtxr9XnivGnyVZtRV1pwCAdo31HrcqZ1r+Rd4K0tFNzbMu/r0McvWrunmdT
	 l3r5kl5x8m9p6f5cwJqGU8m4eBeCDHnm9eOzNtOUm8zEbnqyaod+PkL3aVgKeDd6HQ
	 ZYVyOy4WSM+GeWr7sDkFH9rHbpaKO73bx53vzz6zl4nq3RSiidyEUGNTUor+uxvVJt
	 IFHV3YBbehi0g==
Date: Tue, 28 Oct 2025 22:33:56 +0000
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
Subject: Re: [PATCH 4/4] pwm: th1520: Fix clippy warning for redundant struct
 field init
Message-ID: <aQFE1P_J1DqX4dNt@archiso>
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
 <CGME20251028122318eucas1p1863a8b44efe27c28a1bcf427d2855c00@eucas1p1.samsung.com>
 <20251028-pwm_fixes-v1-4-25a532d31998@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-pwm_fixes-v1-4-25a532d31998@samsung.com>

On Tue, Oct 28, 2025 at 01:22:35PM +0100, Michal Wilczynski wrote:
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

