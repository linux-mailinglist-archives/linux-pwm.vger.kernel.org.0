Return-Path: <linux-pwm+bounces-6681-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2F0AF044A
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 22:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F03481765
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBED261388;
	Tue,  1 Jul 2025 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiCcDC/L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335D1E9B1C;
	Tue,  1 Jul 2025 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751400361; cv=none; b=fpZvJstSmzluOAJ6W6kg/253P64/8b0GMNCdVJ9JfsdC/ODHzRuRFkgkib5bjiiKk5XCBSQoSXBmTTrbztyTs/z4mc0Xd0ByJQ6nKzFsv6c0iqKOcZyWHErsyzTSd26ix8D5Noa3w5PddUQ93+toxa7SsKzIlFvxmh6APEq1V9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751400361; c=relaxed/simple;
	bh=EgCnSjkxf4u1frTm53+gSUO8YuhHv0iXVp3vsJ/h0RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIwX/SAHs5trYQrzpSAJRowld0cWTb1xblBkbJtMIXQTNr19/kHlDirXBToumoxWep6tcHZjHIIDjirSeJt7Ge+59KmEf0ET0InbLoQW6m72MlmRg77FGU9PCNVdW4Y0i/dhjiAmcsODoWQRsSWVI+JTh9/lGgb9YmuO3YOhHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiCcDC/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C334C4CEEB;
	Tue,  1 Jul 2025 20:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751400360;
	bh=EgCnSjkxf4u1frTm53+gSUO8YuhHv0iXVp3vsJ/h0RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiCcDC/LMjF4xusnlzOHKMvbFAnZ5glKwkSnQD38zFYwoP5d+j+D65q8v1QxTBjvE
	 ovSjwtxKoO4AAnJsBdOZPxQiw36jM7qV9i2fUs0QZEzDhhKzmDwgikxzZTEZYJBkEE
	 nSylKd5/ukuQiI05UAv7aJpTx2aY5a+LRhVyiHzmmOzphhvJZFo0CANwewdpdDAn7p
	 d2uGSWQT3bzxAPl9WZ8G8S4iFkbpDrV8OvKzUT1Jhmw7AM5Vkpaa9nmQCrcYJuWgDA
	 dXnKlAn+RqRmebG9V1oOD6N0rXgmAjgfkugQ+voiTz9QQH+piz4p0iiZC+M2yP3SRf
	 uugx2/WRLqaZQ==
Date: Tue, 1 Jul 2025 13:05:58 -0700
From: Drew Fustini <fustini@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Benno Lossin <lossin@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6 0/8] Rust Abstractions for PWM subsystem with TH1520
 PWM driver
Message-ID: <aGQ/ph1dGIJcnyZu@x1>
References: <CGME20250701160157eucas1p1b6dfd8bf3859b07bff0cfcd171d7c939@eucas1p1.samsung.com>
 <20250701-rust-next-pwm-working-fan-for-sending-v6-0-2710932f6f6b@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-rust-next-pwm-working-fan-for-sending-v6-0-2710932f6f6b@samsung.com>

On Tue, Jul 01, 2025 at 06:01:37PM +0200, Michal Wilczynski wrote:
> This patch series introduces Rust support for the T-HEAD TH1520 PWM
> controller and demonstrates its use for fan control on the Sipeed Lichee
> Pi 4A board.
[snip]
> [2] - https://github.com/mwilczy/linux/commits/rust-next-pwm-working-fan-for-sending-v10/

I've tested this branch, which is now based on next-20250701, and the fan
is working correctly.

Tested-by: Drew Fustini <fustini@kernel.org>

