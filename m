Return-Path: <linux-pwm+bounces-7518-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E7DC17B5A
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 02:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36F9403F69
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Oct 2025 01:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734D2227EA8;
	Wed, 29 Oct 2025 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C+uHI4yJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758682D7DC2
	for <linux-pwm@vger.kernel.org>; Wed, 29 Oct 2025 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699614; cv=none; b=J7tYNse+qCpmAgCcExaRkOw8nlcBBcq0JXPzHYcGcTEZ+N23+EBhuF0+NbVwlZgHIC8o5cFzWKJyRU2ZVnQ+5NoxG054y/C23oKLDqVz4JPTauh1lG1oXrM7KVZIQSZqqOjVst69YB2MY+d2GOEfvhu5iCfBZrOiiLh6GFXuwog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699614; c=relaxed/simple;
	bh=m2TntnE29Ayjgb90lea7jgHxSXwtxhfaO+9MYo3cUqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kv5fDA1kAS3FBtn8YmqOqodLa4mWQwU5xwPFRMCjsncTZp4sADH0tZTb67h8+igCSFG1BO8Dc1xVluASabd9h7bFK0NjiBKxpaelF76+rWn96j8USVMJXfHtqk1oUds+HQUMBzQHDj42SwL4QbwKIGmlozakf0SsBRUYnarSwFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C+uHI4yJ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 29 Oct 2025 08:59:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761699600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=axfy//ogFDe/yGbFMo1sZMCFPL+4baIeWWIdu2LpDI8=;
	b=C+uHI4yJrnTWHNX09+K4A6XEe9JSPPUru03wyNSgVfHv61E7wLAa4TZ331QLDUnPoQ1P6E
	VjUIg4YW3JXeZ4EO+p4elnyhBy5vg944BCDQMdxymYkrakt5HKwr3RRDjZBvBZO2zy4wqQ
	Odu3Jg8x6KTSeZ3PTZpwj1+hNJQKZC4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Michal Wilczynski <m.wilczynski@samsung.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: Re: [PATCH 3/4] pwm: th1520: Use module_pwm_platform_driver! macro
Message-ID: <aQFnBYc7C-nQslJ9@kernel.org>
References: <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com>
 <CGME20251028122318eucas1p17161f0e1f2281c868688e8a4cc3d8f68@eucas1p1.samsung.com>
 <20251028-pwm_fixes-v1-3-25a532d31998@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-pwm_fixes-v1-3-25a532d31998@samsung.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 28, 2025 at 01:22:34PM +0100, Michal Wilczynski wrote:
> The `pwm_th1520` Rust driver calls C functions from the `PWM` namespace,
> triggering `modpost` warnings due to missing namespace import
> declarations in its `.modinfo` section.
> 
> Fix these warnings and simplify the module declaration by switching from
> the generic `kernel::module_platform_driver!` macro to the newly
> introduced PWM-specific `kernel::module_pwm_platform_driver!` macro.
> The new macro automatically handles the required `imports_ns: ["PWM"]`
> declaration.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>

