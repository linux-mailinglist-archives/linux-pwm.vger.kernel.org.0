Return-Path: <linux-pwm+bounces-7514-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A53C1733A
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 23:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0721F3B6574
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Oct 2025 22:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA672E11A6;
	Tue, 28 Oct 2025 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b="Cs1tT7Z7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813352D73B8;
	Tue, 28 Oct 2025 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.90.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761690810; cv=none; b=mL7rtLpkgEiMgpEyWgEs9/Cz32OPiBd9SLoMwAx9N/0AhaHQkOa3mGXnPU9+N4Bo/YjC6XVdNrPuYdqVhSUB1t/T1IXDAbMyWbCSgti6Z6UD8Gkx9BDlkMIwkDlLh4hs2DPdqf4DtZ37AsjED4vOiWYdpUFcSoiVIsqtdlKIz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761690810; c=relaxed/simple;
	bh=QCCjj+Bv1j9K1+3pbIl8HC5LywrZOmPqTcduG1Q9lno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfafY8pB5butMmBkcstqsQAu7NIOJh/dv8kTNvaiy5aVIlKjb3X1aQSy6MldVTMgH6yQRmpjaoRhqK6hiYLDY44dFWINI7amfo7CaG0Qu/TfU7XDg0BmETajcDaSWdtErooMXoVM9KKLJQvSypHKMhlWcavfA+eGjqYD1VokyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev; spf=pass smtp.mailfrom=weathered-steel.dev; dkim=pass (2048-bit key) header.d=weathered-steel.dev header.i=@weathered-steel.dev header.b=Cs1tT7Z7; arc=none smtp.client-ip=145.131.90.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weathered-steel.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weathered-steel.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weathered-steel.dev;
	s=startmail1; t=1761690806;
	bh=QCCjj+Bv1j9K1+3pbIl8HC5LywrZOmPqTcduG1Q9lno=;
	h=Date:From:To:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From:Subject:To:Date:
	 Sender:Content-Type:Content-Transfer-Encoding:Content-Disposition:
	 Mime-Version:Reply-To:In-Reply-To:References:Message-Id:
	 List-Unsubscribe:List-Unsubscribe-Post:Autocrypt;
	b=Cs1tT7Z7oqYz673T1j+H2kSAZtLnPBkiY1oTpQWWuQ7yq4IVypcdjiWCfA2oferx0
	 CQQL9lDUo63CrQxSn0jRDAoztNTHc66ektVfok9BemqnfNzPAWiO7PSDI5c1j7k+v0
	 k3epdvwjngDLRpI9ldiaiHr1phMQsS9xE+TNoHJIMeh7I5leAudMTM5Y5qhdaAHBQ/
	 Gw7+hmRJKwxgnj7S9lnUHkCOuy2NpVbEGSR1kAD59rF1kkKXVWz0IJE1u8Kc5n69Qj
	 1vLqKBQFGUoHuCw7DZxG4ZfBeV8f6JGvJV74O5+Zx6oatB4XJuwiXM5x1HQTFCs5Ko
	 BF4ilnO96Jt+Q==
Date: Tue, 28 Oct 2025 22:33:23 +0000
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
Subject: Re: [PATCH 3/4] pwm: th1520: Use module_pwm_platform_driver! macro
Message-ID: <aQFEs_5HI_cFQhtO@archiso>
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
 <CGME20251028122318eucas1p17161f0e1f2281c868688e8a4cc3d8f68@eucas1p1.samsung.com>
 <20251028-pwm_fixes-v1-3-25a532d31998@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-pwm_fixes-v1-3-25a532d31998@samsung.com>

On Tue, Oct 28, 2025 at 01:22:34PM +0100, Michal Wilczynski wrote:
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---

Reviewed-by: Elle Rhumsaa <elle@weathered-steel.dev>

