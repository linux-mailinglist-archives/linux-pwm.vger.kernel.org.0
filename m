Return-Path: <linux-pwm+bounces-6675-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC150AF017C
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 19:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15994A1427
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 17:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A249E27E052;
	Tue,  1 Jul 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opSQbVh6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676551F4285;
	Tue,  1 Jul 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751390085; cv=none; b=rpHLqhlvl0kbGuNjq+LjIDHCkU1kvkNcS2Brh4xa1XmCZQRRKiJYwQ8+bUk4Pipl5npvRvArU3gk0/kEdaBT0QDQFB5tcS6AAf2VS1TV5/t8ZcXCeS2YD7ZjRBOI5OZ4XyXnTMRvKL/L6a+INfcZ5FVleM2RxmJr8X7sdoq6Pyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751390085; c=relaxed/simple;
	bh=/nYOnOIIbrOV+84hpe4LR2uNAOY0fYnhNLgViKHOwaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FDwQdUhbM/DOjSQNwGjKvFKLlrfv4hmITDnNvoEal1nbfShcTeXMm+GK+bNeD2+dGF9YG1jwSMy+bAkc0Ii3DN8WQeFKQHpXKyuESqLjlnPL80I09kmn9jKUQuoqCLUoJW7depxCSG7Fxpv5mMdgo3+MjPY8+a+Scd26k2+B8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opSQbVh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6540DC4CEEB;
	Tue,  1 Jul 2025 17:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751390084;
	bh=/nYOnOIIbrOV+84hpe4LR2uNAOY0fYnhNLgViKHOwaA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=opSQbVh63+1AG4gEDXtVjLecX5Ff/0yV6Pvs8ObQge9FVL2sDvLA4exzHD6w5Eiq4
	 oA0sEuYIT1FPtZzwuCIL/MFW3oLhmvSZ29YQ15I5N3swOVr5tDG9eGfOmNpTLw4Wjb
	 4/3FEXeATUtsv4d46vz5q9LkVVeArZBZuL4S68yVmPKAsVanB0nLbZIBQSQjmIr5HO
	 PDl2Ag2K+yWjOZd08MnNcHXmJdxFT3ymSUawNTxpeSt4mmq27oaOliI690M5kSMjHp
	 YU8hkAsAYkTjkXzWp3t20A9YIb0Cl+20RQu6g2QaOFNrW/kOb1Qqv1fDcfAIKk5H/1
	 JcOO8Yn5xhjOQ==
Message-ID: <aeb45ff9-73a7-427b-8cca-cc9646b65b9b@kernel.org>
Date: Tue, 1 Jul 2025 19:14:37 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] rust: pwm: Add core 'Device' and 'Chip' object
 wrappers
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Benno Lossin <lossin@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Drew Fustini <fustini@kernel.org>,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
References: <20250701-rust-next-pwm-working-fan-for-sending-v6-0-2710932f6f6b@samsung.com>
 <CGME20250701160201eucas1p14d4182ecd8d6b2034f55ed5262bac646@eucas1p1.samsung.com>
 <20250701-rust-next-pwm-working-fan-for-sending-v6-3-2710932f6f6b@samsung.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250701-rust-next-pwm-working-fan-for-sending-v6-3-2710932f6f6b@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/1/25 6:01 PM, Michal Wilczynski wrote:
> +    /// Returns a reference to the parent device of this PWM chip's device.
> +    pub fn parent_device(&self) -> Option<&device::Device> {
> +        self.device().parent()
> +    }

I know what you use this for, i.e. to provide a &Device<Bound> reference in your
class device callbacks -- that's great!

But please don't expose this to the public. I think what you want instead is a
private unsafe method that returns you the &Device<Bound> directly, since you
also know that you set a valid parent device, hence no need to mess with the
Option as well.

And again, sorry for not catching it right away.

- Danilo

